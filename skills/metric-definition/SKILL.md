---
name: metric-definition
description: Use before writing any implementation code for a new feature. North star metric, guardrail metrics, and diagnostic metrics must be defined — with baselines — before the build begins. Blocks "we'll figure out the metrics from the data" completions.
---

# Metric Definition

## The Law

```
A METRIC DEFINED AFTER THE BUILD DESCRIBES WHAT WAS BUILT, NOT WHETHER IT SHOULD HAVE BEEN.
"We'll figure out what to measure from the data" means you cannot distinguish success from noise, or know whether to keep, kill, or iterate the feature.
North star + guardrail + diagnostic metrics with baselines, defined before code IS a measurement plan.
```

## When to Use

Trigger before:
- Writing any implementation code for a new feature
- Committing to a PRD (see prd-quality-gate — metrics must be defined there too)
- Launching an A/B test (see ab-test-design — uses these metric definitions)
- Presenting a launch plan to stakeholders

## When NOT to Use

- Infrastructure changes with no user-visible behaviour
- Bug fixes where "fixed" is the metric (the issue is the acceptance criterion)
- Time-boxed research spikes (the output is knowledge, not a metric)

## The Three Metric Types

Every feature needs all three types. Missing any one creates a measurement blind spot.

### 1 — North Star Metric

The single metric that answers "did this feature achieve its purpose?"

**Properties:**
- One metric only — if you have two north stars, you have no north star
- Directly reflects user value (not a proxy for it)
- Moves when the feature is working, and only when the feature is working
- Has a defined target and timeframe (see prd-quality-gate)

**Common failure:**
> "We'll track engagement" — engagement is not a north star; engagement of what action, by which users, compared to what baseline?

### 2 — Guardrail Metrics

Metrics that must NOT get worse when the north star improves.

Every feature optimisation can create a trade-off. Guardrail metrics make the trade-offs explicit and non-negotiable.

**Required: at least two guardrails:**
```
Guardrail 1: [Core product metric] must not drop by more than X%
Guardrail 2: [User trust / satisfaction metric] must not drop below Y
```

**Example:**
> Feature: improve onboarding completion rate (north star)
> Guardrail 1: D7 retention must not drop by more than 2pp
> Guardrail 2: Support ticket volume must not increase by more than 10%

If a guardrail is breached, the feature is not a success — regardless of the north star movement.

### 3 — Diagnostic Metrics

Leading indicators that explain *why* the north star is or isn't moving.

Diagnostic metrics are not success/fail signals — they are debugging tools. When the north star underperforms, diagnostics tell you which part of the funnel broke.

```
Step 1 metric → Step 2 metric → Step 3 metric → North Star
[If NS is flat, which step is breaking?]
```

Diagnostic metrics must be available before launch. If they require new instrumentation, that instrumentation is part of the feature scope.

## The Logging Plan

Metrics require data. Data requires logging. Define the logging plan before the build — not after.

For each metric, specify:
- **Event name**: what user action or system event produces this data
- **Properties**: what context is captured (user ID, session ID, feature flags, timestamp)
- **Where logged**: analytics system, database, data warehouse
- **How aggregated**: daily/weekly rollup, p50/p95, funnel step conversion

If any metric requires new tracking, add it to the feature scope. A metric without a logging plan is not a metric — it is an intention.

## The Process

### Step 1 — Define the North Star

Write it in the form: "[Metric] increases from [baseline] to [target] within [timeframe], measured in [system]."

Instrument the baseline before the build if it doesn't exist yet.

### Step 2 — Define at Least Two Guardrails

For each: name the metric, state the acceptable tolerance, and identify the data source.

### Step 3 — Map the Diagnostic Funnel

List the funnel steps between user entry and the north star metric. Name one diagnostic metric per step.

### Step 4 — Write the Logging Plan

For every metric, name the event, properties, log destination, and aggregation method.

### Step 5 — Verify All Baselines Exist

Run a query against each metric. If the data doesn't exist yet, the logging implementation is part of the feature and must be in scope.

### Step 6 — Store the Measurement Plan

Store at `product/metrics/<feature>-<date>.md`. This document is the agreement between product and data on what will be measured and how.

## Rationalization Red Flags

These thoughts mean metrics were not defined — stop:

- *"We'll figure out the metrics from the data"* — the data will tell you what happened, not whether it should have happened; you need the metric to know the difference
- *"Engagement is our north star"* — engagement of what? by whom? engagement is a dimension, not a metric; name the specific action and the specific users
- *"We don't need guardrails for a small feature"* — small features can crater D7 retention; "it's small" is not a risk assessment
- *"We can add logging after launch"* — you can add logging for the metrics you wish you'd defined; you cannot retroactively log the baseline
- *"The north star is obvious"* — write it down; when the feature ships and the data is ambiguous, the documented north star is the only thing that ends the debate

## Completion Statement Format

When metric-definition is satisfied, state it like this:

```
Metrics defined.
File: product/metrics/<feature>-<date>.md ✓

North star: [metric] from [baseline] to [target] by [date] via [data source] ✓
Baseline verified: queried on <date> — result: <value> ✓ / instrumentation required: <scope item>

Guardrail 1: [metric] — tolerance: ≤ X% drop — data source: [system] ✓
Guardrail 2: [metric] — tolerance: ≤ Y% drop — data source: [system] ✓

Diagnostics: <N funnel-step metrics named> ✓
Logging plan: all events defined with properties, destination, aggregation ✓
Instrumentation in scope: <yes — PR: link / no — all events already logged> ✓
```

A metric without a verified baseline is not a metric. A logging plan that exists only in this document is not a plan.

## Why This Matters

Features measured after the fact are measured by the outcome they produced, not the outcome they were supposed to produce. Confirmation bias will find the metric that shows success. The north star defined before launch is the only anchor against that bias. Guardrails prevent trading long-term health for short-term north star movement. Diagnostics prevent "the metric isn't moving" from being a dead end.
