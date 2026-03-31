class NodusAT070 < Formula
  desc "Add agent packages to your repo with one command"
  homepage "https://github.com/nodus-rs/nodus"
  version "0.7.0"
  license "Apache-2.0"
  keg_only :versioned_formula
  head "https://github.com/nodus-rs/nodus.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.7.0/nodus-v0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "79d3fb9d058239942c70a35a7d67505a191b6b1cfaf0d0ca2aef64f344ae3adf"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.7.0/nodus-v0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "8ad0102546ec10f7dff554ee3f2c92b8225a4fc6130fd261cd77fce1e5bd3b29"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.7.0/nodus-v0.7.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4058682c094ceef1e2b7d0b74708b01951bc8179b1437d2c8cc700b70dc00002"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.7.0/nodus-v0.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "11630a68b521f1f52e6d7f28380bdf3e7d60b21af37e8a58f9d8a4cc3203e682"
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
