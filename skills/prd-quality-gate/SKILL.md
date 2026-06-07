---
name: prd-quality-gate
description: Use before committing scope, estimate, or engineering time to any feature. Requires user problem, success metric, scope boundary, and anti-goals defined before any estimate is made. Blocks "we'll define success once we see the data" completions.
---

# PRD Quality Gate

## The Law

```
A PRD WITHOUT A DEFINED SUCCESS METRIC IS A SCOPE DOCUMENT, NOT A PRODUCT DECISION.
"We'll know success when we see it" ships a feature with no definition of done and no way to decide whether to keep, kill, or iterate it.
User problem + success metric + scope boundary + anti-goals + estimate IS a PRD.
```

## When to Use

Trigger before:
- Committing engineering time to any feature
- Writing a sprint plan that includes new functionality
- Requesting design or backend effort for a new capability
- Presenting a feature to stakeholders for approval

## When NOT to Use

- Bug fixes with no scope ambiguity and a clear definition of done
- Infrastructure changes with no user-visible behaviour change
- Spikes or time-boxed explorations (label them as such — they are not PRDs)

## The Five Required Elements

### 1 — User Problem

The problem must be real and specific — not a capability gap or a product roadmap goal.

**Required form:**
> [User type] cannot [do thing] because [specific constraint]. This causes [measurable consequence].

**What does NOT count:**
- "We don't have this feature yet"
- "Competitors have it"
- "The team thinks it would be useful"

If the problem statement doesn't name a user type, a specific constraint, and a consequence, it is not a user problem — it is a feature idea.

### 2 — Success Metric

One primary metric that definitively answers "did this work?" at a specific threshold.

**Required form:**
> [Metric name] increases from [baseline] to [target] within [timeframe], measured by [data source].

**Rules:**
- One primary metric, maximum two secondary metrics
- Baseline must be measurable now (if it isn't, instrument it before building)
- Target must be specific (not "improved" or "more")
- Timeframe must be fixed (not "eventually")

**What does NOT count:**
- "Better user experience"
- "Increased engagement" (no baseline, no target)
- "Users will like it more"

### 3 — Scope Boundary

What is explicitly included and what is explicitly excluded.

```
IN SCOPE:
- [Feature element 1]
- [Feature element 2]

OUT OF SCOPE (this release):
- [Element intentionally excluded — will revisit in v2/never/after metric is hit]
```

If something is "out of scope for now," name it explicitly. Unnamed exclusions become undiscovered scope during build.

### 4 — Anti-Goals

What this feature is not trying to do — even if it could.

Anti-goals prevent scope creep by making "we could also add..." arguments fail against a documented decision.

**Examples:**
- "This feature does not replace the existing X flow"
- "This feature does not need to support enterprise users in phase 1"
- "This feature does not need to be internationalised before hitting the metric"

### 5 — Estimate

A time estimate made against the defined scope. Not before it.

The estimate references the scope document. If the scope changes, the estimate is re-done. No estimate is valid without a scope reference.

## The Process

### Step 1 — Write the User Problem

State the problem in the required form. If you cannot, the problem is not understood well enough to scope it.

### Step 2 — Define the Success Metric

Name the primary metric, its baseline, its target, its timeframe, and its data source. Instrument the baseline before proceeding — a metric without a baseline is unverifiable.

### Step 3 — Draw the Scope Boundary

List what is in scope. List what is out of scope by name. Do not leave implicit exclusions — they become undiscovered scope.

### Step 4 — Write the Anti-Goals

Two to four anti-goals. Each should be a decision that the team could reasonably dispute — if nobody would dispute it, it is not an anti-goal, it is an assumption.

### Step 5 — Get the Estimate Against This Scope

Present the scope document to engineering for the estimate. The estimate document references the PRD file path. If scope changes, the estimate is invalidated.

### Step 6 — Store the PRD

Store at `product/prd/<feature>-<date>.md`. The PRD is the source of truth for what was agreed — not the JIRA ticket, not the Slack thread.

## Rationalization Red Flags

These thoughts mean the PRD gate was not satisfied — stop:

- *"We'll know success when we see the data"* — you will see data you already wanted to see; the metric must be defined before you know the outcome, or confirmation bias makes every release a success
- *"The scope is clear in my head"* — scope that exists only in your head is not scope; the engineer who builds it has a different head
- *"We don't need anti-goals for a small feature"* — small features have the most scope creep; "while we're at it" is how a 3-day task becomes a 3-week project
- *"We can estimate without a written scope"* — you can guess; guesses become commitments when you say them in a planning meeting
- *"The user problem is obvious"* — write it down; when the feature ships and the metric doesn't move, the documented problem statement is how you understand why

## Completion Statement Format

When prd-quality-gate is satisfied, state it like this:

```
PRD complete.
File: product/prd/<feature>-<date>.md ✓

User problem: "[User type] cannot [thing] because [constraint]. Causes [consequence]." ✓
Success metric: [metric] from [baseline] to [target] within [timeframe] via [data source] ✓
Baseline instrumented: yes ✓ / instrumentation PR: <link>
Scope: <N items in scope, M items explicitly out of scope> ✓
Anti-goals: <N documented> ✓
Estimate: <N days/sprints — made against this scope document> ✓
```

The baseline must be measurable before the PRD is approved. A metric with no baseline is not a metric.

## Why This Matters

Features built without a success metric are measured by whether the team liked building them. Features built without a scope boundary expand to consume all available time. Features built without anti-goals become the feature that also does X, also does Y, and ships six months late doing none of it well. The PRD is the one document that makes all five decisions explicit before the engineering cost is committed.
