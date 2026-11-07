class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.3.0/luoto-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "b9783db206e3c3564c88a90381b66d35d8b25b1df30df5d1dac89edb838b4a9c"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.3.0/luoto-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "9ae5d8840d991f71938eb173093b96d9139f63a37f17329592a9c2d051adb68e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.3.0/luoto-0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b5bb540463e05c8d87dcb276481e6b7964ca1691189a887d80e273dcb29ccb9d"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.3.0/luoto-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5ad8378877e36c259a8467202837902d032dd7c686267587f2a5a3efdb3f98bb"
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
