# Homelab

This repository documents the architecture, configuration, and automation of my personal homelab.

---

## 🔍 Purpose

The homelab is a self-hosted environment for:

- Cybersecurity testing, research, and CTF practice
- Observability and monitoring of local services and systems
- Secure remote access via ZeroTier overlay networking
- DNS privacy and ad blocking via Pi-hole + Unbound
- Hosting personal media (e.g., Jellyfin)
- Managing torrent services and NAS integration
- Practicing GitOps with real-world tools like Terraform and Ansible
- Deploying containerized services in a lightweight Kubernetes (k3s) cluster

---

## 🖥 Current Topology

### LAN Subnet: `10.0.10.0/24`

| Device          | IP            | Role                                |
|------------------|---------------|--------------------------------------|
| Proxmox Host     | `10.0.10.10`  | Main hypervisor                      |
| Pi-hole VM       | `10.0.10.7`   | Fedora Server running Pi-hole + Unbound |
| ZeroTier LXC     | `10.0.10.9`   | LXC container acting as ZeroTier gateway |

### ZeroTier Subnet

- Internal overlay network for secure remote access
- Referred to in iptables/systemd configs as `<zt_subnet>` to mask public exposure

---

## 📁 Repository Structure

```bash
homelab/
├── README.md                  # This file
├── zerotier-lxc/              # LXC config, iptables rules, systemd for ZeroTier gateway
├── pihole-unbound/            # Fedora VM setup with Pi-hole + Unbound + automation
│   ├── blocklists.txt         # GitOps-managed Pi-hole blocklists
│   ├── systemd/               # pihole-updatelists.service + timer
└── proxmox/                   # Future: bootstrap configs, cloud-init, cluster setup
```

---

## 🚀 Roadmap

### Short-Term

- [x] Secure remote access via ZeroTier gateway
- [x] Full DNS stack with Unbound and Pi-hole
- [x] Automate blocklist updates with `pihole-updatelists`
- [ ] Document bootstrap scripts for fast provisioning
- [ ] Push everything to GitHub and apply GitOps patterns

### Medium-Term

- [ ] Learn and implement Terraform for VM and service provisioning
- [ ] Learn Ansible for configuration management
- [ ] Deploy observability stack (Netdata, Prometheus, Grafana, Loki)
- [ ] Set up Jellyfin, qBittorrent, and connect to NAS

### Long-Term

- [ ] Create a lightweight k3s Kubernetes cluster on Proxmox
- [ ] Migrate critical services (e.g., Pi-hole) into k3s
- [ ] Implement sealed secrets, cert-manager, Traefik, and secure ingress

---

## 🛠 Tooling and Practices

- Git for version control
- Systemd timers for automation
- iptables for routing and NAT
- ZeroTier for remote overlay networking
- Fedora Server for Pi-hole deployment
- Structured documentation in `.md` format
- GitOps: configuration and infra as code

---

## 🧠 Philosophy

Build a self-hosted lab that mirrors real-world infrastructure, using production-grade tools, with full control, transparency, and flexibility — with privacy and learning as first-class goals.
