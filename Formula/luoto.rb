class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.5.0"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.5.0/luoto-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "ba12aedf8605a3f8a6dc4cc4b24dea8847cd7f004e7f07dd8c9d4d7a91c82d49"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.5.0/luoto-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "c3e17f8b9d86cfbc763b7cac2c164681e91b935b7b56841818199fdfb7cde3e6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.5.0/luoto-0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8e0e56f508d48f15db89ac4bcd7f1fb14a16c7cf3d22f80df3ef16cbae64c603"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.5.0/luoto-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6cd16002cfe8a88883d0057cae5b819340916e6fd474d0016173c717223e3232"
    end
  end

  def install
    bin.install "luoto"
    generate_completions_from_executable(bin/"luoto", shell_parameter_format: :clap)
  end

  def caveats
    if OS.mac? && Hardware::CPU.arm? && MacOS.version >= :tahoe
      <<~EOS
        luoto needs a container runtime: Apple's container (recommended: every env its
        own VM), podman or Docker. For Apple's container:
          brew install container
        Then run:
          luoto setup
      EOS
    else
      <<~EOS
        luoto needs a container runtime: podman or Docker. For podman:
          brew install podman
        Then run:
          luoto setup
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/luoto --version")
  end
end
