cask "tungsten" do
  version "1.6.1"
  sha256 "767d9b14c4dbed037a1dff40c3b91b8ddb474bd3bfb737a9e053e6a3cf16fa94"

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
