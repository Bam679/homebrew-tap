class AppleMail < Formula
  desc "Apple Mail CLI for AI agents: read and triage mail, never sends"
  homepage "https://github.com/Bam679/apple-mail-cli"
  version "0.1.0"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/Bam679/apple-mail-cli/releases/download/v0.1.0/apple-mail_0.1.0_darwin_arm64.tar.gz"
      sha256 "81076da165f1a59f6d0df4b23f8e16a744f55c6e4ae64b9d783f7d1afab40b9f"
    end
    on_intel do
      url "https://github.com/Bam679/apple-mail-cli/releases/download/v0.1.0/apple-mail_0.1.0_darwin_amd64.tar.gz"
      sha256 "dea34116748d470572d4c110d2c4f686c74cad4f9674750c5407758f3db3c0a3"
    end
  end

  def install
    bin.install "apple-mail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/apple-mail version")
  end
end
