class Nodus < Formula
  desc "Add agent packages to your repo with one command"
  homepage "https://github.com/nodus-rs/nodus"
  version "0.15.0"
  license "Apache-2.0"
  head "https://github.com/nodus-rs/nodus.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.15.0/nodus-v0.15.0-aarch64-apple-darwin.tar.gz"
      sha256 "8f11c656c36e384025c72c33dabc9c5928d133a49c0dfde189f95e399c1c8d86"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.15.0/nodus-v0.15.0-x86_64-apple-darwin.tar.gz"
      sha256 "6cc93636694f91ae8adc11f4fb093b53adba07f4b41ccda00ed3da5f9234eac1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nodus-rs/nodus/releases/download/v0.15.0/nodus-v0.15.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b2dff5dbcd6e9818327b907ee7090d059890bf2174e233287ef2d3008bde29bf"
    else
      url "https://github.com/nodus-rs/nodus/releases/download/v0.15.0/nodus-v0.15.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "892db3f300f5bb591926369b175ea1e0bb96b82a577f733c1274ee383c099722"
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
