class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.2.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.2.2/luoto-0.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "a332b788117070bff8f97245cb558c18d8f8e80678441fac3917ebfca7282b7a"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.2.2/luoto-0.2.2-x86_64-apple-darwin.tar.gz"
      sha256 "a93e44a5769e601226bbdf21487a0cf4eabf5e8abefd6cff9f4c15c14a0cc09f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.2.2/luoto-0.2.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c8ebb96aea6fdae91f53e1d88d0e896f62cafa7ff5c1a46edcbc11f2bd093462"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.2.2/luoto-0.2.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "48ce00b87cbdbc2700e6d33fd7026631f8f5c688b3482b065dfe873035b742c8"
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
