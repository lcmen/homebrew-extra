class GoPty < Formula
  desc "Terminal multiplexer for Go applications"
  homepage "https://github.com/lcmen/go-pty"
  version "0.2.0"

  on_arm do
    url "https://github.com/lcmen/go-pty/releases/download/v0.2.0/go-pty-darwin-arm64"
    sha256 "ffdd61f93998e907eea554a9660eb40c7f87a2ad8e43ee0842ad98da4e975e36"
  end

  on_intel do
    url "https://github.com/lcmen/go-pty/releases/download/v0.2.0/go-pty-darwin-amd64"
    sha256 "853f7fe71c001ef9a53f73e0406f29779f5d1f8eb0f2f3eee6f8f1f5d10f18d6"
  end

  def install
    binary = if Hardware::CPU.arm?
               "go-pty-darwin-arm64"
             else
               "go-pty-darwin-amd64"
             end
    bin.install binary => "go-pty"
  end

  test do
    assert (bin/"go-pty").exist?, "go-pty binary does not exist"
  end
end
