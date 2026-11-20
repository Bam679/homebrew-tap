class Paperless < Formula
  desc "Paperless-ngx CLI for AI agents with a binary-enforced write policy"
  homepage "https://github.com/Bam679/paperless-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Bam679/paperless-cli/releases/download/v0.1.0/paperless_0.1.0_darwin_arm64.tar.gz"
      sha256 "6a66627464879aaaac86cbd28d8c56acfc1763246e4e512494f3e7aed7e243c1"
    end
    on_intel do
      url "https://github.com/Bam679/paperless-cli/releases/download/v0.1.0/paperless_0.1.0_darwin_amd64.tar.gz"
      sha256 "dab5cf28355133757ed84b82a14784275c9819ab3a0406dc5b6d5249b57fe0fc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Bam679/paperless-cli/releases/download/v0.1.0/paperless_0.1.0_linux_arm64.tar.gz"
      sha256 "ae7527193aeb3199ced6889940f22b02efba07095df8de36d7e4cdaec9f9d22b"
    end
    on_intel do
      url "https://github.com/Bam679/paperless-cli/releases/download/v0.1.0/paperless_0.1.0_linux_amd64.tar.gz"
      sha256 "1ed4c7de06a2b2eee38cb9b081f619bc5ab68949a605ad53cfa7bf98ba3d5d06"
    end
  end

  def install
    bin.install "paperless"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/paperless version")
  end
end
