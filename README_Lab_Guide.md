# Cisco Practical Exam Reference & Configuration Files

## Why Cisco `.pkt` Files Cannot Be Blindly Created
Cisco Packet Tracer uses a proprietary, encrypted binary file format (`.pkt`) secured by Twofish EAX encryption with cryptographic checksums. Manually generating `.pkt` files outside Packet Tracer corrupts them. 

Instead, professional network engineers configure Packet Tracer devices using **Cisco IOS `.cfg` scripts**. You simply copy the text from the files below and click **Paste** in the Packet Tracer Router CLI tab.

---

## File Directory Map
All files are saved in `C:\Users\vedan\.gemini\antigravity\scratch\cisco_lab_files\`:

1. `Exp1.2_RunNetworkCommands.bat` - Double-click to execute and display all Experiment 1.2 Windows network commands.
2. `Exp1.4_Router0.cfg` - Configuration for Router 0 (Static Routing).
3. `Exp1.4_Router1.cfg` - Configuration for Router 1 (Static Routing).
4. `Exp1.5_Router0_RIP.cfg` - Configuration for Router 0 (Dynamic RIP).
5. `Exp1.5_Router1_RIP.cfg` - Configuration for Router 1 (Dynamic RIP).
6. `Exp1.5_Router2_RIP.cfg` - Configuration for Router 2 (Dynamic RIP).
7. `Exp1.5_Router3_RIP.cfg` - Configuration for Router 3 (Dynamic RIP).

---

## How to Apply These `.cfg` Files in Cisco Packet Tracer
1. In Cisco Packet Tracer, click on the **Router**.
2. Click the **CLI** tab.
3. If it asks `Would you like to enter the initial configuration dialog? [yes/no]:`, type `no` and press Enter.
4. Open the corresponding `.cfg` file in Notepad, copy all text (`Ctrl+A`, `Ctrl+C`).
5. In the Packet Tracer CLI window, click the **Paste** button on the bottom right.
6. The entire configuration will apply automatically and save to NVRAM (`write memory`).

---

## IP Addressing Reference

### Experiment 1.4 (Static Routing)
- **PC0**: IP `10.0.0.2`, Subnet Mask `255.0.0.0`, Default Gateway `10.0.0.1`
- **PC1**: IP `20.0.0.2`, Subnet Mask `255.0.0.0`, Default Gateway `20.0.0.1`
- **Router0**: 
  - `Fa0/0`: `10.0.0.1 255.0.0.0`
  - `Fa1/0`: `192.168.1.1 255.255.255.0`
- **Router1**:
  - `Fa0/0`: `20.0.0.1 255.0.0.0`
  - `Fa1/0`: `192.168.1.2 255.255.255.0`
- **Verification**: On PC0 Command Prompt: `ping 20.0.0.2`

### Experiment 1.5 (Dynamic RIP Routing)
- **Use "Router-PT"** for all 4 routers (comes pre-equipped with FastEthernet and Serial ports).
- **PC0**: IP `192.168.1.10`, Mask `255.255.255.0`, Gateway `192.168.1.1`
- **PC1**: IP `172.16.10.2`, Mask `255.255.0.0`, Gateway `172.16.10.1`
- **Cabling**:
  - Router0 `Se2/0` <---> Router1 `Se2/0` (Serial DTE/DCE cable)
  - Router1 `Se3/0` <---> Router3 `Se3/0` (Serial DTE/DCE cable)
  - Router0 `Se3/0` <---> Router2 `Se3/0` (Serial DTE/DCE cable)
  - Router2 `Se2/0` <---> Router3 `Se2/0` (Serial DTE/DCE cable)
- **Verification**: On PC0 Command Prompt: `ping 172.16.10.2`
