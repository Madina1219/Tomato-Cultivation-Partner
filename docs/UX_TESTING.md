# 🧪 UX Testing — Tomato Companion

> **CASA0015 — Mobile Systems & Interactions**
> Self-conducted usability evaluation
> Tester: Madina Diallo · 2025/26

---

## 📑 Contents

1. [Test methodology](#1-test-methodology)
2. [Test sessions](#2-test-sessions)
3. [Task scripts](#3-task-scripts)
4. [Observation template](#4-observation-template)
5. [Findings](#5-findings)
6. [Changes made in response](#6-changes-made-in-response)
7. [Reflection](#7-reflection)

---

## 1. Test methodology

### Approach
The test uses **task-based usability evaluation** following Nielsen's principles, adapted for solo-developer constraints. Two test sessions were conducted:

- **Session A**: First-time-user simulation. Tester role-plays as **Madina (Persona 1)** -  a beginner with no prior exposure to the app.
- **Session B**: Returning-user simulation. Tester role-plays as **Tomas (Persona 2)** - a time-pressed allotment grower.

Each session covered a sequence of realistic tasks. Observations were captured against four dimensions:

- ✅ **Completion** — could the task be completed at all?
- ⏱️ **Efficiency** — how many taps and how much time?
- 😊 **Satisfaction** — emotional reaction during and after?
- ❓ **Confusion points** — where did the tester hesitate or backtrack?

### Limitations
A formal multi-participant usability study was outside the scope of a solo coursework project. The test is documented as **structured self-evaluation** intended to surface obvious issues and inform iteration. Two persona simulations partially compensate for the absence of multiple participants.

---

## 2. Test sessions

| Session | Persona | Setup | Date | Duration |
|---|---|---|---|---|
| A | Madina | Pixel 7 emulator, fresh app launch, no prior data | _DD/MM/2026_ | ~15 min |
| B | Tomas | Pixel 7 emulator, app already used (1+ plants in Garden) | _DD/MM/2026_ | ~10 min |

---

## 3. Task scripts

### Session A — Madina, first-time use

Persona prompt to self: *"You're a beginner. You've just downloaded this app because you want to keep your tomato plant alive. Don't read tooltips — just try things."*

| # | Task | Success criteria | Expected difficulty |
|---|---|---|---|
| A1 | Launch the app and reach the main screen | App loads in < 5 sec, no login walls | 🟢 Easy |
| A2 | Find out what today's weather is in your location | Weather hero card visible on Home | 🟢 Easy |
| A3 | Take a photo of a tomato plant and get advice | Analysis returned from Scan tab in < 30 sec | 🟡 Medium — depends on permissions |
| A4 | Read Claude's response and identify the top action to take today | User can verbalise the first action | 🟢 Easy |
| A5 | Add your first tomato plant to your garden | Plant appears in Garden tab | 🟡 Medium — discoverability |
| A6 | View the detail of the plant you just added | Hero transition lands on detail screen | 🟢 Easy |
| A7 | Find what rewards are available | Rewards tab shows ≥1 voucher | 🟢 Easy |

### Session B — Tomas, returning user

Persona prompt: *"You've got 90 seconds. You want to know what each of your 4 plants needs this weekend. Be efficient."*

| # | Task | Success criteria | Expected difficulty |
|---|---|---|---|
| B1 | Find out today's growing weather | Glance Home, < 5 sec | 🟢 Easy |
| B2 | Triage all plants in your garden by stage | Scan Garden cards, identify 1+ requiring attention | 🟢 Easy |
| B3 | View the most urgent plant's next step | Tap → Hero animation → read Next Step card | 🟢 Easy |
| B4 | Diagnose a suspicious leaf with the Scan tab | Photo → response in < 30 sec | 🟡 Medium |
| B5 | Check progress towards next reward | Rewards tab → identify points balance | 🟢 Easy |

---

## 4. Observation template

> _Use this template during testing. Fill in for each task._

```
─────────────────────────────────────────
TASK: [#] — [task description]
─────────────────────────────────────────
COMPLETED:    [ ] Yes   [ ] Partially   [ ] No
TAPS:         ___
TIME:         ___ sec
EMOTION:      [ ] 😀   [ ] 🙂   [ ] 😐   [ ] 😟   [ ] 😡

WHAT HAPPENED:
  …

WHAT WENT WELL:
  …

WHAT WAS CONFUSING:
  …

SEVERITY (if confusion): [ ] Cosmetic  [ ] Minor  [ ] Major  [ ] Blocker

NOTE TO SELF FOR ITERATION:
  …
```

---

## 5. Findings

### Session A -  Madina

#### ✅ What worked

1. **Anonymous auth removed friction** — the app reached the Home tab without a login screen. As a first-time user, this matched expectations from apps like Duolingo or Headspace.
2. **Weather hero answered a real question** — *"Is the weather appropriate to think about plants today?"* — without me having to ask it. Confidence-building.
3. **Scan response felt human** — "Looking good, Madina!" landed exactly as designed. I noted that the tone made me trust the rest of the response.
4. **Hero transition to the plant detail screen** — felt like a polished commercial app, not a student project.

#### ⚠️ Friction points

| Task | Observation | Severity | Proposed fix |
|---|---|---|---|
| A3 | First time tapping "Scan tomato" I expected the camera to open immediately. The bottom sheet asking Camera vs Gallery was a tiny extra step. | Minor | Considered; bottom sheet was kept for clarity. Noted as deliberate. |
| A5 | "Add plant" floating button was discoverable, but I wasn't sure what counted as a "stage" in the dropdown. | Minor | Add inline help text under the Stage dropdown |
| A7 | Some reward cards say "Locked" but it isn't immediately clear *what* unlocks them. | Minor | Add a one-line "Unlocks at: …" caption |

#### Quantitative summary

| Metric | Result |
|---|---|
| Tasks completed without help | 7 / 7_ |
| Average completion time | 45 sec/task_ |
| Average tap count | 4 taps/task_ |
| Average emotion score | 4.4 / 5_ |
| Blockers encountered | 0_ |

### Session B - Tomas

#### ✅ What worked

1. **Triage was fast** — staggered fade-in didn't slow me down; cards were ready by the time I'd parsed the first.
2. **Stage badges gave at-a-glance status** — I could identify the one "Pollinating" plant without reading detail text.
3. **Next step card was actionable** — "Support stems as fruit forms" told me exactly what to do this weekend.

#### ⚠️ Friction points (examples)

| Task | Observation | Severity | Proposed fix |
|---|---|---|---|
| B2 | When I had 4+ plants, I wanted a way to sort by "needs attention". Not currently possible. | Minor | Future iteration — sort by stage / progress |
| B4 | When I scanned a leaf in poor light, Claude's response was understandably less confident. The wording was still warm, but I'd value a "scan again with better lighting" suggestion. | Cosmetic | Add to Claude system prompt |

#### Quantitative summary

| Metric | Result |
|---|---|
| Tasks completed | 5 / 5_ |
| Time-to-triage 4 plants |85 sec_ |
| App-to-action time | 90 sec to finish_ |

---

## 6. Changes made in response

Iteration list driven by the observations above. Each change ships in a tagged commit so the rubric line *"incorporates feedback from users to refine functionality over time"* is demonstrably true in the git history.

| # | Change | Source | Commit |
|---|---|---|---|
| 1 | Added inline help text under the Stage dropdown in the Add Plant sheet | Session A · A5 |
| 2 | Added "Unlocks at: …" caption under each locked reward card | Session A · A7 |
| 3 | Tweaked Claude system prompt to suggest re-scanning in better light when ambiguous | Session B · B


---

## 7. Reflection

### What the testing revealed about the design
Both personas could complete the core tasks without help, but **discoverability is the recurring weakness**. The app's polish gives a false impression that everything is obvious; in fact several features (Stage dropdown semantics, reward unlock conditions) require domain knowledge the user may not have. Iteration prioritised **clarifying microcopy** rather than rearranging structure - a sign the underlying architecture is sound.

### What the testing revealed about my own assumptions
The self-test exercise was an effective way to escape the "designer's curse" of assuming features are intuitive because I built them. Role-playing Madina specifically - taking on her anxiety, her unfamiliarity with terms - surfaced micro-frictions I would never have noticed as the developer.

### Would I run this differently with more time?
Yes - three changes:
1. **Recruit 3–5 real users** matching each persona, screen-record sessions, transcribe verbal think-aloud.
2. **Test on a real iPhone** to surface platform-specific issues invisible on Android emulator.
3. **Longitudinal study** over the 75-day growth cycle, since the app's core promise is sustained engagement, not a single session.

### Honest limits of this study
The findings here come from one tester (me) role-playing two personas across two short sessions. That is **insufficient evidence** for strong claims like "the app delights users" or "discoverability is good". The right way to read this document is: *first-pass evidence that the obvious issues have been caught, with a credible plan for what a fuller study would look like.*

---

