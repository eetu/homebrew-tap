class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.4.4"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.4/luoto-0.4.4-aarch64-apple-darwin.tar.gz"
      sha256 "3885a1bfc3df0afb4b68156bf80b2815dc97a44a9ca548697d14a425d235d644"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.4/luoto-0.4.4-x86_64-apple-darwin.tar.gz"
      sha256 "4c4ccd143ccf2f6b0c16f98e1e7c866c19dbac4856d36062d2fddccc35dfc208"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.4/luoto-0.4.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0d8eacf4d844e40dc0650ae41a6d40ea6b16815aec114b848464c93a47f496b2"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.4/luoto-0.4.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1539ccc2eace7d09b80081bb8f37874e4e50e114999393245d240b0966f531b8"
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
