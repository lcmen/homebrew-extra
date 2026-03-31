class Compartment < Formula
  desc "Docker-based CLI tool for managing local development services"
  homepage "https://github.com/lcmen/compartment"
  version "0.1.3"

  on_arm do
    url "https://github.com/lcmen/compartment/releases/download/v0.1.3/compartment-darwin-arm64"
    sha256 "e5ca8d443699cf1081143d99447dba04c2d3894247f2fe23bf71181974d1240d"
  end

  on_intel do
    url "https://github.com/lcmen/compartment/releases/download/v0.1.3/compartment-darwin-amd64"
    sha256 "5e3333d076548794791f20154892067f44953d1a6e6dfb58419f122bb75ec40b"
  end

  def install
    binary = if Hardware::CPU.arm?
               "compartment-darwin-arm64"
             else
               "compartment-darwin-amd64"
             end
    bin.install binary => "compartment"
  end

  test do
    assert (bin/"compartment").exist?, "compartment binary does not exist"
  end
end
