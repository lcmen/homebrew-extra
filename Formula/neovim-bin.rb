class NeovimBin < Formula
  desc "Prebuilt Neovim binary for macOS"
  homepage "https://neovim.io"
  version "0.12.3"

  if Hardware::CPU.arm?
    url "https://github.com/neovim/neovim/releases/download/v0.12.3/nvim-macos-arm64.tar.gz"
    sha256 "532da1d00e465a660fa01c3d4991333d09c52107dce7df937368545daca0a14e"
  else
    url "https://github.com/neovim/neovim/releases/download/v0.12.3/nvim-macos-x86_64.tar.gz"
    sha256 "4b40e318eb7073321fa5fc06d7f60c3c0de1d7ea50ffbaa8b04286f5484d294f"
  end

  conflicts_with "neovim", because: "neovim also ships neovim binary"

  def install
    chmod 0755, "bin/nvim"

    libexec.install "bin", "lib", "share"
    bin.install_symlink libexec/"bin/nvim"
  end

  test do
    assert_path_exists bin/"nvim"
  end
end
