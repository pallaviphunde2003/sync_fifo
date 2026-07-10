# UVM-Based Synchronous FIFO Verification Environment

**Overview**

This project implements a parameterized **Synchronous FIFO** in SystemVerilog along with a universal Verification Methodology (UVM) based verification environment. The objective is to verify the FIFO functionality under various operating conditions using a reusable, scalable, and modular UVM testbench.


**Features**

- Parameterized Synchronous FIFO RTL
- Configurable FIFO Depth and Data Width
- UVM-Based Verification Environment
- Constrained Random Stimulus Generation
- Queue-Based Scoreboard
- Transaction-Level Modeling (TLM)
- Functional Verification of FIFO Operations
- Modular and Reusable Verification Components

---

**FIFO Features**

- Single Clock (Synchronous FIFO)
- Parameterized FIFO Depth
- Parameterized Data Width
- Write and Read Pointer Management
- Full and Empty Flag Generation
- Registered Read Output
- One Clock Read Latency
- Power-of-Two FIFO Depth Support

---

**UVM Verification Architecture**

The verification environment consists of the following components:

- Sequence Item
- Sequencer
- Driver
- Monitor
- Agent
- Scoreboard
- Environment
- Base Test
- Derived Test Cases

The monitor captures DUT transactions and forwards them to the scoreboard through UVM analysis ports. The scoreboard maintains a queue-based reference model and compares expected data with DUT output to verify functional correctness.

---

**Test Cases**

The following verification scenarios are implemented:

| Test | Description |
|------|-------------|
| FIFO Write Test | Verifies write-only operations |
| FIFO Read Test | Verifies read-only operations |
| FIFO Write Then Read Test | Performs all writes followed by reads |
| FIFO Write Read Test | Alternating write and read transactions |
| Parallel Write & Read Test | Simultaneous write and read operations |
| Reset Verification | Verifies reset behavior |
| Full & Empty Verification | Verifies FIFO status flags |
| Data Integrity Verification | Ensures FIFO ordering and correctness |

---

**Project Structure**

```
sync_fifo/
│
├── rtl/                    # RTL Design
├── interface.sv
├── sequence_item.sv
├── sequencer.sv
├── driver.sv
├── monitor.sv
├── agent.sv
├── scoreboard.sv
├── environment.sv
├── test.sv
├── wr_test.sv
├── rd_test.sv
├── wr_rd_test.sv
├── wr_then_rd_test.sv
├── fifo_params.svh
├── tb_top.sv
└── README.md
```

---

**Verification Flow**

1. Generate FIFO transactions using UVM sequences.
2. Driver applies transactions to the DUT.
3. Monitor samples DUT interface activity.
4. Transactions are forwarded to the scoreboard.
5. Scoreboard compares DUT output with the reference queue.
6. Simulation reports PASS/FAIL status.

---

**Parameterization**

The FIFO is fully parameterized.

| Parameter | Description |
|----------|-------------|
| FIFO_DEPTH | Number of FIFO entries |
| DATA_WIDTH | Width of each FIFO data word |

Changing these parameters automatically updates the RTL and verification environment.

---

**Tools Used**

- SystemVerilog
- Universal Verification Methodology (UVM)
- Synopsys VCS
- GTKWave

---


