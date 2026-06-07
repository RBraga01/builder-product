# builder-product — AI Product Skills Pack v1.0.0

> Private — not yet published. Maturing before public release.

Skills and agents that enforce product quality before engineering time is committed: problems defined before scopes, metrics instrumented before builds, research synthesised into decisions before planning, and AI features validated for hallucination UX, trust calibration, and reversibility before approval.

## Status

v1.0.0 — complete and usable. Not yet publicly announced.

## Skills

| Skill | What It Enforces |
|---|---|
| `prd-quality-gate` | User problem + success metric + scope boundary + anti-goals before any estimate |
| `feature-scoping` | Written scope before estimate; estimate before commit; no open-ended "we'll see" specs |
| `metric-definition` | North star, guardrail, and diagnostic metrics with baselines before build begins |
| `user-research-synthesis` | Insight → decision chain documented; no "users said X" without "therefore we will Y" |
| `ab-test-design` | Hypothesis, metric, sample size, duration, stopping rule, decision rule before any test runs |
| `ai-feature-validation` | Hallucination UX, trust calibration, capability scope, and reversibility in every AI PRD |

## Agents

| Agent | Role |
|---|---|
| `product-critic` (Sonnet) | Reviews PRDs and feature specs against all skill gates; PASS / CONDITIONAL / BLOCK |
| `metric-designer` (Sonnet) | Designs measurement frameworks with verified baselines before features are built |
| `research-synthesiser` (Opus) | Synthesises user research into an insight → decision chain |

## Install

```bash
# bash (macOS / Linux / WSL)
bash <(curl -fsSL https://raw.githubusercontent.com/RBraga01/builder-product/master/install.sh)

# PowerShell (Windows)
irm https://raw.githubusercontent.com/RBraga01/builder-product/master/install.ps1 | iex
```

Or clone directly:
```bash
git clone https://github.com/RBraga01/builder-product
cp -rn builder-product/skills your-project/
cp -rn builder-product/.claude your-project/
```

## License

MIT — Ricardo Romão Marques Braga
