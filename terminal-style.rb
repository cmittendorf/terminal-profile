require "formula"

class TerminalStyle < Formula
  homepage "https://github.com/cmittendorf/SetTerminalStyle"
  url "https://github.com/cmittendorf/SetTerminalStyle/archive/1.0.0.zip"
  sha1 "b63f30221534f347fad2f5da15f1a645de86bed6"

  head "https://github.com/cmittendorf/SetTerminalStyle", :branch => "master"

  depends_on :macos => :mountain_lion
  depends_on :xcode

  def install
    # Remove unrecognized options if warned by configure
    system 'xcodebuild', "-project", "SetTerminalStyle.xcodeproj",
                         "-target", "SetTerminalStyle",
                         "SYMROOT=build", "DSTROOT=#{buildpath}",
                         "-verbose", "install"
    man1.install "SetTerminalStyle.1" => "terminal-style.1"
    bin.install "usr/local/bin/SetTerminalStyle" => "terminal-style"
  end

  test do
    system "#{bin}/terminal-style", "-c"
  end
end
