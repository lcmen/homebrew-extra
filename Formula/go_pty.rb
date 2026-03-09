class GoPty < Formula
  desc "Terminal multiplexer for Go applications"
  homepage "https://github.com/lcmen/go-pty"
  version "0.1.0"

  on_arm do
    url "https://github.com/lcmen/go-pty/releases/download/v0.1.0/go-pty-darwin-arm64"
    sha256 "dce216009e2728abb5418301abb81b8640a728c7dc0161a570582e4afa730f50"
  end

  on_intel do
    url "https://github.com/lcmen/go-pty/releases/download/v0.1.0/go-pty-darwin-amd64"
    sha256 "f28a5e9f9b3e185f30b359913f6fd773ee7c809869ea497deb46ea920214e648"
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
