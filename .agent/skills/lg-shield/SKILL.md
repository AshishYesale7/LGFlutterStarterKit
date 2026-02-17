---
name: lg-shield
description: Security scanning and hardening for LG apps
---

# LG Shield

Security analysis and hardening for Liquid Galaxy Flutter apps.

## Security Checklist
1. **No hardcoded credentials** — use flutter_secure_storage
2. **SSH key management** — never log passwords
3. **Input validation** — sanitize all user inputs before SSH execution
4. **Dependency audit** — check for known vulnerabilities
5. **Network security** — validate SSL, handle timeouts

## Scan Protocol
1. Grep for hardcoded passwords/keys/tokens
2. Check that `Config.lgPassword` is only used via `SettingsProvider`
3. Verify SSH commands are parameterized (no string concatenation with user input)
4. Check `pubspec.yaml` dependencies for known CVEs
5. Review SFTP file uploads for path traversal

## SSH Command Safety
```dart
// BAD — shell injection risk
await ssh.execute("echo '$userInput' > /tmp/file");

// GOOD — parameterized
await ssh.execute("echo '${userInput.replaceAll("'", "\\'")}' > /tmp/file");
```

## Output
Security report written to `docs/reviews/shield-report.md`
