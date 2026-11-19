class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.6.2"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.6.2/luoto-0.6.2-aarch64-apple-darwin.tar.gz"
      sha256 "054c1a31c3589c11a486b54e8c2e33fcf696a9d3990e46ea4eb40d487a452ee7"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.6.2/luoto-0.6.2-x86_64-apple-darwin.tar.gz"
      sha256 "14804bc829fccccb1ed5fb54f755f9f03f77c6d296abe2536e500551eb6ba8ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.6.2/luoto-0.6.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "74209eab757904bedf21a5378b2dc6f290caf594eafdd6764cbda9867baa528a"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.6.2/luoto-0.6.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d0eac81aca3d6170d0b9d14ee940398e1127d8802ad458865980fb7a7c3ea6e4"
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
