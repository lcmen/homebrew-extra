class GoPty < Formula
  desc "Terminal multiplexer for Go applications"
  homepage "https://github.com/lcmen/go-pty"
  version "0.1.1"

  on_arm do
    url "https://github.com/lcmen/go-pty/releases/download/v0.1.1/go-pty-darwin-arm64"
    sha256 "38abe1e60425ebb2bf8d433ae9f7d0fab13c809638a44885cb382590683c1c39"
  end

  on_intel do
    url "https://github.com/lcmen/go-pty/releases/download/v0.1.1/go-pty-darwin-amd64"
    sha256 "2d49e6d2f296cc22910c8dda52536a93ff7dad3ff816896386cb8fc7c11a4144"
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
