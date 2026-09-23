cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-09-17T13.06-1248dd5"
  sha256 arm:   "347644ceb317df77ceee707df4b993e4c245da954402d92566eb032b1c889a99",
         intel: "3f90df5f5ff63a12bced02ea763375ce85b16252ad594b1bf497e7ce675f7ca0"

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
