#!/bin/sh
# Runs integration_test/slip_parity_test.dart on one platform: real OCR on
# the device + the shared parser, checked against the expected results from
# the Mac Vision fixtures.
#
#   tool/slip_parity.sh ios     <image-dir> [device]   (default "iPhone 17")
#   tool/slip_parity.sh android <image-dir> [device]
#
# <image-dir> holds the sample slip images; testing/fixtures/slips_private
# must hold their OCR fixtures (tool/ocr_dump.swift). Each image's raw OCR
# lines end up in build/slip_parity/<platform>/out for debugging.
set -eu

platform=$1
images=$2
cd "$(dirname "$0")/.."

stage="$PWD/build/slip_parity/$platform"
rm -rf "$stage"
mkdir -p "$stage/in" "$stage/out"
cp "$images"/*.png "$images"/*.jpg "$images"/*.jpeg "$stage/in/" 2>/dev/null || true
dart run tool/expected_slips.dart testing/fixtures/slips_private "$stage/in/expected.json"

case "$platform" in
  ios)
    device=${3:-iPhone 17}
    # Simulator apps can read and write the host filesystem directly.
    flutter test integration_test/slip_parity_test.dart -d "$device" \
      --dart-define=SLIP_DIR="$stage/in" --dart-define=SLIP_OUT="$stage/out"
    ;;
  android)
    adb=${ANDROID_HOME:-$HOME/Library/Android/sdk}/platform-tools/adb
    device=${3:-$("$adb" devices | awk 'NR==2 {print $1}')}
    pkg=com.example.ledger_app
    # The app can't read files adb puts on shared storage, so stream them
    # into its private files dir with run-as (debug builds only).
    remote=/data/user/0/$pkg/files/slip_parity
    flutter build apk --debug >/dev/null
    "$adb" -s "$device" install -r build/app/outputs/flutter-apk/app-debug.apk >/dev/null
    "$adb" -s "$device" shell run-as $pkg rm -rf files/slip_parity
    "$adb" -s "$device" shell run-as $pkg mkdir -p files/slip_parity/in files/slip_parity/out
    for f in "$stage/in"/*; do
      name=$(basename "$f")
      "$adb" -s "$device" exec-in run-as $pkg sh -c "cat > 'files/slip_parity/in/$name'" < "$f"
    done
    status=0
    # --no-uninstall keeps the app's files so the OCR dumps can be copied out.
    flutter test integration_test/slip_parity_test.dart -d "$device" --no-uninstall \
      --dart-define=SLIP_DIR="$remote/in" --dart-define=SLIP_OUT="$remote/out" \
      || status=$?
    for name in $("$adb" -s "$device" shell run-as $pkg ls files/slip_parity/out 2>/dev/null); do
      "$adb" -s "$device" exec-out run-as $pkg cat "files/slip_parity/out/$name" > "$stage/out/$name"
    done
    exit $status
    ;;
  *)
    echo "usage: $0 ios|android <image-dir> [device]" >&2
    exit 2
    ;;
esac
