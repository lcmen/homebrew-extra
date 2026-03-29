class NeovimBin < Formula
  desc "Binary based formula for installing Neovim on MacOS."
  homepage "https://neovim.io"
  version "0.11.7"

  on_arm do
    url "https://github.com/neovim/neovim/releases/download/v0.11.7/nvim-macos-arm64.tar.gz"
    sha256 "9c84686ce84bbab725ff3d88ca3ac1d6da5a72128b68d9dd8094e34d4049a126"
  end

  on_intel do
    url "https://github.com/neovim/neovim/releases/download/v0.11.7/nvim-macos-x86_64.tar.gz"
    sha256 "014649c0c75e188fd70d40f787ee7cb83e7c2926264cd4e72c300d0198922371"
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
