class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.7.2"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.2/luoto-0.7.2-aarch64-apple-darwin.tar.gz"
      sha256 "f40cce591e09d2cb40b04595c0d8d18df314e5c12149499e7d7f921069d6efe6"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.2/luoto-0.7.2-x86_64-apple-darwin.tar.gz"
      sha256 "7bf09fdeacf3634dd995c34a5c87d6d747650700c0a27baaeb4f4fc3c7130fd4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.2/luoto-0.7.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a411576ad668fb90072ce18e88b44172e52471c7875b900017b2ddef14b49979"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.2/luoto-0.7.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "49f97f6c2f9c715ca10132d15d45d1b5b1e1e69bf482fbae39fdda028138e425"
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
