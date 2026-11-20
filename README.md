# homebrew-tap

Homebrew formulas for the [agent-cli](https://github.com/Bam679/agent-cli-plugins) tools: command-line access to Apple Mail, Notes, Calendar, Reminders and Paperless-ngx for AI coding agents.

## Installation

```sh
brew install Bam679/tap/apple-mail
brew install Bam679/tap/apple-notes
brew install Bam679/tap/apple-calendar
brew install Bam679/tap/apple-reminders
brew install Bam679/tap/paperless
```

`brew upgrade` picks up new releases.

## How the formulas are made

A scheduled workflow reads the latest release of each tool, verifies the cosign signature of its `checksums.txt` against that repository's release workflow, and writes the archive URLs and SHA-256 sums into `Formula/`. The tap needs no access token to the tool repositories, and a formula only changes after the signature check has passed. You can run the same update locally with `python3 scripts/update.py --verify` (needs `cosign`).

## Licence

MIT. See [LICENSE](LICENSE).
