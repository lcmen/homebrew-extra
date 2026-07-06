class NeovimBin < Formula
  desc "Prebuilt Neovim binary for macOS"
  homepage "https://neovim.io"
  version "0.12.4"

  if Hardware::CPU.arm?
    url "https://github.com/neovim/neovim/releases/download/v0.12.4/nvim-macos-arm64.tar.gz"
    sha256 "51ab83afa66d663627c2ab1be43209b0f4e81360d4598b53efaa4d8195f24c89"
  else
    url "https://github.com/neovim/neovim/releases/download/v0.12.4/nvim-macos-x86_64.tar.gz"
    sha256 "03fe16f8dd9f1e9eaf52d5e294913a39917b9e2faea30d7fb0fb385fbd36fe59"
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
