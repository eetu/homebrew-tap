class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.4.8"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.8/luoto-0.4.8-aarch64-apple-darwin.tar.gz"
      sha256 "40c80d834cd346dfe864026dcab3fedbbd03d144a1981f16f18508795ac345a9"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.8/luoto-0.4.8-x86_64-apple-darwin.tar.gz"
      sha256 "fb739b2444909c139aed1362856830b8e3689927f69dcc11e3f1f87db41dd6bd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.8/luoto-0.4.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5d2d85225559fae234f2cbe994166db2934c55cfea9f04920d094f363f668bc8"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.8/luoto-0.4.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9a47514f341136fe4db22315d348541e517ccf4387603fd03d3945a93984220c"
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
