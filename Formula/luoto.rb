class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.4.7"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.7/luoto-0.4.7-aarch64-apple-darwin.tar.gz"
      sha256 "82df65d6d3d4da0de47824d57c18c116af392d152de026bafd7d1e017a1db15e"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.7/luoto-0.4.7-x86_64-apple-darwin.tar.gz"
      sha256 "bcf7c8e50034a499f56e2a1f89425f1468da6ae576c4a3caff74a8f476b3eea6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.7/luoto-0.4.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e8b1d2ad40e21d08c449611e13e2a1897a1a56adb9281190c9aa216eb2ec273a"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.7/luoto-0.4.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4fb5a0769f0fea381b767dd6cb0f0802db56dac221e67e491d35545137dd96e1"
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
