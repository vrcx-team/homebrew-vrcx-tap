cask "vrcx" do
  arch arm: "arm64", intel: "x64"

  version "2026.09.16"
  sha256 arm:   "45293b33a96ba222052edba71fcf42306cb220ebe2591b462372a7d14467f2b3",
         intel: "0e7687531d14c4e6a788ee98c55e828754db2bfceeab0b1997b0a3613cea74ff"

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
