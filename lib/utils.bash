#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/jaegertracing/jaeger"
TOOL_NAME="jaeger"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if jaeger is not hosted on GitHub releases.
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
    sed 's/^v//'
}

list_all_versions() {
  list_github_tags
}

get_tool_cmds() {
  echo "jaeger-agent"
  echo "jaeger-all-in-one"
  echo "jaeger-collector"
  echo "jaeger-ingester"
  echo "jaeger-query"
}

download_release() {
  local version filename url platform arch
  version="$1"
  filename="$2"
  platform="$(uname -s | tr '[:upper:]' '[:lower:]')"
  arch="$(uname -m)"

  case "$arch" in
  x86_64)
    arch=amd64
    ;;
  esac

  url="$GH_REPO/releases/download/v${version}/${TOOL_NAME}-${version}-${platform}-${arch}.tar.gz"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path/bin"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

    for tool_cmd in $(get_tool_cmds); do
      mv "$install_path/$tool_cmd" "$install_path/bin"
      chmod +x "$install_path/bin/$tool_cmd"

      test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."
    done

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
