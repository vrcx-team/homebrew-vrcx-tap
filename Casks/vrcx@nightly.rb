cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-02-26T11.38-87f1aee"
  sha256 arm:   "654b59f6c5995551b7cf8116f4b87d7d7a8b0106c4c143a1049a40cdcbf9e67c",
         intel: "6d3f98f259840dfef6b187d9e4d6142463316fa80fc01cf7e38b062b404824bb"

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
