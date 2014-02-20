require "formula"

class TerminalProfile < Formula
  url "https://github.com/cmittendorf/terminal-profile/archive/0.9.0.zip"
  homepage "https://github.com/cmittendorf/terminal-profile"
  sha1 "a9a6b26c63fbd5d41ecca3b06dcd9cfacac0689f"

  head "https://github.com/cmittendorf/terminal-profile", :branch => "master"

  depends_on :macos => :mountain_lion
  depends_on :xcode

  def install
    system 'xcodebuild', "-project", "TerminalProfile.xcodeproj",
                         "-target", "terminal-profile",
                         "SYMROOT=build", "DSTROOT=#{buildpath}",
                         "-verbose", "install"
    man1.install "terminal-profile.1"
    bin.install "usr/local/bin/terminal-profile" => "terminal-profile"
  end

  test do
    system "#{bin}/terminal-profile", "-c"
  end
end
