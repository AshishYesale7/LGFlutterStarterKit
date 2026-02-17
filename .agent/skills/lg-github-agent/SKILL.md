---
name: lg-github-agent
description: Manage GitHub repositories, releases, and CI/CD for LG projects
---

# LG GitHub Agent

Manages GitHub repository operations for Liquid Galaxy projects.

## New App Repository Creation

When a student creates a new app (in a separate directory from LGFlutterStarterKit), this skill handles the GitHub setup.

### Method 1: GitHub CLI (Recommended)
```bash
cd ../<new-app-name>
gh repo create <username>/<new-app-name> --public --source=. --remote=origin --push
```

### Method 2: Manual (if gh not installed)
1. Create repo on GitHub.com → New Repository
2. `git remote add origin https://github.com/<username>/<new-app-name>.git`
3. `git push -u origin main`

### Verify Remote
```bash
git remote -v
# Should show: origin https://github.com/<username>/<new-app-name>.git
```

### Two Repos, Two Purposes
| Repo | Purpose | Who Modifies |
|------|---------|-------------|
| `LGFlutterStarterKit` | Template/reference | Maintainers only |
| `<new-app-name>` | Student's actual project | Student |

## Repository Setup
- Initialize with `.gitignore` (Flutter template)
- Set up branch protection for `main`
- Configure CI/CD via GitHub Actions

## Commit Convention
```
<type>(<scope>): <description>

Types: feat, fix, refactor, docs, test, chore, build
```

## Release Process
1. Tag: `git tag -a v1.0.0 -m "Release v1.0.0"`
2. Build APK: `flutter build apk --release`
3. Create GitHub Release with APK artifact
4. Update README with release badge

## Repository Structure
```
<project>/
├── .github/workflows/    # CI/CD
├── flutter_client/       # Flutter app
├── server/              # Node.js server
├── docs/                # Documentation
├── README.md
└── DEVELOPMENT_LOG.md
```
