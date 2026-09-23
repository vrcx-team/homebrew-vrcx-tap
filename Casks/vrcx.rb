cask "vrcx" do
  arch arm: "arm64", intel: "x64"

  version "2026.05.03"
  sha256 arm:   "195da71d1f333bee66a1e4600e65cb4421c36d0d6a1bb8ab889ef61bf30e86dc",
         intel: "7523ce1b5339c761929599ec2a9771fcc89e6ea6a6ad577a1d9f81a9d99cd7d6"

  url "https://github.com/vrcx-team/VRCX/releases/download/v#{version}/VRCX_#{version}_#{arch}.dmg"
  name "VRCX"
  desc "VRChat companion app"
  homepage "https://vrcx.app/"

  livecheck do
    url "https://api.github.com/repos/vrcx-team/vrcx/releases/latest"
    strategy :json do |json|
      json["tag_name"]&.sub(/^v/, "")
    end
  end

  depends_on macos: :monterey

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
