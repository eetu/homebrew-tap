class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.7.1"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.1/luoto-0.7.1-aarch64-apple-darwin.tar.gz"
      sha256 "fd9e19830f6d090b146eda1f38d06c80e5e66ce71a4a0861a3fab543d3ae81d6"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.1/luoto-0.7.1-x86_64-apple-darwin.tar.gz"
      sha256 "c506eee6938c8d505817b5192f6393cf3785248b3c5b4ac0d517688b90b0cc79"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.1/luoto-0.7.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "34091a449b5ce95912c1b393e16f20d5a5e4116899830d793e5913aa1dfbdcc6"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.1/luoto-0.7.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2f9cf0b55c7006ec9a5aaf897f3defb5484c5b0ff32c51f648b5d23244d5409e"
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
