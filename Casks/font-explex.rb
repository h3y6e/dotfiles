cask "font-explex" do
  version "0.0.3"
  sha256 :no_check

  url "https://github.com/yuru7/Explex/releases/download/v#{version}/Explex_v#{version}.zip"
  name "Explex"
  desc "Programming font based on 0xProto and IBM Plex Sans JP"
  homepage "https://github.com/yuru7/Explex"

  font "Explex_v#{version}/Explex35Console/Explex35Console-Bold.ttf"
  font "Explex_v#{version}/Explex35Console/Explex35Console-BoldItalic.ttf"
  font "Explex_v#{version}/Explex35Console/Explex35Console-Regular.ttf"
  font "Explex_v#{version}/Explex35Console/Explex35Console-Italic.ttf"
end
