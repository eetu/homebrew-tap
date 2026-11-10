class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.4.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.2/luoto-0.4.2-aarch64-apple-darwin.tar.gz"
      sha256 "cc0326cecba336601bf28fd5d11182cdd43f97d8dea5478b5abf59f7e07dda29"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.2/luoto-0.4.2-x86_64-apple-darwin.tar.gz"
      sha256 "9aa7de34874d28f75ce14c1253935a8a9a49801c56a86e55bf1bec982f8b123c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.2/luoto-0.4.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8d4b55125c06b7fbe50be2304a8177a5fe6d5c21c4ab82425fab59ccff763481"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.2/luoto-0.4.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8a9d08f1e0dc23be4b46a6ab68b16eef1f4f7a41734e7df508db3d85249f3325"
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
