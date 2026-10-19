cask "ropy" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.6.0"
  sha256 arm:   "e964c9bc8041774d0bfb33a07b7a97c4afba798d5108ba88de13607d8d791bef",
         intel: "c8f55707458c31c71e383cf8533b8a1d420345219d54f98c5b345f1275b1330c"

  url "https://github.com/StudentWeis/ropy/releases/download/#{version}/ropy-#{arch}-apple-darwin.dmg"
  name "Ropy"
  desc "Clipboard manager built with Rust and GPUI"
  homepage "https://github.com/StudentWeis/ropy"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Ropy.app"

  # Cask moves the bundle to /Applications, outside the Homebrew prefix.
  # Use Ropy's existing publisher marker to leave upgrades to Homebrew.
  postflight_steps do
    touch "Ropy.app/Contents/.ropy-managed", base: :appdir
    # Unsigned releases: clear only this installed bundle's download quarantine.
    # A missing attribute is harmless; other failures remain visible on stderr.
    run "/usr/bin/xattr",
        args:         ["-r", "-d", "com.apple.quarantine", "{{appdir}}/Ropy.app"],
        must_succeed: true
  end

  uninstall quit: "com.ropy.app"
end
