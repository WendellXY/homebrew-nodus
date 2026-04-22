class NodusAT0110 < Formula
  desc "Add agent packages to your repo with one command"
  homepage "https://github.com/nodus-rs/nodus"
  version "0.11.0"
  license "Apache-2.0"
  keg_only :versioned_formula
  head "https://github.com/nodus-rs/nodus.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.11.0/nodus-v0.11.0-aarch64-apple-darwin.tar.gz"
      sha256 "ba67e0ba538b1d3b12567eadc97c6584c08fa91fcf97062280c8bb29c0d92156"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.11.0/nodus-v0.11.0-x86_64-apple-darwin.tar.gz"
      sha256 "a703bf291329f2dc1221b4f8427ca7a74bc4638b366a9827dd3e942fff5168a2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.11.0/nodus-v0.11.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0b05978f85e388717aea57c41a7f617e64577772a73ef02a249bef40ebcdf620"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.11.0/nodus-v0.11.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "81d925a913884b91964b8b22cfb831d8a9454692a100d37d196a45f39ae189ed"
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
