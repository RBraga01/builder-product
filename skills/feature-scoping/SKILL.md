---
name: feature-scoping
description: Use before any engineering estimate is made. Requires a written scope before an estimate, and a written estimate before a commit. Blocks "we'll scope as we go" and "just give me a rough number" completions.
---

# Feature Scoping

## The Law

```
A FEATURE ESTIMATED WITHOUT A WRITTEN SCOPE IS A COMMITMENT MADE AGAINST UNKNOWN WORK.
"Give me a rough number" produces a number that becomes a deadline before the scope is understood.
Written scope → time estimate against that scope → explicit commit IS a feature decision.
```

## When to Use

Trigger before:
- Any request for an engineering estimate
- Any sprint planning that includes new functionality
- Any stakeholder conversation that will produce a commitment
- Any handoff from product to engineering

## When NOT to Use

- Time-boxed spikes where the output is knowledge, not a feature (the scope is "spend N days and report back")
- Hotfixes with unambiguous scope (the scope is "fix the specific bug described in the issue")

## The Scope Document

A scope document answers four questions before any estimate is given.

### 1 — What is being built?

User-visible behaviour only. Not implementation details.

```
The user can:
- [Action 1] — e.g., "filter search results by date range"
- [Action 2] — e.g., "export the filtered results as CSV"

The system will:
- [Behaviour 1] — e.g., "persist filter state across sessions"
```

### 2 — What is NOT being built in this scope?

Name the exclusions. Every implicit exclusion is a future dispute.

```
NOT included in this scope:
- [Exclusion 1] — e.g., "bulk export (> 1000 rows)"
- [Exclusion 2] — e.g., "real-time filter updates without page reload"
```

### 3 — What are the acceptance criteria?

Specific, testable conditions that define "done":

```
Given [state], when [action], then [observable result].
```

Acceptance criteria are the contract between product and engineering. Vague criteria ("works correctly") are not acceptance criteria.

### 4 — What are the dependencies and risks?

```
Dependencies:
- [Service/team/data that must be ready before this can ship]

Risks:
- [Known unknowns that could expand the estimate]
```

## The Estimate Protocol

An estimate is only valid if it names the scope document it was made against.

**Estimate format:**
```
Feature: <name>
Scope reference: product/scopes/<feature>-<date>.md
Estimate: <N days> (confidence: high / medium / low)
Assumptions: [any assumption that, if wrong, invalidates the estimate]
Not included: [any exclusion the estimate depends on]
```

**What does NOT count as an estimate:**
- A number given before seeing the scope
- A number given in a Slack message without assumptions
- "Probably a week or two" — no scope reference, no confidence, no assumptions

## The Commit Protocol

A commit is an estimate made public. Before committing:

1. The scope document exists
2. The estimate was made against it
3. The assumptions are recorded
4. The stakeholder who will hold the commitment has read the scope

If any of these are false, the "commitment" is a guess that will be held as a promise.

## The Process

### Step 1 — Write the Scope Document

Before any number is given. Create `product/scopes/<feature>-<date>.md` with all four sections.

### Step 2 — Give the Estimate Against the Scope

Engineering estimates the scope document — not a verbal description of it. The estimate references the scope file path.

### Step 3 — Review Assumptions Together

Product and engineering review the assumptions explicitly. Any assumption that product disputes is a scope change — update the document and re-estimate.

### Step 4 — Commit With the Scope Attached

When a deadline is shared with stakeholders, share the scope reference. "We'll have X by [date], scope is product/scopes/X-YYYYMMDD.md" makes the scope part of the commitment.

### Step 5 — Enforce Change Control

If scope changes after commit, the estimate is re-done. No exceptions. "It's a small addition" always comes with a small amount of time that nobody accounted for.

## Rationalization Red Flags

These thoughts mean scoping was skipped — stop:

- *"Just give me a rough number"* — the rough number will be the deadline; the scope will expand to make it wrong; the deadline will not expand with it
- *"We'll scope it as we go"* — you will ship whatever fits in the time and call it the feature; scoping-as-you-go is discovering scope under pressure
- *"The scope is obvious"* — to you; write it down so the engineer building it agrees, in advance, in writing
- *"We need to move fast"* — a scope document takes 30 minutes; a scope dispute takes 3 weeks and ships the wrong feature
- *"The estimate will change anyway"* — yes, when the scope changes; the current estimate is valid against the current scope, and changes require a new estimate

## Completion Statement Format

When feature-scoping is satisfied, state it like this:

```
Scope complete.
File: product/scopes/<feature>-<date>.md ✓

What's built: <N user-visible behaviours listed> ✓
What's NOT built: <M explicit exclusions listed by name> ✓
Acceptance criteria: <N testable Given/When/Then statements> ✓
Dependencies: <listed> / Risks: <listed or "none identified"> ✓
Estimate: <N days>, confidence: <level>, made against this scope document ✓
Assumptions: <listed — reviewed with both product and engineering> ✓
```

The estimate is invalid without the scope reference. A number without a scope is not an estimate.

## Why This Matters

Scope and estimate are not separable. An estimate made before scope is complete is not an estimate — it is a guess that will be treated as a deadline. The scope document is what makes the estimate defensible when the feature takes longer than the guess. Without it, "you said two weeks" is an argument that cannot be won.
