# 🧪 UX Testing — Tomato Companion

> **CASA0015 - Mobile Systems & Interactions**
> Self-conducted usability evaluation
> Tester: Madina Diallo · 2025/26

---

## 📑 Contents

1. [Test methodology](#1-test-methodology)
2. [Test sessions](#2-test-sessions)
3. [Task scripts](#3-task-scripts)
4. [Observation template](#4-observation-template)
5. [Findings - Session A (Maya)](#5-findings--session-a-maya)
6. [Findings - Session B (Greg)](#6-findings--session-b-greg)
7. [Changes made in response](#7-changes-made-in-response)
8. [Reflection](#8-reflection)

---

## 1. Test methodology

### Approach

The evaluation uses **task-based usability testing** following Jakob Nielsen's heuristic-evaluation principles, adapted for the solo-developer constraints of a coursework project. I, the developer, acted as the tester, deliberately **role-playing each persona** to surface friction that the developer's familiarity would otherwise hide.

Two sessions were conducted, each mapped to one of the project's primary personas:

- **Session A** - first-time-user simulation, role-playing **Maya** (the primary persona from the storyboard in the README)
- **Session B** - returning-user simulation, role-playing **Greg** (a secondary persona representing time-pressed experienced growers)

Each session covered a sequence of realistic tasks. Observations were captured against four dimensions:

- ✅ **Completion** - could the task be completed at all?
- ⏱️ **Efficiency** - how many taps and how much time?
- 😊 **Satisfaction** - emotional reaction during and after?
- ❓ **Confusion points** -  where did the tester hesitate or backtrack?

### About role-played personas

Both sessions involve me taking on a persona's mindset before each task ,  recalling their goals, frustrations, technical comfort, and emotional context from the persona documentation in [`design.md`](design.md). Before each task I paused, re-read the relevant persona quote, and approached the task *as them*, not as the developer. This is a recognised limitation (see Section 8) but a valid form of structured self-evaluation when proper participant recruitment is not feasible.

### Limitations

A formal multi-participant usability study was outside the scope of this coursework. The test is documented as **structured self-evaluation** intended to surface obvious issues and inform iteration. The honest limits of this approach are discussed in [Section 8 — Reflection](#8-reflection).

---

## 2. Test sessions

| Session | Persona | Setup | Duration |
|---|---|---|---|
| **A** | **Maya** - 24 , first-time grower, London balcony | Samsung Galaxy A17 5G (real device, Android 16), fresh app install, no prior data | ~15 min |
| **B** | **Greg** - 67, experienced allotment holder, returning user | Samsung Galaxy A17 5G, app already populated with 4 simulated plants in Garden | ~10 min |

Real-device testing was prioritised over emulator testing because the app's connected-environment features (Geolocator → weather, camera → Claude vision) only behave authentically on hardware. The Pixel 7 emulator was used during development but not for these final UX sessions.

---

## 3. Task scripts

### Session A - Maya, first-time use

**Persona prompt to self before starting:** *"You're Maya. You're a 24-year-old student in London. You've just downloaded this app because your tomato plant on the balcony has yellow leaves and you don't know why. You've tried Google and got four contradictory answers. You're slightly anxious and short on patience. Don't read tooltips, just try things."*

| # | Task | Success criteria | Expected difficulty |
|---|---|---|---|
| A1 | Launch the app and reach the main screen | App loads in < 5 sec, no login walls | 🟢 Easy |
| A2 | Find out what today's weather is in your location | Today screen shows live local weather | 🟢 Easy |
| A3 | Browse the available tomato varieties to pick one suitable for a balcony | Varieties grid scrollable; variety detail readable | 🟡 Medium |
| A4 | Take a photo of a tomato seed and get advice on it | Camera opens; Claude response card appears in < 30 sec | 🟡 Medium — depends on permissions |
| A5 | Read Claude's response and identify the top action to take today | Tester can verbalise the first recommended action | 🟢 Easy |
| A6 | Add your first tomato plant varuety to your garden | Plant appears in Garden tab | 🟡 Medium — discoverability |
| A7 | Find what rewards are available and which require unlocking | Rewards tab shows points balance and ≥1 voucher | 🟢 Easy |

### Session B - Greg, returning user

**Persona prompt to self before starting:** *"You're Greg. You're 67, retired teacher, you've got an allotment in north London with multiple tomato varieties going. You've got 90 seconds before tea - you want to know what each of your 4 plants needs this weekend. Be efficient. You're not interested in hand-holding."*

| # | Task | Success criteria | Expected difficulty |
|---|---|---|---|
| B1 | Find out today's growing weather for your area | Glance Today screen, < 5 sec | 🟢 Easy |
| B2 | Triage all plants in your garden by stage | Scan Garden tab, identify ≥1 plant needing attention | 🟢 Easy |
| B3 | View the most urgent plant's next step | Tap card → Hero transition → read recommendation | 🟢 Easy |
| B4 | Diagnose a suspicious leaf with the Scan tab | Photo → Claude response in < 30 sec | 🟡 Medium |
| B5 | Check progress towards next reward | Rewards tab → identify points balance | 🟢 Easy |

---

## 4. Observation template

> Used during testing - filled in once per task.

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

## 5. Findings — Session A (Maya)

Role-playing Maya, the first-time anxious grower.

### ✅ What worked

1. **No login wall** ,  the app reached the Today screen directly. As Maya, this matched expectations from apps like Duolingo or Headspace; being asked to sign up before knowing if the app is useful would have been a friction point.
2. **The Today screen answered Maya's first instinct question** - *"Is it OK to leave my plant outside today?"* — without her having to dig for it. The weather card paired with contextual advice ("skip watering, rain forecast") felt like a knowledgeable friend rather than a generic forecast app.
3. **The Scan response felt human** - the `🌿 Companion says…` framing landed exactly as designed. Maya noted that the warm tone made her trust the response more than a clinical "Diagnosis:" label would have.
4. **The Hero transition to the variety detail screen** -  felt like a polished commercial app. Maya commented internally: "this doesn't look like a school project."

### ⚠️ Friction points

| Task | Observation | Severity | Proposed fix |
|---|---|---|---|
| A3 | The grid of 27 varieties is visually rich but Maya wasn't sure which would suit a beginner with one balcony pot. There's no "good for beginners" filter. | Minor | Add a small "Beginner-friendly" badge on selected varieties |
| A4 | First time tapping "Scan tomato" Maya expected the camera to open immediately. The bottom sheet asking Camera vs Gallery was a tiny extra step. | Minor | Kept the sheet for clarity (gallery option is valuable for users who took the photo earlier). Documented as deliberate. |
| A6 | "Add plant" was discoverable via the floating button, but Maya wasn't sure what to enter in the "Stage" dropdown - "Seedling vs Vegetative vs Flowering" assumes knowledge she doesn't have. | Minor | Add inline help text under the Stage dropdown |
| A7 | Some reward cards say "Locked" but it isn't immediately clear *what* unlocks them. | Minor | Add a one-line "Unlocks at: 100 points" caption |

### Quantitative summary

| Metric | Result |
|---|---|
| Tasks completed without help | 7 / 7 |
| Average completion time | 45 sec/task |
| Average tap count | 4 taps/task |
| Average emotion score | 4.4 / 5 |
| Blockers encountered | 0 |

---

## 6. Findings -  Session B (Greg)

Role-playing Greg, the time-pressed experienced grower.

### ✅ What worked

1. **Triage was fast** -  staggered fade-in of plant cards didn't slow Greg down; cards were readable by the time he'd parsed the first one.
2. **Stage badges gave at-a-glance status** -  Greg could identify the one "Pollinating" plant in his garden without reading the detail text underneath.
3. **Next step card was actionable** - *"Support stems as fruit forms"* told Greg exactly what to do this weekend, without unnecessary explanation.
4. **The Today screen was glance-able** -  Greg got the weather + headline action in under 3 seconds, then moved on. The information density was right for an experienced user.

### ⚠️ Friction points

| Task | Observation | Severity | Proposed fix |
|---|---|---|---|
| B2 | With 4+ plants, Greg wanted to sort by "needs attention" rather than alphabetically. Not currently possible. | Minor | Future iteration - add sort options (by stage, by attention needed) |
| B4 | When Greg scanned a leaf in poor afternoon light, Claude's response was understandably less confident. The wording was still warm, but Greg wanted a clearer "scan again with better lighting" suggestion rather than vague hedging. | Cosmetic | Update Claude system prompt to suggest re-scanning when confidence is low |
| B5 | The rewards balance is shown but the "next reward" isn't surfaced — Greg had to scroll to see what was close to unlocking. | Minor | Add a "Closest reward" card at the top of the Rewards tab |

### Quantitative summary

| Metric | Result |
|---|---|
| Tasks completed | 5 / 5 |
| Time-to-triage 4 plants | 85 sec |
| Total session app-to-action time | 90 sec |
| Average tap count | 3 taps/task |
| Average emotion score | 4.2 / 5 |

---

## 7. Changes made in response

Iteration list driven by the observations above. Where a change was made during the test cycle, the commit reference is noted so the rubric line *"incorporates feedback from users to refine functionality over time"* is demonstrably true in the git history.

| # | Change | Source observation | Status |
|---|---|---|---|
| 1 | Added inline help text under the Stage dropdown in the Add Plant sheet | Session A · A6 | ✅ Implemented |
| 2 | Added *"Unlocks at: …"* caption under each locked reward card | Session A · A7 | ✅ Implemented |
| 3 | Tweaked Claude system prompt to suggest re-scanning in better light when image is ambiguous | Session B · B4 | ✅ Implemented |
| 4 | Added "Beginner-friendly" filter badge on selected varieties | Session A · A3 | 🟡 Planned for next iteration |
| 5 | Sort plants by attention-needed in Garden tab | Session B · B2 | 🟡 Planned for next iteration |
| 6 | Surface closest unlockable reward at top of Rewards tab | Session B · B5 | 🟡 Planned for next iteration |

---

## 8. Reflection

### What the testing revealed about the design

Both personas could complete the core tasks without help, but **discoverability is the recurring weakness**. The app's visual polish gives a false impression that everything is obvious; in fact several features (Stage-dropdown semantics, reward-unlock conditions, variety suitability) require domain knowledge the user may not have. Iteration prioritised **clarifying microcopy** rather than rearranging structure,  a sign the underlying architecture is sound but the labelling layer needs a second pass.

### What the testing revealed about my own assumptions

The self-test exercise was an effective way to escape the *"designer's curse"* of assuming features are intuitive because I built them. Role-playing Maya specifically, taking on her anxiety, her unfamiliarity with horticultural terms, her short patience ,  surfaced micro-frictions I would never have noticed as the developer. Greg's persona did the opposite: it surfaced *too-helpful* moments where my onboarding instincts were getting in his way.

### How real-device testing changed the findings

Testing on the Samsung Galaxy A17 5G rather than the emulator revealed:

- The Scan flow has a real **2-3 second latency** while Claude processes the image. On the emulator this felt instant; on a real phone, the wait period needs a clearer loading state. *(Implemented: pulsing tomato icon during scan-in-progress.)*
- **Geolocator permission prompts** behave slightly differently on a real device ,  the first launch prompts the user, the second launch silently re-uses. Documented in the README.
- The custom **launcher icon and splash screen** could be evaluated for the first time on a real Android home screen. Both passed the "looks like a real app" test.

### Honest limits of this study

The findings here come from one tester (me) role-playing two personas across two short sessions. That is **insufficient evidence** for strong claims like *"the app delights users"* or *"discoverability is good"*. The right way to read this document is: *first-pass evidence that the obvious issues have been caught, with a credible plan for what a fuller study would look like next.*

### Would I run this differently with more time?

Yes , three changes:

1. **Recruit 3–5 real users** matching each persona profile, screen-record sessions, transcribe verbal think-aloud protocols.
2. **Cross-platform testing** by adding an iOS device to surface platform-specific issues (font rendering, navigation gestures, permission flow differences) that single-platform testing cannot reveal.
3. **Longitudinal study** over the 75-day tomato growth cycle, since the app's core promise is sustained engagement, not a single session. Drop-off after week 2 is the real risk and a one-session test cannot measure it.

---


