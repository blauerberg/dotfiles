#!/bin/bash
input=$(cat)
NOW=$(date +%s)

# --- ANSI colors ---
CYAN='\033[36m' YELLOW='\033[33m' RED='\033[31m'
GREEN='\033[32m' MAGENTA='\033[35m' DIM='\033[2m' RESET='\033[0m'

# --- Utility functions ---

color_for_pct() {
  if [ "$1" -ge 80 ] 2>/dev/null; then printf '%b' "$RED"
  elif [ "$1" -ge 50 ] 2>/dev/null; then printf '%b' "$YELLOW"
  else printf '%b' "$GREEN"; fi
}

progress_bar() {
  local f=$(( ($1 + 5) / 10 ))
  [ "$f" -gt 10 ] && f=10; [ "$f" -lt 0 ] && f=0
  local bar="▰▰▰▰▰▰▰▰▰▰"
  local empty="▱▱▱▱▱▱▱▱▱▱"
  printf '%s%s' "${bar:0:$f}" "${empty:0:$((10-f))}"
}

format_tokens() {
  local tokens="$1"
  if [ "$tokens" -ge 1000000 ] 2>/dev/null; then
    awk "BEGIN {printf \"%.1fm\", $tokens/1000000}"
  else
    awk "BEGIN {printf \"%.1fk\", $tokens/1000}"
  fi
}

bar_line() {
  local label="$1" pct="$2" reset_str="${3:-}" num_str="${4:-}"
  if [ -n "$pct" ]; then
    [ -n "$num_str" ] && printf '%b%s %s %3s%% %s %b%s' "$(color_for_pct "$pct")" "$label" "$(progress_bar "$pct")" "$pct" "$num_str" "$RESET" "$reset_str"
    [ -z "$num_str" ] && printf '%b%s %s %3s%%%b%s' "$(color_for_pct "$pct")" "$label" "$(progress_bar "$pct")" "$pct" "$RESET" "$reset_str"
  else
    [ -n "$num_str" ] && printf '%b%s ▱▱▱▱▱▱▱▱▱▱  --%% %s %b' "$DIM" "$label" "$num_str" "$RESET"
    [ -z "$num_str" ] && printf '%b%s ▱▱▱▱▱▱▱▱▱▱  --%% %b' "$DIM" "$label" "$RESET"
  fi
}

format_reset() {
  local epoch="$1"
  [ -z "$epoch" ] || [ "$epoch" = "0" ] || [ "$epoch" = "null" ] && return
  local rem=$(( epoch - NOW ))
  [ "$rem" -le 0 ] && return
  local d=$(( rem / 86400 )) h=$(( rem % 86400 / 3600 )) m=$(( rem % 3600 / 60 ))
  local t
  if [ "$d" -gt 0 ]; then   t=$(printf '%dd %dh %dm' "$d" "$h" "$m")
  elif [ "$h" -gt 0 ]; then t=$(printf '%dh %dm' "$h" "$m")
  else                       t=$(printf '%dm' "$m"); fi
  printf ' resets in %-10s' "$t"
}

