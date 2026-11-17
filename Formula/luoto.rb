class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.5.3"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.5.3/luoto-0.5.3-aarch64-apple-darwin.tar.gz"
      sha256 "3adfbbbdcde32fa0cab5561c5dd28164398f560578b83bd35da94f7f011b0e1a"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.5.3/luoto-0.5.3-x86_64-apple-darwin.tar.gz"
      sha256 "c81af29ca1550202b30e23669627efe1c1d2c262c3cd0cc0f72e2e74855981df"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.5.3/luoto-0.5.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3baf55909e1f91d507f1af9f38f27204d11ac8d1eeb3c9395c32f9ae98f61612"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.5.3/luoto-0.5.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "07c0a2047cfb8913ddf94812d40f4531fa62a4d07e5d023f7f08db36ca9e5194"
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
