cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-09-30T21.59-c6a4d8b"
  sha256 arm:   "4c7140d98431c8256a45e57d652e830ddb45b880412af930610ee21a3a31be49",
         intel: "88c7c24871bf6aa48e5eee2d2f5e292d81f121e216dc1a14078f62fd63806e4c"

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
