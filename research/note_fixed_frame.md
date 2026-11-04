# Technical note: fixed-frame reformulation (decision of 2026-11-04)

This note replaces the M_F reference-frame note of 2026-10-22, whose "Option 1" it adopts and extends. It follows Yann's review of `doc/main.tex` (his discussion file and the meeting of 2026-11-04, both kept locally only). It is the specification for the rewrite of `doc/main.tex` and for the changes to the code. Labels in square brackets are those of the current `doc/main.tex`.

## 1. Decision
- **Torques are taken about a fixed point of the sensor frame (the origin), not about the CoP.**
  - The admissible set becomes X(ν) = {(f_T, τ_0)}.
  - Every measurement-conditioned bound is a generalized moment problem (GMP).
- **What this changes in the manuscript:**
  - the CoP slicing [lem:cop_slicing] and the CoP-referenced M_F section [sec:MF] are removed;
  - the M_0 and M_T results are restated, and are equivalent to the old ones through Varignon's formula;
  - homogeneous coordinates (f_N, m_1) replace (f_N, c), so f_N > 0 is no longer assumed.
- **Why.** An element of W(ν) [def. after eq:coulomb_local] is written in a frame centred at c[ν]. Two compatible measures with different CoPs give coordinates in different frames.
  - Under M_0 and M_T, the CoP is measured, so all compatible measures share the frame. The old results are correct, up to a fixed change of coordinates.
  - Under M_F, the union W⁺, the intersection W⁻ and the power reading of ⟨q, w⟩ combine coordinates from different frames.
    - The old M_F numbers are still valid lower and upper bounds on the scalar h_{W(ν*)}(q).
    - But they are not bounds for one physical twist, and W^± are not sets of physical wrenches. So a load given in a fixed frame (what a controller has) cannot be tested against them.
  - The certified load factor [sec:load_factor] and all the Drake studies already used a fixed reference.

## 2. Assessment of the review
Each point is classed as equivalence (E), prior art (P) or novelty (N).

| Point (Yann) | Verdict | Comment |
|---|---|---|
| Torque about a fixed point; Varignon to move it | **Agree** (E/P) | The convention of Alexander–Maddocks, Goyal et al., Huang et al. and Yann's draft. Already noted in `literature_review.md` (claim 5). |
| Support = maximal dissipated power; needs q and w in the same frame | **Agree** (E) | ⟨S_o q, T_o w⟩ = ⟨q, w⟩ (Lemma S3). |
| Everything is a GMP, no slicing | **Agree** | ν ↦ h_{X(ν)}(q) is linear. |
| (34) is the nice result | **Agree**, restated (E/P) | Homogeneous form μ‖f_N a + bJm_1‖ = μ f_N‖v(CoP)‖: triangle inequality, no Jensen. |
| (37) ill-posed; use a preorder on measurement operators | **Agree, with a correction** | The characterization is pointwise span, not a.e. equality: Dirac measures see point values. The quotient "≅ l2(Mes(P))/a.e." is wrong as stated. Only the preorder enters the paper (S8). |
| Remark 3.13 (a) attainment: irrelevant; (b) boundaries: not important | **Agree** | Half-open taxels; one ε-push lemma gives equality with the closure formulas (S11). |
| C_M is a Minkowski average | **Agree**, already Prop [prop:cop_taxel] | Becomes a remark, used for plots only. |
| Grid families M(T;px,py), M(Tc;px,py); nested grids only | **Agree** | Dyadic chains. 3×3 and 4×4 are not comparable. |
| No f_N > 0 needed: homogeneous coordinates | **Agree, with a caveat** | Π_M(y) must stay bounded. Assume a positive combination of the φ_j is ≥ 1 on P (true for M_0, M_F, M_T). |
| Cor 4.6 without c is exactly his problem | **Agree** (P) | Our M_0 upper bound = his Prop 4.4 with C = B(0, μ). |
| Why the local CoPs c_i? | **Partly** | Not needed for M_F (bounds per cell). For M_T they become local first moments u_i = F_i c_i, which make the CoP constraint linear and allow F_i = 0. |
| M_F lower = Σ min over a rectangle, upper = Σ max: closed forms | **Agree** | These are the old cellwise bounds [prop:cellwise], exact for M_F. |
| M_T: LP / SOCP with the CoP constraint | **Agree** | Shared corners can be merged; not needed. |
| Monotonicity in px: by how much do the bounds tighten? | **Answered to first order** (N) | See S14: the gap halves per dyadic step, with an explicit constant. |
| Membership test of a candidate wrench with Frank–Wolfe using h̄ | **Agree for "certain slip" only; an exact SOCP is better** (N) | h̄ is the support function of the convex set X⁺ (S7). h̲ is not the support function of X⁻ and is not convex, so "certain hold" stays the load-factor SOCP. Both upper and lower load factors are SOCPs (S15); Frank–Wolfe stays a remark for general M. |
| K = 3 closed form of the M_0 upper bound | **Pending from Yann** | For a triangle the LP has one feasible point, so h̄ is linear in y. For a rectangle, h̄ is the larger of two triangle values (S10). To compare with his formula. |

