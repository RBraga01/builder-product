# builder-product — Agent Directory

Version: v1.0.0

Three agents. Each produces a file. No file, no completion.

| Agent | Model | Output Path | Verdict Format |
|---|---|---|---|
| `product-critic` | Sonnet | `product/reviews/<feature>/<date>-product-critique.md` | PASS / CONDITIONAL / BLOCK |
| `metric-designer` | Sonnet | `product/metrics/<feature>-<date>.md` | Measurement plan with all baselines verified |
| `research-synthesiser` | Opus | `product/research/<project>-synthesis-<date>.md` | Insights = Decisions count verified |

## product-critic

**Purpose:** Audits PRDs, scopes, and feature specs against all builder-product skill gates before engineering time is committed.

**Trigger:** After any product document is written, before it goes to engineering.

**Does not:**
- Suggest creative feature directions
- PASS a vague metric on the grounds it can be refined later
- Skip Gate 5 (AI validation) for features with any LLM call
- Deliver the critique only in chat

## metric-designer

**Purpose:** Designs north star, guardrail, and diagnostic metrics with verified baselines and a complete logging plan.

**Trigger:** Before writing any implementation code for a new feature.

**Does not:**
- Name metrics that cannot be measured with existing data without logging instrumentation in scope
- Accept "engagement" or "experience" as a metric
- Deliver the measurement plan only in chat

## research-synthesiser

**Purpose:** Translates raw research observations into an insight → decision chain. Every insight has a corresponding decision.

**Trigger:** After user research sessions and before product decisions are made from that research.

**Does not:**
- Produce "we should think about this" decisions
- Promote 2-instance observations to patterns
- Synthesise without a defined research question
- Deliver the synthesis only in chat
