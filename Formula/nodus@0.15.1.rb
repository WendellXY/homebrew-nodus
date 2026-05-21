class NodusAT0151 < Formula
  desc "Add agent packages to your repo with one command"
  homepage "https://github.com/nodus-rs/nodus"
  version "0.15.1"
  license "Apache-2.0"
  keg_only :versioned_formula
  head "https://github.com/nodus-rs/nodus.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.15.1/nodus-v0.15.1-aarch64-apple-darwin.tar.gz"
      sha256 "8da71cfea69780aed989f78223ba1980e33edbfcae07e5373821764fe20adb79"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.15.1/nodus-v0.15.1-x86_64-apple-darwin.tar.gz"
      sha256 "ba3c7678723cac2722eb94eaac02bf865771b80b1f5cbc5246a4112dc017d102"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.15.1/nodus-v0.15.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "76b1966c13e0dac722b08228485edaf6f0f1b036b4e5d5aca8893e308aa2aae2"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.15.1/nodus-v0.15.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b80fb1c779cc7542c0d358e1bfd4db3d2d7156ca34d44f2ae7f5befc1d9db625"
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
