# Technical note: the M_F case, the unknown CoP and the reference frame (2026-10-22)

This note moves the M_F discussion out of the contributions document. It covers the 2026-10-16 clarification of Section 7 and the 2026-10-20 fixed-frame analysis. The paper does not need the note now, but it bears on a later decision about Section 7 of `doc/main.tex`.

## 1. The CoP-referenced problem (main.tex Section 7)
1. **Prop 7.1 [prop:MF_as_MT] is a nested problem.**
   - The outer problem optimizes over the unknown CoP c ∈ C_MF; the inner problems are M_T problems at each c.
   - The generalized moment problem (GMP) is nonlinear because the torsion is taken about the CoP, and the CoP depends on the measure.
2. **Thms 7.2 and 7.3 [thm:taxel_lower, thm:taxel_upper] both eliminate the outer variable exactly.**
   - The inner CoP constraint, Σ F_i c_i = f_N c (resp. Σ λ_ik v_ik = f_N c), fixes c as a function of the decision variables.
   - That c̄ is the CoP of the candidate measure, not a measurement or an estimate.
   - Both theorems are therefore single-level problems.
3. **The two theorems differ in convexity, not in the elimination.**
   - Thm 7.2: c̄ is affine and the weights F_i are fixed, so the problem is convex (an SOCP).
   - Thm 7.3: the weights λ_ik multiply norms that depend on λ through c̄(λ), so the problem is generally nonconvex.
4. **The outer search is a numerical strategy for Thm 7.3, not a mathematical requirement.**
   - Fixing c gives back the M_T LP.
   - Sweeping c over C_MF and keeping the best LP gives a value ≤ h̄_MF. That value is not certified.
   - This is what `pfb.reduced_MF` / `outer_search` returns.
5. **Fixing the CoP is not the same as fixing the reference.**
   - Imposing ∫(x − ĉ)dν = 0 gives one M_T LP. It is valid only if ĉ is the true CoP; otherwise it is just one slice.
   - Taking the torque about ĉ with no CoP constraint (Prop 7.4 [prop:fixed_ref]) gives cellwise bounds that hold for every compatible measure, after the correction μ|b| f_N δ(ĉ).
6. **Estimate quality.** δ(ĉ) is a supremum over all of C_MF.
   - A better ĉ does not shrink it by itself. It is smallest at the centre of C_MF.
   - If extra information confines the CoP to C ⊆ C_MF, take δ over C instead (Remark 7.5 [rem:cop_estimate]).
7. **Practical summary.**
   - Upper bound: sweep ≤ h̄_MF (Thm 7.3) ≤ Prop 7.4 upper bound. Prop 7.4 is the cheap certified option.
   - Lower bound: Thm 7.2 is a single convex SOCP and at least as tight, so no CoP estimate is needed.

**Numerical check** (`pfb`, unit patch, 6 Gaussian loads × 3 directions, 2026-10-16):

| Taxels | Prop 7.4 upper / Thm 7.3 sweep, median (max) | Prop 7.4 lower / Thm 7.2 lower, median |
|---|---|---|
| 2×2 | 1.61 (1.84) | 1.00 |
| 4×4 | 1.39 (1.69) | 1.00 |
| 8×8 | 1.21 (1.41) | 0.99 |

The certified upper bound is much looser at low resolution. That is the sandwich figure F7 in the validation plan (optional).

## 2. Fixed frame versus CoP-referenced torsion (2026-10-20)
- **Frame change.** Writing the twist about a fixed point o instead of the CoP shears the integrand:
  g(x; q, o) = g(x; (a + bJ(c − o), b), c) (Goyal et al. 1991 §12(3)).
  - With c known (M0, M_T), the two frames are equivalent: the shear is known.
  - Under M_F, c depends on the measure. A CoP-referenced direction q then corresponds to a different velocity field for each compatible measure, so the CoP-referenced sets are not envelopes of one motion.
- **Fixed-frame M_F bounds are elementary.** About a fixed o, the integrand no longer depends on the CoP, so the problem over the compatible measures decouples cell by cell:
  inf = μ Σ F_i min_{x∈P̄_i} g(x; q, o) and sup = μ Σ F_i max_{x∈P̄_i} g(x; q, o), both attained by one atom per cell (closure model).
  - The nonconvexity of Thm 7.3 belongs only to the CoP-referenced quantity.
  - The δ term of Prop 7.4 is the cost of moving the reference back to the CoP.
  - In Yann de Mont-Marin's draft the twist is about a fixed origin. The same structure appears there as the concavity of a ↦ s_{D(a)} (his Prop 4.4).
- **Why a controller wants the fixed frame.** A grasped object's load is known about a point fixed to the object or the hand, not about an unknown CoP. Alexander–Maddocks, Huang et al. and Yann's draft all use a fixed frame.
- **Cost of switching.** In the fixed frame, M_F is elementary (cell masses only), so the technical core of the taxel results becomes M_T and the load factor.

## 3. Current state of main.tex (build of 2026-10-22)
- Section 9 (certified load factor) uses the fixed reference throughout:
  - Definition 9.1 [def:wrench_fixed_ref];
  - Lemma 9.2 [lem:fixed_ref_lower];
  - under M_T, o = c recovers Section 6.
- Section 7 is still CoP-referenced (Thms 7.2 / 7.3, Prop 7.4, Remark 7.5).
- The remark that states the decoupling (`rem:reference_point`) is commented out.

## 4. Open decision (for the user)
- **Option 1:** make the fixed frame primary throughout. Section 7 then reduces to the elementary cellwise bounds, plus "torsion about the unknown CoP" as a secondary quantity (the one the torsional-capacity literature reports).
- **Option 2:** keep Section 7 as is and uncomment `rem:reference_point` to explain how it relates to Section 9.

Either option leaves the M_T results, the load factor and the simulation evidence unchanged. The simulations use the fixed reference o = 0 for every policy.
