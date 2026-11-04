# Literature review and novelty audit (consolidated 2026-10-22)

This document merges Stages 1, 1b and 1c (2026-10-16 to 2026-10-20). Those files are deleted; git history has the originals.

**Related files**
- Manuscript: `doc/main.tex`. Result numbers below follow the current build, with labels in brackets.
- Contributions and story: `stage2_contributions.md`.
- Experimental evidence: `doc/experiments.tex`.
- Links, Zotero status and the reader of each reference: `references.md`.
- Abstract-level screening notes per group: `notes/group*.md`.

## 1. Scope and method
**Question.** Is there prior work that bounds the frictional capacity of a planar patch contact (shear plus torsion) from partial normal-pressure information? In particular, is there any work that bounds it from tactile taxel forces?

**Search.** Five groups:
- pushing mechanics;
- moment problems and stochastic programming;
- limit-surface models;
- tactile slip and capacity;
- contact estimation and simulation.

The first pass (Stage 1) was abstract-level. The high-priority papers were then read in full text from the user's Zotero library (Stage 1b). Alexander–Maddocks and Huang et al. were compared claim by claim with our results (Stage 1c).

**Access codes**

| Code | Meaning |
|---|---|
| FULL | Entire text read |
| PART | The listed sections were read |
| SEC | Content known only through a named secondary exposition |
| ABS | Abstract only |
| CIT | Known only as a citation in another paper |
| INACC | Full text not retrievable |

**Reading notes**
- Zotero PDFs were read with `pdftotext`. Howe–Cutkosky 1996 is scanned, so it was read as page images.
- The Zotero database is locked while Zotero runs, so items were located through `~/Zotero/storage`.
- The user added Costanzo T-RO 2020 to Zotero on 2026-10-20.
- Displayed equations of Alexander–Maddocks were lost in extraction. They were read as images (pp. 235, 236, 242).
- Madansky, Huang–Ziemba–Ben-Tal and Frauendorfer were paywalled or bot-blocked. Their content comes from two secondary sources: Yates 1996 (MSc thesis) and Dokov–Morton 2002.
- Absence claims ("no work does X") rest on full texts of the closest papers. They remain claims about what was found, not proofs of absence.

## 2. Executive summary
1. **The coarse case M0 (total force and CoP) is prior art.**
   - Peshkin & Sanderson 1988 bound ∫‖x − r‖dν over pressures on a disk with a fixed centroid.
   - Alexander & Maddocks 1993 note that a prescribed CoP reduces extremal loads to tripods.
   - Huang et al. (RSS 2017) build the "moment envelope" conv G(R), which is our K = conv Φ(P).
   - Caron et al. 2015 spread pressure to the vertices.
   - The mathematics is Jensen plus Edmundson–Madansky / Gassmann–Ziemba vertex bounds.
   - So Thm 4.2, Thm 4.4 and Cor 4.5 (numbering of the 2026-11-04 rewrite) are known results in a new notation.
2. **The support function of the admissible wrench set is the Coulomb dissipation.** This is Alexander–Maddocks eqs. 7 and 10, and Goyal et al. §8. Prop 3.2 is background. Since the 2026-11-04 rewrite, torques are taken about a fixed point, as in these references.
3. **The taxel cases are not in the literature, but their structure is classical.**
   - M_T generalizes the partition bounds with *known* cell means (Gassmann–Ziemba Prop 5.1; Birge–Wets Prop 4.1) to *unknown* cell means with a known global mean.
   - It stays exact and tractable (one SOCP, one LP) even though taxel partitions violate the nesting condition of Wiesemann–Kuhn–Sim. Without that condition, WKS show the general problem is NP-hard.
   - The novelty is real but modest.
