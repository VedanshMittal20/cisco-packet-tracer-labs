# Experiment 1.4: 2-Router Static Routing Step-by-Step Guide

## Objective
Connect two separate LAN networks (`10.0.0.0/8` and `20.0.0.0/8`) via a point-to-point router link (`192.168.1.0/24`) using manual **Static Routes** (`ip route`).

---

## Step 1: Place Devices
From the bottom device tray:
1. **Routers**: Select **Network Devices** $\rightarrow$ **Routers** $\rightarrow$ Drag two **Router-PT** (or **2811**) units onto the canvas:
   - Rename Left Router: `Router0`
   - Rename Right Router: `Router1`
2. **End Devices**: Drag two **PCs**:
   - `PC0` near `Router0`
   - `PC1` near `Router1`

---

## Step 2: Cable Connections
From the **Connections** tab:
1. `PC0` to `Router0`:
   - Cable: **Copper Straight-Through**
   - Ports: `PC0 FastEthernet0` $\leftrightarrow$ `Router0 FastEthernet 0/0`
2. `Router0` to `Router1`:
   - Cable: **Copper Cross-Over** (dashed line)
   - Ports: `Router0 FastEthernet 1/0` $\leftrightarrow$ `Router1 FastEthernet 1/0`
3. `Router1` to `PC1`:
   - Cable: **Copper Straight-Through**
   - Ports: `Router1 FastEthernet 0/0` $\leftrightarrow$ `PC1 FastEthernet 0/0`

---

## Step 3: Configure PC IP Addresses
Click each PC $\rightarrow$ **Desktop** tab $\rightarrow$ **IP Configuration**:

| Device | IP Address | Subnet Mask | Default Gateway |
| :--- | :--- | :--- | :--- |
| **PC0** | `10.0.0.2` | `255.0.0.0` | `10.0.0.1` |
| **PC1** | `20.0.0.2` | `255.0.0.0` | `20.0.0.1` |

*(The Default Gateway is the IP address of the router port directly connected to that PC).*

---

## Step 4: Configure Router 0 (CLI)
1. Click `Router0` $\rightarrow$ Click **CLI** tab.
2. If prompted: `Continue with configuration dialog? [yes/no]:`, type `no` and press Enter.
3. Paste or type the following block:

```cisco
enable
configure terminal
interface fastEthernet 0/0
 ip address 10.0.0.1 255.0.0.0
 no shutdown
 exit
interface fastEthernet 1/0
 ip address 192.168.1.1 255.255.255.0
 no shutdown
 exit
! Forward all traffic for network 20.0.0.0 to Router1's interface (192.168.1.2)
ip route 20.0.0.0 255.0.0.0 192.168.1.2
end
write memory
```

---

## Step 5: Configure Router 1 (CLI)
1. Click `Router1` $\rightarrow$ Click **CLI** tab.
2. If prompted: `Continue with configuration dialog? [yes/no]:`, type `no` and press Enter.
3. Paste or type the following block:

```cisco
enable
configure terminal
interface fastEthernet 0/0
 ip address 20.0.0.1 255.0.0.0
 no shutdown
 exit
interface fastEthernet 1/0
 ip address 192.168.1.2 255.255.255.0
 no shutdown
 exit
! Forward all traffic for network 10.0.0.0 to Router0's interface (192.168.1.1)
ip route 10.0.0.0 255.0.0.0 192.168.1.1
end
write memory
```

---

## Step 6: Verify and Demonstrate to the Examiner
1. **Check Routing Table on Routers**:
   In `Router0` CLI, run:
   ```cisco
   show ip route
   ```
   Show the line with **`S 20.0.0.0/8 [1/0] via 192.168.1.2`**.
   Explain: *"The `S` code confirms our static route with an Administrative Distance of 1."*

2. **Run Ping from PC0**:
   Click `PC0` $\rightarrow$ **Desktop** $\rightarrow$ **Command Prompt** $\rightarrow$ Enter:
   ```cmd
   ping 20.0.0.2
   ```
   - First packet may show `Request timed out` (ARP delay).
   - Remaining packets will reply with `bytes=32 time<1ms TTL=126`.

3. **Show Path (Traceroute)**:
   On `PC0` Command Prompt:
   ```cmd
   tracert 20.0.0.2
   ```
   Output confirms hop 1 = `10.0.0.1` (Router0), hop 2 = `192.168.1.2` (Router1), hop 3 = `20.0.0.2` (Destination PC1).
