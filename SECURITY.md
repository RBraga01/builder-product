# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in builder-product, please report it privately.

**Do not open a public GitHub issue for security vulnerabilities.**

Report via email to the repository owner or use [GitHub's private vulnerability reporting](https://github.com/RBraga01/builder-product/security/advisories/new).

Include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Any suggested fix

You will receive a response within 5 business days.

## Scope

This pack consists of markdown skill files and shell/PowerShell install scripts. Security concerns specific to this pack include:

- **Install script integrity**: The install scripts clone from GitHub over HTTPS. A supply chain compromise of this repository would affect anyone running the install scripts. If you suspect the repository has been compromised, report immediately.
- **Path traversal**: The install scripts accept a target directory argument. Passing `../../sensitive-dir` as the target could write files outside the intended location.
- **No code execution**: The skills and agents are markdown files read by Claude Code. They do not execute independently.

## Supported Versions

| Version | Supported |
|---------|-----------|
| 1.x     | Yes       |
