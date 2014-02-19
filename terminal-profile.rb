require "formula"

class TerminalProfile < Formula
  homepage "https://github.com/cmittendorf/terminal-profile"
  url "https://github.com/cmittendorf/terminal-profile/archive/1.0.0.zip"
  sha1 "892ea4e6383bc21f5a2defb18738b80dcd489e15"

  head "https://github.com/cmittendorf/terminal-profile", :branch => "master"

  depends_on :macos => :mountain_lion
  depends_on :xcode

  def install
    # Remove unrecognized options if warned by configure
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
