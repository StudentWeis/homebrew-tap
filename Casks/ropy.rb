cask "ropy" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.7.1"
  sha256 arm:   "d483cfbe4cb10e08099e33cf4c53632c43ced443cf5e7930464a6da55ef89fde",
         intel: "d41455f3e0f1558bbeefc0364cbe8f7a88680ca337404e809976ac5eb08bbcd0"

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
