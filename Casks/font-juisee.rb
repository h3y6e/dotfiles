cask "font-juisee" do
  version "0.2.0"
  sha256 :no_check

  url "https://github.com/yuru7/juisee/releases/download/v#{version}/Juisee_v#{version}.zip"
  name "Juisee"
  desc "Programming font based on JuliaMono and LINE Seed JP"
  homepage "https://github.com/yuru7/juisee"

  font "Juisee_v#{version}/Juisee-Bold.ttf"
  font "Juisee_v#{version}/Juisee-BoldItalic.ttf"
  font "Juisee_v#{version}/Juisee-Regular.ttf"
  font "Juisee_v#{version}/Juisee-RegularItalic.ttf"
end
