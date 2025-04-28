# ZeroTier LXC Gateway

This container runs ZeroTier and provides secure remote access to the internal LAN (`10.0.10.0/24`).

## Network Topology

- **Proxmox Host**: `10.0.10.10`
- **ZeroTier Gateway (LXC)**: `10.0.10.9`
- **ZeroTier Subnet**: `<zt_subnet>` (e.g., 192.168.x.x/24)

## Proxmox Container Config

Ensure `/etc/pve/lxc/<id>.conf` contains:

```ini
lxc.mount.entry = /dev/net/tun dev/net/tun none bind,create=file
lxc.cgroup2.devices.allow = c 10:200 rwm
lxc.hook.autodev = sh -C "modprobe tun; cd ${LXC_ROOTFS_MOUNT}/dev; mkdir net; mknod net/tun c 10 200; chmod 0666 net/tun"
lxc.apparmor.profile = unconfined
lxc.cap.drop =
```

## Inside the LXC

- Install ZeroTier: `curl -s https://install.zerotier.com | bash`
- Join your network: `zerotier-cli join <network_id>`
- Enable IP forwarding with sysctl

## IPTables Rules

```bash
*nat
:POSTROUTING ACCEPT [0:0]
-A POSTROUTING -o eth0 -s <zt_subnet> -j SNAT --to-source 10.0.10.9
COMMIT

*filter
:FORWARD DROP [0:0]
-A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i zt+ -s <zt_subnet> -d 10.0.10.0/24 -j ACCEPT
-A FORWARD -i eth0 -s 10.0.10.0/24 -d <zt_subnet> -j ACCEPT
COMMIT
```

## Systemd IP Assignment (Optional)

```ini
[Unit]
Description=Assign ZeroTier IP to zt interface
After=network-online.target zerotier-one.service
Wants=network-online.target zerotier-one.service

[Service]
Type=oneshot
ExecStartPre=/usr/bin/sleep 10
ExecStart=/usr/sbin/ip addr add <zt_gateway_ip>/24 dev zt+
ExecStartPost=/usr/sbin/ip link set dev zt+ up
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```
