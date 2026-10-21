cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-10-20T12.01-e387cc5"
  sha256 arm:   "06e1c992e96d36914ec49880705a7ae3cbd664f6790587722604883c53aedd4e",
         intel: "8137007dc81b51fbfdc21a4acf41d8cdc2658a72495fcd39616cf17791abfd19"

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
