class NeovimBin < Formula
  desc "Binary based formula for installing Neovim on MacOS."
  homepage "https://neovim.io"
  version "0.12.1"

  on_arm do
    url "https://github.com/neovim/neovim/releases/download/v0.12.1/nvim-macos-arm64.tar.gz"
    sha256 "b77e01c5421ac1bac593eed5c2ea1b950439306dd4c32371ac2473792da9a9d5"
  end

  on_intel do
    url "https://github.com/neovim/neovim/releases/download/v0.12.1/nvim-macos-x86_64.tar.gz"
    sha256 "e59a5eafcdf824e2bf6a738e75f8f62ba4ff1b7f1c7daaec2d134aa46737907c"
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
