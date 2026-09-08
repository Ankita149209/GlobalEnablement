# CTL AI Innovation & Delivery Portal

A single-file, Git-hostable portal to run the **CTL AI Innovation & Delivery Program** — moving from an *ideas list* to a *delivery pipeline* with owners, metrics, governance and adoption tracking.

> **Operating model:** Ideas → Prioritize → Commit → Build → Validate → Adopt → Scale
> **North star:** Make CTL an AI-enabled delivery organization — AI embedded in how we work, delivering **Productivity + Quality + Innovation**.

---

## 1. Quick start (see it now)

- **Just double-click `index.html`** → the portal opens with all 16 seeded ideas, dashboard, Kanban and metrics. Works offline (seed data is embedded).
- **Recommended for full fidelity** (so `data/ideas.json` auto-loads exactly like when hosted):
  ```
  cd ai-innovation-portal
  python -m http.server 8000      # or any static server
  ```
  Then open `http://localhost:8000`.

> Note: the Excel import/export uses the SheetJS library loaded from a CDN. The first load needs internet; JSON import/export works fully offline.

> **All ideas start in Backlog** and every team-input field (status, next step, updates, due date, SME, champions, metrics, blockers) is intentionally **EMPTY** — nothing is fabricated. Capture the real values live, then Export JSON and commit.

---

## 2. Host it on Git (share with the team)

**Option A — clone & open (simplest)**
1. Commit the `ai-innovation-portal/` folder to your repo.
2. Teammates pull and double-click `index.html`.

**Option B — GitHub Pages (a shareable URL)**
1. Push the repo to GitHub.
2. Repo → **Settings → Pages** → Source: your branch, folder `/ (root)` or `/ai-innovation-portal` (if supported).
3. Open the published URL → the portal loads `data/ideas.json` automatically.

---

## 3. How data works & persists (no backend needed)

The portal reads data in this order:
1. **Browser localStorage** — your working draft. **Every edit auto-saves here instantly**, so your changes survive refreshes and closing the tab **on your machine**.
2. **`data/ideas.json`** — the committed **shared source of truth** everyone sees when they open the hosted portal.
3. **Embedded seed** — fallback so a plain double-click always shows something (browsers block reading local JSON over `file://`).

**Important:** localStorage is **per-browser, per-machine**. Your edits are *not* shared with anyone until you **Export JSON → overwrite `data/ideas.json` → commit to Git**. That commit is what makes changes visible to the team.

**You maintain ONE master file: `data/ideas.json`.**

### The weekly loop
1. A team sends you their filled **Excel/CSV template**.
2. Open portal → **Import / Export / Templates** tab → **Import** the file → review the **merge preview** (X new, Y updated) → **Apply**.
3. Click **Export JSON** → save/overwrite **`data/ideas.json`** → `git commit && git push`.
4. Done. Everyone now sees the update. You import each team file **once** — no repetitive loading.

> Optional helper: run `inject-seed.ps1` (PowerShell) to re-embed the latest `data/ideas.json` into `index.html` so the double-click fallback also shows current data:
> ```
> powershell -NoProfile -ExecutionPolicy Bypass -File ai-innovation-portal\inject-seed.ps1
> ```

---

## 4. What each screen does

| Screen | Purpose |
|---|---|
| **Dashboard** | Scorecard: totals by stage, POCs/pilots/adopted/scaled, **hours saved/yr**, active users, adoption funnel, portfolio-by-horizon, top-impact table. |
| **Pipeline** | 8-stage Kanban. Every idea starts in **Backlog** — move cards along as they progress on the call. Click any card for full context. |
| **Ideas** | Filterable/sortable portfolio. Add/edit ideas; auto-computed priority score. |
| **Idea detail** | Overview, **Metrics** (auto-calculated), **DoD & Governance** checklist, **Progress Log**. |
| **People & Roles** | Participation tiers (Leads / Champions / SMEs / Users / Sponsor), owner table, **Teams & Members** roster, operating cadence. |
| **Import / Export / Templates** | Download the team template, import files, export JSON/Excel master. |

---

