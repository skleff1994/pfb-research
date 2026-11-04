# Group 4 (adjacent mathematical prior art): findings

Note: plan mode blocked writing research/group4_math.md. Copy this file there once plan mode is off.

Access level for all items: bibliographic records and abstracts via web search only. No full text was read. Theorem statements below are from abstracts, secondary descriptions, or my own background knowledge, and I flag which is which.

## Verified references

1. Madansky, A. (1959). Bounds on the expectation of a convex function of a multivariate random variable. Ann. Math. Statist. 30(3), 743-746. DOI 10.1214/aoms/1177706203. https://projecteuclid.org/journals/annals-of-mathematical-statistics/volume-30/issue-3/Bounds-on-the-Expectation-of-a-Convex-Function-of-a/10.1214/aoms/1177706203.full
   - Upper bound by weighting extreme points of the support. Secondary sources say it is valid for independent components; Jensen's lower bound holds in general.
   - Background knowledge, not checked: in the dependent case the vertex weights are not fixed by the mean alone, which is where the LP over weights with a fixed mean arises.
   - Edmundson 1956 is a RAND report and was not located separately.
2. Huang, Ziemba, Ben-Tal (1977). Operations Research 25(2), 315-325. DOI 10.1287/opre.25.2.315 (erratum OR 25(6), 1040). https://pubsonline.informs.org/doi/pdf/10.1287/opre.25.2.315
   - Abstract: sequentially applies Jensen and Edmundson-Madansky to smaller and smaller subintervals. In the dependent multivariate case E-M bounds are unavailable, so conditional Jensen is used.
   - This is the closest classical analogue of the partition-refinement idea (Prop 8.2/8.3).
3. Ben-Tal and Hochman (1972) refined the Madansky bound using extra information. Seen only as a citation in the Huang et al. paper and a thesis. Venue and details not verified.
4. Frauendorfer, K. (1988). Solving SLP recourse problems with arbitrary multivariate distributions, the dependent case. Math. Oper. Res. 13(3), 377-394. DOI 10.1287/moor.13.3.377. https://pubsonline.informs.org/doi/fpi/10.1287/moor.13.3.377
   - Abstract: extends E-M to dependent variables, with the extremal distribution defined via a partial order on distribution functions. Bounds tighten monotonically as the subdivision is refined.
   - This is the closest match to Thm 6.2/Prop 8.2: a vertex bound with mean information on a simplex, refined over a partition.
   - The later barycentric work (Frauendorfer 1992, 1996; Frauendorfer-Kuhn-Schurle chapter) was seen only in titles. Not verified.
