class AgePluginYubikey < Formula
  desc "Yubikey plugin for Age"
  homepage "https://github.com/str4d/age-plugin-yubikey"
  url "https://github.com/str4d/age-plugin-yubikey/releases/download/v0.1.0/age-plugin-yubikey-v0.1.0-x86_64-darwin.tar.gz"
  version "0.1.0"
  sha256 "39d164f68ce9a78455b4da8facd8be9a5a158bb61e579f6783b6860513866163"

  depends_on "age"

  def install
    chmod 0555, "age-plugin-yubikey"

    bin.install "age-plugin-yubikey"
  end

  test do
    assert (bin/"age-plugin-yubikey").exist?, "Yubikey plugin for Age does not exist"
  end
end
