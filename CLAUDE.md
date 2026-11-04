# Private research repository (theory, experimental report, research strategy)

This repository lives at `<code>/paper/`, inside the working tree of the **shared code repository** `pfb`
(the enclosing directory `..`). The code repo ignores `paper/` through its local `.git/info/exclude`,
so nothing here is visible to collaborators of `pfb`.

## What lives where
- `paper/` (private): `doc/main.tex` (theory), `doc/experiments.tex` (experimental report), `doc/references.bib`,
  `doc/figures/` (vector figures), `research/` (literature review, contributions, validation and publication plan, notes).
- `..` (shared, `pfb`): the library `pfb/`, `examples/`, `sim/`, `hw/`, `tests/`, pixi environment.

## Rules
1. **Code first, documents second.** A theory change that needs code: commit the code in `..` (message in code
   terms only), run `make figures pdf` here, then commit here. The `prepare-commit-msg` hook (`.githooks/`, enabled
   with `git config core.hooksPath .githooks`) appends `Code-Commit: <sha>[-dirty]`; `-dirty` means the figures were
   built from uncommitted code.
2. **No private references in the shared repo.** Commit messages, docstrings and READMEs of `pfb` must not mention
   files or sections of this repository (`research/...`, `doc/...`, plan sections). Theorem numbers are fine
   ("the theory note"). Before pushing `pfb`, check `git log` and `git grep -n "research/\|doc/"`.
3. **Figures:** the code writes vector PDFs to `$PFB_DOC_FIG` (default `<code>/examples/figures/pdf`). `make figures`
   sets it to `paper/doc/figures`; when running a figure script by hand, set it yourself
   (`PFB_DOC_FIG=$PWD/paper/doc/figures pixi run resolution`), or the PDF lands in `examples/figures/pdf`.
4. Paths inside these documents are relative to this repository (`doc/...`, `research/...`); code paths are relative
   to the code repository root (`pfb/certify.py`, `sim/grip.py`); `pixi run ...` commands run from `..`.
5. `doc/Contact_patch-YannDeMM.pdf` (a collaborator's unpublished draft) is git-ignored: local only.
