class NeovimBin < Formula
  desc "Binary based formula for installing Neovim on MacOS."
  homepage "https://neovim.io"
  url "https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-macos-arm64.tar.gz"
  version "0.11.2"
  sha256 "e14c092d91f81ec5f1d533baae2b20730e93316eb4aafec0d2d00f0e0193d39e"

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
