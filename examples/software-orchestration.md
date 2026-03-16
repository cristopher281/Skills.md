# Example: Software Development Orchestration

This example shows a complete orchestration run for building a full-stack SaaS application.

---

## User Request

> "Build me a project management tool like a simplified Linear for small teams."

## Orchestration Log

- **Started:** 2026-03-08T15:00:00Z
- **Completed:** 2026-03-08T15:40:00Z
- **Duration:** 40 minutes
- **Workflow:** software
- **Tasks Total:** 6
- **Tasks Completed:** 6
- **Tasks Failed:** 0
- **Skills Used:** [FALLBACK x6]
- **Fallbacks Used:** 6

## Task Graph (Completed)

| # | Task | Skill | Status | Dependencies |
|---|------|-------|--------|--------------|
| 1 | Requirements Analysis | FALLBACK | ✅ Done | None |
| 2 | Project Architecture | FALLBACK | ✅ Done | 1 |
| 3 | Database Schema | FALLBACK | ✅ Done | 2 |
| 4 | Backend API | FALLBACK | ✅ Done | 3 |
| 5 | Frontend Structure | FALLBACK | ✅ Done | 2 |
| 6 | Docker Deployment | FALLBACK | ✅ Done | 4, 5 |

---

# 🎯 Project: FlowBoard

## 1. Project Overview

- **Objective:** Build a simplified project management tool for small teams (2-15 people)
- **Workflow:** Software Development
- **Core Features:** Issues, boards, sprints, team collaboration, real-time updates

## 2. Recommended Architecture

### Tech Stack
| Category | Technology | Reason |
|----------|-----------|--------|
| Frontend | Next.js 14 + TypeScript | SSR, app router, great DX |
| Backend | Next.js API Routes + tRPC | End-to-end type safety |
| Database | Supabase (PostgreSQL) | Realtime subscriptions, auth |
| Auth | Supabase Auth | Social login, magic links |
| Styling | Tailwind CSS | Rapid UI development |
| Realtime | Supabase Realtime | Live board updates |
| Deployment | Docker + Vercel | Production-ready |

### Database Schema (Key Tables)
```sql
-- Core entities
CREATE TABLE teams (id uuid PRIMARY KEY, name text, created_at timestamptz);
CREATE TABLE projects (id uuid PRIMARY KEY, team_id uuid REFERENCES teams, name text);
CREATE TABLE issues (
  id uuid PRIMARY KEY,
  project_id uuid REFERENCES projects,
  title text,
  description text,
  status text DEFAULT 'backlog',
  priority int DEFAULT 0,
  assignee_id uuid REFERENCES auth.users,
  created_at timestamptz DEFAULT now()
);
CREATE TABLE sprints (id uuid PRIMARY KEY, project_id uuid REFERENCES projects, name text, start_date date, end_date date);
```

## 3. Implementation Steps

1. **Phase 1:** Supabase project setup + auth + team management
2. **Phase 2:** Issue CRUD + board view (kanban drag & drop)
3. **Phase 3:** Sprint management + timeline view
4. **Phase 4:** Real-time collaboration + notifications
5. **Phase 5:** Docker containerization + deployment

## 4. Deliverables Generated

- `docs/prd.md` — Product requirements document
- `docs/architecture.md` — System architecture
- `database/schema.sql` — Full database schema
- `backend/` — API routes and business logic
- `frontend/` — Next.js app with components
- `docker-compose.yml` — Container orchestration

## 5. Next Actions

- [ ] Initialize Next.js project with TypeScript
- [ ] Set up Supabase project and apply migrations
- [ ] Implement auth flow (sign up, login, team invite)
- [ ] Build kanban board component
- [ ] Add real-time subscriptions for live updates
