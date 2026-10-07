cask "vrcx@nightly" do
  arch arm: "arm64", intel: "x64"

  version "2026-10-07T11.25-d86d3f7"
  sha256 arm:   "00dfee4764992d08adc97ff11b8c8a8d257dc4fb2d4eba2f820c0656440b0f5b",
         intel: "6b2bfd18815f05fdd1905fba3941f19a891772bb16cf74838a5f10fd4db8cc05"

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