4. **Plug-in capacity from tactile pressure is old.** Bicchi et al. 1988 and Howe–Cutkosky 1996 (Table 2) do it, without guarantees. It is the natural baseline.
5. **No work was found that certifies frictional capacity from taxel measurements.** This is now based on full texts of the closest works: Costanzo 2020, Arslan Waltersson 2024/25, Huang 2017, Alexander–Maddocks 1993, Howe–Cutkosky 1996. The slip literature detects, predicts or estimates under an assumed pressure shape. It does not certify.
6. **The certified load factor (main.tex Section 9) rests on standard tools.** The ray/support identity is convex analysis, and the perspective substitution u_i = b·c_i is standard. What is new is applying them to the intersection over measurement-compatible measures, which yields one convex program even though the lower bound is not convex in q.
7. **The main hardware risks come from the literature.**
   - Silicone and rubber fingertips slip below the Coulomb limit-surface prediction under combined torsion and shear (Howe–Cutkosky §3, p. 12).
   - Quasi-static limit-surface control slips under fast load changes (Costanzo 2020 §V-C, Fig. 17).
8. **Expected counter-citation: "the pressure distribution is almost irrelevant"** (Costanzo 2020 §I, §III-A). It holds *within* an axisymmetric parametric family whose τ_max is calibrated on the pad. It does not hold over arbitrary pressures compatible with taxel data, which is our setting.

## 3. Literature map
| Group | Representative works | What they assume or provide | Relation to us |
|---|---|---|---|
| Pushing mechanics with unknown pressure | Mason; Peshkin–Sanderson 1988; Alexander–Maddocks 1993; Lynch–Mason 1996; Huang et al. 2017 | Bounds on the *motion* (ICR, feasibility) over pressures with known total force and CoP, or over all measures | M0 is their capacity counterpart. Same moment-problem class, different integrand and question. |
| Moment problems and stochastic-programming bounds | Jensen; Edmundson 1956; Madansky 1959; Huang–Ziemba–Ben-Tal 1977; Gassmann–Ziemba 1986; Birge–Wets 1983/86; Frauendorfer 1988; Kall 1991; Winkler 1988; Wiesemann–Kuhn–Sim 2014; Lasserre 2010 | Extremal measures, vertex LPs, partition refinement, tractability conditions | The mathematical core of all our bounds (M0: classical; M_T / M_F: generalization) |
| Limit-surface models | Goyal–Ruina–Papadopoulos 1991; Howe–Cutkosky 1996; Lee–Cutkosky 1991; Xydas–Kao 1999; Tiezzi–Kao 2007; Zhou et al. 2016/18; Arslan Waltersson 2024 | Capacity for a *known* (or parametric) pressure | We bound it when the pressure is only partially measured |
| Tactile slip and capacity | Detection: Yuan 2015, Dong, Kolamuri 2021, Griffa 2022. Prediction: Veiga 2018. Parametric capacity: Cirillo 2017, Costanzo 2020/21/23, Arslan Waltersson 2025, Park 2026. Reviews: Chen 2018, Romeo 2020 | Detect or predict slip; estimate capacity under an assumed family | No set-valued or guaranteed capacity |
| Contact estimation and simulation | Fearing–Hollerbach 1985; Bicchi–Salisbury–Brock 1993; Ma et al. 2019; Sferrazza–D'Andrea 2019; Fazeli et al. 2018; Elandt 2019; Masterjohn 2022; de Mont-Marin 2025 | Reconstruct one pressure state; identifiability; hydroelastic contact | Single-state reconstructions feed plug-in estimates. Drake's model gives exact discrete truth for our simulations. |

**Four-way distinction for the slip literature**
1. **Detecting slip:** well addressed.
2. **Predicting slip:** addressed by learned models, without guarantees.
3. **Estimating capacity:** partly addressed, always under an assumed or identified pressure shape.
4. **Certifying admissible loads from partial pressure data:** no instance found.

## 4. Unified evidence table
Priority: **★★ high** (overlaps a result, or is the expected reviewer citation), ★ medium, · low. High-priority rows are bold and come first.

