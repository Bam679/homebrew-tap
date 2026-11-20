class AppleNotes < Formula
  desc "Apple Notes CLI for AI agents with a binary-enforced write policy"
  homepage "https://github.com/Bam679/apple-notes-cli"
  version "0.1.0"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/Bam679/apple-notes-cli/releases/download/v0.1.0/apple-notes_0.1.0_darwin_arm64.tar.gz"
      sha256 "33bd91dd072482e5ddc3fbc4b5c42331bc8ebf2473a3bac53aa8615c3660253d"
    end
    on_intel do
      url "https://github.com/Bam679/apple-notes-cli/releases/download/v0.1.0/apple-notes_0.1.0_darwin_amd64.tar.gz"
      sha256 "dfc8f18e58d4084240c97ba8bdb6ff8dbeb5260b367d963344752e2ac1d51906"
    end
  end

  def install
    bin.install "apple-notes"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/apple-notes version")
  end
end
