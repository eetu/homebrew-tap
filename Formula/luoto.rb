class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.5.2"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.5.2/luoto-0.5.2-aarch64-apple-darwin.tar.gz"
      sha256 "61dacc80fe2e184a341febf32b74cbd09c707d8680fc1f4da852b1a1bc948ffa"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.5.2/luoto-0.5.2-x86_64-apple-darwin.tar.gz"
      sha256 "256eaa71c85f7622cf8d709ae9936a9735bcd96627ae1bb55debfd343752ef66"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.5.2/luoto-0.5.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "639aebb76b2f44cb8838f95035d2c075a8e1f413f6be4f19e40fc6ab8dd7962f"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.5.2/luoto-0.5.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f8f76890550d1248079fa3d9e0f3f55084ecf027cab77ca6e1518bd02e1628d7"
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
