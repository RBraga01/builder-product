---
name: ab-test-design
description: Use before running any experiment that will inform a product decision. All six elements — hypothesis, metric, sample size, duration, stopping rule, and decision rule — must be defined before the test starts. Blocks "we'll stop when we see something" completions.
---

# A/B Test Design

## The Law

```
A TEST WITHOUT A STOPPING RULE RUNS UNTIL THE RESULT LOOKS GOOD.
"We'll stop when we see something significant" is peeking — it inflates false positive rates until the next meaningless spike ships to production.
Hypothesis + metric + sample size + duration + stopping rule + decision rule IS an experiment.
```

## When to Use

Trigger before:
- Running any A/B or multivariate test that will produce a ship/no-ship decision
- Adding feature flag logic that will split users into groups
- Launching any "let's try this and see what happens" experiment

## When NOT to Use

- Observational studies with no control group (not an A/B test — use a different analysis method)
- Rollouts to < 1% of users as a smoke test (no statistical inference intended — label it as such)
- Shadow mode tests where both groups see the same experience (monitoring, not experimentation)

## The Six Required Elements

### 1 — Hypothesis

One testable claim in the form: If [change], then [metric] will [increase/decrease] by [magnitude] because [mechanism].

```
If we [specific change to control],
then [primary metric] will [direction] by [minimum detectable effect],
because [causal mechanism].
```

**What does NOT count:**
- "We think this will improve conversion" — no direction, no magnitude, no mechanism
- "Let's test it and see" — not a hypothesis; a hypothesis is a prediction, not an openness to observation

The mechanism matters. A hypothesis without a mechanism cannot be learned from even if it's correct — you won't know why.

### 2 — Primary Metric

The single metric that defines success or failure for this test.

- One primary metric only — multiple primary metrics require Bonferroni correction and usually indicate an unclear hypothesis
- Must be measurable at the session or user level (not aggregated)
- Must have a baseline from at least the last 14 days of data

**Secondary metrics** (guardrails and diagnostics — max 5): watched but do not determine the decision.

### 3 — Sample Size

Calculated before the test starts. Not estimated — calculated.

```
Parameters:
- Baseline conversion rate: X%
- Minimum Detectable Effect (MDE): Y% relative improvement
- Statistical power: 80% (standard) or 90% (high-stakes decisions)
- Significance level (α): 0.05 (two-tailed)

Required sample per variant: [use a power calculator or scipy.stats]
```

If the required sample size exceeds your daily traffic in a reasonable timeframe, either:
- Increase the MDE (detect a larger effect) — only if the smaller effect is not business-relevant
- Accept a longer test duration
- Use a different test design (CUPED, stratified, etc.)

Do not reduce the sample size to make the test run faster. An underpowered test is not a test.

### 4 — Duration

Minimum test duration = sample size / daily eligible users, rounded up to the nearest full week.

**Rules:**
- Run for at least one full week to capture weekly seasonality
- Run for at least two full weeks for features with weekly usage patterns
- Maximum duration: 6 weeks — beyond 6 weeks, user behaviour and external factors contaminate the results

If the calculated duration exceeds 6 weeks, the test is not feasible at current traffic. Either increase the MDE or find a higher-traffic surface.

### 5 — Stopping Rule

When will you stop the test, and under what conditions?

```
Stopping rule:
- Fixed duration: stop after [N days], regardless of interim results
- Early stopping: stop early only if [p < 0.001 and sample size ≥ 75% of target]
  (sequential testing / alpha spending — not raw significance peeking)

Interim checks: [none / weekly / at 50% and 100% of target sample size]
```

No peeking without a pre-specified alpha spending function. Every unplanned interim check at α=0.05 inflates the true false positive rate by approximately 20% per check.

### 6 — Decision Rule

What will you do with the result? Defined before the test starts.

```
If primary metric increases by ≥ MDE at p < 0.05 AND no guardrail breached: SHIP
If primary metric is flat or negative at full duration: NO SHIP
If primary metric increases but guardrail breached: INVESTIGATE — do not ship without resolution
If test ends with insufficient power (traffic less than expected): EXTEND or REDESIGN
```

"We'll discuss when we see the results" is not a decision rule. It reintroduces discretion at the point where data should be determining the outcome.

## The Process

### Step 1 — Write the Hypothesis

One sentence with all four elements: change, metric, direction + magnitude, mechanism.

### Step 2 — Identify the Primary Metric and Guardrails

Primary metric with baseline. Guardrails with tolerance thresholds.

### Step 3 — Calculate Sample Size

Use actual baseline data and defined MDE. Do not use online calculators with default inputs — use your actual baseline rate.

### Step 4 — Set the Duration

Divide sample size by daily eligible traffic. Round up to full weeks. Verify it doesn't exceed 6 weeks.

### Step 5 — Write the Stopping Rule

Fixed duration with explicit early-stopping criteria if needed. No open-ended "we'll stop when significant."

### Step 6 — Write the Decision Rule

All four outcomes (ship, no ship, guardrail breach, insufficient power) mapped to actions.

### Step 7 — Store the Experiment Design

Store at `product/experiments/<feature>-design-<date>.md` before any traffic is split.

## Rationalization Red Flags

These thoughts mean the test is not designed — stop:

- *"We'll stop when we see something significant"* — this is peeking; each check at α=0.05 adds ~20% false positive inflation; at 5 checks, your real alpha is ~0.23, not 0.05
- *"The effect will be obvious"* — "obvious" effects are usually noise that survived confirmation bias; calculate the MDE required to be obvious and check whether your traffic supports detecting it
- *"We don't need a hypothesis, we're just testing"* — tests without hypotheses cannot produce learning; you will see a result and confabulate a reason for it
- *"We'll decide what to do based on the results"* — the decision rule must be defined before the test; post-hoc decision criteria are chosen to match the outcome
- *"A week is enough"* — a week may be enough duration; whether it is enough sample depends on the calculation, not the calendar

## Completion Statement Format

When ab-test-design is satisfied, state it like this:

```
Experiment designed.
File: product/experiments/<feature>-design-<date>.md ✓

Hypothesis: If [change], then [metric] will [direction] by [MDE] because [mechanism] ✓
Primary metric: [name] — baseline: X% (from [data source], last [N] days) ✓
Guardrails: <N metrics with tolerance thresholds listed>

Sample size: <N per variant> (power: 80%/90%, α: 0.05, MDE: Y%) ✓
Duration: <N days> = <sample size> ÷ <daily eligible traffic: M users/day> ✓
  [Minimum 7 days / within 6-week maximum ✓]

Stopping rule: fixed at <N days>; early stop if p < 0.001 at ≥ 75% sample ✓
Decision rule:
  Ship condition: ≥ MDE at p < 0.05, no guardrail breached ✓
  No-ship condition: flat or negative at full duration ✓
  Guardrail breach: investigate before decision ✓
  Insufficient power: extend or redesign ✓
```

Sample size and duration must be calculated, not estimated. A decision rule must exist for all four outcomes.

## Why This Matters

Underpowered tests ship features based on noise. Peeked tests ship features based on chance peaks. Tests without decision rules ship features based on whoever argues most convincingly after the results come in. A properly designed experiment is the only way to distinguish a real 3% improvement from a random fluctuation at that magnitude — and 3% improvements compound into meaningful product quality over time.
