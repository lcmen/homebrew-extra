class LibvipsLite < Formula
  desc "Image processing library, stripped down for Rails image variants"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.18.3/vips-8.18.3.tar.xz"
  sha256 "f41285b61bfb495605494f074ca341f7791a1d406e2f157dcea606ef1ae1b146"

  depends_on "gettext" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => [:build, :test]

  depends_on "cgif"
  depends_on "glib"
  depends_on "libexif"
  depends_on "libnsgif"
  depends_on "libpng"
  depends_on "little-cms2"
  depends_on "mozjpeg"
  depends_on "webp"

  uses_from_macos "python" => :build
  uses_from_macos "expat"
  uses_from_macos "zlib"

  conflicts_with "vips", because: "both install vips binaries, libvips, and vips pkg-config files"

  def install
    # mozjpeg needs to appear before libjpeg, otherwise libvips may pick up
    # Apple's/system libjpeg or another libjpeg-compatible provider.
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["mozjpeg"].opt_lib/"pkgconfig"

    args = %w[
      -Ddeprecated=true
      -Dexamples=false
      -Dcplusplus=false
      -Ddocs=false
      -Dcpp-docs=false
      -Dintrospection=disabled
      -Dvapi=false
      -Dmodules=disabled

      -Djpeg=enabled
      -Dpng=enabled
      -Dwebp=enabled
      -Dcgif=enabled
      -Dexif=enabled
      -Dlcms=enabled
      -Dzlib=enabled

      -Darchive=disabled
      -Dcfitsio=disabled
      -Dfftw=disabled
      -Dfontconfig=disabled
      -Dheif=disabled
      -Dheif-module=disabled
      -Dhighway=disabled
      -Dimagequant=disabled
      -Djpeg-xl=disabled
      -Djpeg-xl-module=disabled
      -Dmagick=disabled
      -Dmagick-module=disabled
      -Dmatio=disabled
      -Dnifti=disabled
      -Dopenexr=disabled
      -Dopenjpeg=disabled
      -Dopenslide=disabled
      -Dopenslide-module=disabled
      -Dorc=disabled
      -Dpangocairo=disabled
      -Dpdfium=disabled
      -Dpoppler=disabled
      -Dpoppler-module=disabled
      -Dquantizr=disabled
      -Draw=disabled
      -Drsvg=disabled
      -Dspng=disabled
      -Dtiff=disabled
      -Duhdr=disabled

      -Dnsgif=true
      -Dppm=false
      -Danalyze=false
      -Dradiance=false
    ]

    system "meson", "setup", "build", *std_meson_args, *args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system bin/"vips", "-l"

    input = test_fixtures("test.png")

    assert_equal "8", shell_output("#{bin}/vipsheader -f width #{input}").chomp

    system bin/"vips", "resize", input, testpath/"resized.jpg", "0.5"
    assert_equal "4", shell_output("#{bin}/vipsheader -f width #{testpath}/resized.jpg").chomp

    system bin/"vips", "copy", input, testpath/"test.webp"
    assert_equal "8", shell_output("#{bin}/vipsheader -f width #{testpath}/test.webp").chomp

    system "pkgconf", "--print-errors", "vips"
  end
end
