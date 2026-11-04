# Verified references (updated 2026-10-20, after the depth audit)

**Access codes**
- **FULL**: entire text read.
- **PART**: the listed sections were read.
- **SEC**: content known only through a named secondary source.
- **ABS**: abstract only.
- **CIT**: known only as a citation elsewhere.
- **INACC**: full text not retrievable.

**Columns**
- **Z**: PDF in the user's Zotero. Y = present and readable; Y-scan = scanned, read as page images; — = not in Zotero.
- **By**: who read it. C = Claude directly; A = audit agent (pdftotext or web, read-only).

Evidence for each paper (sections, equations, theorems), the novelty audit and the comparison with Alexander–Maddocks and Huang et al. are in `literature_review.md`.

## Planar contact / unknown pressure
| Reference | Link | Z | Access | By |
|---|---|---|---|---|
| Peshkin, Sanderson. The motion of a pushed, sliding workpiece. IEEE J. Robot. Autom. 4(6):569–598, 1988 | https://peshkin.mech.northwestern.edu/publications/1988_Peshkin_MotionPushedSlidingWorkpiece.pdf | — | PART (§2.7–2.9, §4.5) | C |
| Huang, Bhatia, Boots, Mason. Exact bounds on the contact driven motion of a sliding object. RSS XIII, 2017. DOI 10.15607/RSS.2017.XIII.010 | https://roboticsproceedings.org/rss13/p10.html | Y | FULL (text pp. 1–9; figures not viewed) | C |
| Alexander, Maddocks. Bounds on the friction-dominated motion of a pushed object. IJRR 12(3):231–248, 1993 | https://journals.sagepub.com/doi/abs/10.1177/027836499301200303 | Y | FULL (text pp. 231–248; displayed equations viewed only on pp. 235, 236, 242) | C |
| Caron, Pham, Nakamura. Stability of surface contacts for humanoid robots. ICRA 2015. DOI 10.1109/ICRA.2015.7139910 | https://arxiv.org/abs/1501.04719 | — | PART (§3 Prop 1 with proof; §4 Prop 2) | C |
| Goyal, Ruina, Papadopoulos. Planar sliding with dry friction, Part 1. Wear 143:307–330, 1991 | https://doi.org/10.1016/0043-1648(91)90104-3 | Y | PART (§8, 8.1, 11, 12) | C |
| Howe, Cutkosky. Practical force-motion models for sliding manipulation. IJRR 15(6), 1996 | https://journals.sagepub.com/doi/10.1177/027836499601500603 | Y-scan | FULL (text pp. 1–20; figures pp. 24–26) | C |
| Xydas, Kao. Modeling of contact mechanics and friction limit surfaces for soft fingers. IJRR 18(9), 1999 | DOI 10.1177/02783649922066673 | Y | PART (§4.1; keyword scan) | C |
| Tiezzi, Kao. Modeling of viscoelastic contacts and evolution of limit surface. T-RO 2007 | DOI 10.1109/TRO.2006.889494 | Y | PART | A |
| Arslan Waltersson, Karayiannidis. Planar friction modelling with LuGre dynamics and limit surfaces. T-RO 2024 | DOI 10.1109/TRO.2024.3410455 | Y | PART (model sections in full; simulations skimmed) | A |
| Arslan Waltersson, Karayiannidis. In-hand slip-aware manipulation with parallel grippers. IJRR 2025 | DOI 10.1177/02783649251397549 | Y | PART (estimation, controller, Table 9) | A |
| de Mont-Marin, Montaut, Ponce, Hebert, Carpentier. On the conic complementarity of planar contacts. arXiv 2509.25999, 2025 | https://arxiv.org/abs/2509.25999 | Y | PART (intro + keyword scan for friction; friction stated as future work) | C |
| Lee, Cutkosky. Fixture planning with friction. ASME J. Eng. Ind. 113(3):320–327, 1991; Lee 1991 PhD thesis (Stanford) | https://scinapse.io/papers/1973600975 | — | CIT (Howe–Cutkosky pp. 11, 16) | C |
| Mason. Mechanics and planning of manipulator pushing operations. IJRR 1986; Mechanics of Robotic Manipulation, 2001 | — | — | CIT | — |
| Lynch, Mason. Stable pushing. IJRR 15(6), 1996 | — | — | ABS | A |
| Zhou, Paolini, Bagnell, Mason. Convex polynomial force-motion model. ICRA 2016 / IJRR 2018 | https://arxiv.org/abs/1602.06056 | — | ABS | A |
| Elandt et al. Pressure field contact model. IROS 2019 | https://arxiv.org/abs/1904.11433 | — | ABS | A |
| Masterjohn et al. Velocity level approximation of pressure field contact patches. RA-L 2022 | https://arxiv.org/abs/2110.04157 | — | PART (§III-B, §IV, §V-A, §VI: one Coulomb point contact per contact-surface face at its centroid, force A·p_c) | C |
| Ardakani, Bimbo, Prattichizzo. Quasi-static analysis of planar sliding using friction patches. arXiv 1904.06677 | https://arxiv.org/abs/1904.06677 | — | PART (keyword scan of §2–4, §7) | A |

