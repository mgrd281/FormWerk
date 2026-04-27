# FlowForge

Workflow-Automatisierung der nächsten Generation. **Phase 1: Foundation.**

## Stack

- Next.js 15 (App Router) · TypeScript strict · Tailwind v4
- next-intl (DE / AR / UK) · RTL für Arabisch
- next-themes (Dark default · Light optional)
- Auth.js v5 — Magic Link (Resend) + Google OAuth
- Drizzle ORM + Vercel Postgres

## Erste Schritte

```bash
pnpm install
cp .env.example .env.local
# Fülle .env.local aus (siehe unten)
pnpm db:push       # erstellt Tabellen in Postgres
pnpm dev
```

Öffne [http://localhost:3000/de](http://localhost:3000/de).

## Environment Variables

| Variable                               | Pflicht | Quelle                                                  |
| -------------------------------------- | ------- | ------------------------------------------------------- |
| `POSTGRES_URL`                         | ✅      | Vercel → Storage → Postgres → `.env.local`              |
| `AUTH_SECRET`                          | ✅      | `openssl rand -hex 32`                                  |
| `RESEND_API_KEY` + `EMAIL_FROM`        | ✅\*    | resend.com — Domain muss verifiziert sein               |
| `AUTH_GOOGLE_ID` + `AUTH_GOOGLE_SECRET`| ⬜      | Google Cloud Console → APIs & Services → Credentials    |
| `ENCRYPTION_KEY`                       | Phase 5 | `openssl rand -hex 32`                                  |
| `QSTASH_*`                             | Phase 5 | upstash.com                                             |

\* Magic-Link benötigt Resend; Google ist optional.

## Locales

| Locale | URL Prefix | Direction |
| ------ | ---------- | --------- |
| `de`   | `/de`      | LTR       |
| `ar`   | `/ar`      | RTL       |
| `uk`   | `/uk`      | LTR       |

## Skripte

| Befehl              | Zweck                                  |
| ------------------- | -------------------------------------- |
| `pnpm dev`          | Dev-Server (Turbopack)                 |
| `pnpm build`        | Production Build                       |
| `pnpm typecheck`    | `tsc --noEmit`                         |
| `pnpm lint`         | ESLint (flat config)                   |
| `pnpm format`       | Prettier                               |
| `pnpm db:push`      | Drizzle Schema → Postgres              |
| `pnpm db:studio`    | Drizzle Studio (DB-GUI)                |

## Verifizierung (Phase 1)

- ✅ `pnpm typecheck` → 0 Fehler
- ✅ `pnpm lint` → 0 Fehler
- ✅ `pnpm build` → erfolgreich
- ⏳ `/de/login`, `/ar/login`, `/uk/login` öffnen — RTL für `ar`
- ⏳ Theme-Toggle persistiert
- ⏳ Sprach-Switcher wechselt URL-Präfix
- ⏳ Magic-Link-Versand benötigt Resend-Konfiguration

## Roadmap

- [x] **Phase 1** — Foundation (auth, i18n, dashboard shell)
- [ ] **Phase 2** — Workflows CRUD
- [ ] **Phase 3** — Visuelle Editor + Nodes
- [ ] **Phase 4** — Execution Engine
- [ ] **Phase 5** — Production Polish (Landing, Pricing, Cmd-K)
