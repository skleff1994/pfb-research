# Stage 4: Longer-term research roadmap (2026-10-16, updated 2026-11-04)

**Added prior art:** Caron, Pham & Nakamura, ICRA 2015 (arXiv 1501.04719). Closed-form contact wrench cone for a rectangular support, from corner friction cones, with yaw-torque bounds that depend on the ZMP. This is the "possible" set of M0 for rectangles.
- Locomotion uses "possible" semantics, because the controller shapes the pressure distribution.
- Manipulation needs "guaranteed" semantics, because the object determines the distribution.

**Unifying question.** What does tactile sensing let a robot know for sure about its frictional contacts, and how should control use that set-valued knowledge?

| # | Project | Contribution | Builds on | Challenges | Effort / venue | Type |
|---|---|---|---|---|---|---|
| P1 | Certified shear–torsion capacity (current paper) | Guaranteed and possible sets, robust bounds, resolution law, two-pad extension, physical check | — | Conservatism; uncalibrated sensors | 2 months / RA-L | Reframing + extensions |
| P2 | Certified grip-force and torsion-aware grasp synthesis | Robust SOCP grip-force selection, updated online from tactile data | P1 | Pressure shape varies with squeeze; inner approximations | 4–6 months / RA-L or ICRA | Incremental |
| P3 | Slip events as measurements: set-membership capacity estimation and active probing | No-slip events add convex constraints on ν; observed slip adds supporting-hyperplane conditions; value-of-information probing | P1 | Noisy, dynamic events; direction ambiguity; probing actions | 6–12 months / T-RO or IJRR | Genuinely new |
| P4 | Tactile-conditioned robust contact constraints in MPC (pivoting, in-hand sliding) | Inner approximations of guaranteed sets as MPC constraints; possibly joint with Yann's patch NCP | P1–P3 | Sampled directions give outer (unsafe) approximations, so Lipschitz-corrected cuts are needed; real time; hybrid modes | 9–12 months / T-RO | New; fits MPC expertise |
| P5 | Optimal taxel layout for certification | Minimax partition design | P1 theory | Coupling with load statistics | 3–5 months / T-RO short or IEEE Sensors | Side theory |
| P6 | Guaranteed yaw capacity for legged feet | Guaranteed contact wrench cone from foot-pressure sensing | P1 | Hardware or simulation access | 4–6 months / Humanoids or RA-L | Domain transfer |
| P7 | Learned capacity with physics envelopes | Projection onto [lower, upper] | P1 | Mostly empirical | 3–4 months / CoRL or RA-L | Deprioritized |

## Theory items opened by Yann's review (2026-11-04)
These are side questions of P1, unless one grows into P5.
- **Algebra of measurement operators.** Yann sketched a space of operators with concatenation, a quotient by information equivalence, and the preorder of main.tex Def 3.14.
  - Only the preorder and its pointwise-span characterization are in P1.
  - Open: is the quotient useful, e.g. for optimal sensor design (P5) as a lattice of information?
  - Correction to keep: equivalence is pointwise, not almost everywhere.
- **Sharp rates.**
  - Thm 8.4 gives the first-order M_F gap.
  - Open: the M_T gap at high resolution, i.e. how much the CoP constraint removes; one-directional refinement; non-uniform grids (P5).
- **Membership tests for general operators.** Frank–Wolfe on the convex possible set, using a support oracle, for measurement operators without closed forms (moment–SOS relaxations of the GMP).
- **Robust extension (P1, C7).** In homogeneous coordinates, the fixed-q bounds stay convex under interval taxel forces. The load factor remains bilinear in (a, F_i).
- **P3 link.** In the fixed frame the possible set X⁺ is convex. An observed slip under a known load then cuts the compatible family by a supporting-hyperplane condition, which is P3's set-membership update.

## Recommended order
1. **P1, then P2, within about 6 months.**
2. **P3 as the scientific centerpiece.** Start its exploratory theory during P2.
3. **P4 as the T-RO-level synthesis**, likely joint with Yann.
4. **P5 and P6 are optional; P7 only with a learning collaborator.**

## Coordination
- **Yann.** M0 (his D(a)) is background in P1, and his review reshaped its formulation; P4 is the natural joint paper. Decide authorship of P1 early.
- **Hardware.** GelSight + F/T covers P1–P3. P4 needs a two-finger tactile gripper. P6 needs legged hardware or simulation.
- **Software.** The open-source `pfb` library from P1 (fixed frame since 2026-11-04; robust solvers to come; Drake pipeline) is reused in every later project.
