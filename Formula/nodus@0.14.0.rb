class NodusAT0140 < Formula
  desc "Add agent packages to your repo with one command"
  homepage "https://github.com/nodus-rs/nodus"
  version "0.14.0"
  license "Apache-2.0"
  keg_only :versioned_formula
  head "https://github.com/nodus-rs/nodus.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.14.0/nodus-v0.14.0-aarch64-apple-darwin.tar.gz"
      sha256 "0f5b70efde3b2361b63656dbb59fcf243918fde203f9ecb102a0af31b3095516"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.14.0/nodus-v0.14.0-x86_64-apple-darwin.tar.gz"
      sha256 "39dcd9826112f3f8b320ae670ace0d6c9b141ad3db2ad920fb587041263e13c5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.14.0/nodus-v0.14.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dde8a8079268e7225494ee4cf276f0daa8b928b41735ded92cc76502e868ae38"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.14.0/nodus-v0.14.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b50d8312198cff1b3ddb2c8f669345af3ce45ec61b0543412f16f7d49c7b64f7"
    end
  end

  def install
    bin.install "nodus"
    generate_completions_from_executable(bin/"nodus", "completion")
    doc.install "README.md" if File.exist?("README.md")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nodus --version")
    assert_match "_nodus", shell_output("#{bin}/completion zsh")
  end
end
