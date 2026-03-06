class GoPty < Formula
  desc "Terminal multiplexer for Go applications"
  homepage "https://github.com/lcmen/go-pty"
  version "0.0.3"

  on_arm do
    url "https://github.com/lcmen/go-pty/releases/download/v0.0.3/go-pty-darwin-arm64"
    sha256 "342f22de723f87a1b4d7022a4607467714711272303eeb2675f171f64122a1d5"
  end

  on_intel do
    url "https://github.com/lcmen/go-pty/releases/download/v0.0.3/go-pty-darwin-amd64"
    sha256 "ec097ec222c9edae9c0bba863b88b803c808bb2aa509477c54d95517abaf9c4b"
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