## 5. Metrics (auto-calculated from raw inputs)

Teams enter raw numbers; the portal computes:

| Output | From |
|---|---|
| **% effort reduction / run** | hoursBefore, hoursAfter |
| **Hours saved / month & / year** | (hoursBefore − hoursAfter) × runsPerMonth × 12 |
| **% faster cycle time** | cycleBefore, cycleAfter |
| **% quality improvement** | errorBefore, errorAfter |
| **Adoption %** | activeUsers / targetUsers |
| **DoD maturity %** | checklist completion |

---

## 6. Teams & Members

The **People & Roles** tab has a **Teams & Members** panel where you can:
- **Add a team** (e.g. "Salesforce Eng", "QA / BA").
- **Add members** to each team, and remove teams/members as things change.

This roster:
- **Persists** in localStorage like everything else, and is included when you **Export JSON**.
- Appears as a **Teams** tab in both the **Excel export** and the **downloadable Excel template** (columns: `Team`, `Member` — one row per member).
- Is **imported back** automatically — from the Teams tab of any workbook you import, or from the `teams` array in a JSON backup.

---

## 7. How the portal *enforces* delivery (not just tracking)

- **No idea leaves "Backlog"** without **Owner + Due date + Target users + Hours before/after** → guarantees an owner and a measurable outcome.
- **Definition of Done gating** — an idea only reaches "Adopted/Scaled" when: prototype built → SME validated → security/governance checked → piloted with real users → users trained + docs → value measured. Prevents a graveyard of POCs.
- **Participation tiers** — everyone participates, not everyone owns.

---

## 8. Operating playbook

### Roles
- **AI Leads** (~10–15% capacity): own delivery of experiments — build, demo, document, drive adoption.
- **AI Champions** (~5%): surface process pain points, experiment with Cline/Cursor, test, give feedback.
- **SMEs**: validate solutions against real processes (accuracy, quality, fit).
- **AI Users**: use solutions, give feedback, adopt.
- **Leadership Sponsor**: unblock, allocate capacity, review monthly, back the US↔Canada exchange.

### Cadence
- **Weekly — AI Delivery Stand-up (30 min):** portfolio counts → each owner: done / next / blocker → adoption → decisions.
- **Monthly — Review + Demo Day:** pipeline → results → ROI → decisions; each active team demos something *real* (old way → new way → value).
- **Quarterly — Showcase & US↔Canada Exchange:** what we built, value created, reusable assets, what to borrow/share.

### 90-day plan
- **Month 1 – Mobilize:** own the existing backlog, classify (Build Now / Validate / Backlog / Drop), assign owners + due dates + success metrics, set governance.
- **Month 2 – Build:** 3–5 working prototypes; start testing with real users.
- **Month 3 – Prove:** 2–3 pilots; at least **1 flagship** with measurable productivity/adoption impact.

### Portfolio by horizon
- **H1 Productivity** (quick wins): prompt library, Cline rules, doc/test generation.
- **H2 Workflow AI**: code review, PR gates, spec-driven testing, dashboard builder.
- **H3 Transformation**: HL solutioning agent, Delivery Intelligence Hub, Agentforce scheduler.

---

## 9. Files

```
ai-innovation-portal/
├── index.html              # the whole app (seed embedded)
├── data/ideas.json         # shared source of truth (16 ideas seeded)
├── templates/              # CSV fallbacks for teams
│   ├── 1-Ideas.csv
│   ├── 2-Metrics.csv
│   └── 3-Progress-Log.csv
├── inject-seed.ps1         # re-embed ideas.json into index.html (optional)
├── EXCEL-MASTER-SHEET.md   # full tab/column spec for the intake workbook
└── README.md
```

*The real multi-tab Excel intake workbook is generated by the portal itself — **Import / Export / Templates → Download Excel Template**.*

---

## 10. Upgrade path (when you outgrow manual merge)

The portal centralizes all data loading in `loadData()`. To move to true multi-user self-service later, point it at a **SharePoint List** or **Google Sheet** (published CSV/API) instead of `data/ideas.json` — the rest of the UI stays the same.
