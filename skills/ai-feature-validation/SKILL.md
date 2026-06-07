---
name: ai-feature-validation
description: Use before any AI feature is approved for build. Covers four AI-specific risks that standard PRD review misses: hallucination UX, trust calibration, scope creep, and reversibility. Blocks "we validated it like any other feature" completions.
---

# AI Feature Validation

## The Law

```
AI FEATURES HAVE FAILURE MODES THAT DETERMINISTIC FEATURES DO NOT.
"We validated it like any other feature" misses hallucination UX, trust calibration, scope creep, and irreversibility — none of which appear in a standard acceptance criterion.
All four AI-specific risks addressed in the PRD IS AI feature validation.
```

## When to Use

Trigger before:
- Approving any AI feature for development
- Adding an LLM call to any user-facing surface
- Expanding an existing AI feature's scope or capability
- Reviewing a PRD that includes AI-generated content, predictions, or decisions

## When NOT to Use

- Backend AI pipelines with no user-visible output (use ai-safety-review from builder-ai instead)
- Features where the model output is filtered through deterministic rules before reaching users (the rules are the product; validate the rules)

## The Four AI-Specific Risks

Standard PRD review asks: does the feature solve the user problem? AI feature validation asks four additional questions that standard PRDs never reach.

### Risk 1 — Hallucination UX

What does the product look like when the model is wrong?

Every AI feature produces incorrect outputs. The question is not "will it hallucinate?" but "what does the UX do when it does?"

**Required answers in the PRD:**
- What is the worst plausible incorrect output for this feature? (e.g., "a medical dosage that is wrong by an order of magnitude")
- What does the user see when the model is wrong? Is it distinguishable from a correct output?
- Is there a confidence signal that alerts users to lower-confidence outputs?
- Is there a correction mechanism — can the user flag, override, or report an incorrect output?
- For high-stakes domains: is there an explicit disclaimer at the point of use?

**BLOCK if:**
- Incorrect outputs are visually identical to correct outputs with no uncertainty signal
- There is no correction mechanism for high-stakes outputs (medical, legal, financial, safety)

### Risk 2 — Trust Calibration

Is the user's trust in this feature appropriately calibrated?

AI features fail in two trust directions:
- **Over-trust**: users treat outputs as authoritative when they are probabilistic (they act on hallucinations)
- **Under-trust**: users ignore outputs they should act on (they never adopt the feature)

**Required answers in the PRD:**
- What level of trust is appropriate for this feature's outputs?
- What design choices signal that level of trust? (confidence scores, citations, "verify before acting" copy, etc.)
- Is the onboarding designed to calibrate trust from the first session? (see `ai-onboarding-design` from builder-design)
- How will you measure trust calibration? (e.g., "rate of users acting on AI output without any verification, tracked before/after trust signal changes")

**BLOCK if:**
- The feature design for high-stakes decisions presents AI output as definitive with no uncertainty signal
- There is no plan to measure whether users are over- or under-trusting the model

### Risk 3 — Scope Creep of Capability

What happens as the model gets better — does the feature's scope expand automatically?

Model improvements can silently expand what the AI can do. Without boundaries:
- The AI starts answering questions outside its designed scope
- The AI takes actions beyond its intended authority
- Users develop expectations the feature was never designed to meet

**Required answers in the PRD:**
- Is the AI's capability scope explicitly bounded? (e.g., "only answers questions about the user's uploaded documents — not general knowledge")
- What happens when the model produces an output outside the intended scope?
- Is the capability boundary communicated to users?
- If the model provider improves capabilities, does this feature's behaviour change automatically? Is that acceptable?

### Risk 4 — Reversibility

Can the consequences of an AI-assisted action be undone?

For AI features that take actions (send, publish, modify, delete, pay):

| Action type | Reversibility requirement |
|---|---|
| Read-only (summarise, explain, draft) | No additional requirement |
| Low-stakes write (tag, categorise, label) | Audit log + bulk revert |
| High-stakes write (send, publish, post) | Explicit user confirmation before execution |
| Irreversible (delete, transfer, pay) | Human-in-the-loop checkpoint, no autonomous execution |

**BLOCK if:**
- The AI can take an irreversible action (delete, send, pay) without explicit user confirmation on each action
- There is no audit trail for AI-assisted actions that modified data

## The Process

### Step 1 — Map the Worst-Case Hallucination

Write one sentence: "The worst plausible incorrect output for this feature is [specific example]." Then design the UX for that scenario.

### Step 2 — Define the Trust Level and Signal

Decide: should users trust this output (1) always with verification, (2) as a draft to review, or (3) as a suggestion to consider? Design the visual treatment to match.

### Step 3 — Write the Capability Boundary

One sentence: "This AI [answers / generates / predicts] [specific scope]. It does not [specific exclusion]." This goes in the empty state and the first-run experience.

### Step 4 — Map Every Action for Reversibility

List every action the AI assists with or takes. Assign a reversibility tier. Any irreversible action with no confirmation checkpoint is a BLOCK.

### Step 5 — Add All Four to the PRD

These four risks must appear as named sections in the PRD, with explicit answers. They are not implicit in acceptance criteria.

### Step 6 — Store the Validation Document

Store at `product/ai-validation/<feature>-<date>.md`.

## Rationalization Red Flags

These thoughts mean AI-specific risks were not addressed — stop:

- *"We validated it like any other feature"* — standard acceptance criteria test the happy path; hallucination UX, trust calibration, and irreversibility are not happy paths and don't appear in standard criteria
- *"The model is usually right"* — "usually" is a frequency; your users experience the exceptions; design for the tail
- *"Users will understand it's AI"* — users understand AI in the abstract; they do not calibrate trust per-feature without explicit design signals
- *"We can add the undo button later"* — irreversible actions taken before the undo button ships cannot be undone; the reversibility requirement must be in the initial scope
- *"The capability boundary will emerge from user feedback"* — when the AI produces out-of-scope outputs before the boundary is defined, users have already formed expectations you'll have to undo

## Completion Statement Format

When ai-feature-validation is satisfied, state it like this:

```
AI feature validation complete.
File: product/ai-validation/<feature>-<date>.md ✓

Hallucination UX:
  Worst-case incorrect output: [described] ✓
  Distinguishable from correct output: yes (confidence signal: [type]) ✓
  Correction mechanism: [override / flag / report] ✓
  High-stakes disclaimer: [yes / N/A] ✓

Trust calibration:
  Target trust level: [authoritative / draft-to-review / suggestion] ✓
  Design signal: [confidence score / citation / verify copy / etc.] ✓
  Trust measurement plan: [metric and method] ✓

Capability boundary:
  Stated: "[this AI answers/generates X, does not Y]" ✓
  Communicated to users: [empty state / onboarding / always-visible label] ✓
  Scope expansion control: [model version pinned / output filter / explicit gating] ✓

Reversibility:
  Action audit: <N actions, each assigned a tier>
  Irreversible actions: [none / listed — each has confirmation checkpoint ✓]
  Audit trail: [yes / N/A — read-only feature] ✓

BLOCK items: [none / listed]
```

Any BLOCK item means the PRD is not approved for development. Not for negotiation, not for "we'll address it in v2."

## Why This Matters

Deterministic features fail loudly: a button that doesn't submit shows an error. AI features fail silently: an incorrect output that looks correct is acted on. The four risks above are the failure modes that standard product quality gates are not designed to catch — because they weren't needed before LLMs. Without this validation, AI features ship with hallucination UX designed by default, trust levels set by accident, capability boundaries discovered by users, and irreversible actions taken without checkpoints.
