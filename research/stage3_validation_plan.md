# Stage 3: Validation strategy and publication plan (revised 2026-10-22)

This file holds the plan and its status only. Results and their analysis are in the experimental report `doc/experiments.tex` ("Report §x"). The claims C1–C8 are defined in `stage2_contributions.md`, and the literature in `literature_review.md`.

**Status legend:** ✅ done · ⏳ in progress · ☐ planned · ✗ dropped (with the reason)

**Standing decisions**
- Concept A (certification framing) with the strategy A + B + small C, approved 2026-10-16.
- Hardware not started. Rig: GelSight on an ATI wrist sensor, with no gripper (design §9, 2026-10-22).
- Yann's role undecided.
- Target: RA-L.

## 1. What must be validated
| Claim | Validated by | Status |
|---|---|---|
| C1 formulation; F/T never certifies torsion | Theory (Thm 4.3, Remark 9.5); F1 | ✅ |
| C2 exact taxel bounds | Theory; reduced vs grid-LP checks; tests | ✅ |
| C3 certified load factor (SOCP, tight, multi-contact) | Prop 9.4 (proof sketch in main.tex); `pfb/certify.py` tests; runtime | ✅ (a full proof write-up is still to do) |
| C4 resolution law and value of the CoP | Props 8.1–8.3; F2; load-factor study | ✅ |
| C5 certification vs plug-in | F3; load-factor study | ✅ |
| C6 closed-loop soundness and its price | Drake S2, S3 | ✅ in simulation; ☐ hardware demos (H6) |
| C7 robust extension | Theory + F4 | ☐ |
| C8 scope of a static certificate | Drake S4; S3 scene findings | ✅ in simulation |
| Model adequacy on a real gel | Hardware H2–H4 (calibration, T1/T2 single-contact tests); demos H6 | ☐ |

## 2. Hardware and what it measures (revised 2026-10-22)
| Source | Gives | Information model |
|---|---|---|
| ATI F/T sensor at the wrist, under the GelSight (1 kHz) | Full 6-D contact wrench of the sensed contact. f_N, f_T, the torsion, and the CoP of the normal force (planar contact at a known offset h from the sensor origin: x_c = (h f_x − M_y)/f_z, y_c = (M_x + h f_y)/f_z, after taring the sensor and gel weight per orientation) | M0 exactly, plus the measured tangential load |
| GelSight Mini image (check: frame rate about 25–30 fps, sensing area, gel thickness, markers) | Contact mask, surface normals and depth map (the existing pipeline) | Shape of the normal-force distribution, only through a calibrated depth → pressure map (§9.2). Taxel forces F_i come from integrating it over a k×k grid and scaling to the ATI's f_N. |
| ✗ FeelAnyForce (arXiv 2410.02048) | Resultant 3-D force at about 25 Hz | Dropped: the ATI gives the full wrench at 1 kHz and works better in the user's earlier tactile-servoing experiments |

**Key messages**
- F/T plus contact geometry (M0) never certifies torsion: the lower bound is μf_N‖a‖ (Thm 4.3).
- The contact mask does not help when the contact is convex: if the CoP lies in the mask, the point load at the CoP is compatible and certifies no torsion. A non-convex contact (two separated bosses) is an exception.
- Distributed normal-force information is required, so the depth → pressure calibration is on the critical path. Its residuals define the intervals of the robust extension (C7).

## 3. Strategies
| Strategy | Content | Status |
|---|---|---|
| **A. Theory and numerics** | Verifies the analysis; not independent validation | ✅ nominal; ☐ robust |
| **B. Realistic pressure fields and simulation** | Analytic contact-mechanics families through `pfb.from_pressure` (primary); Drake hydroelastic grasp scenes (S1–S4) | ✅ |
| **C. Hardware** | GelSight Mini + F/T; the only independent physical check | ☐ |
| ✗ Tactile simulators (TACTO, Taxim, Tacchi, DiffTactile, TacIPC, TacSL; names unverified) | — | Dropped. The mechanics-based ones implement Coulomb friction, so checking slip against the bounds would be circular. They cannot test Coulomb adequacy on silicone, and they would need recalibration on the gel anyway. |
| ✗ MuJoCo | — | Dropped: its torsional friction is a lumped coefficient with no pressure field. |

