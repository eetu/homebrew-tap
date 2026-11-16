class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.5.1"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.5.1/luoto-0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "6430cc042d14eef39392782a4ab78398d1277542729035704c7deeeb664c89d8"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.5.1/luoto-0.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "4287c994c16d865f3b3fd4270ea8cb2ee3d89c09bc8f65e8ddc8af7eb145c419"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.5.1/luoto-0.5.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7a417746feae3d9344a571fe017b9cc8f5b0608f8064d21cf30f40bff14f5f6a"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.5.1/luoto-0.5.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3e8057cc972e5137e2b00ec3a14466aeb9e25999d210953470d2f45b676b5edb"
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
