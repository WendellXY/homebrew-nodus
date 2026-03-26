#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
FORMULA_PATH="${ROOT_DIR}/packaging/homebrew-nodus/Formula/nodus.rb"
REPO_SLUG="${REPO_SLUG:-WendellXY/nodus}"

package_field() {
  local field="$1"
  awk -v field="$field" '
    /^\[package\]$/ { in_package = 1; next }
    /^\[/ { in_package = 0 }
    in_package && $1 == field {
      gsub(/"/, "", $3)
      print $3
      exit
    }
  ' "${ROOT_DIR}/Cargo.toml"
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    printf 'error: missing required command: %s\n' "$1" >&2
    exit 1
  }
}

fetch_sha256() {
  local url="$1"
  curl -fsSL "$url" | awk '{print $1; exit}'
}

CRATE_NAME="$(package_field name)"
VERSION="$(package_field version)"
LICENSE="$(package_field license)"
RELEASE_TAG="v${VERSION}"
RELEASE_BASE_URL="https://github.com/${REPO_SLUG}/releases/download/${RELEASE_TAG}"

need_cmd curl

MACOS_ARM64_SHA256="$(fetch_sha256 "${RELEASE_BASE_URL}/${CRATE_NAME}-${RELEASE_TAG}-aarch64-apple-darwin.tar.gz.sha256")"
MACOS_X86_64_SHA256="$(fetch_sha256 "${RELEASE_BASE_URL}/${CRATE_NAME}-${RELEASE_TAG}-x86_64-apple-darwin.tar.gz.sha256")"
LINUX_ARM64_SHA256="$(fetch_sha256 "${RELEASE_BASE_URL}/${CRATE_NAME}-${RELEASE_TAG}-aarch64-unknown-linux-gnu.tar.gz.sha256")"
LINUX_X86_64_SHA256="$(fetch_sha256 "${RELEASE_BASE_URL}/${CRATE_NAME}-${RELEASE_TAG}-x86_64-unknown-linux-gnu.tar.gz.sha256")"

cat >"${FORMULA_PATH}" <<EOF
class Nodus < Formula
  desc "Add agent packages to your repo with one command"
  homepage "https://github.com/${REPO_SLUG}"
  version "${VERSION}"
  license "${LICENSE}"
  head "https://github.com/${REPO_SLUG}.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "${RELEASE_BASE_URL}/${CRATE_NAME}-${RELEASE_TAG}-aarch64-apple-darwin.tar.gz"
      sha256 "${MACOS_ARM64_SHA256}"
    else
      url "${RELEASE_BASE_URL}/${CRATE_NAME}-${RELEASE_TAG}-x86_64-apple-darwin.tar.gz"
      sha256 "${MACOS_X86_64_SHA256}"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "${RELEASE_BASE_URL}/${CRATE_NAME}-${RELEASE_TAG}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "${LINUX_ARM64_SHA256}"
    else
      url "${RELEASE_BASE_URL}/${CRATE_NAME}-${RELEASE_TAG}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "${LINUX_X86_64_SHA256}"
    end
  end

  def install
    bin.install Dir["*/nodus"].first => "nodus"
    generate_completions_from_executable(bin/"nodus", "completion")
    doc.install Dir["*/README.md"].first if Dir["*/README.md"].any?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nodus --version")
    assert_match "_nodus", shell_output("#{bin}/completion zsh")
  end
end
EOF

printf 'updated %s for %s %s from GitHub Releases\n' "${FORMULA_PATH}" "${CRATE_NAME}" "${VERSION}"
