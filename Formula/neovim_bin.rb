class NeovimBin < Formula
  desc "Binary based formula for installing Neovim on MacOS."
  homepage "https://neovim.io"
  url "https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-macos.tar.gz"
  version "0.7.2"
  sha256 "39cb6b62f965dccebe433083e33974e1af3c4579a14bf818066b3d5250968495"

  conflicts_with "neovim", because: "neovim also ships neovim binary"

  def install
    chmod 0755, "bin/nvim"

    libexec.install "bin", "lib", "share"
    bin.install_symlink libexec/"bin/nvim"
  end

  test do
    assert (bin/"nvim").exist?, "neovim binary does not exist"
  end
end
