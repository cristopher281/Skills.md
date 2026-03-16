#!/usr/bin/env bash
# =============================================================================
# audit-performance.sh
# Lighthouse CI Performance Audit Script
# Part of: diseño-UI/UX — 2026 Frontend Architecture Skill
# =============================================================================
#
# Usage:
#   chmod +x scripts/audit-performance.sh
#   ./scripts/audit-performance.sh [URL]
#
# Arguments:
#   URL   The URL to audit (default: http://localhost:3000)
#
# Outputs:
#   - HTML report saved to ./lighthouse-report/
#   - Core Web Vitals printed to stdout
# =============================================================================

set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
TARGET_URL="${1:-http://localhost:3000}"
REPORT_DIR="./lighthouse-report"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
REPORT_FILE="${REPORT_DIR}/report-${TIMESTAMP}.html"
JSON_FILE="${REPORT_DIR}/report-${TIMESTAMP}.json"

# Performance budget thresholds
LCP_LIMIT=1200    # milliseconds
INP_LIMIT=50      # milliseconds
CLS_LIMIT=0.05    # unitless

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ---------------------------------------------------------------------------
# Utilities
# ---------------------------------------------------------------------------
print_header() {
  echo ""
  echo -e "${CYAN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo -e "${CYAN}${BOLD}  🚀 Lighthouse CI Performance Audit${RESET}"
  echo -e "${CYAN}${BOLD}  Target: ${TARGET_URL}${RESET}"
  echo -e "${CYAN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo ""
}

print_pass() {
  echo -e "  ${GREEN}✓ PASS${RESET}  $1"
}

print_fail() {
  echo -e "  ${RED}✗ FAIL${RESET}  $1"
}

print_warn() {
  echo -e "  ${YELLOW}⚠ WARN${RESET}  $1"
}

# ---------------------------------------------------------------------------
# Step 1: Detect / Install Lighthouse
# ---------------------------------------------------------------------------
ensure_lighthouse() {
  echo -e "${BOLD}[1/4] Checking Lighthouse installation...${RESET}"

  if command -v lighthouse &>/dev/null; then
    local version
    version="$(lighthouse --version 2>/dev/null || echo 'unknown')"
    print_pass "Lighthouse found (v${version})"
  else
    print_warn "Lighthouse not found. Installing globally via npm..."

    if ! command -v npm &>/dev/null; then
      echo -e "${RED}Error: npm is required to install Lighthouse.${RESET}"
      echo "Install Node.js from https://nodejs.org and retry."
      exit 1
    fi

    npm install -g lighthouse@latest --silent 2>/dev/null || {
      echo -e "${RED}Error: Failed to install Lighthouse globally.${RESET}"
      echo "Try: sudo npm install -g lighthouse@latest"
      exit 1
    }

    if command -v lighthouse &>/dev/null; then
      print_pass "Lighthouse installed successfully"
    else
      echo -e "${RED}Error: Lighthouse installation completed but binary not found in PATH.${RESET}"
      exit 1
    fi
  fi

  echo ""
}

# ---------------------------------------------------------------------------
# Step 2: Check target URL availability
# ---------------------------------------------------------------------------
check_target() {
  echo -e "${BOLD}[2/4] Checking target URL availability...${RESET}"

  if command -v curl &>/dev/null; then
    local http_code
    http_code="$(curl -s -o /dev/null -w '%{http_code}' --connect-timeout 5 "${TARGET_URL}" 2>/dev/null || echo '000')"
    if [ "${http_code}" = "000" ]; then
      print_fail "Cannot reach ${TARGET_URL}"
      echo ""
      echo "  Make sure your dev server is running:"
      echo "    npm run dev"
      echo ""
      exit 1
    else
      print_pass "Target reachable (HTTP ${http_code})"
    fi
  else
    print_warn "curl not available — skipping reachability check"
  fi

  echo ""
}

# ---------------------------------------------------------------------------
# Step 3: Run Lighthouse audit
# ---------------------------------------------------------------------------
run_audit() {
  echo -e "${BOLD}[3/4] Running Lighthouse performance audit...${RESET}"
  echo "  This may take 30–60 seconds."
  echo ""

  mkdir -p "${REPORT_DIR}"

  lighthouse "${TARGET_URL}" \
    --only-categories=performance,accessibility \
    --output=html,json \
    --output-path="${REPORT_DIR}/report-${TIMESTAMP}" \
    --chrome-flags="--headless --no-sandbox --disable-gpu" \
    --quiet \
    2>/dev/null || {
      echo -e "${RED}Error: Lighthouse audit failed.${RESET}"
      echo "Ensure Chrome/Chromium is installed and the target URL is accessible."
      exit 1
    }

  print_pass "Audit completed"
  echo ""
}

