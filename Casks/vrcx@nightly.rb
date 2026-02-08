cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-02-05T05.35-29494c3"
  sha256 arm:   "67801a4775b286467691507a637dbfa7179fe8ff1d03c4d8c9b6b00052d5130a",
         intel: "ebc1bb63e65d02cbe00357c263927cc6944678b7637156fe0d47ec71a1fa5f1d"

  url "https://github.com/Natsumi-sama/VRCX/releases/download/#{version}/VRCX_#{version}_#{arch}.dmg",
      verified: "github.com/Natsumi-sama/VRCX/"
  name "VRCX"
  desc "VRChat companion app"
  homepage "https://vrcx.app/"

  livecheck do
    url "https://api0.vrcx.app/releases/nightly/latest"
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
