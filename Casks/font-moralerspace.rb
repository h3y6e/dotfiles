cask "font-moralerspace" do
  version "0.0.1"
  sha256 "3d4792ebdc5ff1d302f829314a9558e4e2e04e2260ee73395f26a072733becd1"

  url "https://github.com/yuru7/moralerspace/releases/download/v#{version}/moralerspace_v#{version}.zip"
  name "moralerspace"
  desc "Programming font based on Monaspace and IBM Plex Sans JP"
  homepage "https://github.com/yuru7/moralerspace"

  font "moralerspace_v#{version}/MoralerspaceNeon-Bold.ttf"
  font "moralerspace_v#{version}/MoralerspaceNeon-BoldItalic.ttf"
  font "moralerspace_v#{version}/MoralerspaceNeon-Italic.ttf"
  font "moralerspace_v#{version}/MoralerspaceNeon-Regular.ttf"
  font "moralerspace_v#{version}/MoralerspaceArgon-Bold.ttf"
  font "moralerspace_v#{version}/MoralerspaceArgon-BoldItalic.ttf"
  font "moralerspace_v#{version}/MoralerspaceArgon-Italic.ttf"
  font "moralerspace_v#{version}/MoralerspaceArgon-Regular.ttf"
end