## 3. New statements and proof sketches
Notation:
- Frame (O, B). Patch P compact (convex where stated).
- Scalar planar cross product x × y ≔ (Jx)ᵀy = ⟨e_3, x × y⟩. This also covers Yann's remark on e_3 in (16)/(18).
- g(x; q) ≔ ‖a + bJx‖ for q = (a, b).
- m_1(ν) = ∫x dν.

**S1. Definition (admissible tangential wrench set about O).**
X(ν) = {(∫γ dν, ∫x × γ dν) : γ measurable, ‖γ‖ ≤ μ ν-a.e.}. Equivalently, it is the set of (ρ(P), ∫x × dρ) over R²-valued measures ρ with |ρ| ≤ μν.

**S2. Proposition (support, kept).**
h_{X(ν)}(q) = μ∫g(x; q) dν.
- Reading: q is a twist about O, a + bJx is the velocity of the material point x, and h is the maximal frictional power.
- Proof: the old proof with c = 0.

**S3. Lemma (change of reference point; new, E).**
For o ∈ R², let T_o(f, τ) = (f, τ − o × f) (torque about o) and S_o(a, b) = (a + bJo, b) (twist coordinates about o). Then:
- ⟨S_o q, T_o w⟩ = ⟨q, w⟩;
- X_o(ν) = T_o X(ν);
- h_{X_o(ν)}(S_o q) = h_{X(ν)}(q);
- W(ν) = T_{c[ν]} X(ν).

Since T_o and S_o do not depend on ν, every inf, sup, union and intersection over measures commutes with them:
- the bounds and the sets X^± are covariant;
- the choice of origin is immaterial;
- the old M_0 and M_T bounds at q equal the new ones at S_c⁻¹q.

**S4. Lemma (linearity; new).**
ν ↦ h_{X(ν)} is additive and positively homogeneous. Hence X(ν_1 + ν_2) = X(ν_1) ⊕ X(ν_2), X(tν) = tX(ν) and X(0) = {0}.
Proof: support functions add, and compact convex sets are determined by their support function.

**S5. Definition (measurement operator, restated).**
M(ν) = (∫φ_j dν)_j with bounded Borel φ_j.
- Assumption (mass control): some λ has Σλ_jφ_j ≥ 1 on P. Then ν(P) ≤ λᵀy on Π_M(y), and Π_M(y) is convex and bounded.
- This replaces Assumption [ass:positive_mass].

