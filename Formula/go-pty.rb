class GoPty < Formula
  desc "Terminal multiplexer for Go applications"
  homepage "https://github.com/lcmen/go-pty"
  version "0.3.1"

  if Hardware::CPU.arm?
    url "https://github.com/lcmen/go-pty/releases/download/v0.3.1/go-pty-darwin-arm64"
    sha256 "4689b2f9693a65f8ad46544fa9a318cea98fd2c451a527020deb897c232c21ad"
  else
    url "https://github.com/lcmen/go-pty/releases/download/v0.3.1/go-pty-darwin-amd64"
    sha256 "a442bb8e704e2fa42ac54f6ab51d97bc24d36f02b9dd7c6559b00adeacecc66a"
  end

  def install
    bin.install File.basename(stable.url) => "go-pty"
  end

  test do
    assert_path_exists bin/"go-pty"
  end
end
