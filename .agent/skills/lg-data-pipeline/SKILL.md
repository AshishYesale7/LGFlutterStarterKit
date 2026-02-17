---
name: lg-data-pipeline
description: Build data processing pipelines for LG visualizations
---

# LG Data Pipeline

Builds data processing pipelines from raw data to KML visualization.

## Pipeline Architecture
```
        ┌─────────┐    ┌───────────┐    ┌─────────┐    ┌──────────┐
Data →  │  Fetch  │ →  │ Transform │ →  │ Generate │ →  │  Upload  │
Source  │  (API)  │    │  (Parse)  │    │  (KML)   │    │  (SFTP)  │
        └─────────┘    └───────────┘    └─────────┘    └──────────┘
```

## Transform Rules
1. Validate all coordinates before KML generation
2. Filter data by relevance (geographic bounds, time range, magnitude)
3. Aggregate when data points > 100 (cluster nearby points)
4. Color-code by metric (e.g., earthquake magnitude → color scale)

## Batch vs. Stream
- **Batch**: Fetch all data → process → upload once (good for static datasets)
- **Stream**: WebSocket feed → process each event → update KML (good for live data)

## Performance
- Limit KML file size to < 2MB for fast loading
- Use NetworkLinks for large datasets (server-side pagination)
- Refresh interval: 2-5 seconds for live data
