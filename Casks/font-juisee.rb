cask "font-juisee" do
  version "0.0.4"
  sha256 "36f7bac0e89d76719d6948fc042721331e22c5a683c5f10de7ddb0ff12c2dde1"

  url "https://github.com/yuru7/juisee/releases/download/v#{version}/Juisee_v#{version}.zip"
  name "Juisee"
  desc "Programming font based on JuliaMono and LINE Seed JP"
  homepage "https://github.com/yuru7/juisee"

  font "Juisee_v#{version}/Juisee-Bold.ttf"
  font "Juisee_v#{version}/Juisee-BoldItalic.ttf"
  font "Juisee_v#{version}/Juisee-Regular.ttf"
  font "Juisee_v#{version}/Juisee-RegularItalic.ttf"
end
