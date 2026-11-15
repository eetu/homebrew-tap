class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.4.6"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.6/luoto-0.4.6-aarch64-apple-darwin.tar.gz"
      sha256 "2bd2cb472ce4e62b5ab90824b098247d805178980a4a133c117a28e922145fdf"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.6/luoto-0.4.6-x86_64-apple-darwin.tar.gz"
      sha256 "28ca078d48a36afc23c931e97dd18afa1f0d22cb17dc7561cea9e640270fc36a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.6/luoto-0.4.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8aca30f78ba386639bf817a9ad457db6257e286acc9964e8909544f25d878df7"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.6/luoto-0.4.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "aa7eaa6948af3b7f48f9e23820d8aa53f575ca20877bca111b9b9e38d0fab848"
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
