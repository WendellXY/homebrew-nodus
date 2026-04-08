class NodusAT092 < Formula
  desc "Add agent packages to your repo with one command"
  homepage "https://github.com/nodus-rs/nodus"
  version "0.9.2"
  license "Apache-2.0"
  keg_only :versioned_formula
  head "https://github.com/nodus-rs/nodus.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.9.2/nodus-v0.9.2-aarch64-apple-darwin.tar.gz"
      sha256 "9d06853c755f38f383669f63ff0b394f4080753818f544476bb82f589bdd3198"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.9.2/nodus-v0.9.2-x86_64-apple-darwin.tar.gz"
      sha256 "4369220ddffaf3064c6d5d03c00cde14cae2aa61f29d7013c8f3707a75fc5780"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.9.2/nodus-v0.9.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "240d482b79d5d953e23801916a5aca6d97e7c54a244c93cb11c8e491f2d736e3"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.9.2/nodus-v0.9.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "897b992f7c5a614b2020fa9a03cd560da06b3c67151e10850d1db3375b955c00"
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
