cask "tungsten" do
  version "1.7.2"
  sha256 "6cabc55e58c5c381d0297f37c243febd51d81071a30c4879dfcb7b32befe4435"

  url "https://github.com/imkkapoor/tungsten.wtf/releases/download/v#{version}/Tungsten-#{version}-arm64.dmg"
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
