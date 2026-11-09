# Manuscript brief: "Torsional friction in planar contact" (doc/main.tex, rewritten 2026-11-04)

Shared context for literature and review work. This summary is extracted from the manuscript; it is not a claim of
novelty. The October version took torques about the CoP of each measure; after Yann's review they are taken about a
fixed point (`note_fixed_frame.md`).

## Setting
- A single rigid planar contact patch P ⊂ R² (compact; convex where stated), in a fixed frame (O, B).
- The normal load is a nonnegative Radon measure ν_N on P, so point and line loads are allowed. Homogeneous coordinates: f_N = ν_N(P) ≥ 0 and m_1 = ∫x dν_N; the CoP is c = m_1/f_N when f_N > 0.
- Quasi-static isotropic Coulomb friction in measure form: dν_T = γ_T dν_N with ‖γ_T‖ ≤ μ.
- Object of interest: the admissible tangential wrench set X(ν_N) = {(f_T, τ)}, the tangential force and the torsional moment **about the origin**.
  - Its support function is h(q) = μ ∫ ‖a + bJx‖ dν_N(x): the maximal power friction can dissipate under the planar twist q = (a, b) about O. Equivalently h(q) = μ|b| ∫ ‖x − p‖ dν_N, where p = Ja/b is the instantaneous center of rotation.
  - Varignon's formula moves the reference point. The CoP-referenced set W(ν) = X_{c[ν]}(ν) is recovered whenever the CoP is measured.
  - h is linear in ν_N, so X(ν_1 + ν_2) = X(ν_1) ⊕ X(ν_2).

## Question
Given a measurement y = M(ν_N) (linear integral measurements), bound h over all ν_N compatible with y:
- lower bound h̲(q; y, M) = inf over compatible measures; the guaranteed set X⁻ = ∩ X(ν);
- upper bound h̄(q; y, M) = sup over compatible measures; the possible set X⁺ = ∪ X(ν), which is convex with support h̄.

All of these are generalized moment problems. Measurement operators are compared by an information preorder (M ≽ M′ iff M′ is a linear function of M, pointwise), under which the bounds are monotone.

## Measurement models
- **M0:** f_N and m_1 (zeroth and first moments).
- **M_F:** the taxel forces F_i on a uniform k_x × k_y grid of half-open rectangular taxels (since 2026-11-09 the taxel sections assume grids; other layouts are covered by a remark). The CoP is unknown.
- **M_T = M0 ∨ M_F:** both.
- Grids are comparable iff the cell counts divide each other (dyadic grids form chains; 3×3 vs 4×4 are not comparable).

## Main results
1. **M0** (Thm 4.2, Cor 4.3, Thm 4.4, Cor 4.5):
   - h̲ = μ‖f_N a + bJm_1‖ (triangle inequality), attained by f_N δ_c.
   - The guaranteed set is exactly {(f, c × f) : ‖f‖ ≤ μ f_N}, so there is no guaranteed torsion about the CoP.
   - h̄ is attained by ≤ 3 atoms. For a polygon it is a vertex LP, equal to the maximum over the vertex triangles containing c. This is Yann's Prop 4.4.
2. **Concentration and spreading** (Lemma 5.7):
   - concentrating each taxel's force at its local CoP shrinks the wrench set;
   - spreading it to the taxel corners enlarges it;
   - half-open taxels give the closure values (Lemma 5.6).
3. **M_F** (Thm 6.1): exact closed forms μ Σ F_i min / max over each taxel of ‖a + bJx‖, given by the distance from the ICR to the taxel and to its farthest corner.
4. **M_T** (Thms 7.1, 7.2):
   - an SOCP lower bound in the local first moments u_i ∈ F_i P̄_i with Σ u_i = m_1;
   - an LP upper bound over the corner weights with at most r + 2 nonzeros;
   - both lie inside the M_F bounds.
5. **Comparison and refinement** (Props 8.1–8.3, Thm 8.4):
   - M_T is tighter than both M0 and M_F; M0 and M_F are not ordered.
   - The bounds tighten monotonically along nested refinements, and the gap is ≤ μ|b| Σ F_i diam P_i for M_F and M_T.
   - First order: the M_F gap is μ|b| ∫ (|u_1| w_x + |u_2| w_y) dν, so it halves with each dyadic refinement (bounded density).
6. **Load factors** (Prop 9.2):
   - the certified factor s_lo = inf over ⟨q, w⟩ = 1 of h̲, two SOCPs, attained by a compatible measure;
   - the upper factor s_up = inf of h̄, one SOCP (primal: a most favourable corner measure);
   - the rule: hold if s_lo ≥ 1, slip if s_up < 1, otherwise undecided;
   - multi-contact versions; Frank–Wolfe as the generic membership test.

## Numerics (Python library `pfb`)
- Grid LPs as ground truth, compared with the exact forms.
- Population studies up to 32×32 taxels, now in seconds (no outer search).
- The value of measuring the CoP is larger than the October report stated for mixed twists (audit in `stage3_validation_plan.md` §5.1).

## Assumptions to scrutinize
- Rigid planar patch, quasi-static Coulomb friction, uniform μ.
- No elastic or shear-traction coupling, no incipient-slip mechanics.
- Measurements exact and noise-free.
- Taxel = exact normal force per cell.
