class Compartment < Formula
  desc "Docker-based CLI tool for managing local development services"
  homepage "https://github.com/lcmen/compartment"
  version "0.2.0"

  if Hardware::CPU.arm?
    url "https://github.com/lcmen/compartment/releases/download/v0.2.0/compartment-darwin-arm64"
    sha256 "12aa816480b86ab8c025523184e756417a8fe9b5d169759ad2a4a9b22e966393"
  else
    url "https://github.com/lcmen/compartment/releases/download/v0.2.0/compartment-darwin-amd64"
    sha256 "fc6ec815ca8cb759e082a0cb12a92d9733795dac8539970bef73b29cf1771010"
  end

  def install
    bin.install File.basename(stable.url) => "compartment"
  end

  test do
    assert_path_exists bin/"compartment"
  end
end
