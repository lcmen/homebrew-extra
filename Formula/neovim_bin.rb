class NeovimBin < Formula
  desc "Binary based formula for installing Neovim on MacOS."
  homepage "https://neovim.io"
  url "https://github.com/neovim/neovim/releases/download/stable/nvim-macos.tar.gz"
  version "0.6.1"
  sha256 "3546be6a13f45411731dc4c93b0932f7d6197b4318ea082cafe7b28d843248f9"

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
