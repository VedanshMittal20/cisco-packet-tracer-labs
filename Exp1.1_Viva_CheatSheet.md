# Experiment 1.1: Core Concepts & Viva Cheat Sheet

## 1. IP Addressing & Classes
An IP address is a 32-bit logical address written in dotted-decimal format (4 octets of 8 bits each).

| Class | 1st Octet Range | Default Subnet Mask | Network / Host Division | Typical Use |
| :--- | :--- | :--- | :--- | :--- |
| **A** | `1 - 126` | `255.0.0.0` (/8) | N.H.H.H | Very large networks |
| **B** | `128 - 191` | `255.255.0.0` (/16) | N.N.H.H | Medium-sized enterprise |
| **C** | `192 - 223` | `255.255.255.0` (/24) | N.N.N.H | Small LANs |
| **D** | `224 - 239` | None | Reserved | Multicasting |
| **E** | `240 - 255` | None | Reserved | Experimental / Research |

*Note*: `127.0.0.1` to `127.255.255.255` is strictly reserved for loopback testing.

---

## 2. Cables & RJ45 Pinouts
- **RJ45 Connector**: 8-pin modular connector used for unshielded twisted pair (UTP) Ethernet cabling.
- **T568A Standard**: White/Green, Green, White/Orange, Blue, White/Blue, Orange, White/Brown, Brown.
- **T568B Standard**: White/Orange, Orange, White/Green, Blue, White/Blue, Green, White/Brown, Brown.

### Which Cable to Choose:
- **Straight-Through Cable**: Uses same pinout on both sides (T568B to T568B). Connects **different (unlike) devices**:
  - PC to Switch
  - Switch to Router
  - Hub to PC
- **Cross-Over Cable**: Inverted transmit/receive pins (T568A on one end, T568B on the other). Connects **similar (like) devices**:
  - Router to Router
  - PC to PC
  - Switch to Switch
  - **PC to Router** (Both have active transmitters on the same pins)

---

## 3. Router Architecture & Components
- **RAM (Random Access Memory)**: Volatile memory storing `running-config`, active routing tables, and ARP cache. Lost on reboot.
- **NVRAM (Non-Volatile RAM)**: Permanent storage storing `startup-config`. Preserved across reboots.
- **Flash Memory**: Electronically erasable ROM that holds the **Cisco IOS Operating System image**.
- **ROM (Read-Only Memory)**: Contains bootstrap code, power-on self-test (POST), and ROMMON (mini operating system for recovery).

---

## 4. Cisco IOS Command Modes
1. **User EXEC Mode** (`Router>`): Basic inspection. Enter Privileged mode by typing `enable`.
2. **Privileged EXEC Mode** (`Router#`): Administrative tasks, debugging, viewing running configuration (`show run`). Enter Global Config by typing `configure terminal`.
3. **Global Configuration Mode** (`Router(config)#`): System-wide configurations (hostname, routing protocols).
4. **Interface Configuration Mode** (`Router(config-if)#`): Configuring specific ports (`interface fa0/0`, `interface se2/0`).
5. **Routing Configuration Mode** (`Router(config-router)#`): Configuring routing protocols (`router rip`).
