class NeovimBin < Formula
  desc "Binary based formula for installing Neovim on MacOS."
  homepage "https://neovim.io"
  url "https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-macos.tar.gz"
  version "0.7.0"
  sha256 "6260a2edb2da35af02b986c8a6506138afcb3f78f81a80734214b2cadf390a42"

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
