## ADS-B History Roadmap

### Purpose
Define a clear, staged plan for expanding ADS-B history and reporting. This is a living document that will be reviewed and updated in future sessions.

---

### Phase 1: Core History Foundation (Done)
- Persist ADS-B messages and snapshots to Postgres.
- Record session start/stop state with uptime.
- History dashboard with headless start/stop controls.
- Aircraft detail modal with photos (when available).
- Timeline charts for altitude, speed, heading, vertical rate, and squawk changes.

---

### Phase 2: Session Reporting & Exports (Next)
- Session list view with filters (date range, duration, device, remote host).
- Session summary report (counts, max range, peak message rate).
- Export options: JSON, CSV (snapshots + messages).
- Per-session bookmarks/notes.

---

### Phase 3: Flight Path Analytics
- Map-based playback from snapshots (time slider).
- Track corridor visualization (density by time-of-day).
- Range ring overlay with closest-approach metrics.
- Track segmentation for multi-pass flights.

---

### Phase 4: Alerting & Watchlists
- Watchlist for ICAO/callsign/registration.
- Alerts on first-seen, emergency squawks, or military tags.
- Email/webhook notifications (optional).
- Escalation rules by time window.

---

### Phase 5: Storage & Retention
- Retention policies (days/months, archive instead of delete).
- Optional hourly rollups for long-term stats.
- Health dashboard for DB size, inserts/sec, queue drops.
- USB drive migration guide and volume mount examples.

---

### Phase 6: Performance & UX Enhancements
- Pagination and server-side search for large data sets.
- Cached summary stats and query optimizations.
- History dashboard layout refinements for mobile.
- Background jobs for cleanup/rollup tasks.

---

### Open Questions
- SQLite fallback vs Postgres-only (if needed).
- Should we store raw SBS lines only or parsed fields only?
- How to model multi-station/remote receivers (multi-source support)?
