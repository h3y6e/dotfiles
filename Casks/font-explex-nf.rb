cask "font-explex-nf" do
  version "0.0.3"
  sha256 :no_check

  url "https://github.com/yuru7/Explex/releases/download/v#{version}/Explex_NF_v#{version}.zip"
  name "Explex NF"
  desc "Programming font based on 0xProto and IBM Plex Sans JP with Nerd Font"
  homepage "https://github.com/yuru7/Explex"

  font "Explex_NF_v#{version}/Explex35Console_NF/Explex35ConsoleNF-Bold.ttf"
  font "Explex_NF_v#{version}/Explex35Console_NF/Explex35ConsoleNF-BoldItalic.ttf"
  font "Explex_NF_v#{version}/Explex35Console_NF/Explex35ConsoleNF-Regular.ttf"
  font "Explex_NF_v#{version}/Explex35Console_NF/Explex35ConsoleNF-Italic.ttf"
end
