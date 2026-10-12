# Experiment 1.5: 4-Router Dynamic Routing (RIP) Step-by-Step Guide

## Objective
Configure dynamic routing across a redundant 4-router diamond topology using **Routing Information Protocol (RIPv2)** with automatic failover demonstration.

---

## Step 1: Place Hardware
In Packet Tracer:
1. **Routers**: Drag 4 **Router-PT** units into a diamond layout:
   - Left: `Router0`
   - Top: `Router1`
   - Bottom: `Router2`
   - Right: `Router3`
   *(Why Router-PT? It includes built-in FastEthernet0/0, Serial2/0, and Serial3/0 ports without needing manual module installs).*
2. **Switches**: Drag two **2960** switches (`Switch0` on the left, `Switch1` on the right).
3. **PCs**: Drag two **PCs** (`PC0` on the left, `PC1` on the right).

---

## Step 2: Cable Connections

### LAN Connections (Copper Straight-Through):
- `PC0` to `Switch0` (`Fa0/1`)
- `Switch0` (`Fa0/2`) to `Router0` (`Fa0/0`)
- `PC1` to `Switch1` (`Fa0/1`)
- `Switch1` (`Fa0/2`) to `Router3` (`Fa0/0`)

### WAN Serial Connections (Serial DCE - Red Cable with Clock Icon):
- `Router0` (`Serial 2/0`) $\longleftrightarrow$ `Router1` (`Serial 2/0`)
- `Router1` (`Serial 3/0`) $\longleftrightarrow$ `Router3` (`Serial 3/0`)
- `Router0` (`Serial 3/0`) $\longleftrightarrow$ `Router2` (`Serial 3/0`)
- `Router2` (`Serial 2/0`) $\longleftrightarrow$ `Router3` (`Serial 2/0`)

---

## Step 3: Configure PC IP Addresses
- **PC0**: IP `192.168.1.10` | Mask `255.255.255.0` | Gateway `192.168.1.1`
- **PC1**: IP `172.16.10.2` | Mask `255.255.0.0` | Gateway `172.16.10.1`

---

## Step 4: Paste Router Configurations (CLI Tab)

Open each router's CLI tab, type `no` if prompted, and paste the matching configuration block:

### Router 0 (Left):
```cisco
enable
conf t
interface fa0/0
 ip address 192.168.1.1 255.255.255.0
 no shut
 exit
interface serial 2/0
 ip address 10.0.0.1 255.0.0.0
 clock rate 64000
 no shut
 exit
interface serial 3/0
 ip address 20.0.0.1 255.0.0.0
 clock rate 64000
 no shut
 exit
router rip
 version 2
 network 10.0.0.0
 network 20.0.0.0
 network 192.168.1.0
 no auto-summary
end
write memory
```

### Router 1 (Top Transit):
```cisco
enable
conf t
interface serial 2/0
 ip address 10.0.0.2 255.0.0.0
 no shut
 exit
interface serial 3/0
 ip address 30.0.0.1 255.0.0.0
 clock rate 64000
 no shut
 exit
router rip
 version 2
 network 10.0.0.0
 network 30.0.0.0
 no auto-summary
end
write memory
```

### Router 2 (Bottom Transit):
```cisco
enable
conf t
interface serial 2/0
 ip address 40.0.0.1 255.0.0.0
 clock rate 64000
 no shut
 exit
interface serial 3/0
 ip address 20.0.0.2 255.0.0.0
 no shut
 exit
router rip
 version 2
 network 20.0.0.0
 network 40.0.0.0
 no auto-summary
end
write memory
```

### Router 3 (Right):
```cisco
enable
conf t
interface fa0/0
 ip address 172.16.10.1 255.255.0.0
 no shut
 exit
interface serial 2/0
 ip address 40.0.0.2 255.0.0.0
 no shut
 exit
interface serial 3/0
 ip address 30.0.0.2 255.0.0.0
 no shut
 exit
router rip
 version 2
 network 30.0.0.0
 network 40.0.0.0
 network 172.16.0.0
 no auto-summary
end
write memory
```

---

## Step 5: Verification & Impressive Demonstration

1. **Verify Learned Dynamic Routes**:
   On `Router0` CLI, run:
   ```cisco
   show ip route rip
   ```
   Show lines starting with **`R`**:
   `R 172.16.0.0/16 [120/2] via 10.0.0.2` and `via 20.0.0.2`.
   Explain: *"The Administrative Distance is 120 and metric (hop count) is 2. Both equal-cost paths are loaded."*

2. **Verify RIP Protocol**:
   ```cisco
   show ip protocols
   ```
   Points out: Update timer (every 30s), version 2, and advertised networks.

3. **End-to-End Ping**:
   On `PC0` Command Prompt:
   ```cmd
   ping 172.16.10.2
   ```
   Success rate will be 100%.

4. **Bonus Failover Demo (Guaranteed Full Marks)**:
   - Delete the top cable between Router0 and Router1.
   - Run `ping 172.16.10.2` again from PC0.
   - Packet Tracer will reroute traffic through the bottom path (Router2) without manual intervention!
