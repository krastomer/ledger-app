#!/bin/sh
# Downloads the Tesseract models the Android OCR uses into the app's assets.
# They are ~22 MB, so they stay out of git (see .gitignore).
set -eu

cd "$(dirname "$0")/.."
dest=android/app/src/main/assets/tessdata
mkdir -p "$dest"

for lang in tha eng; do
  file="$dest/$lang.traineddata"
  if [ -f "$file" ]; then
    echo "have $file"
    continue
  fi
  echo "fetching $file"
  curl -fsSL -o "$file" \
    "https://github.com/tesseract-ocr/tessdata_best/raw/main/$lang.traineddata"
done
