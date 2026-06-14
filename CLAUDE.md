# builder-product — Claude Configuration

## Pack Version

builder-product — AI Product Skills Pack v1.0.0

## File Conventions

| Artifact | Path |
|---|---|
| PRDs | `product/prd/<feature>-<date>.md` |
| Feature scopes | `product/scopes/<feature>-<date>.md` |
| Metric plans | `product/metrics/<feature>-<date>.md` |
| Research synthesis | `product/research/<project>-synthesis-<date>.md` |
| Experiment designs | `product/experiments/<feature>-design-<date>.md` |
| AI feature validations | `product/ai-validation/<feature>-<date>.md` |
| Product critiques | `product/reviews/<feature>/<date>-product-critique.md` |

## Skill Trigger Sequence

For any new feature:

0. `mvp-scope-validator` → before any PRD, when the idea may be over-scoped — extract hypothesis and define minimum scope
1. `prd-quality-gate` → defines the problem and success metric
2. `feature-scoping` → written scope before any estimate
3. `metric-definition` → measurement plan with baselines before code
4. `ai-feature-validation` → required if any LLM call is involved
5. `user-research-synthesis` → if any research was done, synthesise before using it
6. `ab-test-design` → before any experiment that informs a ship/no-ship decision

## Agent Usage

| Agent | When to Use |
|---|---|
| `product-critic` | After writing any PRD or feature spec, before engineering time is committed |
| `metric-designer` | When designing measurement frameworks for new features |
| `research-synthesiser` | After user research sessions, before decisions are made |

## What Makes This Pack Different From Generic Product Frameworks

Standard product frameworks produce documents. This pack produces decisions:
- Every PRD has a measurable success metric with a baseline
- Every estimate references a written scope
- Every research report has an insight → decision chain
- Every AI feature addresses hallucination UX, trust calibration, and reversibility

A completed gate means a decision was made. Not a document was written.
