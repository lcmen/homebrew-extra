class NeovimBin < Formula
  desc "Binary based formula for installing Neovim on MacOS."
  homepage "https://neovim.io"
  url "https://github.com/neovim/neovim/releases/download/v0.9.0/nvim-macos.tar.gz"
  version "0.7.2"
  sha256 "ba571c320c9ba98f1f78a9656b0b1fd21aa5833a61054f377c15c09366b96aca"

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
