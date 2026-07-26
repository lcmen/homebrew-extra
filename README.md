# My Homebrew formulas and casks

## How do I install these?

### Homebrew

`brew install lcmen/extra/<formula>`

Or `brew tap lcmen/extra` and then `brew install <formula>`.

## mise

[mise](https://mise.jdx.dev/) 2026.6.6 or newer can provision these formulas directly, without invoking Homebrew.

Use the fully qualified formula names in your mise configuration:

```toml
[bootstrap.packages]
"brew:lcmen/extra/compartment" = "latest"
"brew:lcmen/extra/go-pty" = "latest"
"brew:lcmen/extra/libvips-lite" = "latest"
"brew:lcmen/extra/neovim-bin" = "latest"
```

Then apply them with:

```sh
mise bootstrap packages apply
```

## Available Formulas

- [compartment](https://www.mendelowski.com/compartment/) - Docker-based CLI tool for managing local development services
- [go-pty](https://www.mendelowski.com/go-pty/) - Terminal multiplexer for Go applications
- [libvips-lite](https://github.com/lcmen/homebrew-extra/releases?q=libvips-lite&expanded=true) - Image processing library, stripped down for Rails image variants
- `neovim-bin` - Neovim binary without any dependencies
