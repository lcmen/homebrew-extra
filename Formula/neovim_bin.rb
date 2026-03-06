class NeovimBin < Formula
  desc "Binary based formula for installing Neovim on MacOS."
  homepage "https://neovim.io"
  version "0.11.6"

  on_arm do
    url "https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-macos-arm64.tar.gz"
    sha256 "d5ee93b67630d5a87f3d336d0f7e8b2fe6973aa653d3cc93b82b820e6538c1dd"
  end

  on_intel do
    url "https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-macos-x86_64.tar.gz"
    sha256 "6e665bb0a711cf974050e0f7183dbb696b1e7425814eb87df7cb094a49054a06"
  end

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
