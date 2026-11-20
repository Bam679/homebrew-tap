class AppleReminders < Formula
  desc "Apple Reminders CLI for AI agents with a binary-enforced write policy"
  homepage "https://github.com/Bam679/apple-reminders-cli"
  version "0.1.0"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/Bam679/apple-reminders-cli/releases/download/v0.1.0/apple-reminders_0.1.0_darwin_arm64.tar.gz"
      sha256 "9da03d47a66197496ef92b6121f1ceb855e5b102acc93520a7377a54e4445497"
    end
    on_intel do
      url "https://github.com/Bam679/apple-reminders-cli/releases/download/v0.1.0/apple-reminders_0.1.0_darwin_amd64.tar.gz"
      sha256 "ab046316c422da27ce835b8418630d62fcb0a51536d2a9fa773b18b95a4e3630"
    end
  end

  def install
    bin.install "apple-reminders"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/apple-reminders version")
  end
end
