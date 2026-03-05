cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-03-05T13.39-cb1aea6"
  sha256 arm:   "3edfc0291740c23e105aa83c02f3e51241ca08d82c24cac389305a33eb26e0d0",
         intel: "9b531f00df294d927a3c8c1318d8b4f477b828e6e5671b558688a33539c0930c"

  url "https://github.com/Natsumi-sama/VRCX/releases/download/#{version}/VRCX_#{version}_#{arch}.dmg",
      verified: "github.com/Natsumi-sama/VRCX/"
  name "VRCX"
  desc "VRChat companion app"
  homepage "https://vrcx.app/"

  livecheck do
    url "https://api.github.com/repos/natsumi-sama/vrcx/releases/latest"
    strategy :json do |json|
      json["tag_name"]&.sub(/^v/, "")
    end
  end

  depends_on macos: ">= :monterey"

  app "VRCX.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/VRCX.app"]
  end

  zap trash: [
    "~/Library/Application Support/VRCX",
    "~/Library/Preferences/app.vrcx.plist",
    "~/Library/Saved Application State/app.vrcx.savedState",
  ]
end
