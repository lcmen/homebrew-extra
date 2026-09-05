class GoPty < Formula
  desc "Terminal multiplexer for Go applications"
  homepage "https://github.com/lcmen/go-pty"
  version "0.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lcmen/go-pty/releases/download/v0.3.1/go-pty-darwin-arm64"
      sha256 "4689b2f9693a65f8ad46544fa9a318cea98fd2c451a527020deb897c232c21ad"
    else
      url "https://github.com/lcmen/go-pty/releases/download/v0.3.1/go-pty-darwin-amd64"
      sha256 "a442bb8e704e2fa42ac54f6ab51d97bc24d36f02b9dd7c6559b00adeacecc66a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lcmen/go-pty/releases/download/v0.3.1/go-pty-linux-arm64"
      sha256 "8a8d4d4470ab1b105e103055a7189f366a5806cfac4b1cf08a35b6e5ce37fe7e"
    else
      url "https://github.com/lcmen/go-pty/releases/download/v0.3.1/go-pty-linux-amd64"
      sha256 "e265b7fdcbfa8b301e24894f20586006faf7161cf512ee625ae5dd6bf1664002"
    end
  end

  def install
    asset_name = Dir["go-pty-*"].first

    chmod 0755, asset_name
    bin.install asset_name => "go-pty"
  end

  test do
    assert_path_exists bin/"go-pty"
  end
end
