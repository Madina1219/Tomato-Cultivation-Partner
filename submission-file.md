# Submission File - CASA0015 Mobile Systems & Interactions

**Module**: CASA0015 - Mobile Systems & Interactions
**Programme**: MSc Connected Environments
**Academic year**: 2025/26
**Student**: Madina Diallo
**Submission date**: 16 May 2026

---

## How to create a PDF from this Markdown

This Markdown file is exported to PDF using VSCode with the **MarkdownPDF** extension. Headers and footers were disabled in the extension preferences before exporting, as instructed in the module template.

The PDF is uploaded to Moodle for submission together with the presentation slides.

---

## Link to GitHub repository

**Flutter Application Name**: Tomato Companion

**GitHub Repository**: <https://github.com/Madina1219/Tomato-Cultivation-Partner>

**Live Microsite**: <https://madina1219.github.io/Tomato-Cultivation-Partner/>

**Demo Video** (filmed on a real Samsung Galaxy A17 5G running Android 16): <https://youtu.be/RDK8aizjWwA>

---

## Introduction to Application

**Tomato Companion** is a Flutter mobile application built for the CASA0015 *Mobile Systems & Interactions* module. The app helps urban tomato growers - particularly first-time growers with limited space - succeed with their plants from seedling to harvest, by compressing scattered horticultural advice into a single context-aware pocket assistant.

The app integrates three Connected-Environment components: (1) the **Geolocator** plugin reads the device's current location; (2) that location is passed to the **Open-Meteo** weather API to surface live local conditions on the Today screen; and (3) the device **camera** is paired with the **Anthropic Claude vision API** to deliver conversational AI plant diagnosis - the user points the phone at a plant and receives plain-English advice rather than a generic classification label. A garden tracker uses `shared_preferences` for per-plant logs, **Firebase Authentication** enables cross-device sync, and a rewards loop awards points for daily actions that redeem at real horticultural partners (B&Q, RHS).

The design is anchored around a single primary persona, Maya - a 24-year-old student in a London flat with a balcony, no experience, and limited patience for generic advice - documented in a four-panel storyboard that drove every interface and microcopy decision. The application was developed and tested on the Android emulator (Pixel 7) and a real Samsung Galaxy A17 5G running Android 16.

*(Word count: approximately 235 words.)*

---

## Bibliography

Citations follow Harvard referencing style as specified in the module template.

1. **Anthropic**. (2025). *Claude API documentation — vision capabilities*. San Francisco: Anthropic PBC. Available at: <https://docs.anthropic.com/en/docs/build-with-claude/vision>.

2. **Flutter Team**. (2025). *Flutter documentation*. Mountain View: Google. Available at: <https://docs.flutter.dev>.

3. **Open-Meteo**. (2025). *Free weather forecast API documentation*. Bürglen: Open-Meteo. Available at: <https://open-meteo.com/en/docs>.

4. **Material Design Team**. (2025). *Material Design 3 specification*. Mountain View: Google. Available at: <https://m3.material.io>.

5. **Royal Horticultural Society**. (2024). *Tomatoes — growing guide*. London: RHS. Available at: <https://www.rhs.org.uk/vegetables/tomatoes/grow-your-own>.

6. **O'Sullivan, M.** (2024). *flutter_launcher_icons (version 0.14.1)*. Dart package. Available at: <https://pub.dev/packages/flutter_launcher_icons>.

7. **Tabima, H.** (2025). *flutter_native_splash (version 2.4.1)*. Dart package. Available at: <https://pub.dev/packages/flutter_native_splash>.

8. **Firebase Team**. (2025). *Firebase Authentication for Flutter*. Mountain View: Google. Available at: <https://firebase.google.com/docs/auth/flutter/start>.

9. **Baseflow**. (2025). *geolocator — Dart package*. Groningen: Baseflow. Available at: <https://pub.dev/packages/geolocator>.

10. **Flutter Team**. (2025). *camera — Dart package*. Mountain View: Google. Available at: <https://pub.dev/packages/camera>.

---

## Declaration of Authorship

I, **Madina Diallo**, confirm that the work presented in this assessment is my own. Where information has been derived from other sources, I confirm that this has been indicated in the work (see the Bibliography above and the credits section of the GitHub README).

### Use of generative AI

In line with UCL's policy on the use of generative AI in assessments, I disclose that **Anthropic's Claude (Opus 4.7)** was used as an AI coding assistant during the development of this application.

All design decisions, the choice of features, the user persona and storyboard, the visual identity, the variety database curation, and the integration of all components into a working application are my own. Every AI-suggested code change was reviewed, understood, modified where needed, and committed by me. The Anthropic API key used by the Scan feature is my own, obtained through a personal Anthropic developer account.

The mobile application source code, design documents, screenshots, demo video, and microsite are all produced by me for **CASA0015: Mobile Systems & Interactions, 2025/26**.

---

**Digitally signed**: Madina Diallo