| Paper | Access | What it establishes (location) | Relation to our results | Threat | Priority |
|---|---|---|---|---|---|
| **Peshkin & Sanderson 1988**, IEEE J-RA 4(6) | PART: §2.7–2.9, §4.5 | Pressure in a disk of radius a around the CM, with the centroid at the CM (§2.7). d_r ranges over [r, √(r²+a²)]: the minimum has the load at the centroid (eq. 18), the maximum is an opposite-ends dipod (eq. 19). | The disk case of Thm 4.2 / 4.4 [thm:coarse_lower, prop:coarse_upper_atomic] | high (M0) | ★★ |
| **Huang, Bhatia, Boots, Mason 2017**, RSS XIII | FULL (text; figures not viewed) | Moment envelope {∫G p̂} = conv G(R) (§III-B, eqs. 13–14). Thm 2 holds for any convex pressure class with known CoP. Discretized LP feasibility test (eq. 25), with an optional cap 0 ≤ p ≤ U (eq. 26). Motion feasibility (Def. 1) uses g = ∂_ω‖Av‖ (eq. 12). No taxels, no unknown CoP. | Proof technique of Thm 4.5: the class is exactly M0. Our grid LP for M_T is LP (25) with taxel equalities added and the integrand changed. | high (technique) | ★★ |
| **Alexander & Maddocks 1993**, IJRR 12(3) | FULL (text; displayed equations viewed on pp. 235, 236, 242) | Dissipation D(v) = ∫‖A(x)v‖dμ (eq. 7); gradient condition (eq. 10); ICR set over all measures (eq. 20). Thm 6: unipods inside plus bipods on the boundary generate all ICRs, *because* the first moment is not prescribed; with it, Mason gets tripods (p. 233, §7 p. 246). §7: the bounds are weak because of "extreme and perhaps pathologic" measures. | Prop 3.2 is their dissipation identity. The ≤3-atom count of Thm 4.5 is known. Section 6 below gives the details. | high (M0 atoms) | ★★ |
| **Caron, Pham, Nakamura 2015**, ICRA | PART: §3 (Prop 1 with proof), §4 (Prop 2) | Prop 1 spreads pressure to the vertices with barycentric weights. Prop 2 (eqs. 15–20) gives yaw bounds of the *possible* set, with linearized cones; the converse is "out of scope". | The vertex step of Cor 4.6 / Lemma 5.8 for a single patch. Locomotion uses "possible" semantics; manipulation needs "guaranteed". | high (vertex step) | ★★ |
| **Costanzo, De Maria, Natale 2020**, T-RO 36(1) | FULL (text pp. 157–172; Tables I–II and figures not viewed) | 5×5 taxels with CoP = taxel centroid (eqs. 1–2). Axisymmetric pressure (A4) in the Xydas–Kao family (eq. 25), ρ = δf_n^γ (eq. 24), τ_max = 2μξ_kν_kδf_n^(γ+1) (eq. 33). "Pressure almost irrelevant" (§I, §III-A), but the sensitivity is tested *within* the family: ξ_kν_k ∈ [0.3036, 0.3214], k ∈ [2.48, 4.82], ≤ 2% error at k = 4 (eq. 36, §III-C). Hand-chosen margins μ/α_s and α_d = 1.1–1.4 (eq. 57, §III-E). Gripper capacity = Σ per-finger g_i (eq. 42). Static limit-surface control slips under fast loads (§V-C, Fig. 17). Needs an accurate μ (§VI). | The closest tactile-capacity method and the expected reviewer counter-citation. Plug-in two-finger additivity is theirs; *certified* additivity (Prop 9.2(vi)) is ours. Its rate effect motivates our S4. | medium (objection), high (hardware) | ★★ |
| **Howe & Cutkosky 1996**, IJRR 15(6) | FULL (scanned; text pp. 1–20, figures pp. 24–26) | Pressure assumed known (§2.1). m_max = 0.589 / 0.667 / 0.951 μf_N R for Hertz / uniform / annular (Table 1). Translational capacity is μf_N for any pressure (§2.3). Lee 1991: equilibrium-equivalent point supports give a conservative limit surface (§2.5 p. 11). Tactile-array pressure used as a plug-in (Table 2 p. 16). The ellipsoid is not conservative (p. 17). **Silicone and rubber fingertips slip below the Coulomb limit-surface prediction under combined loads (§3 p. 12).** Bicchi et al. 1988 cited on p. 14. | The plug-in baseline. The "concentrate" step at known centroids (via Lee). The pure-shear filter: bounds matter only for torsion. The main hardware risk. | medium (concentrate step), high (hardware) | ★★ |
| **Madansky 1959**, Ann. Math. Statist. 30(3) | SEC (Yates 1996, Ch. III) | Jensen lower bound, plus an LP over the 2^r rectangle vertices with fixed mean | Thm 4.2 and Cor 4.5 for rectangles | high (M0) | ★★ |
| **Gassmann & Ziemba 1986**, Math. Prog. Study 27 | SEC (Yates 1996, Ch. V) | Thm 5.1: polyhedral vertex LP with known mean. Prop 5.1: partition bounds with known cell probabilities *and* cell means. | Cor 4.6. M_T with the local CoPs c_i fixed is their Prop 5.1; ours leaves the c_i free. | medium (M_T) | ★★ |
| **Birge & Wets 1983/86**, IIASA WP-83-111 | PART: §§3, 4, 6 | Partition Jensen with cell means (Prop 3.1 / 4.1). Monotone, convergent refinement (Convergence 3.7 / 4.6). At most M+1 atoms (Thm 6.9). | Props 8.1–8.3 in the known-cell-means case; the atom counts | medium | ★★ |
| **Wiesemann, Kuhn, Sim 2014**, Oper. Res. 62(6) | FULL (audit agent) | Exact tractability of distributionally robust problems needs the nesting condition (N) (p. 9). Without (N), even non-emptiness is strongly NP-hard (Thm 2). A norm loss needs ellipsoidal C_i and no mean constraint (e-companion Table 1). | Taxel closures violate (N), so Thms 6.1 / 6.2 are not special cases. Their exactness is a point in our favour. | medium (framing) | ★★ |
| Goyal, Ruina, Papadopoulos 1991, Wear 143 | PART: §8, 8.1, 11, 12 | Limit surface as the boundary of a Minkowski sum, via maximum power (§8, eq. 5). Zhukovskii moment function as a sum of cones (§11). A change of reference point shears the limit surface (§12(3)). Maximum load in direction n is reached by motion n (§12.3). Pressure known; no bounds. | Background for Prop 3.2 and the ICR form of the integrand. §12(3) is the frame change of Def. 9.1. | background | ★ |
| Lee & Cutkosky 1991; Lee 1991 thesis | CIT (Howe–Cutkosky pp. 11, 16) | Conservative point-support limit surface | Likely precedent for the concentrate step at known centroids (unverified) | medium | ★ |
| Bicchi, Bergamasco, Dario, Fiorillo 1988 | CIT (Howe–Cutkosky p. 14) | Rotation centre from tactile-array pressure and measured friction forces | Earliest plug-in precedent | low | ★ |
| Masterjohn et al. 2022, RA-L | PART: §III-B, §IV, §V-A, §VI | Drake's discrete hydroelastic contact: one Coulomb point contact per contact-surface face at its centroid, with force A·p_c. Torsion emerges from the distributed points. | For frozen normal forces, the simulated static capacity equals our support function on a discrete field. This is the basis of the Drake truth. | none (tool) | ★ |
| Elandt et al. 2019, IROS | ABS | Pressure-field (hydroelastic) contact model | Simulator background | none | · |
| Huang–Ziemba–Ben-Tal 1977; Frauendorfer 1988; Kall 1991 | ABS (PDF 403 / bot-block) | Conditional (cell-mean) refinement, per the abstracts | Could contain partition bounds from cell probabilities only (M_F-like). **Open.** | not verified | ★ |
| Edmundson 1956 (RAND) | INACC | Univariate upper bound (via secondary sources) | Background | — | · |
| Winkler 1988, Math. OR 13(4) | ABS | Extreme points of moment sets | Atom counts (Thm 4.5) | known | · |
| Xydas & Kao 1999, IJRR 18(9) | PART: §4.1 + scan | Parametric pressure family (eqs. 20–22); radius a ∝ N^γ (eq. 17). No bounds. | Field family in our population; fields scale with f_N | low | · |
| Tiezzi & Kao 2007, T-RO | PART | Parametric k-family (eq. 2); limit-surface evolution under relaxation (§V) | Viscoelastic effects: a hardware caveat | low | · |
| Arslan Waltersson & Karayiannidis 2024, T-RO | PART (model sections) | Limit surface for a known p (eqs. 7–8). Distributed and reduced LuGre (eqs. 9–29). The pure-rotation point differs from the CoP for an asymmetric p (§V-B, Fig. 16). | Assumes a known pressure. Their asymmetry remark supports our off-family setting. | low | · |
| Arslan Waltersson & Karayiannidis 2025, IJRR | PART | Equivalent radius r identified by probing in about 2 s. Measured r = 3.9–7.9 mm vs 10 mm under uniform pressure (Table 9), attributed to the pressure assumption. | Evidence that uniform-pressure assumptions overestimate. Probing baseline (not implemented). | low | · |
| Costanzo 2021, Mechatronics | PART: §2.1, §3 | Axisymmetric p. Limit surface bracketed between the Hertz and uniform profiles (§2.1, Fig. 4), as a qualitative remark only. | Closest to "bounds", but within a family and without a guarantee | low–medium | · |
| Costanzo, De Maria, Natale 2023, Appl. Sci. 13(2) | PART: §§2, 4, 5, 7 | τ_max = μξδf_n^(γ+1) (eq. 4), parameters fitted by SQP (eq. 32) | Parametric capacity | low | · |
| Cirillo et al. 2017, ICRA | PART: §II.A, III, IV | Ellipse f_t² + τ²/e_z² ≤ μ²f_n² with e_z = δρ (eqs. 5–8), identified by rotation (§III-C) | Parametric capacity | low | · |
| Griffa, Sferrazza, D'Andrea 2022, ICRA | PART: §I, III | Per-taxel f_zi, net moment (eq. 6), stick ratio (eq. 7) | Distributed forces used for detection, not capacity | low–medium | · |
| Ardakani, Bimbo, Prattichizzo, arXiv 1904.06677 | PART (keyword scan) | Quadratic limit surface with uniform or Hertz p (§2.3, §7.1); motion-mode bounds | Parametric | low | · |
| Park et al. 2026, Adv. Intell. Syst. | PART | Tactile safety margin TSM = (F_max − F_fric)/F_max, translational only (§2.1, 2.4) | No torsion | none–low | · |
| Shirai, Jha, Raghunathan 2024, T-RO | PART | Worst-case margins over mass, CoM, μ and finger position, with point contacts (§IV) | Robust, but point contacts | low | · |
| Fazeli, Tedrake, Rodriguez 2018, ISRR | PART | Identifiability with point contacts | No patch | none | · |
| de Mont-Marin et al. 2025, arXiv 2509.25999 | PART (intro + friction scan) | Conic complementarity of planar contacts; friction left as future work | Related patch modelling (Yann). Our M0 upper bound coincides with Prop 4.4 of his unpublished draft (Remark 4.6 [rem:demontmarin]). | coordination | ★ |
| Yuan 2015; Dong; Kolamuri 2021; Veiga 2018; Chen 2018 (review); Romeo 2020 (survey); Ueda 2005; Shahidzadeh 2025 (FeelAnyForce) | ABS or CIT | Slip detection or prediction, force regression | Context for the four-way distinction. FeelAnyForce is our hardware force regressor (resultant only). | none | · |
| Fearing–Hollerbach 1985; Bicchi–Salisbury–Brock 1993; Ma et al. 2019; Sferrazza–D'Andrea 2019 | ABS | Single-state pressure or force reconstruction | Feed plug-in estimates | none | · |
| Lynch–Mason 1996; Zhou et al. 2016/18; Mason 1986/2001 | ABS or CIT | Stable pushing; convex polynomial force–motion models; mechanics textbook | Background | none | · |
| Smith 1995; Delage–Ye 2010; Lasserre 2010 | ABS or CIT | Generalized Chebyshev inequalities; moment-based DRO; GMP | Background for the GMP formulation | none | · |

