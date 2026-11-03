cask "ropy" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.6.1"
  sha256 arm:   "17cfdc3f865f770dcc79ab813375f2c9ef492d153ead8cac3a90bc4b03c8fc25",
         intel: "39138772bb89dcf5ebc4f5fe0457819861c0c8c320dd9310c95d63b0aad48225"

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
