class AppleNotes < Formula
  desc "Apple Notes CLI for AI agents with a binary-enforced write policy"
  homepage "https://github.com/Bam679/apple-notes-cli"
  version "0.2.0"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/Bam679/apple-notes-cli/releases/download/v0.2.0/apple-notes_0.2.0_darwin_arm64.tar.gz"
      sha256 "d26608517b98e3bb3c7067ccf4ca23bef9d35a2e3ad7ed9ca2d03eddab05a3fb"
    end
    on_intel do
      url "https://github.com/Bam679/apple-notes-cli/releases/download/v0.2.0/apple-notes_0.2.0_darwin_amd64.tar.gz"
      sha256 "144e30455c3779d1b439a79335ad6c0d259e9521b537d3505373dce6a2df1518"
    end
  end

  def install
    bin.install "apple-notes"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/apple-notes version")
  end
end
