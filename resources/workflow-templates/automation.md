# Automation Workflow Template

## Task Graph

| # | Task | Skill | Status | Dependencies | Output |
|---|------|-------|--------|--------------|--------|
| 1 | Process Analysis | analyzing-processes / FALLBACK | ⬜ | None | Current vs desired state |
| 2 | Workflow Design | designing-workflows / FALLBACK | ⬜ | 1 | Flow diagram |
| 3 | Automation Plan | planning-automation / FALLBACK | ⬜ | 2 | Implementation plan |
| 4 | Integration Build | integrating-tools / FALLBACK | ⬜ | 3 | n8n JSON or scripts |

## Integration Targets

| Platform | Output Format | Notes |
|----------|--------------|-------|
| n8n | JSON workflow | Import directly into n8n |
| Bash/PowerShell | Script files | OS-native automation |
| GitHub Actions | YAML workflow | CI/CD automation |
| Cron | Crontab entries | Scheduled tasks |

## Expected Deliverables

```
project-name/
├── analysis/
│   ├── current-state.md
│   └── desired-state.md
├── workflows/
│   ├── flow-diagram.md
│   └── n8n-workflow.json
├── scripts/
│   ├── automate.sh (or .ps1)
│   └── setup.sh
├── automation-plan.md
└── README.md
```
