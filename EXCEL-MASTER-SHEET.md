# Excel Master Sheet — Intake Workbook Specification

This document describes the **single Excel workbook** teams fill in and send back to the AI Innovation Lead.
The Lead imports it once into the portal (`index.html` → **Import / Export / Templates** tab), reviews the merge preview, exports the master `data/ideas.json`, and commits it to Git.

> Download the ready-made workbook from the portal: **Data tab → "Download Excel Template (.xlsx)"** (`CTL-AI-Idea-Intake-Template.xlsx`).
> It contains all 5 tabs below, pre-filled with one example row per tab.

The workbook has **5 tabs**. Column names below must match **exactly** (the portal reads by header name).

> **Note:** All team-input fields (status, next step, updates, due date, SME, champions, every metric, blockers) start **EMPTY**. Nothing is pre-filled or fabricated — capture the real values live, then export and commit.

---

## How the import works (read this first)

- **Merge key:** Rows are matched to existing ideas by **`ID`** first, then by **`Idea Title`** (case-insensitive).
  - Leave **`ID` blank** for a brand-new idea → the portal auto-assigns the next `IDEA-###`.
  - Keep the **same `ID`** when updating an existing idea → the portal updates it in place.
- **Tabs are linked by `ID` + `Idea Title`.** The Metrics and Progress Log rows attach to the matching Ideas row using those two columns.
- **Ideas** tab is required. **Metrics** tab is needed for value/ROI numbers. **Progress Log** and **Teams** are optional.
- The portal **auto-calculates** all derived numbers (% effort reduction, hours saved/year, adoption %). Teams only enter the **raw** hours and counts.

---

## Tab 1 — `Ideas` (required)

One row per idea. This is the core record.

| # | Column | Who fills | Required | Example | Notes / Allowed values |
|---|--------|-----------|----------|---------|------------------------|
| 1 | `ID` | Lead | No (blank = new) | `IDEA-004` | Blank for new; keep same to update |
| 2 | `Idea Title` | Team | **Yes** | `AI Code Review Assistant` | Short, unique, human-readable |
| 3 | `Owner` | Team | Yes to leave Backlog | `Jane Doe` | The AI Lead accountable for delivery |
| 4 | `Parent ID` | Team/Lead | No | `IDEA-011` | Optional. To make this idea a **sub-idea**, put the parent idea's ID here. On the **Pipeline** it renders as a card nested under its parent. Leave blank for a top-level idea. |
| 5 | `Team/Sub-team` | Team | No | `Salesforce Eng` | Free text |
| 6 | `Team Members` | Team | No | `Jane Doe`⏎`John Roe` | **One member name per line within the single cell** (Alt+Enter in Excel). The portal reads them dynamically, splits on new line / comma / semicolon, and shows them per idea (Owner = idea owner) on the **People & Roles → Teams & Members** tab. They also flow into the **Teams** export tab. |
| 7 | `Domain` | Team | No (defaults Salesforce) | `Salesforce` | **Salesforce \| Beyond-SF \| Delivery Lifecycle \| Enablement \| Process Innovation** |
| 8 | `Detailed Description` | Team | Recommended | `Scan Apex/LWC/SOQL and comment on PRs…` | The problem/process and what the solution does |
| 9 | `Horizon` | Team | No (defaults H1) | `H2 Workflow AI` | **H1 Productivity \| H2 Workflow AI \| H3 Transformation** |
| 10 | `Tools Used` | Team | No | `Cline, Code Analyzer` | Comma-separated |
| 11 | `Stage` | Team/Lead | No (defaults Backlog) | `Building` | **Backlog \| Prioritized \| Committed \| Building \| Validation \| Pilot \| Adopted \| Scaled** |
| 12 | `Priority` | Team/Lead | No (defaults Medium) | `High` | **High \| Medium \| Low** |
| 13 | `SME` | Lead | No | `John SME` | Validator who confirms accuracy/fit |
| 14 | `Champions` | Lead | No | `Champ A, Champ B` | Comma-separated |
| 15 | `Due Date` | Team | Yes to leave Backlog | `2026-10-10` | Format `YYYY-MM-DD` |
| 16 | `Next Step` | Team | Recommended | `Prototype PR scan` | The single next action |
| 17 | `Updates` | Team | No | `Kickoff done` | Latest status note |

**Enforcement in the portal:** To move an idea out of **Backlog**, it must have an **Owner**, a **Due Date**, **Target Users** (Metrics tab), and **Hours Before/After** (Metrics tab) — so every active idea has an owner and a measurable outcome.

---

## Tab 2 — `Metrics` (fill for value / ROI)

One row per idea. Link to Tab 1 with the same `ID` and `Idea Title`. Enter **raw** numbers only — the portal computes the rest.

| # | Column | Who fills | Example | Notes |
|---|--------|-----------|---------|-------|
| 1 | `ID` | Lead | `IDEA-004` | Match the Ideas tab |
| 2 | `Idea Title` | Team | `AI Code Review Assistant` | Match the Ideas tab |
| 3 | `Hours Before (per run)` | Team | `2` | Manual hours for one run today |
| 4 | `Hours After (per run)` | Team | `0.5` | Hours per run with the AI solution |
| 5 | `Runs per Month` | Team | `60` | How often the task happens |
| 6 | `Users Impacted` | Team | `20` | People whose work this touches |
| 7 | `Cycle Time Before (days)` | Team | `1` | End-to-end days before |
| 8 | `Cycle Time After (days)` | Team | `0.5` | End-to-end days after |
| 9 | `Error Rate Before (%)` | Team | `25` | Defect/rework rate before |
| 10 | `Error Rate After (%)` | Team | `10` | Defect/rework rate after |
| 11 | `Target Users` | Team | `25` | Adoption denominator |
| 12 | `Active Users` | Lead | `0` | Adoption numerator (updated over time) |

