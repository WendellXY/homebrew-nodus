class NodusAT0160 < Formula
  desc "Add agent packages to your repo with one command"
  homepage "https://github.com/nodus-rs/nodus"
  version "0.16.0"
  license "Apache-2.0"
  keg_only :versioned_formula
  head "https://github.com/nodus-rs/nodus.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.16.0/nodus-v0.16.0-aarch64-apple-darwin.tar.gz"
      sha256 "a969ed3e9e0c9e9f825d1724764885f43774d5024af7b51d75f934f607680a21"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.16.0/nodus-v0.16.0-x86_64-apple-darwin.tar.gz"
      sha256 "e15afefc399f4a51c41ca2ca316ec50e82c2024f48750d57f6d15a6a500e9432"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.16.0/nodus-v0.16.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "22e916a4b183375072f471ced381caa74f236806841c0402d5a3d3a894f715ce"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.16.0/nodus-v0.16.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ddb33c9c206ab40c1509b08789d1c58044990ae8540c8c59acface3c53f9a61f"
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
