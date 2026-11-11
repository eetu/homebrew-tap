class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.4.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.3/luoto-0.4.3-aarch64-apple-darwin.tar.gz"
      sha256 "15335ecff82f3567c8c9772b54f6ee2fcbf167c9df64d3ea591fed0f26b28d66"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.3/luoto-0.4.3-x86_64-apple-darwin.tar.gz"
      sha256 "069a01292730afb997b7bad2fe10fe6d7375a7934a46896ce2ba9b09a2cddde0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.3/luoto-0.4.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dd24ddf8f3c792b69cc5039d49d1caac9176dd2971c6cce79ee0f66b5cc05591"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.3/luoto-0.4.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "564e4d724bab6ef43e816dd033791ce76d01f750442bfd84cf49149e6348768f"
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
