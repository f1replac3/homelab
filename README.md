# Homelab Project

This repository tracks the design, build, and evolution of my personal network and infrastructure.

Focused on building secure, modular, and reproducible infrastructure — a real-world environment where I can practice systems engineering, infrastructure management, cybersecurity testing, and automation.\
A platform for developing technical depth, mastering tools I use daily, and exploring new technologies that push my understanding forward.

Some project goals:

- Host critical services securely and efficiently
- Build modular, isolated environments for security research and testing
- Automate deployments and enforce reproducibility through GitOps practices
- Integrate and manage technology independently, without relying on third-party cloud services
- Sharpen my skills through constant practice, exploration, and real-world implementation

To me, cybersecurity isn’t an isolated specialty — it’s the result of mastering systems, networks, and the small decisions that underpin the infrastructure.\
This is where I’m putting these ideas into practice.

---

## Repository Structure and Design

This repository is organized to reflect the principles of modularity, clarity, and maintainability that guide the infrastructure itself.\
Each directory represents a critical aspect of the environment — services are treated as independent blades, infrastructure as the forge that supports them, and documentation as a living map of the system.

```bash
homelab/
├── [docker/](docker/)          # Containerized service definitions (pihole, traefik, observability, etc.)
├── [docs/](docs/)              # Project documentation organized by domain (DNS, VPN, proxy, observability, infrastructure)
├── [infrastructure/](infrastructure/)  # Base infrastructure configuration (networking, hosts, hardware, legacy setups)
├── [scripts/](scripts/)        # Automation scripts and setup helpers
├── README.md                   # Project overview and philosophy
```

- **[docker/](docker/)**: Docker Compose definitions for containerized services, with modular separation by service type.
- **[docs/](docs/)**: Organized documentation for each functional domain, reflecting the evolving state of the lab.
- **[infrastructure/](infrastructure/)**: Core infrastructure configuration — including networking, hosts, hardware plans, and legacy notes.
- **[scripts/](scripts/)**: Practical automation to bootstrap and maintain systems reliably and reproducibly.
- **README.md**: This document — the high-level map of design, goals, philosophy, and structure.

The structure is built for clarity and flexibility: systems evolve, but the principles of organization endure.

---

## Future Development

I started on a ThinkPad X220. With 8GB of RAM and 4 cores, I'm lucky to be running an SSD at all — basically hardware from the stone age.\
One of the core achievements of this project has been extracting real-world infrastructure functionality from such limited resources, proving that design, modularity, and optimization matter more than raw hardware.

Reducing e-waste is always a plus.

Future development will be tied to expanding physical infrastructure.\
Plans include:

- Migrating and scaling core services to an old ThinkPad W530 to significantly increase available RAM, storage, and compute resources
- Retaining the ThinkPad X220 as a Kubernetes (k3s) worker node
- Establishing isolated cybersecurity testing environments enabled by the additional compute capacity
- Expanding the physical infrastructure over time to support more advanced Kubernetes orchestration, network segmentation, and dedicated firewalling with OPNsense

The design is intentionally modular and portable — infrastructure is managed in a way that can move across hardware generations, expand horizontally, and support new projects without requiring full rebuilds.\
The philosophy remains simple: build smart, stay flexible, and make each expansion an opportunity to sharpen the system rather than complicate it.

---

## Philosophy

*Sharpen what you have; forge what you need.*

Build carefully. Maintain relentlessly. Expand with precision.

