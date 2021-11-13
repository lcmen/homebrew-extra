class NeovimBin < Formula
  desc "Binary based formula for installing Neovim on MacOS."
  homepage "https://neovim.io"
  url "https://github.com/neovim/neovim/releases/download/stable/nvim-macos.tar.gz"
  version "0.5.1"
  sha256 "d736845b8b63e443970ea93636dfbde3e2673a70d2058c057e41b836ac4f6f6c"

  conflicts_with "neovim", because: "neovim also ships a nvim binary"

  def install
    chmod 0755, "bin/nvim"

    libexec.install "bin", "libs", "lib", "share"
    bin.install_symlink libexec/"bin/nvim"
  end

  test do
    assert (bin/"nvim").exist?, "neovim binary does not exist"
  end
end
