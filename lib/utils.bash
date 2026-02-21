#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where
# releases can be downloaded for foundry.
GH_REPO="https://github.com/foundry-rs/foundry"
TOOL_NAME="foundry"
TOOL_TEST="forge --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if foundry is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  # Change this function if foundry has other means of determining installable versions.
  list_github_tags
}

download_release() {
  local version filename url tag
  version="$1"
  filename="$2"

  # Determine tag for URL (add 'v' prefix only for numeric versions)
  if [[ "$version" =~ ^[0-9]+\. ]]; then
    tag="v$version"
  else
    tag="$version"
  fi

  local platform architecture EXT
  detect_platform_arch

  local archive_name="foundry_${tag}_${platform}_${architecture}.$EXT"
  url="$GH_REPO/releases/download/$tag/$archive_name"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

detect_platform_arch() {
  local uname_s uname_m
  uname_s=$(uname -s)
  uname_m=$(uname -m)

  case $uname_s in
    Linux) platform="linux"; EXT="tar.gz" ;;
    Darwin) platform="darwin"; EXT="tar.gz" ;;
    MINGW*|MSYS*|CYGWIN*) platform="win32"; EXT="zip" ;;
    *) fail "Unsupported platform: $uname_s" ;;
  esac

  case $uname_m in
    x86_64) architecture="amd64" ;;
    aarch64|arm64) architecture="arm64" ;;
    *) fail "Unsupported architecture: $uname_m" ;;
  esac
}

get_ext() {
  detect_platform_arch >/dev/null
  echo "$EXT"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  local bin_path="$install_path/bin"
  mkdir -p "$bin_path"

  # Move binaries to bin directory
  for binary in forge cast anvil chisel; do
    if [ -f "$ASDF_DOWNLOAD_PATH/$binary" ]; then
      mv "$ASDF_DOWNLOAD_PATH/$binary" "$bin_path/$binary"
      chmod +x "$bin_path/$binary"
    fi
  done

  local tool_cmd
  tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
  test -x "$bin_path/$tool_cmd" || fail "Expected $bin_path/$tool_cmd to be executable."

  echo "$TOOL_NAME $version installation was successful!"
}