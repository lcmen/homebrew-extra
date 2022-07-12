cask "sanesidebuttons" do
  version "1.1.0"
  sha256 "1913091544dd0df51d48f2227c76cc0984400aaf5790c8689c458bd8355f877a"

  url "https://github.com/thealpa/SaneSideButtons/releases/download/#{version}/SaneSideButtons.dmg",
      verified: "github.com/thealpa/SaneSideButtons/"
  name "Sane Side Buttons"
  homepage "https://janhuelsmann.com/sanesidebuttons"

  app "SaneSideButtons.app"
end
