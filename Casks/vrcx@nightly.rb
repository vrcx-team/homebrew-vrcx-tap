cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-11-07T16.36-4a63d57"
  sha256 arm:   "d904989bffc95b537512df64afc91e20888244ba022a737fd8c4cd03153b4078",
         intel: "25d398a73722dcf47451f83d9c01b42c4b67e7383299537292e72cc60a860e2e"

  url "https://github.com/Natsumi-sama/VRCX/releases/download/#{version}/VRCX_#{version}_#{arch}.dmg"
  name "VRCX"
  desc "VRChat companion app"
  homepage "https://vrcx.app/"

  livecheck do
    url :url
    strategy :github_latest do |json, _regex|
      json["tag_name"]
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
