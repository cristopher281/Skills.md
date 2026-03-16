# Research Workflow Template

## Task Graph

| # | Task | Skill | Status | Dependencies | Output |
|---|------|-------|--------|--------------|--------|
| 1 | Deep Research | researching-topics / FALLBACK | ⬜ | None | Key findings |
| 2 | Source Scraping | scraping-sources / FALLBACK | ⬜ | 1 | References list |
| 3 | Summarize Findings | summarizing-content / FALLBACK | ⬜ | 1, 2 | Executive summary |
| 4 | Generate Report | generating-reports / FALLBACK | ⬜ | 3 | Full report |

## Parallel Opportunities

Tasks 1 and 2 can partially overlap — begin scraping known sources while research identifies new ones.

## Expected Deliverables

```
project-name/
├── research/
│   ├── raw-findings.md
│   ├── sources.md
│   └── data/
├── report/
│   ├── executive-summary.md
│   └── full-report.md
└── README.md
```
