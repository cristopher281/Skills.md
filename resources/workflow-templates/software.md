# Software Development Workflow Template

## Task Graph

| # | Task | Skill | Status | Dependencies | Output |
|---|------|-------|--------|--------------|--------|
| 1 | Requirements Analysis | analyzing-requirements / FALLBACK | ⬜ | None | PRD document |
| 2 | Project Architecture | designing-architecture / FALLBACK | ⬜ | 1 | System diagram |
| 3 | Database Schema | designing-databases / FALLBACK | ⬜ | 2 | ERD + SQL |
| 4 | Backend API | generating-backend / FALLBACK | ⬜ | 3 | API code |
| 5 | Frontend Structure | generating-frontend / FALLBACK | ⬜ | 2 | UI code |
| 6 | Docker Deployment | deploying-docker / FALLBACK | ⬜ | 4, 5 | Docker config |

## Parallel Opportunities

Tasks 4 and 5 can run in parallel after Task 3 is complete.

## Expected Deliverables

```
project-name/
├── docs/
│   ├── prd.md
│   ├── architecture.md
│   └── api-spec.md
├── database/
│   ├── schema.sql
│   └── seed.sql
├── backend/
│   ├── src/
│   ├── package.json
│   └── .env.example
├── frontend/
│   ├── src/
│   ├── package.json
│   └── .env.example
├── docker-compose.yml
├── Dockerfile
└── README.md
```
