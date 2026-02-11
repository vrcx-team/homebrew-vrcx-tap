cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-02-11T14.41-4ecc60e"
  sha256 arm:   "43accaa7ed8d1f3aa08985d9787d1fb326032e09a67eec21d88a47470f3cf8a0",
         intel: "cf87e5192fa52a3b8a83e3858b97221aec038065dca6949ace14dfcaaee60d6b"

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
