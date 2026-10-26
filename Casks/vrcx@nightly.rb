cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-10-26T08.30-0678985"
  sha256 arm:   "e27f1cc16352e8688b87461620d5d301a7196db5e38ae8e9157ad907b6488947",
         intel: "e6d90aee702ec901d4cf2ff136e2985d2121ec6d0e729fce08bf70109e07e932"

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
