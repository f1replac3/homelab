# Observability Stack Docker Compose

This document contains the full Docker Compose configuration and context for the observability stack running in `observability-lxc` (10.0.10.5).

---

## Overview

The observability stack includes:
- **Prometheus** for metrics collection
- **Grafana** for dashboards and visualizations
- **node-exporter** for host metrics
- **cadvisor** for container metrics
- **glances** for system health and quick terminal UI
- **pihole-exporter** (external) for DNS analytics (targeted via `172.21.0.5`)
- [Planned] **Traefik** — a dynamic reverse proxy and SSL provider (see separate guide)


[Docker Compose File](docker/observe/docker-compose.yml)

Glances Web UI will be accessible at `http://<LXC_IP>:61208`

To customize Glances behavior, modify the configuration file:

**`./volumes/glances/glances.conf`** (create it if not present)

```ini
[global]
check_update = false
autoscale = True
theme = black

[webserver]
bind = 0.0.0.0
port = 61208

[processlist]
sort_key = cpu_percent
```

This example disables update checks, sets the UI theme to black, sorts by CPU usage, and ensures binding to all interfaces.

---

## Prometheus Configuration

Stored in: `./volumes/prometheus/prometheus.yml`

```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'pihole'
    static_configs:
      - targets: ['172.21.0.5:9617']

  - job_name: 'zerotier-gateway'
    static_configs:
      - targets: ['10.0.10.9:19999']

  - job_name: 'node-exporter'
    static_configs:
      - targets: ['localhost:9100']

  - job_name: 'cadvisor'
    static_configs:
      - targets: ['localhost:8080']

  - job_name: 'glances'
    static_configs:
      - targets: ['localhost:61208']
```

---

## Notes

- This stack runs inside `observability-lxc` at IP `10.0.10.5`
- You may choose to host **Traefik** here or in a separate LXC — either works, depending on your preference.
- Ports 3000 (Grafana), 9090 (Prometheus), etc., are exposed for LAN access.
- **pihole-exporter** is assumed to run on `pihole-lxc` and is scraped via static IP.
- Prometheus metrics and Grafana dashboards are stored persistently via bind mounts.
- System metrics are collected locally, and external targets are added via static_configs.
- Glances is configured with `GLANCES_OPT=-w` to enable the web UI.
- Glances can be customized via `glances.conf` if desired (see above).

---

## To Do

- Confirm dashboards and data sources in Grafana
- Add any additional exporters or services to be monitored
- Consider integrating Alertmanager if notifications are needed
- Evaluate Traefik integration for dashboard exposure via subdomains + HTTPS
- Review the docker networking document for deeper understanding of how this stack operates internally and across your LAN

