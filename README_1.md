# CSC 223-L Computer Architecture Lab

Lab material for **CSC 223-L Computer Architecture Lab** (BS Computer Science, Fall 2026) at the Department of Computer Science, FEST, **Iqra University Islamabad**.

Students learn the instruction set architecture (ISA) of a **CISC** processor (Intel x86) and a **RISC** processor (MIPS) by writing assembly programs. They also simulate **cache memory** and **virtual memory address translation**.

| | |
|---|---|
| **Instructor** | Faiza Ali, Junior Lecturer |
| **Email** | faiza.ali@iqraisb.edu.pk |
| **Office** | A8 |
| **Credit hours** | 2+1 (one 3-hour lab per week) |
| **Prerequisite** | CSC 222 |
| **Software** | emu8086 (Labs 1–8), [QtSPIM](https://spimsimulator.sourceforge.net/) (Labs 9–13) |

---

## Repository structure

```
CA-Lab-CSC223L/
├── README.md
├── docs/
│   ├── Course_Card_CSC223L_Computer_Architecture_Lab.pdf
│   └── CA_Lab_Manual_CSC223L.pdf
├── x86/          # Part I  – emu8086 programs (Labs 1–8)
│   ├── p1_1.asm
│   └── ...
└── mips/         # Part II – QtSPIM programs (Labs 9–13)
    ├── p9_1.asm
    └── ...
```

Programs are named `p<lab>_<number>.asm`. For example, `p7_2.asm` is Program P7-2 in Lab Session 07 of the manual.

---

## Lab sessions

| Week | Lab | Topic | Software | Programs |
|:---:|:---:|---|:---:|---|
| 1 | 01 | Exploring Instruction Set Architecture (ISA) of x86 Machines | emu8086 | `p1_1` |
| 2 | 02 | Learning to program in Assembly Language of x86 Machines | emu8086 | `p2_1`, `p2_2` |
| 3 | 03 | Using MACROS for Input / Output and Data Conversion | emu8086 | `p3_1` – `p3_3` |
| 4 | 04 | x86 Data Transfer and Arithmetic Instructions | emu8086 | `p4_1`, `p4_2` |
| 5 | 05 | Implementing Branching in x86 Assembly Language | emu8086 | `p5_1` – `p5_3` |
| 6 | 06 | Implementation of Loop Structures in x86 Assembly Language | emu8086 | `p6_1` – `p6_3` |
| 7 | – | **Open-Ended Lab / Project assigned** | – | – |
| 8 | – | **Midterm Exam** | – | – |
| 9 | 07 | Array Processing in x86 Assembly Language | emu8086 | `p7_1`, `p7_2` |
| 10 | 08 | Development of Procedures and Macros in x86 Assembly Language | emu8086 | `p8_1`, `p8_2` |
| 11 | 09 | Familiarization with SPIM – a MIPS simulator | QtSPIM | `p9_1`, `p9_2` |
| 12 | 10 | SPIM console, system calls and procedures in MIPS | QtSPIM | `p10_1`, `p10_2` |
| 13 | 11 | Vector operations in MIPS and loop unrolling | QtSPIM | `p11_1`, `p11_2` |
| 14 | 12 | Simulating cache read/write (direct-mapped cache) | QtSPIM | `p12_1` |
| 15 | 13 | Address translation in a virtual memory system | QtSPIM | `p13_1` |
| 16 | – | **Open-Ended Lab / Project assessment** | – | – |
| 17 | – | **Final Exam** | – | – |

### Program index

<details>
<summary><b>Part I – x86 (emu8086)</b></summary>

| File | Description |
|---|---|
| `x86/p1_1.asm` | Observing registers, flags and byte ordering |
| `x86/p2_1.asm` | First program: add 158 to a number in memory |
| `x86/p2_2.asm` | Data definition directives and displaying a message |
| `x86/p3_1.asm` | I/O macros: read a lowercase letter, display it in uppercase |
| `x86/p3_2.asm` | Data conversion: ASCII digits → number → decimal display |
| `x86/p3_3.asm` | Buffered string input (INT 21h, AH = 0Ah) and hexadecimal display |
| `x86/p4_1.asm` | Data transfer: MOV, XCHG, LEA, PUSH/POP, XLAT |
| `x86/p4_2.asm` | Arithmetic: (A × B + C) / D with MUL and DIV |
| `x86/p5_1.asm` | Branching: even/odd and larger of two signed numbers |
| `x86/p5_2.asm` | Multi-way branching: grade from marks |
| `x86/p5_3.asm` | Signed vs unsigned comparison (JA vs JG) |
| `x86/p6_1.asm` | Counted loops with LOOP: print 1..9, sum 1..N |
| `x86/p6_2.asm` | Nested loops (star triangle) and a while loop (factorial) |
| `x86/p6_3.asm` | Sentinel-controlled loop: count vowels in a sentence |
| `x86/p7_1.asm` | Arrays: sum, average, maximum and minimum |
| `x86/p7_2.asm` | Linear search and bubble sort |
| `x86/p8_1.asm` | Procedures: register and stack parameters, recursion |
| `x86/p8_2.asm` | Macros with parameters vs procedures |

</details>

<details>
<summary><b>Part II – MIPS (QtSPIM)</b></summary>

| File | Description |
|---|---|
| `mips/p9_1.asm` | First MIPS program: arithmetic and logical instructions |
| `mips/p9_2.asm` | Load/store: z = x + y − 5 |
| `mips/p10_1.asm` | System calls: read integers and a string, print results |
| `mips/p10_2.asm` | Procedures: leaf procedure (max) and recursive factorial |
| `mips/p11_1.asm` | Vector addition and dot product |
| `mips/p11_2.asm` | Loop unrolling: rolled vs unrolled-by-4 array sum |
| `mips/p12_1.asm` | Direct-mapped cache simulator (hits, misses, hit ratio) |
| `mips/p13_1.asm` | Virtual-to-physical address translation with a page table |

</details>

---

## Getting started

### Part I – emu8086 (x86)

1. Install **emu8086** on Windows. It is already installed on the lab computers.
2. Open emu8086, click **new → empty workspace**, and paste or open a program from `x86/`.
3. Click **emulate** to assemble the program and load it into the emulator.
4. Click **single step** to run one instruction at a time and watch the registers, flags and memory. Click **run** to execute the whole program.

All x86 programs use the `.model small` format and DOS `INT 21h` services, which emu8086 emulates.

### Part II – QtSPIM (MIPS)

1. Download **QtSPIM** from <https://spimsimulator.sourceforge.net/> for Windows, Linux or macOS.
2. Make sure **Simulator → Settings → Load exception handler** is ticked, so that execution starts at `main`.
3. Choose **File → Reinitialize and Load File** and select a program from `mips/`.
4. Press **F5** to run, or **F10** to single-step. Output appears in the **Console** window.

> **Tip:** The command-line version of SPIM runs the same programs:
> ```bash
> sudo apt install spim          # Ubuntu / Debian
> spim -file mips/p9_2.asm
> ```

### Example output

```
$ spim -file mips/p12_1.asm
Address Index   Tag     Result
0       0       0       MISS
4       0       0       HIT
16      1       0       MISS
20      1       0       HIT
132     0       1       MISS
...
Hits = 4 out of 10
```

---

## Course Learning Outcomes

| CLO | Statement | BT Level | GA | Weight |
|:---:|---|:---:|:---:|:---:|
| CLO1 | **Apply** concepts of instruction set architecture and assembly language programming to develop solutions for x86 and MIPS systems. | P3 | GA2 | 65% |
| CLO2 | **Analyze** and implement system-level operations, such as procedures, macros, and memory management, using assembly language and simulators. | A3 | GA6 | 35% |

## Assessment

| Component | Weight |
|---|:---:|
| Lab Manual (lab tasks, graded on rubrics R1–R5) | 20% |
| Midterm Exam | 25% |
| Open-Ended Lab / Project | 15% |
| Final Exam | 40% |

**Open-Ended Lab:** *CISC vs RISC Comparative Mini-Project.* Groups of 2–3 students build the same Student Result Processing module in x86 (emu8086) and in MIPS (QtSPIM). They then compare code size, instruction counts and memory accesses, and analyse the sorting routine with the Lab 12 cache simulator.

---

## For students

- Read the theory and example programs of a lab **before** the session.
- Save your work as `LabXX_TaskY_RegNo.asm` and upload the programs and screenshots to the LMS before the deadline.
- Write clean, indented and **commented** code.
- **Academic integrity:** You may study these examples, but your lab tasks must be your own work. Copied programs, whether from classmates, the internet or AI tools, receive zero marks.

## Notes

- All example programs were tested before publication. MIPS programs were run on SPIM, which uses the same engine as QtSPIM. The x86 programs were checked with an 8086 emulator.
- Some register values depend on where the program is loaded, for example `DS` after `mov ax, @data` and the offsets of variables. These may differ on your computer.

## References

1. W. Stallings, *Computer Organization and Architecture: Designing for Performance*, 11th ed., Pearson, 2019.
2. M. Morris Mano, *Computer System Architecture*, 3rd ed., Pearson Education, 2017.
3. D. A. Patterson and J. L. Hennessy, *Computer Organization and Design: The Hardware/Software Interface (MIPS Edition)*, Morgan Kaufmann.
4. Y. Yu and C. Marut, *Assembly Language Programming and Organization of the IBM PC*, McGraw-Hill.
5. J. R. Larus, *SPIM: A MIPS32 Simulator* – <https://spimsimulator.sourceforge.net/>

---

© 2026 Faiza Ali, Department of Computer Science, Iqra University Islamabad. For educational use.
