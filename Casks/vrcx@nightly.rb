cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-03-11T13.25-69ca00a"
  sha256 arm:   "14aa50ed5fb3d65ebbbd4bbd79fa945ca927fe2a3466e97cb4aef37b84f54c67",
         intel: "2bb2f8c2ab0299dc42819346013ae8b6aff6cd4cc2904ac9cd5d6f08b850bdf6"

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
