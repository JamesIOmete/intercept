#!/usr/bin/env bash
set -euo pipefail

timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}

if docker compose version >/dev/null 2>&1; then
  COMPOSE=("docker" "compose")
elif docker-compose version >/dev/null 2>&1; then
  COMPOSE=("docker-compose")
else
  echo "[$(timestamp)] ERROR: docker compose not found."
  exit 1
fi

LOG_DIR="${LOG_DIR:-./logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="${LOG_FILE:-$LOG_DIR/docker-build-$(date +%Y%m%d-%H%M%S).log}"

echo "[$(timestamp)] Starting docker compose build. Logs: $LOG_FILE"
("${COMPOSE[@]}" build --progress=plain 2>&1 | tee "$LOG_FILE") &
build_pid=$!

keepalive() {
  while kill -0 "$build_pid" >/dev/null 2>&1; do
    echo "[$(timestamp)] Build still running..."
    sleep 30
  done
}

keepalive &
keepalive_pid=$!

trap 'kill "$keepalive_pid" >/dev/null 2>&1 || true' EXIT

wait "$build_pid"
kill "$keepalive_pid" >/dev/null 2>&1 || true

echo "[$(timestamp)] Build complete. Starting containers..."
"${COMPOSE[@]}" up -d --remove-orphans

echo "[$(timestamp)] Done. Use 'docker compose ps' to check status."
