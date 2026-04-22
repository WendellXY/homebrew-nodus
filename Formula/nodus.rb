class Nodus < Formula
  desc "Add agent packages to your repo with one command"
  homepage "https://github.com/nodus-rs/nodus"
  version "0.12.0"
  license "Apache-2.0"
  head "https://github.com/nodus-rs/nodus.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.12.0/nodus-v0.12.0-aarch64-apple-darwin.tar.gz"
      sha256 "e73e8051fc1d376cd93f7a1a5c8b93d1942af77fd508a554af12d1736bfffa73"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.12.0/nodus-v0.12.0-x86_64-apple-darwin.tar.gz"
      sha256 "03123732bb5e04bf623d9fe600a20a5cf408eb3debda9c500175b0e630acdca3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.12.0/nodus-v0.12.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a0c155829d57b24ff5d2c630da7722c2a722084a5a85c4a110ebb751959f58db"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.12.0/nodus-v0.12.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b0940213626e3454cf24bb4cc14b9770b8555eed7cffb8c2e2983d43bb9d67a"
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
