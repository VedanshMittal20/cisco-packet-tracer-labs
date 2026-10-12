# Experiment 1.2: Windows Network Commands Practical Guide

## Overview
Perform these commands in Windows Command Prompt (`cmd.exe`) or via [Exp1.2_RunNetworkCommands.bat](file:///C:/Users/vedan/.gemini/antigravity/scratch/cisco_lab_files/Exp1.2_RunNetworkCommands.bat).

---

## Step-by-Step Command Execution & Explanations

### 1. `hostname`
- **Command**: `hostname`
- **Purpose**: Displays the netBIOS host name of your local machine.
- **Examiner Explanation**: "This displays the identity of the current computer on the local network."

### 2. `ipconfig`
- **Basic**: `ipconfig`
- **Full**: `ipconfig /all`
- **Examiner Explanation**: 
  - `IPv4 Address`: Local logical address.
  - `Subnet Mask`: Identifies network vs host portion (`255.255.255.0`).
  - `Default Gateway`: IP address of the router providing access outside this subnet.
  - `Physical Address (MAC)`: 48-bit hardware address burned into the NIC.
  - `DHCP Enabled`: Indicates whether the IP was assigned automatically or statically.

### 3. `ping` (Packet Internet Groper)
- **Standard**: `ping 8.8.8.8`
- **Count Option**: `ping 8.8.8.8 -n 4`
- **Continuous**: `ping 8.8.8.8 -t` (Press `Ctrl + C` to stop)
- **Packet Size**: `ping 8.8.8.8 -l 64` (Sends 64-byte payload)
- **Examiner Explanation**: "Uses ICMP (Internet Control Message Protocol) Type 8 (Echo Request) and Type 0 (Echo Reply) to measure latency (RTT) and packet loss."

### 4. `tracert` (Trace Route)
- **Fast Mode**: `tracert -d 8.8.8.8` (`-d` prevents slow DNS hostname resolution)
- **Examiner Explanation**: "Identifies every intermediate router (hop) between source and destination by incrementally increasing the IP header's TTL (Time To Live) value starting from 1."

### 5. `netstat` (Network Statistics)
- **Command**: `netstat -ano`
- **Examiner Explanation**: 
  - `-a`: Shows all active listening and connected sockets.
  - `-n`: Displays IP addresses and port numbers numerically instead of resolving service names.
  - `-o`: Displays the PID (Process ID) owning each connection.
  - States: `LISTENING` (waiting for connection), `ESTABLISHED` (active session), `TIME_WAIT` (closing).

### 6. `arp` (Address Resolution Protocol)
- **Command**: `arp -a`
- **Examiner Explanation**: "Displays the ARP cache table, which maps Layer 3 IPv4 addresses to Layer 2 physical MAC addresses on the local link."

### 7. `nslookup` (Name Server Lookup)
- **Command**: `nslookup google.com`
- **Examiner Explanation**: "Queries the configured DNS server on UDP port 53 to resolve a Fully Qualified Domain Name (FQDN) into its associated IP addresses."

### 8. `route`
- **Command**: `route print`
- **Examiner Explanation**: "Displays the host's internal routing table, specifically showing default gateway `0.0.0.0` with netmask `0.0.0.0`."
