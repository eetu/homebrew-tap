class Luoto < Formula
  desc "Create and manage supply-chain-safe dev sandboxes"
  homepage "https://github.com/eetu/luoto"
  version "0.4.5"
  license "MIT"

  on_macos do
    # Desktop notifications under luoto's own name; osascript's come from Script Editor.
    depends_on "terminal-notifier"
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.5/luoto-0.4.5-aarch64-apple-darwin.tar.gz"
      sha256 "5b01e2917425295f25e06018d58411ad8950ff5d7e2626ef25aea2c94b329929"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.5/luoto-0.4.5-x86_64-apple-darwin.tar.gz"
      sha256 "99f60faa47fe777dc81cb564c31a8d99b3f9b91e6c4b14dea24685ccdc9bf211"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/eetu/luoto/releases/download/v0.4.5/luoto-0.4.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0621ca45b0e63424150927599bf552df1d1ccb3cc5391b34667b28ad11e29a6d"
    end
    on_intel do
      url "https://github.com/eetu/luoto/releases/download/v0.4.5/luoto-0.4.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5d0dc0722ec0bf27b0231eef2216d611f90a2815891294bc4379be47057db438"
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
