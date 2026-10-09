# Homebrew cask for Buddy -- written by tools/homebrew-cask.js in
# github.com/akshatgg/Buddy for every release; edit that, not this file.
#
#   brew install --cask akshatgg/tap/buddy
#
# Homebrew ADDS com.apple.quarantine to casks. The postflight clears it, which
# is the same permission System Settings -> Privacy & Security -> Open Anyway
# grants by hand: the app is ad-hoc signed, not notarized (that needs a paid
# Apple Developer ID).

cask "buddy" do
  version "1.2.5"
  sha256 "2383473e36b41409531baa26ab6159db63e541328f5b0ee2eb11c99c4191f248"

  url "https://github.com/akshatgg/Buddy/releases/download/v#{version}/Buddy-arm64.dmg"
  name "Buddy"
  desc "3D buddy that writes, fixes and checks your English in any app"
  homepage "https://buddywrites.vercel.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Buddy.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Buddy.app"],
        must_succeed: false
  end

  uninstall quit: "com.akshatgg.buddy"

  zap trash: [
    "~/Library/Application Support/Buddy",
    "~/Library/Caches/com.akshatgg.buddy",
    "~/Library/HTTPStorages/com.akshatgg.buddy",
    "~/Library/Preferences/com.akshatgg.buddy.plist",
    "~/Library/Saved Application State/com.akshatgg.buddy.savedState",
  ]
end
