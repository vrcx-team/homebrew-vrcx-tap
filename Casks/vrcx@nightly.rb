cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-10-25T14.11-4bf0a1a"
  sha256 arm:   "352b4da35f5bbf71b04d048072a9f3a07dff9a75825da1d69df571c3c607df85",
         intel: "220e905b985eaabb13913aca4507b68c3edd2b7d42ddb99abe972679abbe2745"

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
