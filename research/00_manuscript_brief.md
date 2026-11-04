# Manuscript brief: "Torsional friction in planar contact" (doc/main.tex, Oct 2026)

Shared context for the Stage 1 literature review. This summary is extracted from the manuscript; it is not a claim of novelty.

## Setting
- Single rigid planar contact patch P ⊂ R², compact and convex.
- Normal load is a nonnegative Radon measure ν_N on P, so point and line loads are allowed. f_N = ν_N(P) > 0, CoP c = ∫x dν_N / f_N.
- Quasi-static isotropic Coulomb friction in measure form: dν_T = γ_T dν_N with ‖γ_T‖ ≤ μ.
- Object of interest: the admissible tangential wrench set W(ν_N) = {(f_T, τ_N)}, i.e. tangential force and torsion about the CoP.
  - This is the limit-surface-bounded set of Goyal–Ruina, written about the CoP.
  - Its support function is h(q) = μ ∫ ‖a + bJ(x − c)‖ dν_N(x), with q = (a, b) and J the 90° rotation.
  - Equivalently h(q) = μ|b| ∫ ‖x − p‖ dν_N, where p = c + Ja/b is the instantaneous center of rotation.

## Question
Given a partial measurement y of ν_N, bound h over all ν_N compatible with y:
- lower bound h̲(q; y) = inf over compatible measures (a guaranteed capacity, an inner wrench set);
- upper bound h̄(q; y) = sup over compatible measures (possible capacity, an outer set).

These are generalized moment problems. Because c depends on ν_N, they are nonlinear when the CoP is unknown.

## Measurement models
- **M0:** f_N and CoP (zeroth and first moments).
- **M_F:** taxel forces F_i, i.e. the masses of a partition {P_i} (rectangular cells in practice). The CoP is unknown.
  The compatible set lets a load on a shared edge count for either taxel (pieces supported on the closures).
- **M_T:** M0 combined with M_F (taxel masses plus global mean).

## Main results
1. **M0 lower bound** (Thm 4.3): h̲ = μ f_N ‖a‖, by Jensen, attained by f_N δ_c. Coarse data guarantee zero torsion.
2. **M0 upper bound** (Thm 4.5, Cor 4.6): the sup is attained by a measure with ≤ 3 atoms (Carathéodory / moment-set extreme points). For a polygonal P it is an LP over vertex weights with a fixed mean, i.e. an Edmundson–Madansky-type vertex bound.
   This coincides with Prop. 4.4 of Y. de Mont-Marin's unpublished draft "Contact patch" (support function of the patch friction model D(a)).
3. **Non-identifiability** (Cor 4.8): (f_N, c) determines W only if c is an extreme point of P.
4. **M_T lower bound** (Thm 6.1): a convex SOCP min over one point per taxel, Σ F_i ‖a + bJ(c_i − c)‖, s.t. c_i ∈ P̄_i and Σ F_i c_i = f_N c.
5. **M_T upper bound** (Thm 6.2): an LP over taxel corner weights with per-taxel masses and the global mean. At most r+2 nonzeros. Proof by LP duality: an affine roof per taxel.
6. **Cellwise bounds** (Prop 6.4): Σ F_i min/max over P_i of g, in closed form via distances to the ICR.
7. **Compatible CoP set under M_F** (Prop 5.6): the Minkowski sum Σ (F_i/f_N) P̄_i, with diameter ≤ max taxel diameter.
8. **M_F** (Prop 7.1, Thm 7.2, Thm 7.3): M_F equals M_T optimized over the unknown CoP.
   - Lower bound: a single joint convex SOCP.
   - Upper bound: a nonconvex max over c ∈ C_MF of M_T LPs.
   - Certified fixed-reference bounds (Prop 7.4).
   - Remark 7.5: the nonconvexity comes from measuring torque about the unknown CoP; about a fixed point the problem decouples.
9. **Comparison and refinement** (Props 8.1–8.3):
   - M0 ⊆ … information ordering.
   - Monotone tightening under partition refinement.
   - Gap ≤ μ|b| Σ F_i diam(P_i) (M_T), and 2× that (M_F); convergence as the taxel size goes to 0.

## Numerics (Python library `pfb`)
- Grid LPs as ground truth, compared with the reduced SOCP/LP.
- Refinement studies up to 32×32 taxels. The CoP-measurement gain of M_T over M_F grows with resolution, to about 30% in pure torsion.

## Assumptions to scrutinize
- Rigid planar patch, quasi-static Coulomb friction, uniform μ.
- No elastic or shear-traction coupling, no incipient-slip mechanics.
- Measurements exact and noise-free.
- Taxel = exact normal force per cell.
