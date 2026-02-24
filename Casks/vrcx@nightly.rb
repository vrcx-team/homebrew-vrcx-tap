cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-02-24T13.11-3639f4c"
  sha256 arm:   "e6bc652173c47191852438dba52672c1c1df71980ecb33259959fb0f8c4d083d",
         intel: "2f5c043b31c7a5bf3b89fe75216574ad0f6406b246eb42d72fb38b55d61840e2"

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
