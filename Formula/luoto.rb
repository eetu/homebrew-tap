class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.7.4"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.4/luoto-0.7.4-aarch64-apple-darwin.tar.gz"
      sha256 "11042651ec7233109e2e0613bcdee542e4601ad7df39337660ff7e108648efea"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.4/luoto-0.7.4-x86_64-apple-darwin.tar.gz"
      sha256 "190334e5e4b6f8c972ddf8d863e9c5606fe3105e9f509c14702e12b5f892abf6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.4/luoto-0.7.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "245a40335848beaf4f8558a3577dcee89aa141a2c20d0da42518f06433a4389b"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.4/luoto-0.7.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "285f259f55e4aa5296a5d85b79857b552029a37b2f42bb2d5d204e3e9922eae4"
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
