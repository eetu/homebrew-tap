class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.7.6"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.6/luoto-0.7.6-aarch64-apple-darwin.tar.gz"
      sha256 "1517978300153ea318904c92c647fd895ffc8100a74c78fb9818e4e801ae2a15"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.6/luoto-0.7.6-x86_64-apple-darwin.tar.gz"
      sha256 "96e708312ce676e355bdcf984708883515309488a93112871e11d7e47e17463a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.7.6/luoto-0.7.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f43a2fecc97f7bc9a9e0b4c2a8f611cc6b61084adf20cb9d10dca25b4bca9901"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.7.6/luoto-0.7.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "70ee9603de95c19671437f3e7ab34f20694d6cf4df9ed03ed43e469a53302007"
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
