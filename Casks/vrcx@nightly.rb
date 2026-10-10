cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-10-10T15.19-c75d669"
  sha256 arm:   "6358d34a1640b6fd3e8d8877b28c6c8b2c908cc75049fef9eb3c545de0a03889",
         intel: "c75e6023eb3941c441ecb370d49fed375a44e74ab8611a34f0b61b82cfa8bf95"

  url "https://github.com/Natsumi-sama/VRCX/releases/download/#{version}/VRCX_#{version}_#{arch}.dmg"
  name "VRCX"
  desc "VRChat companion app"
  homepage "https://vrcx.app/"

  livecheck do
    url "https://api.github.com/repos/natsumi-sama/vrcx/releases/latest"
    strategy :json do |json|
      json["tag_name"]&.sub(/^v/, "")
    end
  end

  depends_on macos: :sonoma

  app "VRCX.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/VRCX.app"]
  end

  zap trash: [
    "~/Library/Application Support/VRCX",
    "~/Library/Preferences/app.vrcx.plist",
    "~/Library/Saved Application State/app.vrcx.savedState",
  ]
end
