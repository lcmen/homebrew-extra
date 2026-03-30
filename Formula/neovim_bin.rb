class NeovimBin < Formula
  desc "Binary based formula for installing Neovim on MacOS."
  homepage "https://neovim.io"
  version "0.12.0"

  on_arm do
    url "https://github.com/neovim/neovim/releases/download/v0.12.0/nvim-macos-arm64.tar.gz"
    sha256 "cf0137d6961785c34926f879b7a5b5fa0371ab0d6e2959e390e2f00b46165ce9"
  end

  on_intel do
    url "https://github.com/neovim/neovim/releases/download/v0.12.0/nvim-macos-x86_64.tar.gz"
    sha256 "309b3252a04bf8e4043389d3ea9bbb94e17becea2cde74f11f948b4775bbe3d4"
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
