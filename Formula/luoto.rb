class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.7.3"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.3/luoto-0.7.3-aarch64-apple-darwin.tar.gz"
      sha256 "432a6c5baacc336095673eedcc9a8db1b36f6d30025f65228bd30c856ebeb9f0"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.3/luoto-0.7.3-x86_64-apple-darwin.tar.gz"
      sha256 "fd96b052233b73a08247b44047c6c3ed93f0120b4670070e17e3efdceb3cd879"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.3/luoto-0.7.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "79b595d2dac8a426fa6e0eabcfdc33719ab5c4a497906c87967392dd5326aa66"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.3/luoto-0.7.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5fd4a3713cbece4f9c5ae06f11902bf17d99da27324d3e02c5f967e6677f932b"
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
