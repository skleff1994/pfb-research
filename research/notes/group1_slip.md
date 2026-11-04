# Group 1 findings (slip / friction capacity from tactile). Draft for research/group1_slip.md

Plan mode blocked writing the target file. On approval, copy this content to
/home/skleff/CODE/planar_friction_bounds/research/group1_slip.md.

Access level: all entries were seen via web-search snippets, abstracts or fetched abstract pages only. No full texts read. "Not verified" means I did not check.

| # | Paper | Venue / year / link | Seen | Estimated quantity | Method | Guarantee | Threat |
|---|---|---|---|---|---|---|---|
| 1 | Costanzo, De Maria, Natale, "Two-Fingered In-Hand Object Handling Based on Force/Tactile Feedback" | IEEE T-RO 36(1):157-173, 2020, DOI 10.1109/TRO.2019.2944130 | abstract | sliding velocity, min grip force for tangential+torsional load | limit surface + LuGre observer, F/T + tactile | none stated (stability of observer in thesis, not checked) | medium |
| 2 | Costanzo, De Maria, Natale, "Slipping Control Algorithms for Object Manipulation with Sensorized Parallel Grippers" | ICRA 2018 (bibbase / cordis listing) | abstract | rotational and linear slip avoidance | sliding model, 6-axis F/T + tactile | none stated | medium |
| 3 | Costanzo, De Maria, Natale et al., "Detecting and Controlling Slip through Estimation and Control of the Sliding Velocity" | Applied Sciences 13(2):921, 2023, https://www.mdpi.com/2076-3417/13/2/921 (fetch 403, abstract via DOAJ) | abstract | friction state, sliding velocity from force + torsional moment | nonlinear observer, limit surface | none stated | medium |
| 4 | Bogaard, "Pivoting with Tactile Feedback" (MSc thesis, TU Delft) | 2026, https://repository.tudelft.nl/record/uuid:8199ffb2-56f2-4813-9462-efa9391b1c7e | abstract | generalized safety margin (force + torque) | limit surface fitted to slip experiments; CNN on displacement field | empirical only | medium-high (closest to capacity estimation incl. torsion, but learned, not bounds) |
| 5 | TU Delft ICRA 2024 safety-margin CNN with ChromaTouch (authors/title not confirmed) | ICRA 2024, Delft repository files | snippet only | lateral-force safety margin | CNN on marker images | empirical, 98.2% accuracy | low-medium |
| 6 | Dong, Ma, Donlon, Rodriguez, "Maintaining Grasps within Slipping Bound by Monitoring Incipient Slip" | arXiv 1810.13381 (ICRA 2019 per user, venue not confirmed) | abstract | dense incipient slip field, trans+rot | rigid-motion deviation of GelSlim imprint | none, 86.25% accuracy | low |
| 7 | Kolamuri, Si, Zhang, Agarwal, Yuan, "Improving Grasp Stability with Rotation Measurement from Tactile Sensing" | IROS 2021, arXiv 2108.00301 | abstract | rotational displacement | model-based GelSight rotation detection, regrasp | none | low |
| 8 | Yuan, Li, Srinivasan, Adelson, "Measurement of Shear and Slip with a GelSight Tactile Sensor" | ICRA 2015, pp.304-311, https://people.csail.mit.edu/yuan_wz/GelSight1/ICRA15_2740_FI.pdf | abstract | normal, shear, torsional load; incipient slip | image-sequence analysis | none | low |
| 9 | Griffa, Sferrazza, D'Andrea, "Leveraging distributed contact force measurements for slip detection" | arXiv 2109.11504, 2021 (no venue listed) | abstract (fetched) | slip onset, translational + rotational | physics-based, distributed normal/shear forces vs friction cone | none stated | medium (uses distributed force, rigid-ish model; not checked how torsion capacity computed) |
| 10 | Ardakani, Bimbo, Prattichizzo, "Quasi-static Analysis of Planar Sliding Using Friction Patches" | arXiv 1904.06677, 2019 | abstract (fetched) | stick/pivot/slide motion of patch | friction-patch limit surface | n/a | medium (patch model, not bounds from partial data) |
| 11 | Veiga, Peters, Hermans, "Grip Stabilization of Novel Objects Using Slip Prediction" | IEEE ToH 11(4):531-542, 2018, PDF https://www.ias.informatik.tu-darmstadt.de/uploads/Publications/veigaToH2018.pdf | listing | slip event prediction | learned from BioTac | none | low (prediction only) |
| 12 | Veiga, van Hoof, Peters, Hermans, "Stabilizing Novel Objects by Learning to Predict Tactile Slip" | IROS 2015 pp.5065-5072, DOI 10.1109/IROS.2015.7354090 | listing | slip prediction | random forests | none | low |
| 13 | Chen, Khamis, Birznieks, Lepora, Redmond, "Tactile Sensors for Friction Estimation and Incipient Slip Detection" (review) | IEEE Sensors J. 18, 2018, DOI 10.1109/JSEN.2018.2868340 | snippet | survey | n/a | n/a | none |
| 14 | Romeo, Zollo, "Methods and Sensors for Slip Detection in Robotics: A Survey" | IEEE Access 8:73027-73050, 2020, DOI 10.1109/ACCESS.2020.2987849 | citation only | survey | n/a | n/a | none |
| 15 | Khamis, Xia, Redmond, "Real-time Friction Estimation for Grip Force Control" | ICRA 2021 (DBLP listing, not opened) | citation only | friction coefficient from incipient slip | PapillArray | none | low |
| 16 | Su et al., "Force Estimation and Slip Detection/Classification for Grip Control using a Biomimetic Tactile Sensor" | Humanoids 2015 pp.297-303 | abstract | force, slip class | BioTac learning | none | low |
| 17 | Calandra et al., "More than a Feeling" | RA-L 3(4):3300-3307, 2018, arXiv 1805.11085 | abstract | grasp success | deep visuo-tactile | none | none |
| 18 | Tremblay, Cutkosky, "Estimating Friction Using Incipient Slip Sensing During a Manipulation Task" | ICRA 1993, vol.1 pp.429-434 | citation only | friction coefficient | incipient-slip vibration | none | none |

## Not found / not verified
- Any work computing a lower or upper bound on the admissible (f_T, torsion) set from partial normal-pressure data: none found in these searches. Searches were limited (about 14 queries), so absence is not proven.
- Xu et al. 2019 six-dimensional friction of soft-finger contacts, and Isfahan limit-surface/pressure-skew work: seen only as search summaries, no citation details.
- Monnoyer, Willemet, Wiertlewski 2023 safety-margin paper: mentioned in snippet only.

## 4-way distinction (within what was found)
1. Detection: well covered (6,7,8,9,16, reviews 13,14).
2. Prediction: covered by learned methods (11,12,5); no guarantees.
3. Capacity / margin: addressed for translation by learned margin (5); for shear+torsion by limit-surface-based estimators (1-3, 4). These rely on F/T sensor or fitted/learned limit surfaces, not on pressure-map-derived bounds.
4. Conservative guarantees on admissible loads from partial data: no instance found. This is the open slot the manuscript targets.

Closest works to flag: 1-3 (Costanzo et al., limit surface + torsion), 4 (generalized safety margin with torque), 9 (distributed forces, rotational slip), 10 (friction patch).
