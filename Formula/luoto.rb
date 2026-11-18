class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.6.0"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.6.0/luoto-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "452610e35522b16f76449c601c5c8699103fbafdb0ee1f69bd38e7b1536e37ca"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.6.0/luoto-0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "ffda5a22277c6599c5b0034260c91461af29c9409d45c88dbdf3a5f0010ba6ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.6.0/luoto-0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6e76373ca542641ffbde6e9e3e2a9d0cd5608a3eb4339f49af5a3e0a45f28254"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.6.0/luoto-0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "19151d4f3f0097119465f099aa6b8849d7e203087ba8f2509075f8afbfdf9a73"
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