**Portal auto-calculates from these:**
- `% Effort Reduction/run` = (Hours Before − Hours After) / Hours Before
- `Hours Saved / Month` = (Hours Before − Hours After) × Runs per Month
- `Hours Saved / Year` = Hours Saved/Month × 12
- `% Faster Cycle` = (Cycle Before − Cycle After) / Cycle Before
- `% Quality Improvement` = (Error Before − Error After) / Error Before
- `Adoption %` = Active Users / Target Users

---

## Tab 3 — `Progress Log` (optional)

One row per update. Multiple rows per idea allowed. Builds the timeline shown on each idea's **Progress Log** tab.

| # | Column | Who fills | Example | Notes |
|---|--------|-----------|---------|-------|
| 1 | `ID` | Lead | `IDEA-004` | Match the Ideas tab |
| 2 | `Idea Title` | Team | `AI Code Review Assistant` | Match the Ideas tab |
| 3 | `Date` | Team | `2026-09-08` | Format `YYYY-MM-DD` |
| 4 | `Stage` | Team | `Building` | Stage at the time of the update |
| 5 | `Update Note` | Team | `Kickoff` | What happened |
| 6 | `Blocker` | Team | `Waiting on sandbox` | Blank if none |
| 7 | `Logged By` | Team | `Jane Doe` | Who wrote the update |

---

## Tab 4 — `Teams` (optional — roster)

One row **per member**. Repeat the team name on each of its members' rows. The portal groups rows by `Team` and shows each team with its members on the **People & Roles** tab. Adding/removing teams and members in the portal is also reflected here on export.

| # | Column | Who fills | Example | Notes |
|---|--------|-----------|---------|-------|
| 1 | `Team` | Lead/Team | `Salesforce Eng` | Team name — repeat on each member row |
| 2 | `Member` | Lead/Team | `Jane Doe` | One member per row |

Example:

| Team | Member |
|------|--------|
| Salesforce Eng | Jane Doe |
| Salesforce Eng | John Roe |
| QA / BA | Thejaswini S |

---

## Tab 5 — `Instructions` (reference — do not edit)

Ships inside the template as a quick-reference so teams don't need this document open. Contents:

| Field | Guidance |
|-------|----------|
| HOW TO USE | Fill the **Ideas** tab (required) and **Metrics** tab (for value). Progress Log optional. Send the file back to your AI Innovation Lead. |
| ID | Leave blank for new ideas (auto-assigned). Keep the same ID when updating an existing idea. |
| Domain | Salesforce \| Beyond-SF \| Delivery Lifecycle \| Enablement \| Process Innovation |
| Horizon | H1 Productivity \| H2 Workflow AI \| H3 Transformation |
| Stage | Backlog \| Prioritized \| Committed \| Building \| Validation \| Pilot \| Adopted \| Scaled |
| Priority | High \| Medium \| Low |
| Metrics | Enter raw hours/counts. The portal auto-calculates % reduction, hours saved/year and adoption %. |
| Parent ID | Optional. Put a parent idea's ID (e.g. IDEA-011) to nest this idea under it on the Pipeline. Blank = top-level. |
| Teams | One row per member. Columns: Team, Member. Repeat the team name for each member. |
| Golden rule | Bring a **PROCESS/problem**, not just an AI tool. Every idea needs an owner, due date and a measurable outcome. |

---

## Allowed-value reference (all dropdowns)

| Field | Allowed values |
|-------|----------------|
| **Domain** | `Salesforce`, `Beyond-SF`, `Delivery Lifecycle`, `Enablement`, `Process Innovation` |
| **Horizon** | `H1 Productivity`, `H2 Workflow AI`, `H3 Transformation` |
| **Stage** | `Backlog`, `Prioritized`, `Committed`, `Building`, `Validation`, `Pilot`, `Adopted`, `Scaled` |
| **Priority** | `High`, `Medium`, `Low` |

---

## Prioritization score (set inside the portal, not the template)

Scored 1–5 per idea in the portal editor; combined into a weighted **Priority Score**:

| Criterion | Weight |
|-----------|--------|
| Value | 25% |
| Feasibility | 15% |
| Data readiness | 10% |
| Risk (higher = safer) | 15% |
| Adoption likelihood | 15% |
| Scalability | 10% |
| Differentiation | 10% |

---

## End-to-end flow (recap)

1. Lead shares `CTL-AI-Idea-Intake-Template.xlsx` (from the portal's Download button).
2. Teams fill **Ideas** + **Metrics** (Progress Log optional) and send it back.
3. Lead opens the portal → **Import** → selects the file → reviews the **X new / Y updated** preview → **Apply merge**.
4. Lead → **Export JSON (master)** → save as `data/ideas.json` (overwrite) → **commit to Git**.
5. Everyone opening the hosted portal now sees the updated data.
