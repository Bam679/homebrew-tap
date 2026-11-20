class AppleCalendar < Formula
  desc "Apple Calendar CLI for AI agents with a binary-enforced write policy"
  homepage "https://github.com/Bam679/apple-calendar-cli"
  version "0.1.0"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/Bam679/apple-calendar-cli/releases/download/v0.1.0/apple-calendar_0.1.0_darwin_arm64.tar.gz"
      sha256 "289848bc28e0634a14a58f0ff4f9c75df837bdf681ca49286b98d910d3a21804"
    end
    on_intel do
      url "https://github.com/Bam679/apple-calendar-cli/releases/download/v0.1.0/apple-calendar_0.1.0_darwin_amd64.tar.gz"
      sha256 "37a1127fe91cd8ba7ab4b3cce19d46855138a8e3fc886df183f56894cf60a4dc"
    end
  end

  def install
    bin.install "apple-calendar"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/apple-calendar version")
  end
end
