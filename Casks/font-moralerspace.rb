cask "font-moralerspace" do
  version "0.0.11"
  sha256 :no_check

  url "https://github.com/yuru7/moralerspace/releases/download/v#{version}/Moralerspace_v#{version}.zip"
  name "moralerspace"
  desc "Programming font based on Monaspace and IBM Plex Sans JP"
  homepage "https://github.com/yuru7/moralerspace"

  font "Moralerspace_v#{version}/MoralerspaceNeon-Bold.ttf"
  font "Moralerspace_v#{version}/MoralerspaceNeon-BoldItalic.ttf"
  font "Moralerspace_v#{version}/MoralerspaceNeon-Italic.ttf"
  font "Moralerspace_v#{version}/MoralerspaceNeon-Regular.ttf"
  font "Moralerspace_v#{version}/MoralerspaceArgon-Bold.ttf"
  font "Moralerspace_v#{version}/MoralerspaceArgon-BoldItalic.ttf"
  font "Moralerspace_v#{version}/MoralerspaceArgon-Italic.ttf"
  font "Moralerspace_v#{version}/MoralerspaceArgon-Regular.ttf"
end
