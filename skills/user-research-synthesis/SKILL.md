---
name: user-research-synthesis
description: Use after conducting user research and before making product decisions from it. Requires every insight to map to a decision. Blocks "users said X" reports that produce no actionable direction.
---

# User Research Synthesis

## The Law

```
RESEARCH THAT DOES NOT PRODUCE A DECISION PRODUCES A DOCUMENT.
"Users said X" without "therefore we will Y" is observation without direction — the team reads the report, nods, and builds what they already planned.
An insight → decision chain, documented and traceable IS research synthesis.
```

## When to Use

Trigger after:
- Any user interview, usability test, or survey that informs a product decision
- Any discovery sprint before a new feature is scoped
- Any moment when "what do users want?" is used to justify a direction

## When NOT to Use

- Competitive analysis (no user data involved — use a different framework)
- Usage analytics review (quantitative data without qualitative context — different synthesis process)
- Research stored for reference without an active product decision being made

## The Synthesis Structure

Raw research is observation. Synthesis is the translation of observation into decision. Every step below must be completed before the synthesis is done.

### 1 — Observations

What did users actually do, say, or show? Only direct evidence — no interpretation yet.

```
Observation format:
[User type], [context], [verbatim quote or behaviour]:
"[exact quote]" or "[described behaviour]"
```

**Rules:**
- Quote directly where possible — paraphrase introduces interpretation
- Include the context (what task were they doing? what were they trying to achieve?)
- Do not include "they seemed to want..." at this stage — that is interpretation

### 2 — Patterns

Which observations repeat across multiple users? A pattern requires at least 3 independent instances.

```
Pattern: [Name]
Instances: [User A, User B, User C] — each with reference to observation
Strength: strong (5+ instances) / moderate (3–4) / weak (< 3, noted as signal not pattern)
```

Weak signals (< 3 instances) are noted but not used to drive decisions without supporting quantitative evidence.

### 3 — Insights

What do these patterns mean? One sentence per insight. Insight = pattern + implication.

```
Insight format:
[Pattern] suggests that [user population] [belief, expectation, or behaviour], which means [product implication].
```

**What does NOT count as an insight:**
- "Users want a better experience" — no pattern, no implication
- "Users find X confusing" — observation, not insight (insight: "users find X confusing because they expect Y, which means the mental model mismatch is at [specific step]")

### 4 — Decisions

Each insight must map to exactly one of:
- **Build decision**: we will build [X] because [insight]
- **Don't build decision**: we will not build [Y] because [insight] shows it doesn't solve the underlying problem
- **Further research needed**: we cannot decide until we understand [specific question]; research method: [proposed method], timeline: [date]

**What does NOT count as a decision:**
- "We should think about this"
- "This is something to keep in mind"
- "We'll revisit this later"

Every insight that produces a "we should think about this" response is an insight that will be ignored in the next planning cycle.

## The Decision Audit

Before the synthesis document is shared, run the decision audit:

1. Count the insights. Count the decisions. They must be equal.
2. For each decision, confirm it names a specific product action or a specific research question with a date.
3. For each "further research needed" decision, confirm a method and timeline are named.

If any insight has no corresponding decision, the synthesis is incomplete.

## The Process

### Step 1 — Log All Observations

Immediately after each session, log observations in the standard format. Do not paraphrase without a quote to support it.

### Step 2 — Identify Patterns

Group observations. Name patterns. Count instances. Mark weak signals.

### Step 3 — Write Insights From Patterns

One insight per pattern. Test each insight: does it contain a pattern AND an implication? If not, it is still an observation.

### Step 4 — Map Each Insight to a Decision

For every insight, write the decision it produces. Build / don't build / further research (with method + date).

### Step 5 — Run the Decision Audit

Insights = decisions. No orphaned insights. No decisions without insights.

### Step 6 — Store the Synthesis Document

Store at `product/research/<project>-synthesis-<date>.md`. This document is the evidence base for every product decision made from this research.

## Rationalization Red Flags

These thoughts mean synthesis was not completed — stop:

- *"The research speaks for itself"* — research requires interpretation; interpretation requires documentation; undocumented interpretation cannot be challenged, revised, or learned from
- *"Users want X"* — how many users? in what context? doing what task? "users want X" without these is a summary that hides the evidence
- *"We'll use this to inform future decisions"* — this means the research will not produce a decision; "inform" is the word used when research is filed and forgotten
- *"The team heard the sessions, they know the insights"* — they know their interpretation of the sessions, which differs per person; the synthesis document is what makes the interpretation shared
- *"We don't have time to synthesise, we need to move fast"* — you will spend the time anyway, debating "what users really meant" in planning meetings; the synthesis front-loads that cost

## Completion Statement Format

When user-research-synthesis is satisfied, state it like this:

```
Research synthesis complete.
File: product/research/<project>-synthesis-<date>.md ✓

Sessions: <N users, method: interview / usability test / survey>
Observations: <N logged with direct quotes/behaviours> ✓
Patterns: <N patterns — M strong (5+), K moderate (3-4), J weak signals noted>

Insights: <N total>
Decisions produced:
  Build: <N decisions — feature/change named for each>
  Don't build: <N decisions — with insight reference>
  Further research: <N — method and date named for each>

Decision audit: insights (<N>) = decisions (<N>) ✓
```

Every insight must map to a decision. "Informing future work" is not a decision.

## Why This Matters

User research without synthesis produces a library of evidence for arguments that have already been decided. Teams that skip synthesis don't skip the decisions — they make them based on the most memorable quote from the sessions, which is usually the most dramatic one, not the most representative one. The synthesis document is what turns 10 hours of sessions into 3 concrete decisions.
