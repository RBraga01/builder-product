---
name: mvp-scope-validator
description: Use before writing a PRD for a new product or feature. Extracts the core hypothesis and reduces scope to the minimum needed to test it. Blocks feature lists that bundle multiple unvalidated assumptions.
---

# MVP Scope Validator

## The Law

```
AN MVP THAT CANNOT NAME ITS HYPOTHESIS IS NOT AN MVP.
"We need all these features to launch" is a bet on multiple unvalidated assumptions at once.
One hypothesis → minimum scope to test it → binary success metric IS a validated learning.
```

## When to Use

- When defining a new product or feature for the first time
- When reviewing a PRD or feature list that feels too large
- When the team debates what to cut before a deadline
- When a feature list has grown and the original hypothesis is no longer clear

## When NOT to Use

- For an existing product with live users — this validates new hypotheses, not iterative improvements
- When the idea is so vague that no hypothesis can be extracted — the skill will flag LOW_HYPOTHESIS and ask first
- For a single required bug fix or compliance task — there is no MVP for a fix; the scope is already defined
- When the goal is not learning (e.g., a required regulatory feature) — compliance requirements cannot be reduced by hypothesis framing

## Inputs

| Input | Required | Description |
| --- | --- | --- |
| idea | required | Product or feature description — can be a sentence, a paragraph, or a feature list |
| constraints | optional | Time, budget, team size, or tech stack constraints that affect feasibility |
| hypothesis | optional | If the user already has a hypothesis, use it as the anchor; otherwise extract it from the idea |

## Outputs

| Output | Description |
| --- | --- |
| mvp-definition | Core hypothesis, in-scope features (minimum to test hypothesis), out-of-scope items (explicitly removed), success metric |
| scope-reduction | List of removed items with a one-sentence reason per item |

## Steps

1. Read the idea. Try to extract a core hypothesis in the form: "We believe [target user] will [desired behaviour] because [reason]."
2. If no specific hypothesis can be extracted from the idea, set context-flag to LOW_HYPOTHESIS and ask 3 specific questions to help the user define one. Stop here until the hypothesis is clarified.
3. List every feature or capability mentioned in the idea.
4. For each feature, ask: "Is this required to test the hypothesis?" If not, it is out of scope for the MVP.
5. If the scope cannot be reduced at all (every feature is required to test the hypothesis), set context-flag to ALREADY_MINIMAL and explain why.
6. Write the in-scope feature set — the minimum to test the hypothesis.
7. Write the out-of-scope list: each item with a one-sentence reason why it is not needed for the hypothesis test.
8. Define the success metric as a binary statement: "The hypothesis is validated if [specific measurable outcome] within [timeframe]." The metric must be observable without interpretation.
9. Output the MVP definition and scope-reduction list.
10. Fill the Completion Statement.

## Completion Statement Format

When mvp-scope-validator is satisfied, state it like this:

```
mvp-scope-validator complete.
Product/feature: [name]
Core hypothesis: [one sentence]
In-scope: [count] features — [brief list]
Out-of-scope: [count] items removed
Success metric: [binary metric]
Context flag: [NONE / LOW_HYPOTHESIS — reason / ALREADY_MINIMAL — reason]
```

## Red Flags

- *"We need user accounts to test this"* — user accounts are rarely the hypothesis; they're an assumption. Ask: can the hypothesis be tested with a fake door or a manual process instead?
- *"This feature is basic, it'll only take a day"* — effort is not the criterion for MVP inclusion; hypothesis relevance is the only criterion
- *"We need the admin dashboard to manage the data"* — internal tools are almost never required to test the user-facing hypothesis
- *"The success metric is 'users like it'"* — "like it" is not binary; define a specific action, count, or conversion rate that can be checked without asking the user
- *"We can't remove [feature] because users will expect it"* — pre-launch user expectations are assumptions, not facts; the MVP tests assumptions, not confirms them

## Examples

### Example 1 — Restaurant reviews app (multi-feature idea)

**Input:**
- idea: App for restaurant owners to manage Google and TripAdvisor reviews, respond to reviews, get sentiment analytics, multi-location support, competitor comparison

**Output:**
- Core hypothesis: Restaurant owners will pay €29/month to be alerted of negative reviews and have AI-generated response templates
- In scope: negative review alert + AI response template generator
- Out of scope: sentiment analytics dashboard, multi-location management, competitor comparison, review aggregation across platforms
- Success metric: 3 restaurant owners pay for the tool within 30 days of beta launch

### Example 2 — Already minimal

**Input:**
- idea: Add a "forgot password" email reset flow to an existing web app

**Output:** ALREADY_MINIMAL. This is a single required feature. The scope is defined by the feature: email trigger → reset link → new password. There is nothing to remove without removing the feature entirely.

## Counter-Examples

### Counter-Example 1 — No hypothesis

**Input:**
- idea: "I want to build a social network for pet owners"

**What should happen:** Flag LOW_HYPOTHESIS. Ask: What behaviour are you trying to validate? Who specifically are the target users? What will they do differently because of this product?

**What the skill must NOT do:** Write a scope for a social network without a hypothesis. Any scope produced without a hypothesis is arbitrary.

### Counter-Example 2 — Compliance feature treated as MVP

**Input:**
- idea: "We need to add GDPR consent banners before the May deadline"

**What should happen:** Flag this as a compliance requirement, not a hypothesis-driven feature. There is no MVP for a legal requirement — the scope is the requirement itself.

**What the skill must NOT do:** Reduce the scope of a legal/regulatory requirement based on hypothesis framing.

## Why This Matters

Scope and hypothesis are not separable. A feature list built without a hypothesis is a collection of bets that cannot be individually validated. The MVP definition is what makes the result of the launch interpretable — without it, "it worked" and "it didn't work" are opinions, not evidence.
