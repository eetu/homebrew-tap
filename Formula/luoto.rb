class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.7.5"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.5/luoto-0.7.5-aarch64-apple-darwin.tar.gz"
      sha256 "c1abe8480c9f802db294aef8c945934921111a76c438f4a4b78c411db4564806"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.5/luoto-0.7.5-x86_64-apple-darwin.tar.gz"
      sha256 "e44066a8a2b5648645fdf414b64ee1976281ceeb37aa33f70eff95188770e507"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.5/luoto-0.7.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0ecb40acd0cb355af2f48d92491b77777fb0ab00b783387462c6ab2f8f196b19"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.5/luoto-0.7.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b5e00cea7b933867f1bce07c4c1c3bdded9104dc1b5da194192972a00568c15"
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
