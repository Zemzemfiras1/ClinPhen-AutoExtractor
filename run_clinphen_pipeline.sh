#!/bin/bash

BASE_DIR="ClinphenResult"
LOG_DIR="$BASE_DIR/logs"
INPUT_FILE=""

# -----------------------
# HELP MENU
# -----------------------
usage() {
  echo ""
  echo "ClinPhen Pipeline Tool"
  echo ""
  echo "Usage:"
  echo "  ./run_clinphen_pipeline.sh --input file.tsv"
  echo ""
  echo "Options:"
  echo "  -i, --input   Input TSV file (required)"
  echo "  -h, --help    Show help"
  echo ""
  exit 0
}

# -----------------------
# PARSE ARGUMENTS
# -----------------------
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -i|--input)
      INPUT_FILE="$2"
      shift
      ;;
    -h|--help)
      usage
      ;;
    *)
      echo "Unknown parameter: $1"
      usage
      ;;
  esac
  shift
done

# -----------------------
# VALIDATE INPUT
# -----------------------
if [[ -z "$INPUT_FILE" ]]; then
  echo "ERROR: Input file is required!"
  usage
fi

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "ERROR: File not found -> $INPUT_FILE"
  exit 1
fi

# -----------------------
# SETUP
# -----------------------
mkdir -p "$BASE_DIR"
mkdir -p "$LOG_DIR"

# extract basename without path and extension
INPUT_BASENAME=$(basename "$INPUT_FILE")
INPUT_NAME="${INPUT_BASENAME%.*}"

LOG_FILE="$LOG_DIR/${INPUT_NAME}.txt"

rm -f "$LOG_FILE"

# logging function
log() {
  echo "$@" | tee -a "$LOG_FILE"
}

log "Starting ClinPhen pipeline..."
log "Input file: $INPUT_FILE"
log "Log file: $LOG_FILE"

# -----------------------
# MAIN LOOP
# -----------------------
while IFS=$'\t' read -r id features; do
  log "===================================="
  log "Processing $id"
  log "===================================="

  echo "$features" > tmp.txt

  clinphen tmp.txt 2>&1 | tee >(tee -a "$LOG_FILE" > "$BASE_DIR/${id}_clinphen.txt")

done < <(tail -n +2 "$INPUT_FILE")

rm -f tmp.txt

log "Pipeline completed."