# ---------------------------------------------------------------------------
# Step 4: Parse and display Core Web Vitals
# ---------------------------------------------------------------------------
display_results() {
  echo -e "${BOLD}[4/4] Core Web Vitals Results${RESET}"
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

  if [ ! -f "${JSON_FILE}" ]; then
    # Lighthouse may output with .report.json suffix
    local alt_json="${REPORT_DIR}/report-${TIMESTAMP}.report.json"
    if [ -f "${alt_json}" ]; then
      JSON_FILE="${alt_json}"
    else
      print_fail "JSON report not found. Cannot parse vitals."
      return 1
    fi
  fi

  local passed=0
  local failed=0

  # --- LCP ---
  local lcp_raw
  lcp_raw="$(python3 -c "
import json, sys
with open('${JSON_FILE}') as f:
    data = json.load(f)
audits = data.get('audits', {})
lcp = audits.get('largest-contentful-paint', {})
print(lcp.get('numericValue', -1))
" 2>/dev/null || echo '-1')"

  if [ "${lcp_raw}" != "-1" ]; then
    local lcp_ms="${lcp_raw%.*}"
    local lcp_s
    lcp_s="$(echo "scale=2; ${lcp_ms} / 1000" | bc 2>/dev/null || echo 'N/A')"

    echo ""
    if [ "${lcp_ms}" -le "${LCP_LIMIT}" ] 2>/dev/null; then
      print_pass "LCP: ${lcp_s}s  (budget: < $(echo "scale=1; ${LCP_LIMIT} / 1000" | bc)s)"
      ((passed++))
    else
      print_fail "LCP: ${lcp_s}s  (budget: < $(echo "scale=1; ${LCP_LIMIT} / 1000" | bc)s)"
      ((failed++))
    fi
  else
    print_warn "LCP: Could not parse value"
  fi

  # --- CLS ---
  local cls_raw
  cls_raw="$(python3 -c "
import json
with open('${JSON_FILE}') as f:
    data = json.load(f)
cls = data.get('audits', {}).get('cumulative-layout-shift', {})
print(cls.get('numericValue', -1))
" 2>/dev/null || echo '-1')"

  if [ "${cls_raw}" != "-1" ]; then
    local cls_check
    cls_check="$(echo "${cls_raw} <= ${CLS_LIMIT}" | bc -l 2>/dev/null || echo '0')"

    if [ "${cls_check}" = "1" ]; then
      print_pass "CLS: ${cls_raw}  (budget: < ${CLS_LIMIT})"
      ((passed++))
    else
      print_fail "CLS: ${cls_raw}  (budget: < ${CLS_LIMIT})"
      ((failed++))
    fi
  else
    print_warn "CLS: Could not parse value"
  fi

  # --- INP (approximated via TBT) ---
  local tbt_raw
  tbt_raw="$(python3 -c "
import json
with open('${JSON_FILE}') as f:
    data = json.load(f)
tbt = data.get('audits', {}).get('total-blocking-time', {})
print(tbt.get('numericValue', -1))
" 2>/dev/null || echo '-1')"

  if [ "${tbt_raw}" != "-1" ]; then
    local tbt_ms="${tbt_raw%.*}"

    if [ "${tbt_ms}" -le "${INP_LIMIT}" ] 2>/dev/null; then
      print_pass "TBT (INP proxy): ${tbt_ms}ms  (budget: < ${INP_LIMIT}ms)"
      ((passed++))
    else
      print_fail "TBT (INP proxy): ${tbt_ms}ms  (budget: < ${INP_LIMIT}ms)"
      ((failed++))
    fi
  else
    print_warn "TBT: Could not parse value"
  fi

  # --- Performance Score ---
  local perf_score
  perf_score="$(python3 -c "
import json
with open('${JSON_FILE}') as f:
    data = json.load(f)
cats = data.get('categories', {})
perf = cats.get('performance', {})
score = perf.get('score', -1)
print(int(score * 100) if score >= 0 else -1)
" 2>/dev/null || echo '-1')"

  echo ""
  if [ "${perf_score}" != "-1" ]; then
    if [ "${perf_score}" -ge 90 ] 2>/dev/null; then
      print_pass "Performance Score: ${perf_score}/100 ⚡"
    elif [ "${perf_score}" -ge 50 ] 2>/dev/null; then
      print_warn "Performance Score: ${perf_score}/100"
    else
      print_fail "Performance Score: ${perf_score}/100"
    fi
  fi

  # --- Accessibility Score ---
  local a11y_score
  a11y_score="$(python3 -c "
import json
with open('${JSON_FILE}') as f:
    data = json.load(f)
cats = data.get('categories', {})
a11y = cats.get('accessibility', {})
score = a11y.get('score', -1)
print(int(score * 100) if score >= 0 else -1)
" 2>/dev/null || echo '-1')"

  if [ "${a11y_score}" != "-1" ]; then
    if [ "${a11y_score}" -ge 90 ] 2>/dev/null; then
      print_pass "Accessibility Score: ${a11y_score}/100"
    elif [ "${a11y_score}" -ge 50 ] 2>/dev/null; then
      print_warn "Accessibility Score: ${a11y_score}/100"
    else
      print_fail "Accessibility Score: ${a11y_score}/100"
    fi
  fi

  # --- Summary ---
  echo ""
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

  if [ "${failed}" -eq 0 ]; then
    echo -e "  ${GREEN}${BOLD}All Core Web Vitals within budget ✓${RESET}"
  else
    echo -e "  ${RED}${BOLD}${failed} metric(s) exceeded budget — architecture redesign required${RESET}"
  fi

  echo ""
  echo -e "  ${BOLD}HTML Report:${RESET} ${REPORT_DIR}/report-${TIMESTAMP}.report.html"
  echo -e "  ${BOLD}JSON Report:${RESET} ${JSON_FILE}"
  echo ""

  return "${failed}"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
  print_header
  ensure_lighthouse
  check_target
  run_audit
  display_results
  exit $?
}

main
