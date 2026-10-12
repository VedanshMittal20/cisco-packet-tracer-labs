# Computer Networks Practical Exam: Master Viva Voce Q&A Reference

---

## Section 1: OSI & TCP/IP Layer Fundamentals

### Q1: What are the 7 layers of the OSI model and their PDUs?
| Layer Number | Layer Name | Protocol Data Unit (PDU) | Primary Devices / Protocols |
| :--- | :--- | :--- | :--- |
| **7** | Application | Data | HTTP, HTTPS, FTP, DNS, DHCP, Telnet, SSH |
| **6** | Presentation | Data | SSL/TLS, JPEG, ASCII, Encryption/Compression |
| **5** | Session | Data | NetBIOS, RPC, Session Management |
| **4** | Transport | Segment (TCP) / Datagram (UDP) | TCP, UDP (Ports) |
| **3** | Network | Packet | IP, ICMP, ARP, Routers, Layer 3 Switches |
| **2** | Data Link | Frame | Ethernet, MAC Addresses, Switches, Bridges |
| **1** | Physical | Bit | Cables, RJ45, Hubs, Repeaters |

### Q2: What is the difference between TCP and UDP?
- **TCP (Transmission Control Protocol)**: Connection-oriented, reliable, guarantees packet delivery via 3-way handshake (`SYN`, `SYN-ACK`, `ACK`), handles retransmission and flow control. Slower.
- **UDP (User Datagram Protocol)**: Connectionless, unreliable (best-effort), no handshake, no retransmission, lower header overhead (8 bytes vs 20 bytes). Used for real-time traffic (DNS, VoIP, video streaming).

### Q3: What is the difference between a Collision Domain and a Broadcast Domain?
- **Collision Domain**: A network segment where packet collisions can occur if two devices transmit simultaneously.
  - *Hub*: 1 single collision domain for all ports.
  - *Switch*: Every single port is its own separate collision domain.
  - *Router*: Every port is a separate collision domain.
- **Broadcast Domain**: A network segment where a broadcast frame (`FF:FF:FF:FF:FF:FF`) sent by one device is received by all other devices.
  - *Hub*: 1 single broadcast domain.
  - *Switch*: 1 single broadcast domain across all ports (unless partitioned by VLANs).
  - *Router*: **Breaks broadcast domains**. Routers do NOT forward Layer 2 or Layer 3 broadcasts. Every router port is a separate broadcast domain.

---

## Section 2: Hardware, Cables & Cisco IOS (Experiment 1.1)

### Q4: What is the difference between a Hub, a Switch, and a Router?
- **Hub**: Layer 1 physical device. Multiport repeater. It lacks intelligence; any electrical signal received on one port is blindly repeated to all other ports. Operates in half-duplex.
- **Switch**: Layer 2 data link device. Forwards frames based on hardware MAC addresses. Inspects the source MAC of incoming frames to learn port mappings and sends unicast traffic directly to the destination port. Operates in full-duplex.
- **Router**: Layer 3 network device. Forwards packets between different logical subnets based on destination IP addresses using a routing table.

### Q5: What is the difference between a Straight-Through and a Cross-Over cable?
- **Straight-Through Cable**: Has identical pinouts on both ends (T568B $\leftrightarrow$ T568B). Connects **unlike devices**:
  - PC to Switch
  - Switch to Router
  - PC to Hub
- **Cross-Over Cable**: Has inverted transmit and receive pin pairs (T568A $\leftrightarrow$ T568B, swapping pins 1 with 3 and 2 with 6). Connects **like devices**:
  - PC to PC
  - Router to Router
  - Switch to Switch
  - **PC to Router** (both have active transmit circuitry on pins 1 and 2).

### Q6: What are the T568A and T568B color codes?
- **T568A**: White/Green, Green, White/Orange, Blue, White/Blue, Orange, White/Brown, Brown.
- **T568B**: White/Orange, Orange, White/Green, Blue, White/Blue, Green, White/Brown, Brown.

### Q7: What are the 4 memory components of a Cisco Router?
1. **RAM (Random Access Memory)**: Volatile. Holds the currently running configuration (`running-config`), routing tables, ARP cache, and packet buffers. Erased when powered off.
2. **NVRAM (Non-Volatile RAM)**: Permanent. Holds the saved startup configuration (`startup-config`). Preserved across reboots.
3. **Flash Memory**: Electronically erasable memory. Stores the Cisco IOS operating system image (`.bin` file).
4. **ROM (Read-Only Memory)**: Permanent chip. Contains bootstrap instructions to load the IOS, POST (Power-On Self Test), and ROMMON (mini recovery OS).

