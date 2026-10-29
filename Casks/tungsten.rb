cask "tungsten" do
  version "1.8.1"
  sha256 "68d0c9be7573b5c79b22758732779f7ea4987535bc594ae8413af9c4e5f5d0b2"

  url "https://github.com/tungsten-wtf/tungsten.wtf/releases/download/v#{version}/Tungsten-#{version}-arm64.dmg"
  name "Tungsten"
  desc "Pan/zoom canvas of terminal panes"
  homepage "https://www.tungsten.wtf/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Tungsten.app"

  # Ad-hoc signed, not notarized: without this Gatekeeper calls the app damaged.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Tungsten.app"]
  end

  zap trash: [
    "~/Library/Application Support/tungsten",
    "~/Library/Preferences/com.vinayakkapoor.tungsten.plist",
    "~/Library/Saved Application State/com.vinayakkapoor.tungsten.savedState",
  ]
end
