# Startup Creation Workflow Template

## Task Graph

| # | Task | Skill | Status | Dependencies | Output |
|---|------|-------|--------|--------------|--------|
| 1 | Generate Startup Idea | generating-ideas / FALLBACK | ⬜ | None | Idea brief |
| 2 | Market Analysis | researching-markets / FALLBACK | ⬜ | 1 | Competitor matrix |
| 3 | Branding & Identity | generating-branding / FALLBACK | ⬜ | 1 | Brand kit |
| 4 | Landing Page | building-landing-pages / FALLBACK | ⬜ | 2, 3 | HTML/CSS/JS |
| 5 | MVP Architecture | designing-architecture / FALLBACK | ⬜ | 2 | System design doc |

## Expected Deliverables

```
project-name/
├── docs/
│   ├── idea-brief.md
│   ├── market-analysis.md
│   ├── brand-guide.md
│   └── mvp-architecture.md
├── landing-page/
│   ├── index.html
│   ├── style.css
│   └── script.js
└── README.md
```
