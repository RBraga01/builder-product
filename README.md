# builder-product — AI Product Skills Pack v1.0.0

Skills and agents that enforce product quality before engineering time is committed: problems defined before scopes, metrics instrumented before builds, research synthesised into decisions before planning, and AI features validated for hallucination UX, trust calibration, and reversibility before approval.

**[→ Visual overview](https://rbraga01.github.io/builder-product/)**

Works standalone or alongside [A Team](https://github.com/RBraga01/a-team), [builder-ai](https://github.com/RBraga01/builder-ai), [builder-design](https://github.com/RBraga01/builder-design), and [builder-growth](https://github.com/RBraga01/builder-growth).

## Skills

| Skill | What It Enforces |
|---|---|
| `mvp-scope-validator` | Core hypothesis extracted and scope reduced to minimum before any PRD is written |
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

## The builder-* Ecosystem

| Pack | Domain | Skills | Agents |
|---|---|---|---|
| [A Team](https://github.com/RBraga01/a-team) | Engineering baseline | 19 | 25 |
| [builder-ai](https://github.com/RBraga01/builder-ai) | LLM engineering | 8 | 5 |
| [builder-design](https://github.com/RBraga01/builder-design) | AI UI design | 8 | 5 |
| **builder-product** | Product quality | 7 | 3 |
| [builder-growth](https://github.com/RBraga01/builder-growth) | Growth & messaging | 6 | 3 |

All packs share the same enforcement model: Completion Statement Formats that require real values, not summaries.

## License

MIT — Ricardo Romão Marques Braga
