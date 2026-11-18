class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.6.1"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.6.1/luoto-0.6.1-aarch64-apple-darwin.tar.gz"
      sha256 "acc8ca935985e6eff647ce5c182051e46931c5124b028f226611c9bb79346960"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.6.1/luoto-0.6.1-x86_64-apple-darwin.tar.gz"
      sha256 "228005a674085234a2d35f6257e797b19c0a20d7f251eacee1974d5de1aea76e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.6.1/luoto-0.6.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5e03c4ebe67a3348b4e97d0de312c3b9a05361f7a1797ee368a3e7598e8411c6"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.6.1/luoto-0.6.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a5837f9dc2bac52f3600691e543a95e754c2711f131cfb3988daea9f9724408d"
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