### Q8: What are the different command modes in Cisco IOS?
1. **User EXEC Mode** (`Router>`): View-only status commands. Command to enter next mode: `enable`.
2. **Privileged EXEC Mode** (`Router#`): Administrative inspection, debugging, copying files, rebooting. Command to enter next mode: `configure terminal`.
3. **Global Configuration Mode** (`Router(config)#`): System-wide configurations (hostname, routing protocols).
4. **Interface Configuration Mode** (`Router(config-if)#`): Port-specific setup (`ip address`, `no shutdown`, `clock rate`).

### Q9: What are IPv4 Classes and their default subnet masks?
| Class | First Octet Range | Default Subnet Mask | CIDR | Purpose |
| :--- | :--- | :--- | :--- | :--- |
| **Class A** | `1 - 126` | `255.0.0.0` | `/8` | Huge networks (16M hosts/net) |
| **Class B** | `128 - 191` | `255.255.0.0` | `/16` | Medium/Large enterprises (65K hosts/net) |
| **Class C** | `192 - 223` | `255.255.255.0` | `/24` | Small local LANs (254 hosts/net) |
| **Class D** | `224 - 239` | None | - | Multicasting |
| **Class E** | `240 - 255` | None | - | Research and experimental |

*Note*: `127.0.0.0/8` is reserved for host loopback diagnostics (`127.0.0.1`).

### Q10: What are Private IP addresses (RFC 1918)?
IP ranges reserved for internal networks that are not routable across the public Internet:
- Class A: `10.0.0.0` to `10.255.255.255` (`10.0.0.0/8`)
- Class B: `172.16.0.0` to `172.31.255.255` (`172.16.0.0/12`)
- Class C: `192.168.0.0` to `192.168.255.255` (`192.168.0.0/16`)

---

## Section 3: Windows Network Commands (Experiment 1.2)

### Q11: What protocol does `ping` use, and what message types?
`ping` uses **ICMP (Internet Control Message Protocol)** at Layer 3:
- Sender transmits **ICMP Type 8: Echo Request**.
- Target responds with **ICMP Type 0: Echo Reply**.
- Note: Ping does NOT use TCP or UDP port numbers.

### Q12: What does TTL (Time to Live) mean in ping and IP headers?
TTL is an 8-bit field (max value 255) that prevents packets from looping infinitely in a network. Every router that forwards the packet decrements the TTL by 1. When TTL reaches 0, the router discards the packet and sends an **ICMP Type 11 (Time Exceeded)** message back to the sender.

### Q13: How does `tracert` (traceroute) determine the path to a destination?
`tracert` sends packets with intentionally low TTL values:
1. Sends packet with `TTL = 1` $\rightarrow$ 1st router drops it, returns ICMP Time Exceeded. Traceroute records Hop 1.
2. Sends packet with `TTL = 2` $\rightarrow$ 2nd router drops it, returns ICMP Time Exceeded. Traceroute records Hop 2.
3. Continues incrementing TTL until the destination host is reached and replies with ICMP Echo Reply or Port Unreachable.

### Q14: What is the purpose of `arp -a` and what is ARP?
**ARP (Address Resolution Protocol)** resolves a known Layer 3 logical IP address into an unknown Layer 2 physical MAC address on a local network segment. `arp -a` displays the local machine's ARP cache mapping recent IP addresses to MAC addresses.

### Q15: What is the difference between `ipconfig` and `ipconfig /all`?
- `ipconfig`: Displays basic network information: IPv4 address, Subnet Mask, and Default Gateway.
- `ipconfig /all`: Displays full diagnostic configuration: Physical (MAC) Address, DHCP Server status, Lease times, DNS Servers, and NetBIOS settings.

### Q16: What information does `netstat -ano` provide?
- `-a`: Displays all active connections and listening ports.
- `-n`: Displays addresses and port numbers numerically (avoids DNS/service name resolution).
- `-o`: Displays the Process ID (PID) owning each socket.

---

## Section 4: Hub vs Switch Simulation (Experiment 1.3)

### Q17: Why does a Hub broadcast packets, and why is this insecure?
A Hub is purely an electrical Layer 1 device with no processor or memory to read Layer 2 frame headers. It cannot inspect the destination MAC address, so it simply regenerates electrical signals to all connected physical pins. This wastes network bandwidth and creates a security vulnerability because any host connected to the hub can run a packet sniffer (like Wireshark in promiscuous mode) to capture all conversation traffic.

### Q18: How does a Switch build its MAC address table (CAM Table)?
A Switch uses **Source MAC Learning**:
1. When a frame arrives on a port, the switch reads the **Source MAC address** in the frame header.
2. It binds that Source MAC address to the physical incoming port in its MAC address table along with a timestamp.
3. To forward the frame, it checks the **Destination MAC address**:
   - If found in the table, it sends it **only to that specific port** (Unicast).
   - If not found in the table (Unknown Unicast), it floods the frame to **all ports except the incoming port**.

