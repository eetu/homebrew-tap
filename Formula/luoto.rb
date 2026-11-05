class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.2.1/luoto-0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "10d095ebd2d23cb34823cb1081cac94863cb482df9ca31be427683070dba3c64"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.2.1/luoto-0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "b0470e9282e127d840b75cae178278a5bfedf7c2f5ea9d8a5640d4bc6d8d7d47"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.2.1/luoto-0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "56b6310441adedcaecdf8fc8bfd706c4525045c3eaf28a260c5d4a71a8e680be"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.2.1/luoto-0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6bd8ab102a23825ad6bb5a2f84adec19bb48eb6b04804f152de5dac0c2b4f387"
    end
  end

  def install
    bin.install "luoto"
    generate_completions_from_executable(bin/"luoto", shell_parameter_format: :clap)
  end

  def caveats
    <<~EOS
      luoto needs a container runtime: podman or Docker. For podman:
        brew install podman
      Then run:
        luoto setup
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/luoto --version")
  end
end
