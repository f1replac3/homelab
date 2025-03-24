# Pi-hole + Unbound Setup

This Fedora Server VM acts as a local DNS resolver and privacy filter.

## IP: `10.0.10.7`

- Pi-hole is the primary resolver for LAN devices
- Unbound provides upstream recursive DNS (localhost)
- Pi-hole uses `/etc/resolv.conf` pointing to `127.0.0.1` and optionally the router as fallback

---

## Installing Dependencies (Fedora)

```bash
sudo dnf install php-cli php-pdo php-intl php-process -y
```

---

## Pi-hole Updatelists

This repo uses [`pihole-updatelists`](https://github.com/jacklul/pihole-updatelists) for managing blocklists.

### Install it:

```bash
git clone https://github.com/jacklul/pihole-updatelists.git
cd pihole-updatelists
chmod +x install.sh
sudo ./install.sh
```

### Replace systemd units:

Move the defaults:
```bash
sudo mv /etc/systemd/system/pihole-updatelists.* /etc/systemd/system/*.bak
```

Copy your custom `.service` and `.timer` into `/etc/systemd/system/`, then:

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now pihole-updatelists.timer
```

---

## blocklists.txt

Create this in your Git repo:

```text
https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
https://mirror1.malwaredomains.com/files/justdomains
https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt
https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt
https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt
https://v.firebog.net/hosts/AdguardDNS.txt
https://v.firebog.net/hosts/Easylist.txt
```

Host it via GitHub or locally. Example:

```ini
BLOCKLISTS_URL="https://raw.githubusercontent.com/<you>/homelab/main/pihole-unbound/blocklists.txt"
```

---

## Verification

```bash
systemctl status pihole-updatelists.service
sqlite3 /etc/pihole/gravity.db "SELECT address FROM adlist;"
pihole -q doubleclick.net
```