# --- Parse stdin JSON ---
eval "$(echo "$input" | jq -r '
  "MODEL=" + (.model.display_name // "Unknown" | @sh),
  "CTX_SIZE=" + (.context_window.context_window_size // empty | tostring),
  "CTX_USED_PCT=" + (.context_window.used_percentage // 0 | tostring),
  "CTX_INPUT=" + ((.context_window.current_usage.input_tokens // 0) | tostring),
  "CTX_CACHE_CREATE=" + ((.context_window.current_usage.cache_creation_input_tokens // 0) | tostring),
  "CTX_CACHE_READ=" + ((.context_window.current_usage.cache_read_input_tokens // 0) | tostring),
  "CTX_HAS_USAGE=" + (if .context_window.current_usage then "1" else "0" end),
  "CTX_USED_TOKENS=" + ((.context_window.current_usage.input_tokens // 0) + (.context_window.current_usage.cache_creation_input_tokens // 0) + (.context_window.current_usage.cache_read_input_tokens // 0) | tostring),
  "CTX_TOTAL_TOKENS=" + (.context_window.context_window_size // empty | tostring),
  "TOTAL_INPUT=" + (.context_window.total_input_tokens // 0 | tostring),
  "TOTAL_OUTPUT=" + (.context_window.total_output_tokens // 0 | tostring),
  "LINES_ADD=" + (.cost.total_lines_added // 0 | tostring),
  "LINES_DEL=" + (.cost.total_lines_removed // 0 | tostring),
  "FIVE_PCT=" + (.rate_limits.five_hour.used_percentage // empty | floor | tostring),
  "FIVE_RESET_EPOCH=" + (.rate_limits.five_hour.resets_at // 0 | tostring),
  "SEVEN_PCT=" + (.rate_limits.seven_day.used_percentage // empty | floor | tostring),
  "SEVEN_RESET_EPOCH=" + (.rate_limits.seven_day.resets_at // 0 | tostring),
  "EFFORT=" + (.effort.level // "" | @sh)
' 2>/dev/null)"

# --- Per-model default context length ---
if [ -z "$CTX_SIZE" ] || [ "$CTX_SIZE" = "null" ] || [ "$CTX_SIZE" = "0" ]; then
  case "$MODEL" in
    *qwen*|*Qwen*) CTX_SIZE=256000 ;;
  esac
  CTX_TOTAL_TOKENS=$CTX_SIZE
fi

if [ "$CTX_HAS_USAGE" = "1" ]; then
  CTX_PCT=$(( (CTX_INPUT + CTX_CACHE_CREATE + CTX_CACHE_READ) * 100 / CTX_SIZE ))
  CTX_NUM_STR="$(format_tokens $CTX_USED_TOKENS)/$(format_tokens $CTX_TOTAL_TOKENS)"
elif [ -n "$CTX_SIZE" ] && [ "$CTX_SIZE" != "null" ] && [ "$CTX_SIZE" != "0" ]; then
  CTX_PCT=${CTX_USED_PCT%%.*}
  CTX_NUM_STR="$(format_tokens $CTX_USED_TOKENS)/$(format_tokens $CTX_TOTAL_TOKENS)"
else
  CTX_PCT=${CTX_USED_PCT%%.*}
  CTX_NUM_STR=""
fi

# --- Git branch & diff ---
CWD=$(echo "$input" | jq -r '.workspace.current_dir // "."')
GIT_BRANCH=""
if git -C "$CWD" rev-parse --git-dir > /dev/null 2>&1; then
  BRANCH=$(git -C "$CWD" --no-optional-locks branch --show-current 2>/dev/null)
  if [ -n "$BRANCH" ]; then
    # Ahead/behind relative to upstream
    AHEAD=$(git -C "$CWD" rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
    BEHIND=$(git -C "$CWD" rev-list --count HEAD..@{u} 2>/dev/null || echo 0)
    # Uncommitted changes
    HAS_DIFF=$(git -C "$CWD" diff --stat 2>/dev/null | tail -1)
    if echo "$HAS_DIFF" | grep -q "changed"; then
      ADDED=$(echo "$HAS_DIFF" | grep -o '[0-9]* insertion' | grep -o '[0-9]*')
      REMOVED=$(echo "$HAS_DIFF" | grep -o '[0-9]* deletion' | grep -o '[0-9]*')
    else
      ADDED=0
      REMOVED=0
    fi
    GIT_ICON=""
    if [ "$AHEAD" -gt 0 ] && [ "$BEHIND" -eq 0 ]; then
      GIT_ICON="${GREEN}↑${RESET}"
    elif [ "$AHEAD" -eq 0 ] && [ "$BEHIND" -gt 0 ]; then
      GIT_ICON="${RED}↓${RESET}"
    elif [ "$AHEAD" -eq 0 ] && [ "$BEHIND" -eq 0 ]; then
      GIT_ICON="${GREEN}✓${RESET}"
    else
      GIT_ICON="${YELLOW}↑${RESET}${RED}↓${RESET}"
    fi
    if [ "$ADDED" -gt 0 ] || [ "$REMOVED" -gt 0 ]; then
      GIT_ICON="${GIT_ICON} ${GREEN}+${ADDED}${RESET}/${RED}-${REMOVED}${RESET}"
    fi
    GIT_BRANCH=" | ${MAGENTA}${BRANCH}${RESET} ${GIT_ICON}"
  fi
fi

# --- Rate limits ---
FIVE_RESET=$(format_reset "$FIVE_RESET_EPOCH")
SEVEN_RESET=$(format_reset "$SEVEN_RESET_EPOCH")

# --- Output ---
LINE_STATS=""
if [ "$LINES_ADD" -gt 0 ] 2>/dev/null || [ "$LINES_DEL" -gt 0 ] 2>/dev/null; then
  LINE_STATS=" | ${GREEN}+${LINES_ADD}${RESET}/${RED}-${LINES_DEL}${RESET}"
fi

TOKEN_STATS=""
if [ -n "$TOTAL_INPUT" ] && [ "$TOTAL_INPUT" != "0" ]; then
  TOKEN_STATS=" | ${YELLOW}In: $(format_tokens $TOTAL_INPUT)${RESET} ${YELLOW}Out: $(format_tokens $TOTAL_OUTPUT)${RESET}"
fi

EFFORT_PART=""
[ -n "$EFFORT" ] && EFFORT_PART=" ${DIM}(${RESET}${MAGENTA}${EFFORT}${RESET}${DIM})${RESET}"
printf '%b\n' "$(bar_line "cx" "$CTX_PCT" "" "$CTX_NUM_STR") | ${CYAN}${MODEL}${RESET}${EFFORT_PART}${GIT_BRANCH}${TOKEN_STATS}${LINE_STATS}"
printf '%b'   "$(bar_line "5h" "$FIVE_PCT" "" "") |$FIVE_RESET    $(bar_line "7d" "$SEVEN_PCT" "" "") |$SEVEN_RESET"