### Q19: What command shows the MAC address table on a Cisco Switch?
```cisco
Switch# show mac address-table
```

---

## Section 5: Static Routing (Experiment 1.4)

### Q20: What is Static Routing?
Static routing is the manual configuration of network paths entered into a router's routing table by a network administrator. The router does not dynamically discover or advertise routes to neighbors.

### Q21: What is the syntax for a static route in Cisco IOS?
```cisco
Router(config)# ip route <destination-network-id> <subnet-mask> <next-hop-ip | exit-interface>
```
Example:
```cisco
Router(config)# ip route 20.0.0.0 255.0.0.0 192.168.1.2
```

### Q22: What is Administrative Distance (AD)?
Administrative Distance is a measure of the **trustworthiness** or priority of a routing source when multiple routes to the same destination exist. A lower value is more trusted.
- Directly Connected Interface: **0**
- Static Route: **1**
- EIGRP (Internal): **90**
- OSPF: **110**
- RIP: **120**
- External EIGRP: **170**

### Q23: What is a Default Route?
A default route (Gateway of Last Resort) matches all packets that have no specific route in the routing table.
```cisco
Router(config)# ip route 0.0.0.0 0.0.0.0 <next-hop-ip>
```

### Q24: What is a Floating Static Route?
A static route configured with an Administrative Distance higher than the primary dynamic routing protocol (e.g., AD = 130 vs RIP's 120). It remains dormant and only enters the active routing table if the primary dynamic route fails, providing automatic backup.

---

## Section 6: Dynamic Routing & RIP (Experiment 1.5)

### Q25: What is the difference between Distance Vector and Link State routing?
- **Distance Vector (e.g., RIP)**: Routers share their entire routing table only with immediate neighbors at regular periodic intervals ("routing by rumor"). Metric is typically hop count. Uses the Bellman-Ford algorithm.
- **Link State (e.g., OSPF)**: Routers flood link state advertisements (LSAs) containing the status of their own links to the entire network area. Every router builds an identical topological map of the entire network and calculates the shortest path using Dijkstra's algorithm.

### Q26: What are the key characteristics of RIP (Routing Information Protocol)?
1. **Algorithm**: Bellman-Ford Distance Vector.
2. **Metric**: Hop count (number of routers a packet must traverse).
3. **Maximum Metric**: **15 hops**. A hop count of **16** is considered unreachable / infinite metric.
4. **Administrative Distance**: **120**.
5. **Periodic Update Timer**: Sends complete routing updates every **30 seconds**.
6. **Transport Protocol & Port**: Runs over **UDP port 520**.

### Q27: What is the difference between RIPv1 and RIPv2?
| Feature | RIP Version 1 (RIPv1) | RIP Version 2 (RIPv2) |
| :--- | :--- | :--- |
| **Addressing** | Classful (No subnet mask sent in updates) | Classless (Includes subnet mask) |
| **VLSM / CIDR** | Not supported | Fully supported |
| **Update Method** | Broadcast to `255.255.255.255` | Multicast to `224.0.0.9` |
| **Authentication** | None | MD5 and Plain Text password authentication |
| **RFC** | RFC 1058 | RFC 2453 |

### Q28: What is the Count-to-Infinity problem and how does RIP prevent loops?
When a link goes down, Distance Vector routers can bounce obsolete routing information back and forth, slowly incrementing the hop count until it reaches infinity (16).
**Prevention mechanisms**:
1. **Split Horizon**: A router will never advertise a route back out the same interface through which it learned it.
2. **Route Poisoning**: When a link fails, the router immediately advertises the route with a metric of 16 (unreachable).
3. **Poison Reverse**: An explicit acknowledgement that overrides split horizon by advertising the poisoned metric back to the sender.
4. **Holddown Timers**: When a route is reported unreachable, the router ignores any updates with equal or worse metric for a period (default 180 seconds) to allow the network to stabilize.

### Q29: Why is `clock rate` configured on Serial interfaces in Packet Tracer?
In a serial WAN link, one router must act as the **DCE (Data Communications Equipment)** to provide clocking pulses that synchronize data transmission across the serial line, while the other end acts as **DTE (Data Terminal Equipment)**. In a lab simulation, you must set `clock rate 64000` on the interface connected to the DCE end of the cable (marked with a clock symbol in Packet Tracer).

### Q30: What is the command to verify RIP routes and RIP configuration on a router?
```cisco
Router# show ip route rip       ! Displays only routes learned via RIP (prefixed with 'R')
Router# show ip protocols       ! Displays active timers, protocol version, and advertised networks
```