## Tactile slip and capacity
| Reference | Link | Z | Access | By |
|---|---|---|---|---|
| Costanzo, De Maria, Natale. Two-fingered in-hand object handling based on force/tactile feedback. T-RO 36(1):157–173, 2020 | DOI 10.1109/TRO.2019.2944130 | Y | FULL (text pp. 157–172; Tables I–II and figures not viewed) | C |
| Cirillo et al. Control of linear and rotational slippage based on six-axis force/tactile sensor. ICRA 2017 | — | Y | PART (§II.A, III, IV) | A, C |
| Costanzo. Control of robotic object pivoting based on tactile sensing. Mechatronics 2021 | — | Y | PART (§2.1, §3) | A |
| Costanzo, De Maria, Natale. Detecting and controlling slip through estimation and control of the sliding velocity. Appl. Sci. 13(2), 2023 | DOI 10.3390/app13020921 | Y | PART (§2, 4, 5, 7) | A |
| Griffa, Sferrazza, D'Andrea. Leveraging distributed contact force measurements for slip detection. ICRA 2022 | https://arxiv.org/abs/2109.11504 | Y | PART (§I, III) | A |
| Park et al. Proactive robotic grasp stability via tactile safety margin feedback. Adv. Intell. Syst. 2026 | — | Y | PART | A |
| Shirai, Jha, Raghunathan. Robust pivoting manipulation using contact implicit bilevel optimization. T-RO 2024 | — | Y | PART (§I–IV, limitations) | A |
| Bicchi, Bergamasco, Dario, Fiorillo. Integrated tactile sensing for gripper fingers. 1988 | — | — | CIT (Howe–Cutkosky p. 14) | C |
| Yuan, Li, Srinivasan, Adelson. Measurement of shear and slip with a GelSight tactile sensor. ICRA 2015 | — | Y | ABS | A |
| Dong, Ma, Donlon, Rodriguez. Maintaining grasps within slipping bound by monitoring incipient slip | https://arxiv.org/abs/1810.13381 | — | ABS | A |
| Kolamuri et al. Improving grasp stability with rotation measurement from tactile sensing. IROS 2021 | https://arxiv.org/abs/2108.00301 | — | ABS | A |
| Veiga, Peters, Hermans. Grip stabilization of novel objects using slip prediction. IEEE ToH 2018 | — | Y | ABS | A |
| Chen et al. Tactile sensors for friction estimation and incipient slip detection (review). IEEE Sensors J. 2018 | DOI 10.1109/JSEN.2018.2868340 | Y | ABS | A |
| Romeo, Zollo. Slip detection survey. IEEE Access 8, 2020 | DOI 10.1109/ACCESS.2020.2987849 | — | CIT | A |
| Ueda, Ikeda, Ogasawara. Vision-based slip-margin feedback. T-RO 2005 | — | Y | ABS | C |
| Shahidzadeh et al. FeelAnyForce. ICRA 2025 | https://arxiv.org/abs/2410.02048 | — | ABS | C |

