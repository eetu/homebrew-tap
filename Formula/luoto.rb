class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.1/luoto-0.4.1-aarch64-apple-darwin.tar.gz"
      sha256 "fc2ae49f06311db57a6aab15afe6a44e73f3a571ff7a97cd420f348647fdcb82"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.1/luoto-0.4.1-x86_64-apple-darwin.tar.gz"
      sha256 "bf1a552d33251121231335a7013b5e8195b771bc39c295a06b57851795d99a09"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.1/luoto-0.4.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "521d5f4464967026b3701b838673db0b9c2416d2a667bc6a49e0887c8595abfb"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.1/luoto-0.4.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "78223e76b07814ab3bf79f80b4abe4c6b6cc8cf25646fd1c4cfedd27764c84b3"
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
