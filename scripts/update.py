#!/usr/bin/env python3
"""Regenerate Homebrew formulas from the latest signed releases.

For each tool: fetch the latest release, download checksums.txt and its
Sigstore bundle, verify the bundle with cosign (--verify), and write
Formula/<tool>.rb with the archive URLs and SHA-256 sums. Standard library
only; cosign is called with a fixed argument list, never through a shell.
"""
import json
import os
import subprocess
import sys
import tempfile
import urllib.request

OWNER = "Bam679"
TOOLS = {
    "apple-mail": ("apple-mail-cli", "Apple Mail CLI for AI agents: read and triage mail, never sends", True),
    "apple-notes": ("apple-notes-cli", "Apple Notes CLI for AI agents with a binary-enforced write policy", True),
    "apple-calendar": ("apple-calendar-cli", "Apple Calendar CLI for AI agents with a binary-enforced write policy", True),
    "apple-reminders": ("apple-reminders-cli", "Apple Reminders CLI for AI agents with a binary-enforced write policy", True),
    "paperless": ("paperless-cli", "Paperless-ngx CLI for AI agents with a binary-enforced write policy", False),
}


def get(url, binary=False):
    req = urllib.request.Request(url, headers={"User-Agent": "homebrew-tap-updater"})
    token = os.environ.get("GITHUB_TOKEN")
    if token and url.startswith("https://api.github.com/"):
        req.add_header("Authorization", "Bearer " + token)
    with urllib.request.urlopen(req, timeout=30) as r:  # nosec B310 -- fixed https URLs
        data = r.read()
    return data if binary else data.decode()


def class_name(tool):
    return "".join(p.capitalize() for p in tool.split("-"))


def formula(tool, repo, desc, mac_only, version, sums):
    base = f"https://github.com/{OWNER}/{repo}/releases/download/v{version}"

    def block(os_name, arch, indent):
        name = f"{tool}_{version}_{os_name}_{arch}.tar.gz"
        if name not in sums:
            raise SystemExit(f"{repo} v{version}: {name} missing from checksums.txt")
        pad = " " * indent
        return f'{pad}url "{base}/{name}"\n{pad}sha256 "{sums[name]}"\n'

    out = [f"class {class_name(tool)} < Formula\n",
           f'  desc "{desc}"\n',
           f'  homepage "https://github.com/{OWNER}/{repo}"\n',
           f'  version "{version}"\n',
           '  license "MIT"\n\n']
    if mac_only:
        out.append("  depends_on :macos\n\n")
    out.append("  on_macos do\n    on_arm do\n" + block("darwin", "arm64", 6) + "    end\n    on_intel do\n"
               + block("darwin", "amd64", 6) + "    end\n  end\n")
    if not mac_only:
        out.append("\n  on_linux do\n    on_arm do\n" + block("linux", "arm64", 6) + "    end\n    on_intel do\n"
                   + block("linux", "amd64", 6) + "    end\n  end\n")
    out.append(f'\n  def install\n    bin.install "{tool}"\n  end\n\n')
    out.append(f'  test do\n    assert_match version.to_s, shell_output("#{{bin}}/{tool} version")\n  end\nend\n')
    return "".join(out)


def main(argv):
    verify = "--verify" in argv
    changed = False
    for tool, (repo, desc, mac_only) in TOOLS.items():
        try:
            rel = json.loads(get(f"https://api.github.com/repos/{OWNER}/{repo}/releases/latest"))
        except Exception as e:  # no release yet
            print(f"{tool}: skipped ({e})")
            continue
        version = rel["tag_name"].lstrip("v")
        base = f"https://github.com/{OWNER}/{repo}/releases/download/{rel['tag_name']}"
        checksums = get(base + "/checksums.txt", binary=True)
        if verify:
            with tempfile.TemporaryDirectory() as d:
                c, b = os.path.join(d, "checksums.txt"), os.path.join(d, "bundle.json")
                with open(c, "wb") as f:
                    f.write(checksums)
                with open(b, "wb") as f:
                    f.write(get(base + "/checksums.txt.sigstore.json", binary=True))
                subprocess.run(["cosign", "verify-blob", "--bundle", b,
                                "--certificate-identity-regexp", f"^https://github.com/{OWNER}/{repo}/",
                                "--certificate-oidc-issuer", "https://token.actions.githubusercontent.com", c],
                               check=True, capture_output=True)
        sums = {}
        for line in checksums.decode().splitlines():
            parts = line.split()
            if len(parts) == 2:
                sums[parts[1]] = parts[0]
        text = formula(tool, repo, desc, mac_only, version, sums)
        path = os.path.join("Formula", tool + ".rb")
        old = open(path).read() if os.path.exists(path) else ""
        if old != text:
            with open(path, "w") as f:
                f.write(text)
            changed = True
        print(f"{tool}: {version}{' (verified)' if verify else ''}{' updated' if old != text else ''}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
