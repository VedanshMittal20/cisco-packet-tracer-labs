# Experiment 1.3: Hub vs. Switch Simulation Guide

## Objective
Demonstrate that a **Hub** works at Layer 1 (broadcasting data to every connected port), whereas a **Switch** works at Layer 2 (learning MAC addresses and forwarding unicast packets only to the target device).

---

## Step 1: Build the Topology in Cisco Packet Tracer

### Setup A: The Hub Network (Broadcast Domain Test)
1. In the bottom-left device library:
   - Click **Network Devices** (top icon) $\rightarrow$ **Hubs** (second row) $\rightarrow$ Select **PT-Hub**. Place it in the center.
   - Click **End Devices** $\rightarrow$ Drag 4 **PCs** (`PC0`, `PC1`, `PC2`, `PC3`) in a star shape around the Hub.
2. Select **Connections** (lightning bolt):
   - Choose **Copper Straight-Through** (solid black line).
   - Click `PC0` $\rightarrow$ `FastEthernet0` $\rightarrow$ Click `Hub0` $\rightarrow$ `Port 0`.
   - Click `PC1` $\rightarrow$ `FastEthernet0` $\rightarrow$ Click `Hub0` $\rightarrow$ `Port 1`.
   - Click `PC2` $\rightarrow$ `FastEthernet0` $\rightarrow$ Click `Hub0` $\rightarrow$ `Port 2`.
   - Click `PC3` $\rightarrow$ `FastEthernet0` $\rightarrow$ Click `Hub0` $\rightarrow$ `Port 3`.

---

## Step 2: Configure IP Addresses
Click each PC $\rightarrow$ Open **Desktop** tab $\rightarrow$ Click **IP Configuration** $\rightarrow$ Select **Static**:

| PC Name | IP Address | Subnet Mask | Default Gateway |
| :--- | :--- | :--- | :--- |
| **PC0** | `192.168.1.1` | `255.255.255.0` | *(Leave blank)* |
| **PC1** | `192.168.1.2` | `255.255.255.0` | *(Leave blank)* |
| **PC2** | `192.168.1.3` | `255.255.255.0` | *(Leave blank)* |
| **PC3** | `192.168.1.4` | `255.255.255.0` | *(Leave blank)* |

---

## Step 3: Run the Simulation & Observe Hub Behavior
1. In the bottom-right corner, click the **Simulation** stopwatch tab (or press `Shift + S`).
2. In the Simulation panel, click **Show All / None** (to uncheck all filters), then click **Edit Filters** $\rightarrow$ Check **ICMP** only.
3. Click the **Add Simple PDU** envelope icon on the right toolbar (or press `P`).
4. Click `PC0` (source), then click `PC1` (destination).
5. Click the **Play / Auto Capture** button:
   - The packet travels from `PC0` to `Hub0`.
   - **Observation**: `Hub0` copies and sends the packet to `PC1`, `PC2`, and `PC3` simultaneously.
   - `PC2` and `PC3` inspect the packet, see it is not addressed to their MAC, and discard it (marked with a red **X**).
   - `PC1` accepts it (marked with a green checkmark) and replies.

---

## Step 4: Replace Hub with a Switch (Unicast Test)
1. Delete `Hub0` (press `Delete` key and click on the Hub).
2. Go to **Network Devices** $\rightarrow$ **Switches** $\rightarrow$ Drag a **2960 Switch** to the center.
3. Reconnect the 4 PCs to the switch ports (`Fa0/1` through `Fa0/4`) with **Copper Straight-Through** cables.
4. Fast forward time 30 seconds (click the fast-forward button `>>` on the bottom toolbar until all link lights turn green).
5. Ping `PC1` from `PC0` once in Realtime mode so the switch populates its MAC table.
6. Switch back to **Simulation Mode** and send another Simple PDU from `PC0` to `PC1`:
   - **Observation**: The Switch forwards the packet **only to PC1**. `PC2` and `PC3` receive nothing.

---

## Step 5: How to Show the MAC Table to the Examiner
Click on the **Switch** $\rightarrow$ Open **CLI** tab $\rightarrow$ Press Enter:
```cisco
enable
show mac address-table
```
Point to the screen and explain: *"The switch learned which MAC address is attached to which FastEthernet port, allowing direct Layer 2 unicast forwarding."*
