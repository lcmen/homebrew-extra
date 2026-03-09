class GoPty < Formula
  desc "Terminal multiplexer for Go applications"
  homepage "https://github.com/lcmen/go-pty"
  version "0.0.4"

  on_arm do
    url "https://github.com/lcmen/go-pty/releases/download/v0.0.4/go-pty-darwin-arm64"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  end

  on_intel do
    url "https://github.com/lcmen/go-pty/releases/download/v0.0.4/go-pty-darwin-amd64"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
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
