class NeovimBin < Formula
  desc "Prebuilt Neovim binary for macOS"
  homepage "https://neovim.io"
  version "0.12.5"

  if Hardware::CPU.arm?
    url "https://github.com/neovim/neovim/releases/download/v0.12.5/nvim-macos-arm64.tar.gz"
    sha256 "65fb000099e47ca1b762584c484cc833f40e30851a0ec450d4174e16317c1f9b"
  else
    url "https://github.com/neovim/neovim/releases/download/v0.12.5/nvim-macos-x86_64.tar.gz"
    sha256 "81f4518622cb059b450ee2e498c6a1082a222f6bd89589de5bbcf0c6a68aa3fd"
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