## 4. Methods compared (baselines)
Definitions are in Report §3.

| Method | Literature | Where | Status |
|---|---|---|---|
| Oracle (true capacity of the current contact) | — | `pfb` truth; `sim/policies.py` | ✅ |
| Certified M_T k×k, M_F 16×16, one pad sensed | main.tex Sections 6, 7, 9 | `pfb/certify.py`, `sim/policies.py` | ✅ |
| M0 bounds | Peshkin–Sanderson; Huang et al. | `pfb.reduced` | ✅ (numerics) |
| Plug-in (uniform pressure within each taxel) | Bicchi 1988; Howe–Cutkosky Table 2 | `pfb.plugin_uniform`, `sim/policies.py` | ✅ |
| Full-resolution depth plug-in (the calibrated pressure map taken as exact) | Reconstruction approaches (Ma et al. 2019; Sferrazza–D'Andrea 2019) | — | ☐ hardware H4 |
| F/T + contact mask (uniform over the measured contact area) | Classical limit-surface assumption (Howe–Cutkosky Table 1) | `sim/policies.py` | ✅ |
| Uniform over the pad (F/T only) | — | `sim/policies.py` | ✅ |
| Costanzo axisymmetric parametric model (k = 4; δ, γ calibrated on a training split of the torsion slides) | Costanzo 2020 | — | ☐ hardware H4/H6 |
| Ellipsoidal limit surface | Howe–Cutkosky; Xydas–Kao | — | ☐ optional |
| Probing-based radius identification | Arslan Waltersson 2025 | — | ✗ discussed only (needs active probing) |

## 5. Numerical studies (strategy A/B, analytic fields)
| Item | Content | Status | Report | Main finding |
|---|---|---|---|---|
| Verification | Reduced SOCP/LP vs grid LPs; orderings; counterexample; unit tests | ✅ | §4.1 | Reduced bounds agree with the grid LPs and orderings hold. Same total force and CoP, torsional support 0 vs 0.5. |
| Field population | 7 contact-mechanics families × 3 fields (Hertz, Xydas–Kao, flat punch, ramp, partial, line, asperities) | ✅ | §4.2 | Replaces the synthetic Gaussian loads of 2026-10-16 |
| F1 wrench sets | Inner/outer sets of M0 / M_F / M_T on a partial tilted contact | ✅ | §4.3 | M0 inner set is a force segment (no torsion). The taxel sets close in on W(ν) with resolution. |
| F2 resolution and value of the CoP | Bound/true vs k×k, M_F vs M_T, gap vs Prop 8.3 | ✅ | §4.4 | Gap ∝ taxel diameter, nearly attaining the Prop 8.3 bound. Torsion lower/true 0.30 (2×2) → 0.84 (16×16) → 0.94 (32×32). The CoP gains 2–13% up to 16×16 and 26–30% at 32×32. |
| F3 certification vs plug-in | Plug-in/true vs certified/true | ✅ | §4.5 | Plug-in is above the truth for all 21 fields at every resolution (worst ×2.5 at 2×2, ×1.03 at 16×16). The certificate is never above the truth. |
| Load factor + runtime (example 10) | Certified/true load factor, plug-in, solve time | ✅ | §4.6 | Median certified/true pure-torque capacity 0.23 (2×2), 0.84 (16×16), 0.94 (32×32). One pad: 10–24 ms up to 16×16, ~80 ms at 32×32. |
| F4 resolution vs noise | Taxel intervals from pixel noise; an interior optimal resolution is expected | ☐ | §7.1 | Needs the robust solver |
| F5 hardware gate | Certified minimal press force vs resolution on recorded GelSight maps of the demo objects | ☐ | §7.2 | Phase H5 (simulated analogue in S3) |
| F6 runtime table | SOCP/LP times, r = 4 … 1024 | ⏳ | §4.6 | Load-factor times measured; the full table is not done |
| F7 M_F sandwich (optional) | Sweep ≤ exact ≤ Prop 7.4 vs resolution | ⏳ | `note_fixed_frame.md` | Gaussian-load check only (Prop 7.4 is 1.21–1.61× the sweep). Depends on the reference-frame decision. |

## 6. Drake simulation (strategy B)
The scope, decided 2026-10-21, is to test the pipeline (sensing → certificate → command → outcome) and the effects the theory does not model. The friction law is not tested: Drake implements Coulomb friction per contact face (Masterjohn et al. 2022).

| Study | Question | Status | Report | Main finding |
|---|---|---|---|---|
| S1 smoke | Sensing adapter: faces → measure, totals match | ✅ | §5.2 | Face forces add up to the weight and to Drake's resultant |
| S2 break-away | Does the break-away match s_true, and is the certificate ≤ break-away? Solver sensitivity. | ✅ | §5.3 | Lagged/similar solvers with stiction ≤ 1e-5 give 0.992–1.001 of s_true, certified/observed 0.915–0.923. Drake's default tolerance makes the certificate look violated (1.025). SAP holds 36% above Coulomb, so it is excluded. |
| S1 static on grasp-derived contacts | Static trends on Drake fields | ✗ | — | Dropped: S2/S3 use Drake fields directly, and F2/F3 already cover the static trends |
| S3 closed-loop grip | Does the certificate hold in closed loop, and at what price? | ✅ (v2) | §5.4 | 0 silent slips in 2160 certified episodes. 16×16: 1.18× the oracle squeeze, 2×2: 3.1× with 13% flagged. Tuned baselines are 0–14% cheaper but slip in 35–75% under a geometry shift. |
| S4 sensing delay | How much delay does the S3 loop tolerate with the S3 margins? | ✅ | §5.5 | With the load previewed, flat up to 200 ms. With the load measured, every policy slips at ramp onset (oracle 100% even at 0 ms). The one-pad certificate is silent-free to 100/50/0 ms at 1/2/4×. A separate temporal margin is needed. |
| ✗ Full re-run of F2/F3 on Drake fields | — | ✗ | — | Not informative beyond F2/F3 |

**Settings fixed by these studies:**
- solver: lagged, stiction tolerance ≤ 1e-5 (1e-6 used);
- a force budget per seed (pad working range);
- the oracle's dynamic margin m_dyn = 0.05 (calibrated with preview);
- planar joint for the bar.

## 7. Decision log (protocol changes)
- **2026-10-20** — Field population replaces Gaussian blobs. Drake is optional; tactile simulators are dropped.
- **2026-10-21, stress test (ChatGPT review, each point checked):**
  - Capacity along a load is the *load factor*, not a support value, so F2/F3 were relabelled.
  - The controller certifies the demanded wrench, not the measured reaction.
  - Two pads: Minkowski sum in a common frame. An unsensed pad contributes its worst case over the pad.
  - Flat object faces only; side walls are monitored (> 0.5% rejected).
  - Effort–failure Pareto curves.
  - Rejected: "taxels finer than the mesh tighten the bounds artificially".
- **2026-10-21** — Exact load-factor certificate: two SOCPs, replacing the Lipschitz grid search, which over-certifies by up to about 7%. Appended to main.tex as Section 9.
- **2026-10-22, S3 review (ChatGPT):**
  - Three outcomes, a force budget instead of exclusion, and matched seeds.
  - A stronger baseline (contact mask).
  - Tune/test splits by seed and by geometry.
  - The oracle margin made explicit (m_dyn).
  - Rejected wording: "the oracle's slips show static admissibility is insufficient". The diagnosis is zero margin at a boundary.
- **2026-10-22, S4 design** (from the user's proposal, critically assessed):
  - Kept: the question, the fixed S3 margins, the outcomes and the envelope.
  - Added a second mode, P vs M: the S3 loop previewed the load, while D1 must measure it.
  - Dropped: the control-rate axis (equivalent to a delay; 50 Hz infeasible for MT16; it confounds the lookahead), the slow load rate and scenario B.
  - Added: the one-pad and contact-mask policies, and a pre-stated prediction.
- **2026-10-22, hardware design** (from the user's rig and questions):
  - No gripper: the robot's GelSight on the ATI, with a passive pad on a vertical bar.
  - FeelAnyForce dropped (the ATI gives the full wrench at 1 kHz).
  - Depth → pressure calibrated with statically determinate indenters and scaled to the ATI.
  - μ from pure shear only, with torsion held out (replaces "lowest μ under combined loads").
  - Single-contact tests T1/T2 before any demo.
  - D-dial added; D1 run in Config V before the two-gel Config D.

## 8. Robust extension (theory + F4) ☐
1. **Model.**
   - Interval taxel forces F_i ∈ [F_i⁻, F_i⁺] with consistent totals.
   - A convex set for the first moment under M_T.
   - μ ∈ [μ_lo, μ_hi], which is only a scalar factor.
2. **Lower bounds and load factor.** Derive the robust version of Prop 9.4.
   - **Open risk:** with F_i uncertain, F_i multiplies a in ‖F_i a + bJ(F_i c_i − F_i o)‖. The perspective substitution u_i = b·c_i may not keep the problem jointly convex.
   - Check whether w_i = F_i c_i with F_i as a variable stays convex; otherwise find an alternative (e.g. a decomposition over the sign of b plus a bilinear relaxation).
3. **Upper bounds:** expected to remain an LP. Verify.
4. **Implementation** in `pfb`, with tests in the style of `tests/test_certify.py` (tightness, brute force).
5. **F4:** pixel noise aggregated into taxel intervals. The nominal gap shrinks like 1/k while the summed interval widths grow like √r, so an interior optimal resolution is plausible but not assumed.
6. **Interval model for GelSight pseudo-taxels** (depth → pressure), with a sensitivity analysis. This links to the hardware.

## 9. Hardware validation ☐ (design revised 2026-10-22)
**Purpose.** An independent physical test of the Coulomb patch model the certificate assumes, plus a downstream use.
- Soundness on silicone is *not* presumed. Howe–Cutkosky §3 report slip below the Coulomb prediction under combined loads.
- The campaign is a **model-adequacy test**, and violations will be reported with the derating they imply.

**Set-up (reuses the tactile-servoing rig, no gripper).**
- The robot carries the GelSight on top of the ATI wrist sensor. The existing ROS hybrid force–position controller (IK, velocity mode) and the ATI + GelSight pipeline (normals, contact mask, depth) are reused; the control stack itself is out of scope here.
- **Single-contact tests:** an indenter is clamped to the table, and the robot presses and moves the sensor against it.
- **Holding demo:** the object is held between the robot's GelSight and a passive gel on a fixed vertical bar (§9.6).

### 9.1 Design rules (from theory and simulation)
1. **All of the contact inside the field of view.** Otherwise the taxel forces do not add up to the ATI's f_N.
   - Objects therefore touch the gel only through small raised **bosses with flat tops**, smaller than the view. A flat top keeps the patch planar, which the theory assumes; domes only with shallow indentation.
   - If some force must fall outside the view, treat the outside region as one more, unsensed taxel with mass f_N − Σ F_i. The M_F / M_T bounds handle it exactly.
2. **Gentle tangential loading** (brittle gel and coating).
   - Fillet every edge (≥ 1 mm) and use smooth surfaces: SLA resin, or sanded or machined parts. FDM layer lines give anisotropic friction and can cut the gel.
   - Low f_N, and short slides with an automatic abort at gross slip, detected from the imprint motion in the image or an F/T plateau.
   - Debug on the old gel *mounted on the sensor*; use a spare gel for final runs.
   - Inspect and photograph the coating before and after each session: wear changes both μ and the optics.
3. **Slow, continuous loads** (S4). No step loads: a step is the worst case for a static certificate.
4. **Gravity in the grasp plane** for the holding demo: the sensor normal is horizontal and the bar vertical.
   - Hang the load in the mid-plane between the pads, at in-plane lever arms.
   - Put coaxial bosses on both faces, to avoid the out-of-plane couple seen in S3.
5. **Offline first.** Calibration, μ and the adequacy tests are analysed offline from synchronized logs (ROS bags) with `pfb`.
   - Reuse `pfb.certify.load_factor_lower` / `load_factor_true` and `pfb.TaxelGrid`.
   - Reuse the sim's taxel binning (`sim/sensing.py`, `sim/policies.py`), with pixels as point loads.
   - Closed loop only in the demos.
6. **Pre-registration.** Before each campaign, write down the hypotheses, the analysis and the exclusion rules, as for S4.

### 9.2 Normal-force distribution from the GelSight (answers: depth as a proxy? calibration? downsampling?)
**Division of labour.**
- The ATI gives f_N and the CoP exactly (M0).
- The GelSight only needs to give the *shape* of the distribution, i.e. the taxel force fractions.

**Pipeline per frame:**
1. depth d(x) and contact mask;
2. p̂ = K(d) inside the mask (calibrated map, below);
3. integrate over the cells of a k×k grid on a fixed centred square footprint → F_i;
4. scale so that Σ F_i = f_N (ATI).

M_T uses the ATI CoP; M_F does not need it.

If the ATI CoP falls outside the compatible CoP set of the F_i (Prop 5.6), the M_T problem is infeasible. That flags an inconsistency between the depth model and the ATI, which makes it a built-in calibration check.

**Depth is a usable proxy, but it needs calibration.**
- Silicone is nearly incompressible. The local (Winkler) relation p ∝ d is only a first approximation: under a thin bonded incompressible layer, pressure is non-local in depth. (Thin-layer contact mechanics; find and verify a source before citing.)
- Photometric-stereo depth has low-frequency integration bias.
- The gel spreads depth beyond the true contact, so mask it out.
- Illumination is non-uniform across the view.
- The gel creeps (viscoelasticity), so calibrate at a fixed dwell time.

**Calibration protocol: statically determinate indenters.**
- Printed indenters with 1, 2 or 3 bosses (3 non-collinear) at known positions. The ATI's (f_z, M_x, M_y) determine each boss force *exactly*, which gives per-region ground truth without pressure film.
- Data:
  - each indenter at several forces;
  - at several positions across the view (spatial uniformity);
  - loading and unloading;
  - a fixed dwell.
- Fit and compare three maps by least squares:
  1. linear Winkler;
  2. power law p = κ d^α;
  3. a small convolution kernel p = K ∗ d.
- Validate on held-out shapes (discs, rings, bars):
  - total-force error (before scaling);
  - CoP error against the ATI;
  - per-boss force error.
- **Output:** an error budget per taxel size, which gives the interval widths [F_i⁻, F_i⁺] for the robust extension (§8). Until that exists, report the sensitivity of the nominal certificate to F_i perturbations within these residuals.
- Optional spot check of the spatial distribution: pressure-sensitive film (Fuji Prescale low-pressure grades; check the range against the expected 10–100 kPa), in normal presses only.

**Downsampling.**
- Emulate k ∈ {1, 2, 4, 8, 16, 32} from the same frames; rectangular taxels are allowed by the theory.
- Taxels smaller than about the gel thickness are correlated by elastic spreading. This sets the useful resolution and feeds F4.

### 9.3 Friction coefficient (answer: how to choose μ)
**Calibrate on pure shear only.**
- Pure-shear capacity is μf_N for *any* pressure distribution (Howe–Cutkosky §2.3). Shear slides therefore measure μ independently of the depth → pressure calibration.
- Protocol:
  - the indenter is clamped and the robot holds f_N;
  - slow tangential slide, abort shortly after gross slip;
  - μ = |f_T| / f_N at gross slip (ATI).
- Sweep:
  - f_N over the operating range (silicone friction often depends on pressure);
  - two or three speeds (rate effects, Costanzo 2020 §V-C);
  - dwell time before sliding (static friction of elastomers can grow with contact time; standardize it);
  - indenter material.
- **μ used by the certificate:** the minimum over the operating range, with its spread.
- **Drift:** a reference shear test at the start and end of every session; log temperature, humidity and gel ID.

**Torsion and combined loads are held out as the test, not used for calibration.**
- The earlier rule ("lowest μ under combined loads") would calibrate on the test data.
- If torsion falls below the lower bound with the shear μ, that is the Howe–Cutkosky effect. Report it as the derating factor needed.

**Generating torsion with the existing indenters: yes.**
- The robot holds f_N by force control and rotates about the sensor normal. If the sensor normal is along the flange axis (check the mount), this is the last wrist joint alone.
- Rotating about an axis offset from the CoP gives combined loads. The offset is the instantaneous centre of rotation p, so each trial selects one direction q of the support function, h = μ|b|∫‖x − p‖dν.

### 9.4 Model-adequacy tests (single contact, indenter clamped to the table)
**T1, support-value test.** Slow steady sliding at an imposed twist q (known ICR, from the robot kinematics).
- At steady sliding, maximum dissipation gives ⟨w_meas, q⟩ = h(q), with w_meas the ATI wrench about the reference point.
- Check h_lo(q) ≤ ⟨w_meas, q⟩ ≤ h_up(q) for M0, M_F and M_T at each k, using the pressure measured *during* the slide (pressure redistributes under shear).
- Slides must go past the elastic pre-slip of the gel (from imprint tracking) but stay short.

**T2, load-factor test.** Ramp the tangential wrench along a fixed w until gross slip (S2 on hardware), and check s_lo ≤ s_obs ≤ s_up.
- This needs wrench control on the tangential axes and torsion.
- If the hybrid controller only does position on those axes, use a slow position ramp through the gel's compliance; the plateau of the wrench then gives the capacity along the imposed motion (T1).

**Design.**
- Shapes: disc, ring, bar, tilted flat, two bosses, off-centre boss near the edge of the view.
- Two or three f_N levels.
- Four or five twist directions: pure shear, pure torsion about the CoP, ICR at 0.5 / 1 / 2 contact radii.
- Three repeats, about 100 short slides in total.
- Report gross slip, the theory's event, separately from incipient slip.

**Methods compared on the same frames:**
- certified M_T / M_F at k = 2…16;
- M0;
- plug-in per taxel;
- full-resolution depth plug-in;
- F/T + contact mask (uniform over the mask);
- Costanzo parametric model (fitted on a training split).

**Pre-registered hypotheses (outcomes open):**
- **H-a (adequacy):** the measured values lie within the certified bounds, with μ from shear.
- **H-a′ (alternative, Howe–Cutkosky):** torsion and combined loads fall below the lower bound by a measurable factor.
- **H-b:** the plug-ins and the mask method overestimate capacity in a substantial share of trials, most for rim-loaded and partial contacts (F3, S3).
- **H-c:** the certified gap shrinks with k as in F2, until gel spreading limits the useful resolution.

**Outputs:**
- coverage (share inside the bounds);
- size of the violations;
- overestimation rates;
- certified / measured against k.

### 9.5 Gate (F5, before the demos)
- From recorded maps of the demo objects, compute the certified minimal press force against resolution and the plug-in error.
- Proceed if:
  - the 2×2 vs 16×16 gap is ≥ 1.5× (2.6× in S3);
  - the required force stays within the gel's and robot's limits (check the gel's rated load).

### 9.6 Demos
**D-dial (single contact; first).**
- The GelSight presses on a dial whose axle is along the sensor normal. A torsion spring resists rotation, so the load torque grows with the angle and its rate is set by the robot's speed: a **previewed** load (S4 mode P).
- The robot turns the dial through friction with the certified minimal press force.
- Exchangeable boss faces on the dial: disc, ring, off-axis boss for combined loads.
- Pure torsion is exactly where F/T alone certifies nothing.
- Metrics: slip (dial angle vs robot angle, imprint rotation), press force, flags.

**D1 (holding under a growing off-centre load).**
- The object (a plate with coaxial bosses and a hook in the mid-plane at several lever arms) is pressed by the robot's GelSight against a passive pad on the vertical bar.
- A container on the hook is filled slowly: water from a syringe pump (known flow, so previewed), or through an orifice with an inline load cell (measured).
- This gives the preview / measured A/B of S4 on hardware.
- **Config V (validation):** the passive side is a low-friction plate (PTFE or greased glass).
  - All the tangential load then passes through the sensed contact, so the ATI measures it directly and the single-contact certificate is tested in closed loop.
- **Config D (the user's proposal):** an old gel on the bar.
  - The load split between the two gels is statically indeterminate, and the ATI sees only the sensed share. The total load must come from the load cell or the known flow.
  - The passive contact enters the grasp certificate (Prop 9.4(iv)) through its worst case over the *known boss face* on that side, which is much cheaper than "one pad unsensed" over a whole pad.
  - Its μ must be calibrated separately, e.g. by shear slides with a rigid tool.
  - The ATI then reveals the actual load split, a side result.
  - Slip of the object relative to the bar is observed with an external camera and a fiducial.
- **Loop:**
  - certify D + Ḋ·L, with Ḋ from the ATI or the load cell, and L the measured loop latency (tactile frame + processing + certificate + force response); or use the previewed load.
  - Policies: F/T only (refuse or press to the limit), plug-ins, mask-uniform, Costanzo, certified at k = 2 / 4 / 16.
- **Metrics:** slip events (sensed side from the imprint, passive side from the camera), flags, peak squeeze.

### 9.7 Phases
| Phase | Content | Exit criterion | Status |
|---|---|---|---|
| H0 | Bench and safety: mounts (is the sensor normal along the flange axis?), tare per orientation, limits (f_N, tangential, slip abort), session log | Repeatable tare; abort tested | ☐ |
| H1 | Sensor characterization: GelSight rate and latency vs ATI (timestamp a press onset in both streams), depth noise and drift, ATI noise, time synchronization, force-loop response | Δ and loop latency L measured | ☐ |
| H2 | Depth → pressure calibration with determinate indenters (§9.2) | Model chosen; error budget per k | ☐ |
| H3 | μ from pure shear (§9.3) | μ_min with spread and drift | ☐ |
| H4 | Model adequacy T1/T2 (§9.4) | Coverage / violation report | ☐ |
| H5 | Gate F5 (§9.5) | Go / no-go for the demos | ☐ |
| H6 | Demos: D-dial, then D1 in Config V, then D (§9.6) | Slip / flag / squeeze against the baselines | ☐ |

**To check or procure before H0:**
- GelSight Mini specs: sensing area, frame rate, gel thickness, markers, rated load, spare gels;
- the sensor-normal / flange alignment;
- an SLA printer or resin service;
- an inline load cell and amplifier;
- a syringe pump;
- a PTFE plate;
- a torsion spring and dial bearing;
- optionally, Prescale film.

**Lessons carried over from simulation:**
- **The load must be previewed, or certified with a rate term** (S4): measure L first.
- **Free-object couple** (S3): use coaxial bosses and the mid-plane hook, or state it as a limitation.
- **Cost of an unsensed contact** (S3: 2.4× with a whole unsensed pad): reduced in Config D by knowing the passive boss face.
- **Pad range:** monitor the maximal depth (gel bottoming-out, S3).

## 10. Demo options
**Filter.** Pure-shear capacity is μf_N for any pressure (Howe–Cutkosky §2.3). The bounds matter only for tasks that transmit **torsion about the pad normal**.

- **D-dial (first, single contact):** turning a spring-loaded dial through friction with the certified minimal press force (§9.6). It replaces the earlier knob idea (D3) and fits the rig without a gripper.
- **D1 (main, pending the gate):** holding a plate between the GelSight and a passive pad on a vertical bar under a slowly filled off-centre load, first in Config V (low-friction passive side), then in Config D (passive gel) (§9.6). Simulated analogue: S3/S4 scenario A.
- **D2 (riskier):** reorienting a puck on a slippery sheet by pressing from the top.
  - Certificate: h̄_table(q) ≤ h_pad,lower(q) in a common fixed frame.
  - It is a yes/no decision that can flip with resolution.
- **D4 (pivoting): reduced form only.**
  - "Rotates about the pad without translating" is a motion property; support bounds cannot certify it.
  - Feasible variant: a "tactile slip clutch", which certifies the maximum torque transmitted to a partner.

## 11. Publication strategy
**Paper (RA-L), outline**
1. **Introduction and positioning:** capacity counterpart of the M0 motion bounds; gap; claims C1–C8.
2. **Theory:**
   - formulation;
   - M0 as background (cited);
   - M_T / M_F exact bounds;
   - refinement law;
   - certified load factor and multi-contact;
   - robust extension (C7).
3. **Numerics:** F1, F2, F3 and the load factor (one compact figure each, or merged), plus F4 and a runtime table.
4. **Simulation:** S2 (soundness and the regularization caveat, short), S3 (main closed-loop figure), S4 (scope, compact).
5. **Hardware:** depth → pressure and μ calibration; model-adequacy tests T1/T2; gate; demos D-dial and D1.
6. **Limitations:** quasi-static; planar; Coulomb on silicone; temporal margin; free object.

**Figures available now** (`doc/figures/`):
- `measurements`, `vertex_reduction`, `fields`;
- `wrench_sets` (F1), `resolution` (F2), `plugin` (F3), `load_factor`;
- `grip_pareto` (S3), `delay_envelope` (S4).

**Venue**
- **RA-L** with A + B + C and the robust extension.
- **T-RO follow-up:** several contacts, an extensive hardware campaign, set-membership learning from slip events (roadmap P3).

**Software:** open-source `pfb` (certificates, fields, studies) and the Drake scripts (`sim/`).

## 12. Timeline (eight weeks from 2026-10-16)
| Week | Content | Status |
|---|---|---|
| 1 (10-16 → 10-22) | Clarify Section 7 (outer CoP variable, convexity, sweep vs Prop 7.4) | ✅ 10-20 |
| | Literature depth audit and positioning | ✅ 10-20, consolidated 10-22 |
| | Field population, F1–F3, load-factor certificate and Section 9 | ✅ 10-21 |
| | Drake pipeline, S1–S4 | ✅ 10-22 (ahead of plan) |
| | Documentation and visualization of the sim code | ✅ 10-22 |
| 2 | Robust extension: theory and proofs; `pfb` robust solvers; F4 | ☐ |
| 2 | Full proof write-up of Prop 9.4; reference-frame decision for Section 7 | ☐ |
| 3 | H0–H2: bench, sensor characterization, depth → pressure calibration; indenters and objects printed | ☐ |
| 4 | H3–H5: μ, model-adequacy tests T1/T2, gate; pseudo-taxel interval model | ☐ |
| 5 | H6: demos D-dial and D1 (Configs V, D); hardware analysis | ☐ |
| 6 | Writing (paper sections from main.tex + `experiments.tex`) | ☐ |
| 7 | Internal review (Yann), revision | ☐ |
| 8 | Submission | ☐ |

The simulation work, planned for weeks 3–4, is done; that time is now buffer for the robust theory and the hardware.

## 13. Risks and mitigation
| # | Risk | Level | Mitigation |
|---|---|---|---|
| 1 | **Coulomb model unsound on silicone** (Howe–Cutkosky §3) | HIGH | Treat hardware as a model-adequacy test (T1/T2). Calibrate μ on pure shear only and hold out torsion; slow, reported load rates; report violations and the implied derating; restrict claims to soundness relative to the model if needed |
| 2 | Robust load factor not convex (C7) | medium–high | Check the convexity first (week 2). Fallbacks: a relaxation with a certified gap, or interval F_i only in the lower bound via worst-case F_i⁻ if monotone (to be proven) |
| 3 | Tuned baselines are cheaper | medium | Frame the value as robustness (no calibration, flag, geometry shift) and state the price (S3) |
| 4 | Temporal validity (S4): a static certificate fails when the load is measured | medium | Separate the temporal term in the paper; design D1 with a measured Δ and lag and a rate term or slow fill; do not claim a dynamic guarantee |
| 5 | Free-object couple with two pads | medium | Constrain the object or align the CoPs in D1; state it as a limitation (Remark 9.5) |
| 6 | Conservatism at low resolution / unsensed contact (2.4× in S3) | medium | Present it as a resolution / sensing design trade-off; known passive boss face in Config D; check forces against the gel's limit at the gate |
| 7 | Depth → pressure calibration (non-local in a nearly incompressible gel; depth bias; creep) | medium–high | Scale to the ATI's f_N and check the CoP against it; calibrate with statically determinate indenters; held-out shapes; interval model plus sensitivity analysis (robust extension) |
| 11 | Gel tear or coating wear during slides | medium | Filleted, smooth bosses; low f_N; short slides with automatic abort; old gel for debugging; inspection log; spare gels |
| 12 | Load split between two gels is statically indeterminate (Config D) | medium | Config V first; measure the total load (load cell or known flow); the ATI gives the sensed share |
| 13 | μ drift (dwell time, speed, humidity, wear) | medium | Reference shear test at the start and end of each session; standardized dwell; μ_min over the operating range |
| 8 | Simulator regularization contradicting a sound certificate | low (handled) | Report the solver settings and the S2 sensitivity table |
| 9 | Overlap with Yann's work (M0 = his D(a)) and with prior art | medium | Cite M0 as background; settle Yann's role early |
| 10 | Schedule slip in the hardware weeks | medium | The simulation buffer gained; offline-first analysis; D1 Config D and D2 are optional |