## Contact estimation
| Reference | Link | Z | Access | By |
|---|---|---|---|---|
| Fazeli, Tedrake, Rodriguez. Identifiability analysis of planar rigid-body frictional contact. ISRR 2018 | — | Y | PART | A |
| Fearing, Hollerbach. Basic solid mechanics for tactile sensing. IJRR 1985 | — | — | ABS | A |
| Bicchi, Salisbury, Brock. Contact sensing from force measurements. IJRR 1993 | https://dspace.mit.edu/handle/1721.1/5996 | — | ABS | A |
| Ma, Donlon, Dong, Rodriguez. Dense tactile force estimation using GelSlim and inverse FEM. ICRA 2019 | https://arxiv.org/abs/1810.04621 | — | ABS | A |
| Sferrazza, D'Andrea. Full-resolution optical tactile sensor. Sensors 2019 | https://pmc.ncbi.nlm.nih.gov/articles/PMC6412824 | — | ABS | A |
| Coping with the grasping uncertainties in force-closure analysis. IJRR 2005 (authors unconfirmed) | https://journals.sagepub.com/doi/10.1177/0278364905049469 | — | ABS | A |

## Mathematics
| Reference | Link | Z | Access | By |
|---|---|---|---|---|
| Madansky. Bounds on the expectation of a convex function of a multivariate random variable. Ann. Math. Statist. 30(3), 1959 | https://projecteuclid.org/journals/annals-of-mathematical-statistics/volume-30/issue-3/Bounds-on-the-Expectation-of-a-Convex-Function-of-a/10.1214/aoms/1177706203.full | — | SEC (Yates 1996, Ch. III); original blocked | A |
| Gassmann, Ziemba. A tight upper bound for the expectation of a convex function of a multivariate random variable. Math. Prog. Study 27, 1986 | — | — | SEC (Yates 1996, Ch. V) | A |
| Birge, Wets. Designing approximation schemes for stochastic optimization problems. IIASA WP-83-111 (1983); Math. Prog. Study 27 (1986) | https://pure.iiasa.ac.at/id/eprint/2201/1/WP-83-111.pdf | — | PART (WP version §§3, 4, 6) | A |
| Huang, Ziemba, Ben-Tal. Bounds on the expectation of a convex function of a random variable. Oper. Res. 25(2), 1977 | https://ideas.repec.org/a/inm/oropre/v25y1977i2p315-325.html | — | ABS (PDF 403) | A |
| Frauendorfer. Solving SLP recourse problems… the dependent case. Math. OR 13(3), 1988 | https://pubsonline.informs.org/doi/fpi/10.1287/moor.13.3.377 | — | ABS | A |
| Kall. An upper bound for SLP using first and total second moments. Ann. Oper. Res. 1991 | https://link.springer.com/article/10.1007/BF02204820 | — | ABS | A |
| Edmundson. Bounds on the expectation of a convex function of a random variable. RAND, 1956 | — | — | INACC | — |
| Wiesemann, Kuhn, Sim. Distributionally robust convex optimization. Oper. Res. 62(6), 2014 | https://ideas.repec.org/a/inm/oropre/v62y2014i6p1358-1376.html | Y | FULL (audit agent; full pdftotext read) | A |
| Winkler. Extreme points of moment sets. Math. OR 13(4), 1988 | https://pubsonline.informs.org/doi/fpi/10.1287/moor.13.4.581 | — | ABS | A |
| Delage, Ye. DRO under moment uncertainty. Oper. Res. 58(3), 2010 | DOI 10.1287/opre.1090.0741 | — | CIT | A |
| Smith. Generalized Chebyshev inequalities. Oper. Res. 43(5), 1995 | https://pubsonline.informs.org/doi/pdf/10.1287/opre.43.5.807 | — | ABS | A |
| Lasserre. Moments, Positive Polynomials and Their Applications. 2010 | — | — | CIT (cited in manuscript) | — |

## Secondary sources used
| Reference | Link | Access | By |
|---|---|---|---|
| Yates. MSc thesis, Univ. Tennessee, 1996 (expositions of Madansky, Gassmann–Ziemba) | https://trace.tennessee.edu/utk_gradthes/11014 | PART (Ch. III, V) | A |
| Dokov, Morton. Second-order bounds… (2002 preprint) | https://edoc.hu-berlin.de/bitstreams/7814d9ad-657d-41fd-8b38-49ac2744b298/download | PART (intro) | A |
