class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.7.0"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.0/luoto-0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "9cf656be914990f1cf8855b9bcdc6bedee98055caef69fcadadf15b4fcd6a6e1"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.0/luoto-0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "566e1cee9a6d4025a2ba628e677badbaf8f66ec7a2c0fd0cab9a4abbf38485d1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.0/luoto-0.7.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "81d2eda136a933a3997712b6c18e32e0cec20e731435b1a21703c70f51d3445f"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.0/luoto-0.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2a910ab1ce2cb18e3ba588514afa6a4073d6f70204601c077ad6760b3dd2dd74"
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
