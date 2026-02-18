# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| Latest (main branch) | ✅ |
| Older releases | ❌ |

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please report it responsibly. **Do not open a public GitHub issue.**

### How to Report

1. **Email**: Send a detailed report to **ashishyesale7@gmail.com**
2. **Subject line**: `[SECURITY] LGFlutterStarterKit — <brief description>`
3. **Include**:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

### Response Timeline

- **Acknowledgment**: Within 48 hours of receiving the report
- **Assessment**: Within 1 week
- **Fix & Disclosure**: Coordinated with the reporter

### What Qualifies

- Hardcoded credentials or API keys in source code
- SSH key or password exposure in logs or artifacts
- Dependency vulnerabilities with known CVEs
- Insecure data storage (passwords in SharedPreferences instead of flutter_secure_storage)
- Unvalidated input leading to command injection via SSH
- CI/CD workflow secrets leakage

### What Does NOT Qualify

- Issues in the Liquid Galaxy rig itself (report to [LiquidGalaxyLAB](https://github.com/LiquidGalaxyLAB))
- Default credentials in `config.dart` (these are documented template defaults, not production secrets)
- Issues requiring physical access to the LG rig

## Security Practices in This Project

### Automated Scanning

This project runs **security-scan.yml** on every push to `main`:

- **Secret scanning**: Grep-based detection of hardcoded passwords, API keys, and tokens
- **Dart dependency audit**: Checks `pubspec.lock` for known vulnerabilities
- **Node.js audit**: Runs `npm audit` on the companion server

### Secure Storage

- Passwords and API keys **must** use `flutter_secure_storage` (encrypted, OS-level keychain)
- Non-sensitive settings use `SharedPreferences`
- The agent's `lg-shield` skill enforces this automatically during development

### Build-Time Configuration

Connection credentials support `--dart-define` overrides so they never need to be committed:

```bash
flutter build apk \
  --dart-define=LG_HOST=192.168.56.101 \
  --dart-define=LG_PASSWORD=mypassword
```

### Agent Security Guardrails

The Antigravity agent system includes the `lg-shield` skill that:

1. Scans for hardcoded secrets before and after development
2. Validates `.gitignore` includes sensitive patterns
3. Checks that `flutter_secure_storage` is used for credentials
4. Blocks pipeline graduation if critical security issues are found

## Disclosure Policy

We follow coordinated disclosure. Once a fix is available, we will:

1. Release a patched version
2. Credit the reporter (unless they prefer anonymity)
3. Publish a brief advisory in the CHANGELOG

Thank you for helping keep this project and the Liquid Galaxy community safe.