**S6. Definition (bounds, Yann's notation).**
- h̲(q; y, M) = inf over Π_M(y) of h_{X(ν)}(q), and h̄(q; y, M) = sup.
- X⁺(y, M) = ∪X(ν) and X⁻(y, M) = ∩X(ν).

**S7. Proposition (outer set convex; new, N).**
- X⁺(y, M) is convex, with support function h̄.
- X⁻ = {w : ⟨q, w⟩ ≤ h̲(q) ∀q}, and h_{X⁻} ≤ h̲ (h_{X⁻} is the closed convex envelope of h̲).

Proof: for w_k ∈ X(ν_k), tw_1 + (1−t)w_2 ∈ X(tν_1 + (1−t)ν_2) (S4), and Π_M(y) is convex.
- This fails for W, where c[ν] moves with ν.
- Consequences: w ∉ cl X⁺ means slip for every compatible measure, and this test is convex.

**S8. Definition and proposition (information preorder; new, from Yann).**
- **Definition.** M ≽ M′ if Π_M(M(ν)) ⊆ Π_{M′}(M′(ν)) for every ν ∈ M_+(P).
- **(i)** This is a preorder: it is not antisymmetric, and not total.
- **(ii) Characterization.** M ≽ M′ ⇔ M′ = A∘M for a matrix A ⇔ every φ′_j ∈ span{φ_k} pointwise on P.
  - Proof: for finitely supported signed σ = σ⁺ − σ⁻ with M(σ) = 0, M(σ⁺) = M(σ⁻) gives M′(σ) = 0, so ker M ⊆ ker M′ on point evaluations.
  - Counterexample to "a.e.": φ′ = 1_{x_0} against φ′ = 0, distinguished by δ_{x_0}.
- **(iii)** cat(M, M′) ≽ M, M′. NOINFO is minimal.
  - The number of functions is not monotone in ≽, because measurement functions can be redundant (Yann).
- **(iv) Monotonicity theorem.** If M ≽ M′, then for every ν, every q and y = M(ν), y′ = M′(ν):
  - h̲(q; y′, M′) ≤ h̲(q; y, M) ≤ h_{X(ν)}(q) ≤ h̄(q; y, M) ≤ h̄(q; y′, M′);
  - X⁻(y′, M′) ⊆ X⁻(y, M) and X⁺(y, M) ⊆ X⁺(y′, M′).
  - This replaces [lem:monotone] and fixes (37), since both observations come from the same ν.
- **Examples:**
  - M_T = cat(M_0, M_F);
  - partition refinement;
  - dyadic chains (S11);
  - M_0 and M_F are not comparable: x_1 ∉ span{1_{P_i}}, and 1_{P_i} ∉ span{1, x_1, x_2};
  - 3×3 and 4×4 grids are not comparable.

**S9. Lemma (integrand, restated).**
- (i) g(·; q) is convex.
- (ii) |g(x; q) − g(x′; q)| ≤ |b|‖x − x′‖.
- (iii) ∫g dν ≥ ‖f_N a + bJm_1‖, by the triangle inequality for vector integrals. For f_N > 0 this is f_N‖v(c[ν])‖: the maximal dissipated power is at least that of the whole load at the CoP.

**S10. M_0, y_0 = (f_N, m_1).**
- **Lower bound.** h̲ = μ‖f_N a + bJm_1‖, attained by f_N δ_c (P convex).
- **Corollary (exact guaranteed set).** X⁻(y_0) = {(f, c × f) : ‖f‖ ≤ μ f_N}.
  - ⊇: the uniform field γ ≡ f/f_N gives torque c × f for every compatible ν.
  - ⊆: the point load at c has exactly this set.
  - About the CoP (T_c) this is f_N B(0, μ) × {0}: no torsion about the CoP is ever guaranteed. The headline result is kept, now as an exact set.
- **Upper bound.** h̄ = μ max{Σλ_k g(v_k; q) : λ ≥ 0, Σλ_k = f_N, Σλ_k v_k = m_1} (polygonal P), with at most 3 atoms. This is Yann's Prop 4.4 for C = B(0, μ), with no c left.
  - Triangle: λ = B⁻¹(f_N, m_1) is unique, so h̄ is linear in y_0.
  - Convex quadrilateral (a rectangle): the feasible set is a segment whose endpoints are the triangle decompositions of c in the two diagonal triangulations, so h̄ is the larger of two triangle values.
  - Example [ex:segment] is kept.

**S11. Taxels (restated).**
- **Model.**
  - Half-open rectangular cells.
  - Dyadic grid G(px, py) on P = [0, L] × [0, ℓ]: M(T; px, py) gives the taxel forces, and M(Tc; px, py) = cat(M_0, M(T; px, py)).
  - Chains: M(T; px′, py′) ≽ M(T; px, py) when px′ ≥ px and py′ ≥ py, and the same for Tc.
  - M(T; 0, 0) is the mass alone, and M(Tc; 0, 0) = M_0.
- **Half-open lemma (ε-push; replaces eq:PiMF and lem:closure).** The inf and sup over the half-open preimage equal those of the closure model.
  - M_F: move each atom by ε into its cell.
  - M_T: move every mass of cell i a fraction ε toward the local CoP of ν* in that cell. That CoP lies in the half-open cell, the global CoP does not change, and the value changes by at most εμ|b|Σ F_i diam P_i.
  - The proof exists in the comments of [lem:closure].
- **Concentration and spreading (set level; new, replaces lem:taxel_barycenters and lem:vertex_reduction).** Let ν = Σν_i, with masses F_i and local first moments u_i. Then
  X(Σ F_i δ_{u_i/F_i}) ⊆ X(ν) ⊆ X(any corner spread of ν).
  - Concentrating: the field equal to γ_i on cell i gives force F_iγ_i and torque (u_i/F_i) × F_iγ_i.
  - Spreading: replace the atom (x, ρ_x) by (α_k(x), α_k(x)ρ_x) at the corners v_k, with Σα_k v_k = x. Force and torque are unchanged, |α_kρ_x| ≤ μα_kν_x, and F_i and m_1 are preserved. Use a measurable choice of α, e.g. bilinear coordinates.
  - This makes the "concentrate / spread" intuition of [rem:why_lemmas] exact, at set level. The LP-duality proof is no longer needed.

**S12. M_F, exact closed forms (new as exact; old prop:cellwise).**
- h̲ = μΣF_i min over P̄_i of g, and h̄ = μΣF_i max over corners of g.
- For b ≠ 0, g = |b|‖x − p‖ with p = Ja/b (the instantaneous centre of rotation). On a rectangle with centre m, half-sides (w_x/2, w_y/2) and Δ = m − p:
  - min = |b|‖((|Δ_x| − w_x/2)₊, (|Δ_y| − w_y/2)₊)‖;
  - max = |b|‖(|Δ_x| + w_x/2, |Δ_y| + w_y/2)‖.
- For b = 0 both equal f_N‖a‖ and the bounds meet.
- Proof: the cells decouple; inside each cell, take one atom at the minimizer or the maximizer.
- Compatible CoP set: a remark only, m_1 ∈ ΣF_i P̄_i (Minkowski average).

**S13. M_T (restated, homogeneous).**
- **Lower bound.** h̲ = μ min{Σ‖F_i a + bJu_i‖ : u_i ∈ F_i P̄_i, Σu_i = m_1}.
  - An SOCP: u_i ∈ F_i P̄_i is linear in (F_i, u_i), and F_i = 0 forces u_i = 0.
  - Proof: S9(iii) applied to each cell, then concentration.
- **Upper bound.** h̄ = μ max{Σλ_ik g(v_ik; q) : λ ≥ 0, Σ_k λ_ik = F_i, Σλ_ik v_ik = m_1}.
  - An LP, with at most r + 2 nonzeros.
  - Proof: spreading.
- r = 1 gives M_0. Dropping Σu_i = m_1 gives M_F, so the M_T bounds lie inside the M_F bounds.

**S14. Refinement and the rate of tightening.**
- **Gap bound.** For M_F and M_T, 0 ≤ h̄ − h̲ ≤ μ|b|ΣF_i diam P_i. The factor 2 of [prop:taxel_resolution_MT] for M_F is gone. Convergence follows.
- **First-order rate (new, N).** Rectangular cells w_x × w_y, b ≠ 0, ν with a bounded density, u(x) = (x − p)/‖x − p‖. Then:
  - h̄_F − h̲_F = μ|b|∫(|u_x|w_x + |u_y|w_y) dν + O(h²).
  - For square cells of side h this is μ|b| h C_ν(p) + O(h²), with C_ν(p) = ∫(|u_x| + |u_y|) dν ∈ [f_N, √2 f_N].
  - Along a dyadic chain the gap ratio is therefore 1/2 + O(h).
  - In terms of the diameter √2·h, the gap is between 1/√2 and 1 times the bound μ|b| f_N diam. This explains why the F2 study found the bound nearly attained.
- **Proof sketch.**
  - For a cell C not containing p, d = ‖· − p‖ has gradient u and curvature ≤ 1/d.
  - So max_C d − min_C d = |u_x(m)|w_x + |u_y(m)|w_y + O(diam²/dist(p, C)).
  - Summing gives the error h²∫dν/‖x − p‖, finite for a bounded density.
  - Cells within 2 diam of p contribute O(diam · ν(B(p, 3 diam))) = O(h³).
- **Open.** The same asymptotic for M_T: its gap is ≤ the M_F gap, but by how much less? This is the value of the CoP at high resolution, to quantify numerically.

**S15. Load factor (restated, with the new upper factor).**
- **Definitions.** s*(ν; w) = max{s ≥ 0 : sw ∈ X(ν)}, for a load w about O (a load about o is mapped by T_o⁻¹). Then s̲ = inf_Π s*, and s̄ = sup_Π s*.
- **(i) Lower factor (kept).** s̲ = max{s : sw ∈ X⁻} = inf_{⟨q,w⟩=1} h̲(q). The SOCP with u_i = bc_i of [prop:load_factor] is unchanged.
- **(ii) Upper factor (new).** s̄ = max{s : sw ∈ cl X⁺} = inf_{⟨q,w⟩=1} h̄(q), by S7 and the argument of (i). Both versions are SOCPs:
  - **primal:** max s over corner weights λ (taxel and CoP constraints) and corner forces ρ_ik with ‖ρ_ik‖ ≤ μλ_ik, Σρ = s f and Σv_ik × ρ_ik = sτ. This is exact by spreading, and gives the most favourable compatible pressure;
  - **dual, M_F:** min μΣF_i t_i subject to t_i ≥ ‖a + bJv_ik‖ for all k and ⟨q, w⟩ = 1;
  - **dual, M_T:** min μ(ΣF_i y_i + zᵀm_1) subject to y_i + zᵀv_ik ≥ ‖a + bJv_ik‖ and ⟨q, w⟩ = 1 (LP duality inside).
- **(iii) Decision rule.**
  - s̲ ≥ 1: every compatible pressure carries w.
  - s̄ < 1: none does, so quasi-static slip is certain.
  - Otherwise the measurement cannot decide.
  - Under ≽, s̲ increases and s̄ decreases.
- **(iv) Several contacts.** s̄_grasp = inf_q Σ_k h̄_k(q), one SOCP. A Minkowski sum of convex X⁺_k is convex, so this equals the sup over compatible tuples. The s̲ part is unchanged.
- **Remark (Frank–Wolfe).** For an operator where only h̄ and its maximizer can be evaluated (e.g. moment–SOS relaxations), Frank–Wolfe on cl X⁺ gives the distance from w to X⁺. The linear minimization oracle is the support point.

## 4. Label map (current `doc/main.tex` → rewrite)

| Current label | Fate |
|---|---|
| W(ν) definition, prop:support | restated about O (S1, S2); W appears only in S3 |
| — | new: lem:varignon (S3), lem:linearity (S4), lem:concentrate_spread (S11), prop:outer_convex (S7), def/prop:preorder, thm:monotone (S8), lem:half_open (S11), thm:MF (S12), thm:rate (S14) |
| def:measurement_operator, ass:positive_mass | restated with mass control (S5); ass:positive_mass removed |
| def:CM | remark (homogeneous) |
| def:measurement_support_bounds, rem:use_bounds, rem:inner_outer | restated (S6); rem:inner_outer → prop:outer_convex |
| eq:general_nonlinear_lower/upper, lem:cop_slicing | removed |
| lem:integrand | (iii) homogeneous (S9) |
| lem:monotone | → thm:monotone (S8) |
| rem:closures | short remark on attainment |
| thm:coarse_lower | homogeneous, plus a corollary on the exact X⁻ (S10) |
| prop:coarse_upper_atomic, cor:coarse_upper_polygon | kept without c, plus triangle / rectangle closed forms |
| rem:demontmarin | rewritten: exact identity with Yann's Prop 4.4 |
| cor:M0_not_identifying | commented out but cited in prop:taxel_refinement: restore it or drop the citation |
| ass:taxels, def:MF, eq:PiMF, def:MT | half-open dyadic grids, cat (S11); eq:PiMF removed |
| lem:taxel_barycenters, lem:vertex_reduction | → lem:concentrate_spread |
| prop:cop_taxel | remark |
| rem:why_lemmas | rewritten around the set inclusions |
| lem:closure | → lem:half_open |
| thm:combined_lower, thm:combined_upper | restated, homogeneous (S13) |
| prop:cellwise, eq:cellwise_MT | → thm:MF (exact for M_F; a relaxation for M_T) |
| sec:MF: prop:MF_as_MT, thm:taxel_lower, thm:taxel_upper, prop:fixed_ref, rem:cop_estimate, rem:reference_point | removed; one remark on why the CoP-referenced M_F quantity is dropped |
| prop:taxel_refinement, prop:taxel_refinement_MF | corollaries of S8 |
| prop:taxel_resolution_MT | factor 2 removed; followed by thm:rate |
| def:wrench_fixed_ref, lem:fixed_ref_lower | removed: X is about O, loads move by T_o; the lower bounds are S12 / S13 |
| def:load_factor, prop:load_factor, rem:load_factor | s̄ added, (ii) the upper SOCP, (iii) the decision rule; Frank–Wolfe remark |

The report `doc/experiments.tex` cites several removed labels. They are listed and fixed in the validation audit, before the report is updated.

## 5. Numerical checks (scratch scripts on `pfb`, 2026-11-04)
- **A. Equivalence.** Old CoP-referenced M_0 / M_T grid bounds at q vs new fixed-frame grid bounds at S_c⁻¹q: 5 random measures × 2 grids × 3 directions, max difference 2·10⁻⁸.
- **B. M_F changes.** Gaussian loads, 4×4 taxels, q = rotation about the true CoP:

| Direction | True | Old M_F (lower / upper) | New M_F (lower / upper) |
|---|---|---|---|
| Pure torsion | 0.147 | 0.068 / 0.278 | 0.071 / 0.283 |
| Mixed (1, 0, 5) | 1.035 | 0.849 / 1.600 | 0.541 / 1.675 |

  - The new bounds are looser than the old ones for this twist, because the old ones bounded a twist that moved with each measure.
  - **The F2 statement "M_F ≈ M_T at intermediate resolution" must be re-checked.**
  - The grid LP with half-open cells differs from the closure formula by O(|b|·grid spacing), as expected.
- **C. Upper load factor.** Ramp field, k = 1, 2, 4, 8, two loads.
  - The primal SOCP (closure model) equals the dual SOCP to 5 digits, for M_F and M_T.
  - s̲ ≤ s* ≤ s̄ held in every case.
  - Example, pure torque at 8×8: M_F 0.131 ≤ 0.188 ≤ 0.256.
- **D. Rate.** 21 population fields, k = 1…64, two directions, reference at the true CoP or the pad centre.
  - Median gap(2k)/gap(k): 0.65 → 0.52 → 0.506 → 0.504 → 0.500 → 0.500.
  - Worst case: 0.505 at k = 32.
  - The first-order constant gap/(μ|b|h) matches C_ν(p) to 3–4 digits at k = 64 (e.g. 1.2739 against 1.2726).

## 6. Open items
- Yann's K = 3 closed form: compare with S10. Ask him whether his formula covers a different case, e.g. M_T, or the triangle with a CoP constraint.
- M_T asymptotics: how much the CoP constraint reduces the gap at high resolution.
- Robust extension: with fixed q and F_i ∈ [F_i⁻, F_i⁺], the M_T lower bound stays an SOCP in the homogeneous (F_i, u_i). The load factor with interval F_i is bilinear in (a, F_i): still open.
- The algebra of measurement operators (Yann's quotient space): roadmap only.
