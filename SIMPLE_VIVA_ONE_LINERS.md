# Ultra-Simple Viva One-Liners (Say Exactly This in the Exam)

---

### Hardware & Devices
1. **Hub**: A dumb device that blindly copies incoming data to every connected wire.
2. **Switch**: An intelligent device that sends data only to the target device using its MAC address.
3. **Router**: A device that connects different networks together using IP addresses.
4. **Repeater**: A device that amplifies a weak signal so it can travel longer distances.
5. **Bridge**: A 2-port switch used to connect two separate network segments together.
6. **Gateway**: A translator device that connects two completely different network architectures.

---

### Cables & Hardware
7. **Straight-Through Cable**: Connects two **different** devices (PC to Switch, Switch to Router).
8. **Cross-Over Cable**: Connects two **identical** devices (PC to PC, Router to Router, PC to Router).
9. **RJ45**: The standard plastic 8-pin plug clipped onto Ethernet cables.

---

### Addressing
10. **IP Address**: A logical 32-bit ID given to a computer so it can be found on a network.
11. **MAC Address**: A permanent 48-bit physical ID burned into the network card at the factory.
12. **Subnet Mask**: A filter that tells the computer which part of an IP is the network and which part is the host.
13. **Default Gateway**: The router's IP address that lets your computer reach the outside world.

---

### Commands & Tools
14. **Ping**: A tool that checks if another computer is alive by sending a test message and waiting for a reply.
15. **Traceroute (`tracert`)**: A tool that shows the step-by-step list of routers your data hops through.
16. **ARP**: The protocol that finds a device's physical MAC address when you only know its IP address.
17. **`netstat`**: A command that shows all active network connections and open ports on your computer.
18. **`nslookup`**: A command that asks the DNS server to turn a website name (like google.com) into an IP address.

---

### Routing Concepts
19. **Static Routing**: You manually type the exact path into the router.
20. **Dynamic Routing**: Routers talk to each other and automatically find the best path.
21. **Hop Count**: The number of routers a packet must jump across to reach its destination.
22. **RIP (Routing Information Protocol)**: A dynamic routing system that chooses the shortest path based on the fewest router hops (maximum 15 hops).
23. **Administrative Distance (AD)**: A trust score for routes—lower numbers are trusted more (Static = 1, RIP = 120).
24. **Default Route (`0.0.0.0 0.0.0.0`)**: A catch-all rule that tells the router: "If you don't know where to send a packet, send it here."

---

### Router Memory
25. **RAM**: Temporary memory; holds the current settings; clears when the router restarts.
26. **NVRAM**: Permanent memory; saves your configuration so it stays after a restart.
27. **Flash Memory**: The router's hard drive; stores the Cisco IOS operating system.
28. **ROM**: Permanent chip; contains the startup instructions to turn the router on.

---

### Domains
29. **Collision Domain**: A zone where data packets can collide if sent at the same time (Hub = 1, Switch = 1 per port).
30. **Broadcast Domain**: A zone where a shout message reaches everyone (Switches pass broadcasts; Routers stop them).
