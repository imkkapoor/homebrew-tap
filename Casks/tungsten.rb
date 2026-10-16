cask "tungsten" do
  version "1.5.0"
  sha256 "f2a90927c34f94b2ebcdc55ac494c95b8617aa77499af77ac008d00591593978"

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
