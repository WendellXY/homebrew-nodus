class Nodus < Formula
  desc "Add agent packages to your repo with one command"
  homepage "https://github.com/nodus-rs/nodus"
  version "0.13.0"
  license "Apache-2.0"
  head "https://github.com/nodus-rs/nodus.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.13.0/nodus-v0.13.0-aarch64-apple-darwin.tar.gz"
      sha256 "5b653b2df75c607f1cbca4e6bdc95975413d400b623fe00d217030a99778add6"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.13.0/nodus-v0.13.0-x86_64-apple-darwin.tar.gz"
      sha256 "d45b60dbccf37fa2ea8622d736c4264218b3d23d299fec9f09d98e5f3a65d953"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.13.0/nodus-v0.13.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0dbb4456c3d1149c29391337ec7391f06e7a0ff837a6bebf5e08ba4cafecaeb5"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.13.0/nodus-v0.13.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7cbe305babeb7ee6e4d1973b0429b4da9ea4eb07c6db775b498b3a2365c4a207"
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
