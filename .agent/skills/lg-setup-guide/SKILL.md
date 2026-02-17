---
name: lg-setup-guide
description: OS-specific installation guides for all required development tools
---

# LG Setup Guide

Provides OS-specific installation commands for all tools needed by LG projects.

## Tool Installation Matrix

### Flutter SDK
| OS | Method 1 | Method 2 | Method 3 |
|----|----------|----------|----------|
| macOS | `brew install flutter` | Manual: download from flutter.dev | `git clone https://github.com/flutter/flutter.git` |
| Ubuntu | `sudo snap install flutter --classic` | Manual download | Git clone |
| Windows | `choco install flutter` | Manual download | Git clone |

### Android Studio + SDK
| OS | Method |
|----|--------|
| macOS | `brew install --cask android-studio` or download from developer.android.com |
| Ubuntu | `sudo snap install android-studio --classic` or manual download |
| Windows | `choco install androidstudio` or manual download |

### Git
| OS | Method |
|----|--------|
| macOS | `xcode-select --install` or `brew install git` |
| Ubuntu | `sudo apt install git` |
| Windows | `choco install git` or download from git-scm.com |

### Node.js (Optional)
| OS | Method |
|----|--------|
| macOS | `brew install node` or `nvm install --lts` |
| Ubuntu | `sudo apt install nodejs npm` or use nvm |
| Windows | `choco install nodejs` or download from nodejs.org |

### GitHub CLI
| OS | Method |
|----|--------|
| macOS | `brew install gh` |
| Ubuntu | `sudo apt install gh` |
| Windows | `choco install gh` |

## PATH Configuration
After installing Flutter manually:
```bash
# Add to ~/.zprofile (macOS) or ~/.bashrc (Ubuntu)
export PATH="$HOME/flutter/bin:$PATH"
```