## 5. Result-by-result novelty audit
Categories:
- **known:** the same statement exists;
- **equivalent:** the same mathematics in another notation or question;
- **generalization:** classical structure extended;
- **new:** none found.

| Result (main.tex, fixed-frame rewrite of 2026-11-04) | Category | Closest prior art | Threat |
|---|---|---|---|
| Prop 3.2 [prop:support]: support function about a fixed point = maximal dissipated power; ICR form of the integrand | known | Alexander–Maddocks eqs. 7, 10; Goyal §8 eq. 5, §11, §12.3; Peshkin–Sanderson d_r | high: background |
| Lemma 3.4 [lem:varignon]: change of reference point | known | Varignon; Goyal §12(3) | background |
| Lemma 3.6, Prop 3.11 [lem:linearity, prop:inner_outer]: Minkowski additivity in ν; possible set X⁺ convex with support h̄; concavity/convexity of the bounds in y | elementary / generalization | Yann's Prop 4.4 (concavity of a ↦ s_D(a), the M0 case) | low |
| Def 3.14, Prop 3.15, Thm 3.16 [def:preorder, prop:preorder, lem:monotone]: information preorder on measurement operators (pointwise-span characterization), monotonicity | elementary (from Yann's review) | Blackwell-type comparison of experiments is the analogous idea in statistics (not checked against a source; do not cite without one) | low |
| Thm 4.2, Cor 4.3 [thm:coarse_lower, cor:coarse_inner]: lower bound μ‖f_N a + bJm_1‖; exact guaranteed set; zero guaranteed torsion about the CoP | known | Peshkin–Sanderson min d_r = r; Madansky; uniform field as in Yann's Remark 4.2 | high |
| Thm 4.4, Cor 4.5 [prop:coarse_upper_atomic, cor:coarse_upper_polygon]: ≤ 3 atoms, vertex LP, triangle form | known / equivalent | Huang §III-B and LP (25); Peshkin–Sanderson eq. 19; Alexander–Maddocks Thm 6 and p. 233; Caron Prop 1; Madansky; Gassmann–Ziemba Thm 5.1; Birge–Wets Thm 6.9; Yann's Prop 4.4 (identical, same frame) | high |
| Example 4.7 [ex:segment]: (f_N, CoP) does not determine the wrench set | folklore | Statically indeterminate supports | medium |
| Lemma 5.7 [lem:concentrate_spread]: concentration shrinks and spreading enlarges the wrench set (set inclusions) | equivalent (single patch) | Caron Prop 1; Yann's eq. (33) (extreme points); Lee 1991 (concentrate step) | medium |
| Lemma 5.6 [lem:half_open]: half-open taxels give the closure values | elementary | — | low |
| Remark 5.9 [rem:cop_taxel]: compatible CoPs as a Minkowski average | elementary | — | low |
| Thm 6.1 [thm:MF]: exact closed-form M_F bounds (sum over taxels of min / max of the speed) | elementary once the frame is fixed | Partition bounds with known cell probabilities only; the HZB / Frauendorfer / Kall abstracts may contain the analogue (open item) | low–medium |
| Thm 7.1 / 7.2 [thm:combined_lower, thm:combined_upper]: M_T SOCP (local first moments) / LP with ≤ r+2 atoms | generalization | Gassmann–Ziemba Prop 5.1 and Birge–Wets Prop 4.1 assume known cell means. WKS (N) is violated, so these are not special cases. | medium |
| Props 8.1–8.3 [prop:taxel_refinement, prop:taxel_refinement_MF, prop:taxel_resolution_MT]: ordering, refinement, O(diam) gap | classical analogue (known-cell-means case) | Birge–Wets Convergence 3.7 / 4.6; Frauendorfer and HZB (abstracts only) | medium |
| Thm 8.4 [thm:rate]: first-order rate of the M_F gap, halving per dyadic step, explicit constant | new (none found) | Second-order error terms of partition bounds in stochastic programming may be related; not checked | low |
| Prop 9.2 [prop:load_factor] (i): load factors = inf over ⟨q,w⟩ = 1 | known tool | Ray/support duality (Rockafellar §13) | — |
| Prop 9.2 (ii), (iv): certified factor, two SOCPs via u_i = b·c_i; attained by a compatible measure | new application of a standard substitution | Perspective substitution (standard). Applied to the intersection over compatible measures; no precedent found. | low–medium |
| Prop 9.2 (iii), (v): upper load factor (one SOCP, primal and dual) and the hold / slip / undecided rule | new application | Frank–Wolfe membership via a support oracle is standard (not cited yet) | low |
| Prop 9.2 (vi): multi-contact certified and upper factors | new (certified form) | The plug-in sum is in Costanzo 2020 eq. 42 | low |
| Value of the CoP (M_T vs M_F) in the fixed frame (numerical) | new empirical result | — | — |

The CoP-referenced M_F results of the October draft (Prop 7.1, Thms 7.2 / 7.3, Prop 7.4) were removed in the rewrite; see `note_fixed_frame.md`.

**Do not claim as new:**
- Prop 3.2, Lemma 3.4, Thm 4.2, Cor 4.3, Thm 4.4, Cor 4.5, Example 4.7;
- refinement monotonicity and the atom counts;
- vertex spreading for one patch;
- the concentrate step at known centroids;
- plug-in limit surfaces from tactile data;
- summing plug-in capacity over fingers;
- the support-function/dissipation identity;
- grid-LP computation over convex pressure classes (Huang LP 25);
- the ray/support identity and the perspective substitution as tools.

`stage2_contributions.md` keeps the full list.

## 6. Alexander–Maddocks and Huang et al. versus our bounds (Stage 1c)
This section checks five claims from the user's reading, with ChatGPT, against the full texts.

| # | Claim | Verdict | Evidence |
|---|---|---|---|
| 1 | The support function of W is the Coulomb dissipation; W = ∂D(0); −w_fric ∈ ∂D(v) | **Correct, and established** | AM eq. 7: D(v) = ∫‖A(x)v‖dμ, with dμ = μ(x)P(x)dx. AM eq. 10: the gradient condition. Huang eq. 7 is the same with uniform μ. W = ∂D(0) because D is sublinear (Moreau 1979, cited by AM; Goyal §8). Prop 3.2 is the case dμ = μ dν_N, about a fixed reference point. |
| 2 | They bound motions; we bound extremal dissipation | **Correct** | AM eq. 20 gives the ICR set over all measures. Huang Def. 1: ω is feasible if some pressure with the known CoP gives zero moment. Huang's g = ∂_ω‖Av‖ (eq. 12), so the motion test is the same class of moment problem, with the derivative integrand. The extremes of D do not determine its argmin set. |
| 3 | Huang ≈ M0 with extra convex constraints | **Mostly correct** | The class is exactly M0, over a discretized R. Thm 2 holds for any convex class with known CoP. The experiments use only 0 ≤ p_i ≤ U (eq. 26). |
| 4 | AM's bipods concern motions; our three atoms concern support values | **Conclusion correct, attribution partly wrong** | AM Thm 6 holds *because* the first moment is free; with it, Mason gets tripods. AM need a point inside a convex hull, where a connectedness version of Carathéodory (Lemma 8) lowers the count. We need a boundary value, where it does not. Three atoms can be necessary: an equilateral triangle with the CoP at the centroid under pure torsion. The unique maximizer is the 3-vertex measure, with value R·f_N, versus ≤ (2/3)R·f_N for any two-point load through the centroid. |
| 5 | Under M_F, CoP-referenced envelopes are not envelopes of one velocity field | **Correct** | (a, b) referenced at c[ν] gives a different velocity field for each ν. Changing the frame shears the integrand: g(x; q, o) = g(x; (a + bJ(c − o), b), c) (Goyal §12(3)). With c known (M0, M_T) the frames are equivalent; under M_F they are not. Yann's review of 2026-11-04 made the fixed reference primary throughout (`note_fixed_frame.md`). |

**What AM and Huang do not imply:**
- continuum-exact taxel reductions (Thms 6.1, 7.1, 7.2) with half-open taxels;
- the information preorder and the first-order rate of tightening (Section 8);
- the certified and upper load factors (Section 9);
- the robust extension.

These use standard moment-problem arguments, so the novelty rests on exactness and tractability, not on new tools.

**Atomic extremizers (expected objection).**
- Our extremal measures are point masses at vertices.
- AM §7 concede that their bounds are weak because of "extreme and perhaps pathologic" measures. Huang add a density cap U (eq. 26) for this reason.
- A pressure-capped variant (0 ≤ p ≤ U) is a natural extension and a likely reviewer request.

**Validation precedents.**
- AM (IJRR) is theory and numerics only.
- Huang (RSS) adds a pulling planner and 80 hardware trials (76 kept; §V-C, §VI-B).
- Since M0 is prior art, theory plus numerics alone would be weak for RA-L.

## 7. Arguments for and against significance (from the literature)
**For**
- The gap is clear and verified on full texts. Tactile pipelines reconstruct one pressure state or fit a parametric limit surface, and then use the capacity as if it were exact. None states what the measurement guarantees.
- The guaranteed (lower) bound is what a safety decision needs. The literature uses hand-chosen margins instead (Costanzo α_s, α_d = 1.1–1.4).
- F/T plus contact geometry (M0) provably certifies no torsion about the CoP (Cor 4.3). Distributed sensing is necessary, which gives a sensor-design argument.
- Exactness despite violating the WKS nesting condition is a clean mathematical point.
- The computation is cheap (one SOCP or LP per bound, two SOCPs per load factor).

**Against**
- M0 re-derives results from 1959–2017. The mathematics is classical throughout.
- The setting is idealized: rigid patch, Coulomb friction, known μ, noise-free taxels. Silicone violates Coulomb under combined loads (Howe–Cutkosky §3).
- Parametric methods (Costanzo) already work well within their family, with a calibrated pad.
- Extremal measures are atomic, which can make the outer bounds loose.

The evidence answering these points (numerics, Drake closed loop) is in `doc/experiments.tex`. The reviewer-response table is in `stage2_contributions.md`.

## 8. Open literature items
- Full texts of Huang–Ziemba–Ben-Tal 1977, Frauendorfer 1988 and Kall 1991. Could any give partition bounds from cell probabilities only (the analogue of Thm 6.1 [thm:MF]), or second-order error terms (the analogue of Thm 8.4 [thm:rate])?
- Lee 1991 (thesis) and Lee–Cutkosky 1991: verify the concentrate step directly.
- Two unverified leads: a "6D friction" paper (2019) and a study of limit surfaces under pressure skew.
- Tactile simulator names (TACTO, Taxim, Tacchi, DiffTactile, TacIPC, TacSL) are from memory. Verify them before citing.
- Coordination with Yann de Mont-Marin about his unpublished D(a) result (Remark 4.6). His review of 2026-11-04 is reflected in `note_fixed_frame.md`; his K = 3 closed form is pending.
- Frank–Wolfe (support-oracle membership, Prop 9.2 remark): add a verified reference before citing.
