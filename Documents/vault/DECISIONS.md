---
title: TomatoBar — Decisions
version: 1.0
created: 2026-04-14
updated: 2026-04-14
tags:
  - tomatobar
  - decisions
  - adr
---

# TomatoBar — Architecture Decision Records

## ADR-001 — Use SwiftState for timer state machine

- **Date:** 2022-01-01
- **Status:** Accepted
- **Context:** The timer needs to manage transitions between idle, work, and rest states with guards and side effects.
- **Decision:** Use the SwiftState library to model the state machine.
- **Rationale:** SwiftState provides a declarative API for defining states, events, transitions, and guards. It keeps transition logic centralised and testable.
- **Consequences:** Adds a third-party dependency but simplifies state management significantly.

## ADR-002 — Use @AppStorage for all preferences

- **Date:** 2022-01-01
- **Status:** Accepted
- **Context:** User preferences (interval lengths, scheduling, sounds) need to persist across app launches.
- **Decision:** Use `@AppStorage` (UserDefaults wrapper) for all preference values directly on `TBTimer`.
- **Rationale:** Simple, built-in, and reactive with SwiftUI. No need for a separate settings model layer.
- **Consequences:** Preferences are tightly coupled to `TBTimer`. Acceptable given the app's small scope.

## ADR-003 — Extract TBScheduleRule as a pure value type

- **Date:** 2026-04-09
- **Status:** Accepted
- **Context:** Auto-start and auto-stop scheduling logic was embedded in `TBTimer`, making it hard to reason about in isolation.
- **Decision:** Extract a `TBScheduleRule` struct that takes `enabled`, `minutesSinceMidnight`, and `daysBitmask` and exposes a `shouldFire(now:calendar:)` method.
- **Rationale:** Keeps scheduling logic free of `TBTimer` state, making it testable and reusable for both auto-start and auto-stop.
- **Consequences:** Caller is responsible for once-per-day deduplication and state guards.

## ADR-004 — Remove lunch pause feature

- **Date:** 2026-04-14
- **Status:** Accepted
- **Context:** A lunch-pause feature was added on 2026-04-09 (TBLunchWindow struct, UI controls, localization keys). The feature was not satisfactory.
- **Decision:** Cleanly remove all lunch-pause code, UI, and localization keys. Keep the design spec (`specs/2026-04-09-lunch-pause-design.md`) as historical reference.
- **Rationale:** Feature did not meet expectations. Clean removal avoids dead code and UI clutter.
- **Consequences:** Users who had enabled lunch pause will lose the setting silently (acceptable since feature was never released).

## ADR-005 — Rebrand as Tiny Tomato Bar for App Store release

- **Date:** 2026-04-14
- **Status:** Accepted
- **Context:** The fork has diverged enough from upstream TomatoBar to warrant its own identity. Publishing on the Mac App Store requires a distinct name and bundle ID.
- **Decision:** Rebrand to "Tiny Tomato Bar" with bundle ID `com.ploutonconsulting.veridian`. Keep internal project names as TomatoBar. Replace buddhabeats-licensed sounds with macOS system sounds (Purr, Glass). Remove ticking feature.
- **Rationale:** MIT license permits rebranding. System sounds avoid third-party audio licensing risk. Ticking was not essential to the Pomodoro workflow.
- **Consequences:** URL scheme changes from `tomatobar://` to `veridian://`. Log file path changes due to new container. Users of the upstream project are unaffected.

---

## Related Documents

- [[ARCHITECTURE]] — System design
- [[PROJECT]] — Project context and decisions log
