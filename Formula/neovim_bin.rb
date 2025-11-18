class NeovimBin < Formula
  desc "Binary based formula for installing Neovim on MacOS."
  homepage "https://neovim.io"
  version "0.11.5"

  on_arm do
    url "https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-macos-arm64.tar.gz"
    sha256 "79143d3b408f7034f90b7cf59af2276de09ef8a4c2f1a28e4c99581b249d3107"
  end

  on_intel do
    url "https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-macos-x86_64.tar.gz"
    sha256 "6612760a7037ca2518e456908baf5e43101fa79819d18979fc4d4e8441d9dfa5"
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
