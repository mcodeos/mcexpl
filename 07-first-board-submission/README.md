# 07 Your First Board

The last chapter is not another circuit. It is the three steps that turn a
circuit into something you can show, compare, and put your name on: get the
toolchain without building it, run your first board, and submit a candidate
to a leaderboard.

<!-- #region _071-first-board-submission -->
## 071 First Board Submission

### Step 1 — zero install

The desktop workbench (**MCode Bench**) ships the compiler, the standard
library, and three ready-made sample boards: an LED circuit, a blank start,
and a power tree. Nothing to clone, nothing to build.

The command line is the other door, and it is a different shape: it wants an
`mcc` binary and the libraries you use. The [toolchain page](/toolchain/) is
the map of which layer lives where.

### Step 2 — the first run

Open the power-tree sample. It is one 5 V source feeding two regulated rails,
3.3 V and 1.8 V, each with its own load.

Change one number — say, the 3.3 V rail's output voltage — and check the
board again. The working point moves with it: the rail contract, the load
current, and the reading all follow the value you changed. That is the whole
loop this product is built around: a design you can turn and watch.

The same loop on the command line:

```bash
mcc check 07-first-board-submission/071-first-board-submission.mc
```

`071-first-board-submission.mc` is the smallest board that carries a claim: a
5 V source, a divider that makes a measurement point, a bulk capacitor, and a
load. It is the shape every board in this tutorial has been building toward.

### Step 3 — the first board submission

A board that only you can see is a design. A board other people can submit
to is a leaderboard.

A leaderboard project is a git-hosted folder with five parts:

| Part | What it holds |
|---|---|
| `bench.mc` | The contract: the circuit, the claims, and the board's declarations |
| `ideal/` | The organizer's fixed context — the abstract slots everyone fills |
| `subs/` | The submissions: one file per candidate, and the file's name is the candidate's name |
| `results/` | The frozen evidence |
| `README.md` | The scoring rule in words, and how to submit |

Run the board and its submissions:

```bash
mcc matrix run . -L -o build/matrix.json
mcc matrix export --matrix build/matrix.json -L
```

The first command judges every submission against the board's claims; the
second writes the leaderboard page. The page carries one column per claim and
one row per submission, and it says where each reading came from — a missing
reading states its cause instead of pretending to be a number.

To submit, add one file under `subs/`. A submission declares which base draft
and which configuration cut it uses; it does not restate the board:

```mc
solution {
    baseline = "ldo-3v3"
    config = "default"
}
```

Then run the matrix again. Your file is a row. Opening a pull request with it
is the submission — the review and the merge are what put a row on the board.

Two honest notes, so nothing here reads as more than it is:

- A board's **applicability domain** is declared in the contract's block
  header. Until that declaration is writable there, the page prints readings
  and says the board's identity is not declared — it will not invent a
  ranking for a board it cannot identify.
- A reading needs a **part**. An abstract family is a shape, not a circuit:
  bind a concrete part to a slot in the selection layer (`bom.mc`) and the
  column carries a number.

<!-- #endregion _071-first-board-submission -->
