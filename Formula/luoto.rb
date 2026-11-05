class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.2.0/luoto-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "c808cac6d5465b09b5cbe8aedc763ac99375513e8e13fa522115f94c806474b7"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.2.0/luoto-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "53cb84ecdacec69abe28fd2a81248e8111c257ab36a71d6def20be730b116058"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.2.0/luoto-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d6986c6cc789142a42cfa1e7e5b745a1acd8f39e0eee463606366108ac698146"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.2.0/luoto-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "729deb7d2a9a60cd25f24f8844509753a6f6b3d4e524136d530b49c233d3e84b"
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
