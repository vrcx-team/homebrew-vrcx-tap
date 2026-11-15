cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-11-15T13.19-0224acf"
  sha256 arm:   "12cfdbe64738a6c73bc38f363855501d9f93fc2b37cfa6b1e6e64701c44c7b02",
         intel: "176c3b8b0918ae31934c4fb8e93154bd7364de0a03939fc15d59e182be5ffb64"

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
