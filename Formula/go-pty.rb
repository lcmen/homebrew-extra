class GoPty < Formula
  desc "Terminal multiplexer for Go applications"
  homepage "https://github.com/lcmen/go-pty"
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lcmen/go-pty/releases/download/v0.3.2/go-pty-darwin-arm64"
      sha256 "d231885fca89256edb4f625c1305ac9e122775b394a1fdd21bb50bcc81f7e4c7"
    else
      url "https://github.com/lcmen/go-pty/releases/download/v0.3.2/go-pty-darwin-amd64"
      sha256 "98ba9b6bf24a33c7d253072db1c62970a7e29ad79a91b12d2409bb527d914950"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lcmen/go-pty/releases/download/v0.3.2/go-pty-linux-arm64"
      sha256 "186648fb205992c681c5dc00843a4c36492a08863e5c62fd7dad66628fdbd22c"
    else
      url "https://github.com/lcmen/go-pty/releases/download/v0.3.2/go-pty-linux-amd64"
      sha256 "34ba1b965c970cefd1ae0b80f7ff1c74d9b4157b473a833db07562c4a3238a72"
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
