class NeovimBin < Formula
  desc "Prebuilt Neovim binary for macOS"
  homepage "https://neovim.io"
  version "0.12.2"

  if Hardware::CPU.arm?
    url "https://github.com/neovim/neovim/releases/download/v0.12.2/nvim-macos-arm64.tar.gz"
    sha256 "eeddee1009734f9071266e6b1b8a70308cb60cbcc45f5e1c1023adc471450fee"
  else
    url "https://github.com/neovim/neovim/releases/download/v0.12.2/nvim-macos-x86_64.tar.gz"
    sha256 "728321db960a9b6af6c03881892a6abfd743bf759bc62d233f52fa1be64ace3c"
  end

  conflicts_with "neovim", because: "neovim also ships neovim binary"

  def install
    chmod 0755, "bin/nvim"

    libexec.install "bin", "lib", "share"
    bin.install_symlink libexec/"bin/nvim"
  end

  test do
    assert_path_exists bin/"nvim"
  end
end
