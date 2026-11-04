# Stage 2: Scientific story, gap and contributions (revised 2026-11-04)

**Inputs to this revision**
- the consolidated literature review: `literature_review.md`;
- the theory: `doc/main.tex`, Sections 3–9, including the certified load factor;
- the numerical and Drake evidence: `doc/experiments.tex` ("Report §x" below).

The reference-frame decision (Yann's review, 2026-11-04: torques about a fixed point throughout) is in `note_fixed_frame.md`. Theorem numbers below follow the rewritten main.tex. Report numbers follow the rerun of 2026-11-04 (`stage3_validation_plan.md` §5.1).

**Decisions so far**
- The user chose the certification framing (A).
- Yann's role is still undecided. His D(a) result is our M0 upper bound, in the same frame. His review of 2026-11-04 reshaped the formulation (fixed frame, information preorder, homogeneous coordinates), which strengthens the case for co-authorship.

## 1. The story in plain terms
**What a tactile sensor gives.** It tells a robot how hard each small region of a contact is pressed. It never gives the exact pressure field.

**Why that matters.** How much twisting load (torsion) a grip can hold depends on where the pressure sits.
- Pressure at the rim resists twisting.
- Pressure concentrated at one point does not.
- Pure shear does not care: its capacity is μf_N for any pressure.

**What we compute.** We ask what a given measurement *guarantees* and what it merely *allows*. Over every pressure field consistent with the reading, we compute:
- the loads that are certainly held, an inner set;
- the loads that might be held, an outer set.

Both come from small convex programs, and the wrenches and twists are written about one fixed point, so the sets describe physical loads. For a given load we compress this into two numbers: the certified load factor (by how much the load could grow and still be guaranteed), and the upper load factor (beyond which no pressure consistent with the reading can hold it). Together they say whether the load is surely held, surely slips, or cannot be decided from the measurement.

**Four findings follow.**
1. A force/torque sensor alone (total force and CoP) **never certifies any torsion about the CoP**, however hard the grip. Its guaranteed set is exactly the friction disc.
2. Taxels do. The certificate tightens as the taxels get finer: each halving of the taxel size halves the gap between the bounds, to first order, with an explicit constant. Measuring the CoP in addition to the taxel forces matters most for mixed shear–torsion loads.
3. A plug-in estimate (treating the measured pressure as exact) overestimates capacity, so it is unsafe exactly where it matters.
4. In a closed-loop grasp simulation, a controller that squeezes just enough to keep the load certified:
   - never slipped silently;
   - needs no tuning data;
   - flags when it cannot certify the load.

   Estimators tuned on one set of contacts slipped when the contact geometry changed. The price is 16–18% more squeeze than an oracle at 16×16 taxels.

**What the certificate does not do.** It is a statement about one instant. When the load changes faster than the sensing and control loop, a separate temporal margin is needed. The certificate does not provide that margin, and our delay study shows how large it must be.

## 2. The gap
| What exists | Where | What it lacks for our question |
|---|---|---|
| Bounds over pressures with known total force and CoP (M0) | Peshkin–Sanderson 1988; Alexander–Maddocks 1993; Huang et al. 2017; Caron et al. 2015; Madansky / Gassmann–Ziemba | They use coarse data only, and mostly bound motions rather than capacity. With M0, guaranteed torsion about the CoP is zero (Cor 4.3), so these bounds cannot support a torsional grasp decision. |
| Capacity from a measured or assumed pressure | Plug-in: Bicchi 1988, Howe–Cutkosky 1996. Parametric families: Xydas–Kao, Cirillo 2017, Costanzo 2020/23. Identified radius: Arslan Waltersson 2025. | One pressure state or family is treated as exact. No statement of what the measurement guarantees, and safety comes from hand-chosen margins (Costanzo α = 1.1–1.4). |
| Slip detection and prediction | Yuan, Dong, Kolamuri, Veiga, Griffa | They react to slip, or predict it without guarantees. |
| Partition bounds in stochastic programming | Gassmann–Ziemba Prop 5.1; Birge–Wets; Wiesemann–Kuhn–Sim | They assume known cell means, or a nesting condition that taxel partitions violate. |

**The gap, stated precisely.** No method bounds the frictional capacity of a planar patch (shear and torsion) over **all normal-pressure fields consistent with distributed tactile measurements**. None turns such bounds into a **load-admissibility decision that inherits the guarantee**.

## 3. Positioning and framing
**Frame.** The paper gives measurement-conditioned bounds on frictional dissipation (the support function of the limit surface).
- It is the *capacity* counterpart of the motion bounds of Peshkin–Sanderson, Alexander–Maddocks and Huang et al.
- Their setting (M0) is the known baseline.
- Tactile sensing is the measurement model that produces the new cases (M_T, M_F).
- The paper is not a slip-detection paper and not a new friction model.

**Framings considered.**
- **A. Certified shear–torsion capacity from tactile normal-force measurements.** Chosen. Theory, numerics, Drake closed loop and a small hardware study.
- **B. Information limits of tactile sensing** (resolution law, value of the CoP): a section of A; too weak alone.
- **C. Slip prevention with certified margins:** the S3 closed loop is a first instance. A full version (several contacts, hardware campaign) is a T-RO follow-up.
- **D. Patch-contact model for simulation and MPC:** later, likely joint with Yann.
- **E. The initial "what does a measurement tell us" framing:** not submittable as is.

**Ranking:**
1. A with the load factor, two-pad grasp and robustness (RA-L target).
2. A without robustness.
3. B alone.
4. C and D later.

## 4. Defensible claims
Strength: **S** = proven or verified; **M** = supported by simulation or numerics, with stated limits; **P** = planned, not yet established.

| # | Claim | Evidence | Strength |
|---|---|---|---|
| C1 | **Formulation.** Guaranteed (inner) and possible (outer) tangential wrench sets of a planar patch about a fixed point, conditioned on linear normal-force measurements. Every bound is a GMP, the possible set is convex, and measurement operators are compared by an information preorder. M0 recovers Peshkin–Sanderson / Huang as a special case, and F/T + CoP provably certifies no torsion about the CoP (exact guaranteed set). | Defs 3.1, 3.10, 3.14; Prop 3.11; Thm 3.16; Cor 4.3; Report §4.3 (F1) | S |
| C2 | **Exact, tractable taxel bounds.** M_F: closed forms (sum over taxels of the min / max speed). M_T: SOCP lower bound in the local first moments, LP upper bound with ≤ r+2 atoms. All exact over the continuum with half-open taxels, although taxel partitions violate the WKS nesting condition. M_T generalizes the partition bounds with known cell means. | Thms 6.1, 7.1, 7.2; Lemmas 5.6, 5.7; Report §4.1 (grid-LP agreement) | S |
| C3 | **Certified and upper load factors.** The largest guaranteed scaling of a load is the minimum of two SOCPs, attained by a compatible measure (tight). The upper factor, beyond which no compatible pressure holds the load, is one SOCP (convexity of the possible set), attained by a most favourable corner measure. Together: hold / slip / undecided. Both add over contacts for a grasp. Solve times are tens of milliseconds at 16×16. | Prop 9.2; Report §4.6 (s_up) | S (theory), M (runtime) |
| C4 | **Resolution law and value of the CoP.** The gap is ≤ μ\|b\|f_N max diam for M_F and M_T. To first order the M_F gap is μ\|b\| h ∫(\|u_1\| + \|u_2\|) dν, so it halves with each dyadic refinement; the bound is sharp up to √2. On the field population, the certified pure-torque capacity grows from about a quarter of the truth at 2×2 to 0.92 at 32×32. The CoP narrows the bounds by 30–34% for a mixed twist at every resolution from 2×2, and by 2–12% for a rotation about the CoP. | Props 8.1–8.3, Thm 8.4; Report §4.4–4.6 | S (bound, rate), M (numbers) |
| C5 | **Certification vs plug-in.** Spreading taxel forces uniformly per taxel overestimates the capacity for most fields, and for pure torque always (convexity of the integrand). The certificate is below the truth by construction. | Report §4.5–4.6 | M |
| C6 | **Closed-loop soundness and its price** (Drake, two compliant pads, three pad families). Shown: 0 silent slips in 2160 certified episodes; infeasibility flagged before any slip; squeeze 1.18× the oracle at 16×16 vs 3.1× at 2×2. Against tuned nominal estimators the certificate costs 0–17% more squeeze, but it needs no calibration. Margins tuned on flat pads slip in 35–75% of curved-pad episodes. **Not shown:** a dynamic guarantee; validity on real silicone. | Report §5.4 (S3) | M |
| C7 | **Robust extension.** Bounds and load factor under interval taxel forces and an interval μ, and the resolution-vs-noise trade-off (F4). The perspective substitution may not carry over when F_i is uncertain (F_i multiplies a), so another algorithm may be needed. | Not yet derived; Report §7.1 | P |
| C8 | **Scope of a static certificate** (insight, stated as a limitation). With the load previewed, sensing delay up to 200 ms has no effect. With the load measured, every policy slips at the start of a ramp, the oracle included: the load grows during the hold and the actuator lag. A static certificate needs a separate temporal term covering the load change over delay plus loop lag. Certified policies survive only in proportion to their conservatism. Also: with a free object, offset normal forces create an out-of-plane couple that the planar certificate ignores. | Remark 9.3 (scope); Report §5.5 (S4), §5.4 (scene findings) | M |
| — | **Hardware model-adequacy test** (D1). Does the measured capacity on a GelSight gel lie in [lower, upper]? | Planned; Report §7.2 | P |

### Do not claim as new
- Prop 3.2 (support = Coulomb dissipation; Alexander–Maddocks eqs. 7, 10; Goyal §8).
- The fixed reference point and Varignon's formula (Lemma 3.4): the classical convention, and Yann's.
- Thm 4.2, Thm 4.4, Cor 4.5 and Example 4.7: M0 is Peshkin–Sanderson, Huang et al., Madansky, Gassmann–Ziemba, and Yann's Prop 4.4 (same frame).
- The information preorder as an idea (from Yann's review); only its use here is ours.
- The ≤ 3-atom count and the refinement monotonicity (Birge–Wets Thm 6.9, Convergence 3.7 / 4.6).
- Vertex spreading for one patch (Caron et al. Prop 1; Yann's eq. 33), and the concentrate step at known centroids (Lee 1991, via Howe–Cutkosky).
- Plug-in limit surfaces from tactile pressure (Bicchi 1988; Howe–Cutkosky Table 2).
- Summing plug-in capacities over fingers (Costanzo 2020 eq. 42).
- Grid-LP computation over convex pressure classes (Huang LP 25).
- The ray/support identity and the perspective substitution as tools. What is new is applying them to the intersection over compatible measures.

## 5. Reviewer objections
| Objection | Response | Evidence | Residual risk |
|---|---|---|---|
| **"The mathematics is classical."** | Concede it and cite it in full. The contribution is the measurement model (taxels), exactness despite violating the WKS nesting condition, the two-sided load factor as convex tests, the first-order rate, and the closed-loop evidence. | Literature review §5; Thms 7.1/7.2, 8.4; Prop 9.2 | low if handled openly |
| **"Torsional capacity is classically about the CoP; why a fixed point?"** | The load on an object is known about a fixed point; about the CoP of each candidate measure, the union of wrench sets mixes frames when the CoP is unknown (Remark 3.5). Statements about the CoP are recovered by Varignon when it is measured (Cor 4.3). | main.tex Rem 3.5, Lemma 3.4 | low |
| **"Too conservative to be useful."** | The cost falls with resolution, from ~3× the oracle squeeze at 2×2 to 1.18× at 16×16, with 0% infeasible from 8×8 up. The alternative estimators are not conservative; they are unsafe. | Report §4.6, §5.4 | medium |
| **"A tuned plug-in or contact-area baseline is cheaper."** | True: 0–14% cheaper on a representative set (the certificate costs 0–17% more). The case for the certificate is robustness, not efficiency. It needs no calibration set, flags infeasibility, and stays sound under a shift of contact geometry. Tuned margins then slip in 35–75% of episodes. State the price and the shift result side by side. | Report §5.4 (tuned-margin transfer) | medium |
| **"The pressure distribution is almost irrelevant"** (Costanzo 2020) | That holds within an axisymmetric family with τ_max calibrated on the pad (k ∈ [2.48, 4.82], ≤ 2%). Over pressures consistent with taxel data, including edge and partial contacts, plug-in and certified capacity differ by large factors. Uniform pressure over the pad fails even at a margin of 1. | Report §4.5, §5.4 | medium |
| **"Extremal measures are pathological point masses."** | AM §7 concede this for their own bounds, and Huang add a density cap. The lower bound is attained by point loads per taxel and is what safety needs. The outer bound could be tightened with a cap 0 ≤ p ≤ U, a possible extension. | Literature review §6 | medium |
| **"Your simulation implements Coulomb friction, so it is circular."** | Agreed for the friction law, and we do not claim to validate it. Drake tests what the theory does not model: the pipeline (sensing → certificate → command), compliant pads, gripper lag, load dynamics and the two-pad split. It also exposed real failure modes: a simulator's default regularization violated the certificate; the free-object couple; the temporal margin. Friction on silicone is the hardware question. | Report §5.1–5.5 | low |
| **"Static certificate, dynamic task."** | Agreed and quantified. With preview, delay is harmless. Without it, a temporal margin covering load growth over the delay plus loop lag is required, separate from the certificate. | Report §5.5 (S4) | medium |
| **"Soft fingers violate rigid Coulomb"** (Howe–Cutkosky §3) | Treat the hardware study as a model-adequacy test: calibrate μ under combined loads, report violations, and restrict claims to soundness relative to the model where needed. | Plan, hardware section | **high** until tested |
| **"Taxels are noisy or uncalibrated."** | The robust extension (C7) gives interval bounds. Until then, state the noise-free scope. | — | medium |
| **"μ uncertainty dominates."** | μ scales all bounds linearly, so an interval μ is a scalar factor. Report the μ and pressure uncertainties separately. | — | medium |
| **"Two-pad planar certificate with a free object."** | The planar model assumes out-of-plane moments are carried without friction. S3 shows that offset normal-force centres on a free bar consume friction. Hardware must constrain the object or keep the CoPs aligned; this is stated as a limitation. | Report §5.4; Prop 9.2(vi) assumption | medium |
| **"Only one sensed finger on the robot."** | Prop 9.2(vi) handles an unsensed pad: it contributes its worst case over the pad. This costs about 2.4× the oracle squeeze in simulation, which is still sound. | Report §5.4 | low–medium |
| **"No hardware."** | Planned (D1, plus a gate on recorded pressure maps). The validation plan has the protocol. | Plan | high until done |
