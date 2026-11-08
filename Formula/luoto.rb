class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.3.1/luoto-0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "a025afabaec6a4463599674f0f636037b812a4148b037d4421cf03a8740eafa8"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.3.1/luoto-0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "6dc9c0657f18bff60bc462fcb630a63b3f21a71b5fd89d27d6bff07ababbc597"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.3.1/luoto-0.3.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9e4a41aae76c141fd860cd2e82ae89a306745e43b2502b23956d0632953abe58"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.3.1/luoto-0.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2ddbdfeabbd1f748c08a6f70cf0b347218e378cb68be056cfa59186793b7a3ef"
    end
  end

  def install
    bin.install "luoto"
    generate_completions_from_executable(bin/"luoto", shell_parameter_format: :clap)
  end

  def caveats
    <<~EOS
      luoto needs a container runtime: podman or Docker. For podman:
        brew install podman
      Then run:
        luoto setup
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/luoto --version")
  end
end
