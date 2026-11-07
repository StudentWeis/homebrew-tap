cask "ropy" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.6.2"
  sha256 arm:   "8e1566df377c37fa51cf3ce6b170685d8ae4cd2aed23c838e612f394db964f45",
         intel: "c8c6c6c20599ab2727dace1c5240f2c2edbd736ec2bc4fbeb32a2cc68c3a29b3"

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
