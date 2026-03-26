class Nodus < Formula
  desc "Add agent packages to your repo with one command"
  homepage "https://github.com/WendellXY/nodus"
  version "0.3.3"
  license "Apache-2.0"
  head "https://github.com/WendellXY/nodus.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/WendellXY/nodus/releases/download/v0.3.3/nodus-v0.3.3-aarch64-apple-darwin.tar.gz"
      sha256 "REPLACE_MACOS_ARM64_SHA256"
    else
      url "https://github.com/WendellXY/nodus/releases/download/v0.3.3/nodus-v0.3.3-x86_64-apple-darwin.tar.gz"
      sha256 "REPLACE_MACOS_X86_64_SHA256"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/WendellXY/nodus/releases/download/v0.3.3/nodus-v0.3.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "REPLACE_LINUX_ARM64_SHA256"
    else
      url "https://github.com/WendellXY/nodus/releases/download/v0.3.3/nodus-v0.3.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "REPLACE_LINUX_X86_64_SHA256"
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
