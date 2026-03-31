class Nodus < Formula
  desc "Add agent packages to your repo with one command"
  homepage "https://github.com/nodus-rs/nodus"
  version "0.7.1"
  license "Apache-2.0"
  head "https://github.com/nodus-rs/nodus.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.7.1/nodus-v0.7.1-aarch64-apple-darwin.tar.gz"
      sha256 "028d9d9270ac30ab9c60715515a98be4f5c1e9cf317af5704f82ed6c2fc14840"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.7.1/nodus-v0.7.1-x86_64-apple-darwin.tar.gz"
      sha256 "5d4c1be9963ca8d195bfa975140f81cb2f6e40765e210027db15a7bdd94f757b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.7.1/nodus-v0.7.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6c1b6d363f43facb13f2a83edb55b1ce98a3eaa7cc0380fffcc39bcce15596c4"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.7.1/nodus-v0.7.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "10e2f6d312afc0757d4b05ff1927404985a1c3878d58095989503f21b577f110"
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