5. Birge and Wets (1986). Designing approximation schemes for stochastic optimization problems, in particular for stochastic programs with recourse. Math. Programming Study 27, 54-102. DOI 10.1007/BFb0121114 (Springer link, https://link.springer.com/doi/10.1007/BFb0121114). Abstract from the IIASA working paper WP-83-111: approximation of the measures and/or the objective. Details not verified.
6. Edirisinghe and Ziemba (1994). Bounding the expectation of a saddle function with application to stochastic programming. Math. OR 19(2), 314-340. DOI 10.1287/moor.19.2.314. https://pubsonline.informs.org/doi/10.1287/moor.19.2.314
   - Bounds use first moments and cross moments, with no independence assumption. Covers unbounded domains.
   - Related: Edirisinghe 1996, OR (second-order lower bounds). Not verified in detail.
7. Dokov and Morton (2005). Second-order lower bounds on the expectation of a convex function. Math. OR 30(3), 662-677. DOI 10.1287/moor.1040.0136. https://pubsonline.informs.org/doi/10.1287/moor.1040.0136
   - Lower bounds using the first two moments on an interval or hyper-rectangle. A companion paper on upper bounds exists. It is not relevant here because the manuscript has no second moments.
8. Kall and Stoyan (1982). Solving stochastic programming problems with recourse including error bounds. Math. Operationsforsch. Statist., Ser. Optim. 13(3), 431-447. Citation only; abstract not found. Kall's page links a scan that I did not open.
9. Dupacova 1966, Kall 1987/1991, Birge-Louveaux textbook: not searched. Do not cite from this report.
10. Vandenberghe, Boyd, Comanor (2007). Generalized Chebyshev bounds via semidefinite programming. SIAM Review 49(1), 52-64. DOI 10.1137/S0036144504440543. https://epubs.siam.org/doi/10.1137/S0036144504440543
    - Sharp lower bound on the probability of a set given first two moments. SDP formulation.
    - Concerns probability of sets, not integrals of a convex integrand over a measure on a polytope. Low relevance.
11. Bertsimas and Popescu (2005). Optimal inequalities in probability theory: a convex optimization approach. SIAM J. Optim. 15(3), 780-804. DOI not retrieved. Early version: MIT Sloan WP 4083, https://dspace.mit.edu/bitstream/1721.1/2755/1/SWP-4083-43770133.pdf
12. Smith, J. E. (1995). Generalized Chebychev inequalities: theory and applications in decision analysis. Operations Research 43(5), 807-825. DOI 10.1287/opre.43.5.807. https://pubsonline.informs.org/doi/pdf/10.1287/opre.43.5.807
    - Framework for bounds on the expectation of an arbitrary objective given moments. This is the generic home of "sup/inf of a linear functional over a moment set".
13. Winkler, G. (1988). Extreme points of moment sets. Math. OR 13(4), 581-587. DOI 10.1287/moor.13.4.581. https://pubsonline.informs.org/doi/fpi/10.1287/moor.13.4.581
    - Extreme points of probability measures with finitely many generalized moment constraints, and optimization of affine functionals. Background knowledge, not verified from the abstract: extreme points have at most m+1 atoms for m constraints.
    - This reproduces the manuscript's Carathéodory-type "at most 3 atoms" result (Thm 4.5) and the "at most r+2 nonzeros" claim (Thm 6.2).
    - Richter 1957 and Rogosinski 1958 are the original sources. Not searched.
14. Wiesemann, Kuhn, Sim (2014). Distributionally robust convex optimization. Operations Research 62(6), 1358-1376. DOI 10.1287/opre.2014.1314. https://ideas.repec.org/a/inm/oropre/v62y2014i6p1358-1376.html
    - Abstract: ambiguity sets with conic-representable confidence sets and means on an affine manifold. The confidence-set structure covers "known probability of a region", which is the closest DRO analogue of M_F and M_T.
15. Delage and Ye (2010). Operations Research 58(3), 595-612. DOI 10.1287/opre.1090.0741. Mean and covariance ambiguity. Low relevance.
16. Hanasusanto, Roitch, Kuhn, Wiesemann (2015). A distributionally robust perspective on uncertainty quantification and chance constrained programming. Math. Programming, DOI 10.1007/s10107-015-0896-z. The search did not confirm any partition-based content. Not verified; do not claim it.
17. Not searched: Lasserre 2010, Shapiro 2001, Kemperman 1968. Do not cite from this report without checking.

## Mapping: manuscript result to classical result

| Manuscript | Classical counterpart | Threat |
|---|---|---|
| Thm 4.3 (Jensen lower, attained by a Dirac at c) | Jensen's inequality. Textbook. | none, but cite Jensen as standard |
| Thm 4.5 / Cor 4.6 (sup attained with at most 3 atoms; vertex LP) | Edmundson-Madansky (1956/59) for the vertex upper bound. Richter-Rogosinski/Winkler 1988 for the atom count. Fixed-mean vertex LP on a polytope matches Frauendorfer 1988 (simplices) and the standard "worst-case expectation of a convex function given the mean" in DRO. | medium for the general principle, low for the friction-specific statement |
| Thm 6.1 / 6.2 (partition + global mean: SOCP lower, LP upper) | Conditional Jensen and E-M per cell (Huang-Ziemba-Ben-Tal 1977; Kall-Stoyan 1982; Birge-Wets 1986; Frauendorfer 1988). The difference is that those use known cell means (and cell probabilities). The manuscript has cell probabilities and one global mean. That is a moment problem with piecewise constraints. Winkler/Smith-type generalized moment theory covers it, and the LP-duality "affine roof per cell" is standard. | medium: structure is classical, the specific instance is not found |
| Prop 6.4 (cellwise closed-form bounds) | Cellwise min/max of a convex function (min over a cell is not E-M). Trivial given cell masses. | low |
| Thm 7.2 / 7.3 (partition-only, integrand depends on the unknown mean c) | No source found. In the classical setting g is fixed. Here g depends on c = E[x], so the problem is nonlinear in the measure. The manuscript's reduction (optimize M_T over c in a compatible set) is a bilevel/nested step. | low, based on searches only |
| Prop 8.2 / 8.3 (monotone tightening, gap vs. diameter) | Huang-Ziemba-Ben-Tal 1977 (sequential refinement), Frauendorfer 1988 (monotone bounds under refinement), Birge-Wets 1986 (convergence). Gap bound by Lipschitz constant times diameter is standard. | medium-high for the principle, low for the specific constants |

## Does "integrand depends on the unknown mean" appear?
Not in anything I found. The classical results assume g is fixed and independent of the measure. Searching abstracts cannot exclude it. A full-text check of Frauendorfer 1988, Kall-Stoyan 1982 and Birge-Wets 1986 would be needed to rule it out completely. It is not strictly new in structure: g(x - c) with c = mean is a convex integrand of a centered variable, so ∫ g(x-c) dν is a function of the first moment and of ν, and the bounds in M_T become inf/sup over c.

## Conclusions for the novelty audit
- The principles in Thm 4.3, Thm 4.5 and the partition/refinement parts of Sec. 6 and 8 are classical. The manuscript should cite Jensen, Edmundson-Madansky/Madansky, Huang-Ziemba-Ben-Tal, Frauendorfer, Winkler/Richter-Rogosinski, and Smith or Wiesemann et al. and frame its results as instances.
- The friction-specific statement (h(q) as integral of a norm, ICR interpretation, wrench set) is not in this literature.
- M_F with the mean-dependent integrand and the information-ordering comparisons look new relative to these sources. This conclusion rests on abstracts only.
- Gaps: no full text, no DOI for Bertsimas-Popescu, Edmundson 1956, Kall 1987/1991, Birge-Louveaux, Dupacova, Lasserre, Shapiro, Kemperman not checked, partition-based DRO claim unverified.
