---
name: lg-ssh-controller
description: Guide SSH command implementation for LG rig communication
---

# LG SSH Controller

Guides implementation of SSH-based communication with the Liquid Galaxy rig.

## Core SSH Commands
| Command | Purpose | Target |
|---------|---------|--------|
| `echo "flytoview=..." > /tmp/query.txt` | Fly camera to location | Master |
| `echo "search=..." > /tmp/query.txt` | Search for place | Master |
| KML upload via SFTP | Display geographic data | Master |
| `echo "..." > /var/www/html/kmls.txt` | Load KML files | Master |
| Reboot/shutdown via sshpass | Machine management | All |

## Connection Parameters
- Host: `192.168.56.101` (default VM IP)
- Port: `22`
- User: `lg`
- Password: `lg`

## LG Rig Topology (3-screen default)
```
┌─────────┐  ┌─────────┐  ┌─────────┐
│  lg3    │  │  lg1    │  │  lg2    │
│  LEFT   │  │ MASTER  │  │  RIGHT  │
└─────────┘  └─────────┘  └─────────┘
```

## Slave Screen KML
Each slave has its own KML file: `/var/www/html/kml_slave_<n>.kml`

## Error Recovery
- Connection lost → auto-reconnect with exponential backoff
- Command timeout → retry once, then report error
- SFTP failure → fallback to echo command
