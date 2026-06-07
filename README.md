# builder-product — AI Product Skills Pack v0.1.0

> Private — not yet published. Maturing before public release.

Skills and agents that enforce product quality for AI features: PRDs that define success before scoping, features validated against real user needs before committing, metrics defined before the feature ships, and experiments designed with stopping rules before they run.

## Status

Early draft. Skills under development. Not ready for external use.

## Planned Skills

| Skill | What It Enforces |
|---|---|
| `prd-quality-gate` | Success metric, user problem, scope boundary, and anti-goals defined before any estimate |
| `feature-scoping` | Scope before estimate; estimate before commit; no open-ended "we'll see" specs |
| `metric-definition` | North star, guardrail, and diagnostic metrics defined before build begins |
| `user-research-synthesis` | Insight → decision chain documented; no "users said X" without "therefore we will Y" |
| `ab-test-design` | Hypothesis, metric, sample size, duration, and stopping rule before any experiment runs |
| `ai-feature-validation` | AI-specific product risks (hallucination UX, trust calibration, scope creep) addressed in PRD |

## Planned Agents

| Agent | Role |
|---|---|
| `product-critic` (Sonnet) | Reviews PRDs and feature specs against all skill gates |
| `metric-designer` (Sonnet) | Designs measurement frameworks before features are built |
| `research-synthesiser` (Opus) | Synthesises user research into actionable decisions |

## License

MIT — Ricardo Romão Marques Braga
