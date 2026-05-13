# 🎨 Design Document — Tomato Companion

> **CASA0015 — Mobile Systems & Interactions**
> Personas, storyboards, user journeys, and design principles
> Author: Madina Aliyeva · 2025/26

---

## 📑 Table of Contents

1. [Problem statement](#1-problem-statement)
2. [Research question](#2-research-question)
3. [User personas](#3-user-personas)
4. [Empathy maps](#4-empathy-maps)
5. [Storyboards](#5-storyboards)
6. [User journey map](#6-user-journey-map)
7. [Design principles](#7-design-principles)
8. [Information architecture](#8-information-architecture)
9. [Visual design decisions](#9-visual-design-decisions)
10. [How the design responds to research](#10-how-the-design-responds-to-research)

---

## 1. Problem statement

Growing tomatoes at home is one of the most popular entry points into food gardening — almost anyone with a balcony, windowsill or back garden can try it. Yet the gap between *attempting* to grow tomatoes and *actually harvesting* them is huge. Studies of urban gardening drop-off rates suggest that **over half of first-time tomato growers lose their plants before fruiting**, most often because of:

- **Wrong action at the wrong stage** — overwatering a seedling, underfeeding a flowering plant, harvesting too early.
- **No real-time feedback loop** — generic blog advice doesn't account for *this* plant, *today*, in *this* weather.
- **Loneliness of the learning curve** — beginners give up because no one is "watching over their shoulder" with encouragement.
- **Fragmented tooling** — separate apps for weather, plant ID, reminders, shopping — none designed for the tomato grower's journey.

Tomato Companion exists to compress all of those into one warm, AI-powered mobile experience that meets the grower where they are, on the device they already use, with advice tied to what their plant looks like right now.

---

## 2. Research question

> *How might a mobile app combine AI visual diagnosis, stage-aware guidance, and real local context (weather, geography, partners) to keep first-time tomato growers engaged from seedling to harvest?*

Three sub-questions guided design decisions:

1. **What's the smallest possible action a beginner can take that delivers obvious value?** → The Scan tab: one photo, one warm response.
2. **How do we hold someone's attention across a 75-day growing cycle without nagging them?** → Stage-aware journey + gentle gamification + cycle-matched colour theming.
3. **How do we make every screen feel like a friend, not a database?** → Voice ("Looking good!"), emoji, microcopy, animations that delight rather than impress.

---

## 3. User personas

### 👩‍🎓 Persona 1 — Madina, the Sustainability-Minded Student

```
┌────────────────────────────────────────────────────────────┐
│                                                            │
│   🎓  MADINA   ·   age 24   ·   London, UK                  │
│                                                            │
│   ╔════════════════╗                                       │
│   ║                ║   "I just want to grow ONE tomato     │
│   ║   👩🏽‍🦱           ║    plant on my windowsill that doesn't│
│   ║                ║    die. Is that too much to ask?"     │
│   ╚════════════════╝                                       │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

**Background**
MSc student at UCL, lives in a 4th-floor flat with one south-facing window. Brought up in Guinea where her grandmother grew everything. Wants to reconnect with that, but small-space living, dissertation deadlines, and total inexperience are working against her.

**Goals**
- Successfully harvest one tomato plant within a term
- Eat something she grew herself
- Feel competent-not just dependent on YouTube
- Save a bit of money on supermarket vegetables

**Pain points**
- Doesn't know what "Seedling" vs "Germination" actually means
- Can't tell if her plant is healthy or dying
- Hates reading long forum threads in old gardening sites
- Forgets to water unless reminded
- Can't carry tools or huge bags of compost up four flights of stairs

**Tech profile**
- iPhone-mobile-first, uses TikTok and Duolingo daily
- Comfortable with apps that feel like Duolingo (small, frequent wins)
- Won't read more than 50 words at a time
- Trusts AI assistants more than online forums

**Quote**
> *"If the app could just tell me, 'Madina, your plant looks fine, water it tomorrow' - that's all I want. I don't need a botanical encyclopaedia."*

**How Tomato Companion serves Madina**
- **Scan tab** answers her core anxiety ("is my plant okay?") in one tap
- **Warm voice** ("Looking good, Madina!") makes her feel seen
- **Stage badges** turn jargon into colour-coded confidence
- **Rewards tab** turns a 75-day commitment into a series of small celebrations
- **Partner offers** (B&Q, RHS) point her to small-space-friendly tools nearby

---

### 👨‍👧 Persona 2 — Tomas, the Time-Pressed Allotment Dad

```
┌────────────────────────────────────────────────────────────┐
│                                                            │
│   🧑‍💼  TOMAS   ·   age 42   ·   Reading, UK                  │
│                                                            │
│   ╔════════════════╗                                       │
│   ║                ║   "I've got 30 minutes on Saturday    │
│   ║   👨🏼            ║    mornings before the kids wake up.  │
│   ║                ║    Make those minutes count."         │
│   ╚════════════════╝                                       │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

**Background**
Father of two (ages 6 and 9), works in IT for a mid-sized firm, has a half-plot allotment 10 minutes from home. Grew up watching his dad garden in Slovakia. Wants his kids to grow up knowing where food comes from.

**Goals**
- Maintain 4–6 tomato plants across the season with minimal time
- Have something to show the kids each weekend
- Avoid catastrophic losses (blight, pests, bolting)
- Compete with neighbours on his allotment site

**Pain points**
- Limited time - needs decisions in seconds, not minutes
- Trial-and-error is expensive: a failed crop = a wasted season
- Existing apps either too shallow ("water your plant!") or too academic
- Wants to know *exactly* what to do this weekend, not in general
- Frustrated by tools that don't know UK climate

**Tech profile**
- Android user (Pixel 7)
- Heavy WhatsApp, Maps, Strava user
- Won't tolerate slow apps or noisy notifications
- Wants data — progress %, day counts, evidence

**Quote**
> *"I don't need an app to be cute. I need it to tell me whether my Sungold needs feeding this weekend or not. Don't waste my time."*

**How Tomato Companion serves Tomas**
- **Garden tab** gives him a status dashboard for all his plants
- **Stage progression %** + day counts give him the data he wants
- **Scan tab** lets him diagnose problems on the fly between school runs
- **Weather + location integration** matches advice to UK conditions
- **Next step** card tells him exactly what to do this weekend
- **Rewards** create healthy rivalry — he'll show off badges to allotment neighbours

---

## 4. Empathy maps

### Empathy map — Madina

| Quadrant | Content |
|---|---|
| **🧠 Thinks** | "Did I overwater again?" · "Why are the leaves yellow?" · "Am I doing this right?" · "I don't want to ask the WhatsApp group again, it's embarrassing" |
| **💬 Says** | "Is this normal?" · "Should I cut this off?" · "The leaves look weird" · "I'm bad at plants" |
| **🎯 Does** | Googles photos of yellow leaves · Posts in r/gardening · Asks her mum on FaceTime · Checks the plant 5+ times a day · Buys tools impulsively |
| **❤️ Feels** | Hopeful at first · Anxious by week 2 · Defeated when something looks wrong · Proud when it works · Lonely in the learning |
| **🟢 Pains** | Information overload · Conflicting advice · No real-time validation · Time-poor with dissertation · Lives alone |
| **🟡 Gains** | A working harvest · A connection to her grandmother · A skill to share · Less supermarket spend · Therapy through nature |

### Empathy map — Tomas

| Quadrant | Content |
|---|---|
| **🧠 Thinks** | "Is it worth the time this Saturday?" · "Will the rain wreck my flowers?" · "What did Dave next door do differently?" · "Can I get a better yield this year?" |
| **💬 Says** | "Right, what needs doing today?" · "Look kids, that one's about to fruit" · "I haven't got time for nonsense" |
| **🎯 Does** | Checks the allotment Saturdays only · Pre-plans the visit on Friday night · Takes photos to compare week-on-week · Records yields in Notes |
| **❤️ Feels** | Pride in self-sufficiency · Frustration when something fails · Smug when it goes well · Slight competitiveness with the site community |
| **🟢 Pains** | Time poverty · Variable UK weather · Pest pressure · Lack of guidance specific to UK conditions |
| **🟡 Gains** | A productive plot · Quality family time · Status on the site · A "real-world" balance to his desk job |

---

## 5. Storyboards

Three storyboards illustrate the most important user journeys in the app.

### Storyboard 1 — Madina's First Scan (the magic moment)

The pivotal experience: a beginner's first encounter with AI plant guidance.

```
┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│  Frame 1    │  │  Frame 2    │  │  Frame 3    │  │  Frame 4    │
│             │  │             │  │             │  │             │
│  Monday     │  │  Madina     │  │  Opens      │  │  Taps Scan  │
│  morning.   │  │  notices    │  │  Tomato     │  │  tab on the │
│  Madina's   │  │  the lower  │  │  Companion  │  │  bottom nav.│
│  tomato     │  │  leaves     │  │  on her     │  │  Sees big   │
│  seedling   │  │  look       │  │  iPhone.    │  │  green leaf │
│  has been   │  │  yellow.    │  │  Friendly   │  │  + "Scan    │
│  on her     │  │  Stomach    │  │  tomato     │  │  tomato"    │
│  windowsill │  │  drops.     │  │  icon       │  │  button.    │
│  3 weeks.   │  │  Is it      │  │  greets her │  │  Curiosity  │
│             │  │  dying?     │  │  by name.   │  │  beats fear.│
└─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘

┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│  Frame 5    │  │  Frame 6    │  │  Frame 7    │  │  Frame 8    │
│             │  │             │  │             │  │             │
│  Bottom     │  │  Takes      │  │  "Looking   │  │  Madina     │
│  sheet:     │  │  photo      │  │  at your    │  │  reads:     │
│  Take Photo │  │  with her   │  │  tomato..." │  │  "Looking   │
│  or Pick    │  │  phone      │  │  Loading    │  │  good,      │
│  from       │  │  camera.    │  │  spinner.   │  │  Madina!"   │
│  gallery.   │  │  Plant      │  │  Tomato     │  │  Big sigh   │
│  Picks      │  │  fills      │  │  emoji      │  │  of relief. │
│  Take Photo │  │  the frame. │  │  bounces    │  │  Reads 4    │
│             │  │             │  │  gently.    │  │  next steps │
└─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘

┌─────────────┐  ┌─────────────┐
│  Frame 9    │  │  Frame 10   │
│             │  │             │
│  Sees       │  │  Feels      │
│  "Lower     │  │  competent. │
│  yellow     │  │  Closes the │
│  leaf is    │  │  app, gives │
│  normal —   │  │  the plant  │
│  shedding   │  │  a small    │
│  seedling   │  │  drink.     │
│  leaves".   │  │  Tells her  │
│  Anxiety →  │  │  flatmate   │
│  curiosity. │  │  proudly.   │
└─────────────┘  └─────────────┘
```

**Design intent at each beat**
- **Frames 1–2**: Acknowledge that anxiety, not knowledge, is the actual user state on entry.
- **Frames 3–4**: Lower the barrier to first action; one obvious button.
- **Frames 5–6**: Camera UX is system-native -  no novel learning required.
- **Frame 7**: Loading state itself reassures (warm copy, animated emoji).
- **Frame 8**: First word is a compliment using the user's name. This is the **emotional payoff** the entire app is built around.
- **Frames 9–10**: Knowledge transfer happens *because* of the trust earned in Frame 8.

### Storyboard 2 — Tomas's Saturday morning check-in

The returning user with constraints: minimal time, multiple plants, decision fatigue.

```
┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│  Frame 1    │  │  Frame 2    │  │  Frame 3    │  │  Frame 4    │
│             │  │             │  │             │  │             │
│  7:00 AM    │  │  Opens app  │  │  Home tab:  │  │  Taps       │
│  Saturday.  │  │  while      │  │  "Reading · │  │  Garden     │
│  Kids       │  │  kettle     │  │  May · 11°  │  │  tab. Sees  │
│  asleep.    │  │  boils.     │  │  Partly     │  │  4 plant    │
│  30 mins    │  │  Instant    │  │  cloudy"    │  │  cards      │
│  before     │  │  load.      │  │  weather    │  │  fade in    │
│  chaos.     │  │  No login   │  │  hero.      │  │  one after  │
│             │  │  needed.    │  │  Useful.    │  │  another.   │
└─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘

┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│  Frame 5    │  │  Frame 6    │  │  Frame 7    │  │  Frame 8    │
│             │  │             │  │             │  │             │
│  Scans the  │  │  Taps the   │  │  Hero       │  │  Reads      │
│  cards:     │  │  Cherokee   │  │  transition │  │  "Support   │
│  3 plants   │  │  Carbon     │  │  morphs the │  │  stems as   │
│  on track,  │  │  card —     │  │  card into  │  │  fruit      │
│  1 needs    │  │  the only   │  │  a detail   │  │  forms".    │
│  attention. │  │  Pollinating│  │  screen.    │  │  Mental     │
│  Sungold    │  │  one.       │  │  Big yellow │  │  note: pick │
│  flowering. │  │             │  │  flower.    │  │  up canes.  │
└─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘

┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│  Frame 9    │  │  Frame 10   │  │  Frame 11   │  │  Frame 12   │
│             │  │             │  │             │  │             │
│  Closes the │  │  At the     │  │  Snaps      │  │  Heads home │
│  app at     │  │  allotment  │  │  one more   │  │  with kids  │
│  7:08 AM.   │  │  by 8:15.   │  │  scan of a  │  │  for        │
│  Total time │  │  Picks up   │  │  suspicious │  │  pancakes,  │
│  in app:    │  │  bamboo     │  │  leaf. AI:  │  │  feeling    │
│  90 secs.   │  │  canes      │  │  "Looks     │  │  on top of  │
│  4 plants   │  │  from his   │  │  fine,      │  │  the plot.  │
│  triaged.   │  │  shed.      │  │  no worry". │  │             │
└─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘
```

**Design intent at each beat**
- **Frame 2**: Anonymous auth means no friction. No login screen. *Ever.*
- **Frame 3**: Weather hero answers the implicit "is it worth going?" question first.
- **Frame 4**: Staggered animation isn't decoration — it's progressive disclosure that prevents overwhelm with 4+ items.
- **Frame 5**: Status colour-coding (green progress vs amber badges) is at-a-glance scannable.
- **Frame 6–7**: Hero animation creates spatial continuity — Tomas knows exactly where he came from and where he's going.
- **Frame 8**: One concrete action per plant. Not a checklist.
- **Frame 9**: 90 seconds is the success metric for the returning-user journey.

### Storyboard 3 — The Reward Redemption Loop

How the gamification layer drives long-term retention.

```
┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│  Frame 1    │  │  Frame 2    │  │  Frame 3    │  │  Frame 4    │
│             │  │             │  │             │  │             │
│  After 5    │  │  Notification │ │  Opens      │  │  Rewards    │
│  daily      │  │  arrives:   │  │  Tomato     │  │  tab shows  │
│  scans,     │  │  "Sprout    │  │  Companion. │  │  available  │
│  Madina's   │  │  watcher    │  │  Sees       │  │  vouchers.  │
│  earned her │  │  badge      │  │  badge on   │  │  Free RHS   │
│  second     │  │  unlocked!" │  │  Garden tab │  │  heirloom   │
│  badge.     │  │             │  │  with       │  │  seed pack  │
│             │  │             │  │  +75 pts.   │  │  for 1k pts │
└─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘

┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│  Frame 5    │  │  Frame 6    │  │  Frame 7    │  │  Frame 8    │
│             │  │             │  │             │  │             │
│  Realises   │  │  Stays      │  │  3 days     │  │  RHS pack   │
│  she's at   │  │  consistent │  │  later, she │  │  arrives    │
│  870 pts.   │  │  for 3 more │  │  taps       │  │  in post.   │
│  Only 130   │  │  days to    │  │  Redeem.    │  │  Plants     │
│  more for   │  │  hit 1k.    │  │  Voucher    │  │  the seeds. │
│  the free   │  │  Genuine    │  │  emailed.   │  │  Now has    │
│  seeds.     │  │  retention. │  │  Free       │  │  six tomato │
│             │  │             │  │  delivery!  │  │  varieties. │
└─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘
```

**Design intent at each beat**
- **Frame 1**: Earning badges is intrinsic (5 daily scans) not extractive (purchases).
- **Frame 2**: Notification celebrates rather than nags.
- **Frame 4**: Vouchers are real partner offers, not vanity points — they have actual cash value.
- **Frame 5**: A clear, near-term goal motivates short-term consistency.
- **Frame 8**: The reward loop closes back into the core loop — more plants → more engagement → more rewards.

---

## 6. User journey map

End-to-end Madina journey across the 75-day growth cycle.

```
PHASE             DAY 0          DAY 14         DAY 30         DAY 50         DAY 75
                  Seedling       Germination    Flowering      Fruiting       Harvest
                  ───────        ───────────    ──────────     ─────────      ───────

ACTIONS           Buys seed,     Daily scans,   Adds support,  Weekly         Picks first
                  sows in pot,   first stage    pollinates     scans, feeds   ripe tomato
                  logs plant     transition

TOUCHPOINTS       Add plant      Scan tab,      Plant detail   Garden status  Harvest hero
                  sheet, Home    Garden cards   Hero screen    dashboard      badge

EMOTIONS          🙂 hopeful      😨 anxious     😊 hopeful     😎 confident   😍 ecstatic
                  ↑              ↓              ↑              ↑              ↑↑↑

CRITICAL          "Is this even  "Is this       "Will it       "Almost        "I grew this!"
THOUGHTS          working?"      yellow leaf    actually       there..."
                                 normal?"       fruit?"

APP RESPONSE      Welcoming      Reassuring     Stage-change   Streak         Achievement
                  empty state    AI scan        badge unlock   celebration    + share

RISK OF           Low            HIGHEST        Medium         Low            Very low
DROP-OFF          (motivation    (uncertainty,  (waiting       (visible       (almost done)
                  high)          first crisis)  fatigue)       progress)

DESIGN            Make first     Make scan      Hero-animate   Show progress  Big visual
INTERVENTION      action easy    feel friendly  stage change   prominently    celebration
                  & rewarding    & non-judgey   feel earned    & weekly       + reward
```

The map confirms **Day 14 is the highest-risk drop-off point**. The entire Scan-tab experience is engineered around this moment: warm copy, fast results, structured advice that calms fears.

---

## 7. Design principles

Six principles emerged from the persona work and were used to evaluate every screen.

### Principle 1 — Anxiety first, knowledge second
Beginners arrive at the app *worried* their plant is dying, not *curious* about botany. Every screen leads with reassurance ("Looking good!") and only then provides information.

### Principle 2 — One concrete action per screen
No screen presents more than 4 numbered next steps. The Scan response is capped at 200 words by system prompt. The plant detail screen has exactly one CTA.

### Principle 3 — Stage-aware everything
Colour, copy, badges, emoji, recommended actions — all derive from the plant's current stage. The app *knows where the user is* and adapts.

### Principle 4 — Time-respect
The returning user can triage the entire garden in under 90 seconds. Anonymous auth means no login. Live Firestore sync means no manual refresh.

### Principle 5 — Reward, don't extract
Points come from healthy behaviours (scanning, logging, completing stages). Vouchers redirect users to real partner products, building habit-forming positive loops.

### Principle 6 — Connected environment as ambient context
Weather, location, and time of year are present but never the protagonist. They quietly shape advice rather than demanding attention.

---

## 8. Information architecture

```
                        ┌──────────────────────┐
                        │   Tomato Companion   │
                        │   (anonymous auth)   │
                        └──────────┬───────────┘
                                   │
            ┌──────────┬───────────┼────────────┬──────────┐
            ▼          ▼           ▼            ▼          ▼
        ┌───────┐  ┌───────┐  ┌───────┐  ┌───────────┐ ┌─────────┐
        │ Home  │  │Varieties│ │ Scan  │  │  Garden   │ │ Rewards │
        └───┬───┘  └────┬───┘  └───┬───┘  └─────┬─────┘ └────┬────┘
            │           │          │            │            │
        Weather    Variety       Camera     Plant cards   Vouchers
        Tasks      detail        AI vision  Hero detail   Streaks
                   (Hero)        result     screen        Partners
```

**Five-tab structure** chosen for thumb-reach, with **Scan** in the privileged centre position because it is both the most distinctive feature and the most anxiety-relieving.

---

## 9. Visual design decisions

| Element | Decision | Reasoning |
|---|---|---|
| Primary colour | Tomato red | Brand recognition, organic warmth |
| Stage colours | Yellow / leaf-green / tomato-red | Mirrors the actual plant lifecycle |
| Typography | System default, generous weight contrast | Native feel on each platform |
| Iconography | Material Icons + emoji | Emoji read as warm; icons as functional |
| Corner radius | Medium (12–16px) | Friendly without being childish |
| Padding | Generous (16–24px) | Breathing room reduces anxiety |
| Animations | 300–500ms with ease-out cubic | Snappy enough for Tomas, gentle enough for Madina |
| Loading states | Animated emoji + copy | Removes "is it broken?" anxiety |
| Empty states | Illustrated + actionable | Welcomes new users into action |

---

## 10. How the design responds to research

| User research insight | Design response |
|---|---|
| "I don't know what 'germination' means" | Stage badges with colour + plain-language `nextStep` summaries |
| "I check 5+ times a day" | Anonymous auth, instant launch, live Firestore sync — checking is friction-free |
| "I'm embarrassed to ask in forums" | Private 1:1 with AI — no shame, no audience |
| "I want a quick yes/no, not an essay" | 200-word Claude system prompt cap, structured response |
| "I forget to water" | Notification roadmap + Rewards streak system |
| "Generic advice doesn't fit UK weather" | Geolocator + Open-Meteo wire local conditions into context |
| "I want something to show for the effort" | Rewards tab with real partner vouchers |
| "I want to feel competent, not nagged" | Warm voice, never accusatory copy ("Watch moisture" not "You forgot to water") |

---

## 📎 Appendix — References & inspirations

- **Material Design 3** — colour and motion guidelines (Google, 2023)
- **Refactoring UI** — typography and spacing principles (Adam Wathan, Steve Schoger, 2018)
- **Hooked** — habit-forming product design (Nir Eyal, 2014) — influenced the Rewards loop
- **The Royal Horticultural Society** — botanical accuracy on stage progression
- **Open-Meteo** — public weather data
- **Anthropic Claude** — vision and language model powering the Scan experience

---

*Last updated: 14 May 2026 · Tomato Companion v0.9*
