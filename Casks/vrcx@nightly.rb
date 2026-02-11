cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-02-10T12.24-3324918"
  sha256 arm:   "226aeb9cdb9b30fbd19983aff3d180b9923ad328867b367c862b2a97f73dc634",
         intel: "3fda3ea42db49ce69f09246c40264745bb55d0fef2798d3ed3c820c973e670cb"

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
