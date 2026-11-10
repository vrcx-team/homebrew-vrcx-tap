cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-11-10T11.23-ab378a0"
  sha256 arm:   "9ddb16e3de56ed2d00bc3661f57a6c00effe75f79a0f9ca5569a573cd6b979a4",
         intel: "08f30ea0e099a8fc8fa1f94c0883ab6f3e252fa559459f0655c3cdcd28911bc4"

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
