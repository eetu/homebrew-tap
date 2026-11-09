class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.0/luoto-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "dcfb483ff215554a043366f15c2ba71b2a58a87693ea9f12d923dbc412c3cd08"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.0/luoto-0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "297cba057a4a5f1ec9119a50419b72ce4005ed04d644f494c79517545fdcfab5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.0/luoto-0.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "af9b8a7b5fff323c505f07ef8730f4037bcda2beaca729c787ed1c03a73430e9"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.0/luoto-0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "46549790f90246e39136959aa669c8e431f3ed874a08b3da35294096ad0be3be"
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
