class AppleMail < Formula
  desc "Apple Mail CLI for AI agents: read and triage mail, never sends"
  homepage "https://github.com/Bam679/apple-mail-cli"
  version "0.2.0"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/Bam679/apple-mail-cli/releases/download/v0.2.0/apple-mail_0.2.0_darwin_arm64.tar.gz"
      sha256 "85dc712378d54c5e3081b7397eb0da5e2b73d11b663e89ea594008faab5b27a8"
    end
    on_intel do
      url "https://github.com/Bam679/apple-mail-cli/releases/download/v0.2.0/apple-mail_0.2.0_darwin_amd64.tar.gz"
      sha256 "967b97cdb82a2a374ef2943ad283f85606e2c612170f42a5b1a72fa58d7d5935"
    end
  end

  def install
    bin.install "apple-mail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/apple-mail version")
  end
end
