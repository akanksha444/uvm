# UVM Verbosity Guide

## 1. List of Verbosity Levels in `uvm_info`

UVM defines standard verbosity levels that control which messages get printed based on the configured verbosity threshold:

| Verbosity Level | Macro Constant | Numeric Value | Description                            |
| --------------- | -------------- | ------------- | -------------------------------------- |
| NONE            | `UVM_NONE`     | 0             | Always printed. Critical messages.     |
| LOW             | `UVM_LOW`      | 100           | General test progress or summary.      |
| MEDIUM          | `UVM_MEDIUM`   | 200           | Default level. Good balance of detail. |
| HIGH            | `UVM_HIGH`     | 300           | More detailed info for debugging.      |
| FULL            | `UVM_FULL`     | 400           | Detailed trace of component activity.  |
| DEBUG           | `UVM_DEBUG`    | 500           | Extremely detailed debug messages.     |

---

## 2. What is the Default Verbosity?

The default verbosity level in UVM is:

```systemverilog
UVM_MEDIUM (200)
```

This means only messages with verbosity `UVM_MEDIUM` or lower (`LOW`, `NONE`) will be printed unless the level is changed.

---

## 3. How Does the Filtering Mechanism Using Verbosity Work?

Each UVM component can be configured with a verbosity threshold. When a message is generated using:

```systemverilog
`uvm_info("TAG", "Message", VERBOSITY)
```

The message will only be printed if:

```text
VERBOSITY <= current verbosity level of the component
```

This allows selective filtering:

* You can suppress lower-priority messages during normal operation.
* Enable verbose messages only when debugging.

---

## 4. How to Change the Default Verbosity?

### A) In code:

To change verbosity for a specific component:

```systemverilog
my_env.set_report_verbosity_level(UVM_HIGH);
```

To change it for the whole hierarchy:

```systemverilog
uvm_top.set_report_verbosity_level_hier(UVM_HIGH);
```

### B) From command line:

```bash
+uvm_set_verbosity=uvm_test_top.env.agent, UVM_FULL
```

This lets you increase/decrease verbosity without modifying code.

---

## 5. Usecases of Various Verbosity Levels

| Verbosity    | Usecase Examples                                                     |
| ------------ | -------------------------------------------------------------------- |
| `UVM_NONE`   | Final results, test verdicts, always-important messages              |
| `UVM_LOW`    | Testcase start/end banners, key component status                     |
| `UVM_MEDIUM` | Common debug info, packet transmission logs, phase entry messages    |
| `UVM_HIGH`   | Sequence start/stop, detailed port activity, additional monitoring   |
| `UVM_FULL`   | Internal variable dumps, state machine transitions                   |
| `UVM_DEBUG`  | Every signal change, coverage sampling, deep component introspection |

Choose verbosity wisely to balance performance and debugging detail.
