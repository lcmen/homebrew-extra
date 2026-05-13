class GoPty < Formula
  desc "Terminal multiplexer for Go applications"
  homepage "https://github.com/lcmen/go-pty"
  version "0.3.0"

  on_arm do
    url "https://github.com/lcmen/go-pty/releases/download/v0.3.0/go-pty-darwin-arm64"
    sha256 "d5af9bf8e6369c9fcd77fe63e72c01a4306a92f619df5715af74a3e7721d761a"
  end

  on_intel do
    url "https://github.com/lcmen/go-pty/releases/download/v0.3.0/go-pty-darwin-amd64"
    sha256 "e347f57eeede9a72dcbeedd612263406dbd710929792af22cd43dafb8bfc0921"
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
