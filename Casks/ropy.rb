cask "ropy" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.7.0"
  sha256 arm:   "5deeac977a04b4685d3e77649808e5fcf1d4a25208c344b65f1fce54b486efa1",
         intel: "6a01c374ce4165901a036f0a6b86a16fc860c58b1510f57a217a34b2b9870470"

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
