{smcl}
{* *! version 1.0.0  07sep2013}{...}
{cmd:help weakivtest}{right: ({browse "http://www.stata-journal.com/article.html?article=st0377":SJ15-1: st0377})}
{hline}

{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{hi:weakivtest} {hline 2}}Weak-instrument test for two-stage least squares and limited-information maximum likelihood{p_end}
{p2colreset}{...}


{title:Syntax}

{p 8 11 2} {cmdab:weakivtest} [{cmd:,} {cmd:level(}{it:#}{cmd:)} {cmd:eps(}{it:#}{cmd:)} {cmd:n2(}{it:#}{cmd:)}]


{title:Description}

{pstd}
{cmd:weakivtest} implements the weak-instrument test of Montiel Olea and
Pflueger (2013).  It is a postestimation command for {cmd:ivreg2},
described in Baum, Schaffer, and Stillman (2007, 2010), and
{cmd:ivregress}.

{pstd}
{cmd:weakivtest} tests the null hypothesis of weak instruments for both
two-stage least squares (TSLS) and limited-information maximum
likelihood (LIML) with one endogenous regressor.  The test
rejects the null hypothesis when the effective F statistic exceeds a
critical value, which depends on the estimator (TSLS or LIML), the
significance level, and the desired weak-instrument threshold tau.
{cmd: weakivtest} extends the Stock and Yogo (2005) weak-instrument
tests available in {cmd:ivreg2} and in the {cmd:ivregress}
postestimation command {cmd:estat firststage}.

{pstd}Note: You must install {cmd:avar} by typing {cmd:ssc install avar} before running {cmd:weakivtest}.


{title:Options}

{phang}{cmd:level(}{it:#}{cmd:)} specifies the confidence level.  The
default is {cmd:level(0.05)}.

{phang}{cmd:eps(}{it:#}{cmd:)} specifies the input parameter for the
Nelder-Mead optimization technique.  The default is {cmd:eps(10^(-3))}.

{phang}{cmd:n2(}{it:#}{cmd:)} specifies the denominator degrees of
freedom for the inverse noncentral F distribution.  Set {cmd:n2(}{it:#}{cmd:)} to a large
positive number to approximate an inverse noncentral chi-squared
distribution.  The default is {cmd:n2(10^(7))}.


{title:Options of ivreg2 and ivregress}

{p 4 4 2}{cmd:weakivtest} estimates the variance-covariance matrix of
errors as specified in the preceding {cmd:ivreg2} or {cmd:ivregress}
command.  The following options are supported:

{phang}{cmdab: robust} estimates an Eicker-Huber-White heteroskedasticity robust variance-covariance matrix.

{phang}{cmd:cluster}{cmd:(}{it:varname}{cmd:)}  estimates a variance-covariance matrix clustered by the specified variable.

{phang}{cmd:robust bw(}{it:#}{cmd:)} (for {cmd: ivreg2}) estimates a heteroskedasticity- and autocorrelation-consistent variance-covariance matrix computed with a Bartlett (Newey-West) kernel with bandwidth {it:#}. 

{phang}{cmd: bw(}{it:#}{cmd:)}, without the {cmd:robust} option (for {cmd: ivreg2}), requests estimates that are autocorrelation consistent but not heteroskedasticity consistent. 

{phang}{cmd:vce (hac nw} {it:#}{cmd:)} (for {cmd: ivregress}) estimates
a heteroskedasticity- and autocorrelation-consistent variance-covariance
matrix computed with a Bartlett (Newey-West) kernel with number of lags {it:#}.
The bandwidth of a kernel is equal to the number of lags plus one.


{marker s_examples}{title:Examples}

{pstd} Change webuse URL {p_end}
{phang2}{bf:{stata "webuse set http://fmwww.bc.edu/repec/bocode/d" : . webuse set http://fmwww.bc.edu/repec/bocode/d}}{p_end}

{pstd}Load Campbell (2003) and Yogo (2004) data{p_end}
{phang2}{bf:{stata "webuse Data_USAQ.dta, clear" : . webuse Data_USAQ.dta, clear}}{p_end}

{pstd} Reset URL to the default {p_end}
{phang2}{bf:{stata "webuse set" : . webuse set, clear}}{p_end}
{phang2}{bf:{stata "gsort date" : . gsort date}}{p_end}
{phang2}{bf:{stata "tsset quarter" : . tsset quarter}}{p_end}

{pstd}Baseline example: Robust Bartlett (Newey and West 1987) kernel with bandwidth 7{p_end}
{phang2}{bf:{stata "ivreg2 dc (rrf=z1 z2 z3 z4), robust bw(7) " : . ivreg2 dc (rrf=z1 z2 z3 z4), robust bw(7)}}{p_end}
{phang2}{bf:{stata "weakivtest" : . weakivtest }}{p_end}

{pstd}Implement {cmd:weakivtest} as a postestimation command for {cmd:ivregress}{p_end}
{phang2}{bf:{stata "ivregress 2sls dc (rrf=z1 z2 z3 z4), vce(hac nw 6)" : . ivregress 2sls dc (rrf=z1 z2 z3 z4), vce(hac nw 6)}}{p_end}
{phang2}{bf:{stata "weakivtest" : . weakivtest }}{p_end}


{title:Stored results}

{p 4 4 2}{cmd:weakivtest} stores the following results in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt: {cmd:r(N)}}number of observations{p_end}
{synopt: {cmd:r(K)}}number of instruments{p_end} 
{synopt: {cmd:r(n2)}}denominator degrees of freedom noncentral F{p_end}
{synopt: {cmd:r(level)}}test significance Level{p_end}
{synopt: {cmd:r(eps)}}optimization parameter{p_end}
{synopt: {cmd:r(F_eff)}}effective F statistic{p_end}
 
{synopt: {cmd:r(c_TSLS_5)}}TSLS critical value for tau{it:=}5{it:%}{p_end}
{synopt: {cmd:r(c_TSLS_10)}}TSLS critical value for tau{it:=}10{it:%}{p_end}
{synopt: {cmd:r(c_TSLS_20)}}TSLS critical value for tau{it:=}20{it:%}{p_end}
{synopt: {cmd:r(c_TSLS_30)}}TSLS critical value for tau{it:=}30{it:%}{p_end}

{synopt: {cmd:r(c_LIML_5)}}LIML critical value for tau{it:=}5{it:%}{p_end}
{synopt: {cmd:r(c_LIML_10)}}LIML critical value for tau{it:=}10{it:%}{p_end}
{synopt: {cmd:r(c_LIML_20)}}LIML critical value for tau{it:=}20{it:%}{p_end}
{synopt: {cmd:r(c_LIML_30)}}LIML critical value for tau{it:=}30{it:%}{p_end}

{synopt: {cmd:r(c_simp_5)}}TSLS simplified conservative critical value for tau{it:=}5{it:%}{p_end}
{synopt: {cmd:r(c_simp_10)}}TSLS simplified conservative critical value for tau{it:=}10{it:%}{p_end}
{synopt: {cmd:r(c_simp_20)}}TSLS simplified conservative critical value for tau{it:=}20{it:%}{p_end}
{synopt: {cmd:r(c_simp_30)}}TSLS simplified conservative critical value for tau{it:=}30{it:%}{p_end}

{synopt: {cmd:r(x_TSLS_5)}}TSLS noncentrality parameter for
tau{it:=}5{it:%}{p_end}
{synopt: {cmd:r(x_TSLS_10)}}TSLS noncentrality parameter for
tau{it:=}10{it:%}{p_end}
{synopt: {cmd:r(x_TSLS_20)}}TSLS noncentrality parameter for
tau{it:=}20{it:%}{p_end}
{synopt: {cmd:r(x_TSLS_30)}}TSLS noncentrality parameter for
tau{it:=}30{it:%}{p_end}

{synopt: {cmd:r(K_eff_TSLS_5)}}TSLS effective degrees of freedom for tau{it:=}5{it:%}{p_end}
{synopt: {cmd:r(K_eff_TSLS_10)}}TSLS effective degrees of freedom for tau{it:=}10{it:%}{p_end}
{synopt: {cmd:r(K_eff_TSLS_20)}}TSLS effective degrees of freedom for tau{it:=}20{it:%}{p_end}
{synopt: {cmd:r(K_eff_TSLS_30)}}TSLS effective degrees of freedom for tau{it:=}30{it:%}{p_end}

{synopt: {cmd:r(x_LIML_5)}}LIML noncentrality parameter for
tau{it:=}5{it:%}{p_end}
{synopt: {cmd:r(x_LIML_10)}}LIML noncentrality parameter for
tau{it:=}10{it:%}{p_end}
{synopt: {cmd:r(x_LIML_20)}}LIML noncentrality parameter for
tau{it:=}20{it:%}{p_end}
{synopt: {cmd:r(x_LIML_30)}}LIML noncentrality parameter for
tau{it:=}30{it:%}{p_end}

{synopt: {cmd:r(K_eff_LIML_5)}}LIML effective degrees of freedom for tau{it:=}5{it:%}{p_end}
{synopt: {cmd:r(K_eff_LIML_10)}}LIML effective degrees of freedom for tau{it:=}10{it:%}{p_end}
{synopt: {cmd:r(K_eff_LIML_20)}}LIML effective degrees of freedom for tau{it:=}20{it:%}{p_end}
{synopt: {cmd:r(K_eff_LIML_30)}}LIML effective degrees of freedom for tau{it:=}30{it:%}{p_end}

{synopt: {cmd:r(x_simp_5)}}TSLS simplified noncentrality parameter for tau{it:=}5{it:%}{p_end}
{synopt: {cmd:r(x_simp_10)}}TSLS simplified noncentrality parameter for tau{it:=}10{it:%}{p_end}
{synopt: {cmd:r(x_simp_20)}}TSLS simplified noncentrality parameter for tau{it:=}20{it:%}{p_end}
{synopt: {cmd:r(x_simp_30)}}TSLS simplified noncentrality parameter for tau{it:=}30{it:%}{p_end}

{synopt: {cmd:r(K_eff_simp_5)}}TSLS simplified effective degrees of freedom for tau{it:=}5{it:%}{p_end}
{synopt: {cmd:r(K_eff_simp_10)}}TSLS simplified effective degrees of freedom for tau{it:=}10{it:%}{p_end}
{synopt: {cmd:r(K_eff_simp_20)}}TSLS simplified effective degrees of freedom for tau{it:=}20{it:%}{p_end}
{synopt: {cmd:r(K_eff_simp_30)}}TSLS simplified effective degrees of freedom for tau{it:=}30{it:%}{p_end}


{marker references}{...}
{title:References}

{marker Baum2007}{...}
{phang}
Baum, C. F., M. E. Schaffer, and S. Stillman.  2007.
{browse "http://www.stata-journal.com/sjpdf.html?articlenum=st0030:Enhanced routines for instrumental variables/generalized method of moments estimation and testing}.
{it:Stata Journal} 7: 465-506.

{marker Baum2010}{...}
{phang}
------.  2010.  ivreg2: Stata module for extended instrumental variables/2SLS
and GMM estimation.  Statistical Software Components S425401, Department of
Economics, Boston College.
{browse "http://ideas.repec.org/c/boc/bocode/s425401.html"}.

{marker C2003}{...}
{phang}
Campbell, J. Y.  2003.  Consumption-based asset pricing.  In
{it:Handbook of the Economics of Finance: Financial Markets and Asset Pricing Vol. 1B},
ed. G. Constantinides, M. Harris, and R. M. Stulz, 803-887.
Amsterdam: Elsevier.

{marker MOP2013}{...}
{phang}
Montiel Olea, J. L., and C. E. Pflueger.  2013.  A robust test for weak
instruments.  {it:Journal of Business and Economic Statistics} 31: 358-369.

{marker NW1987}{...}
{phang}
Newey, W. K., and K. D. West. 1987.  A simple, positive semi-definite,
heteroskedasticity and autocorrelation consistent covariance matrix.
{it:Econometrica} 55: 703-708.

{marker StockYogo2005}{...}
{phang}
Stock, J. H., and M. Yogo. 2005.  Testing for weak instruments in linear
IV regression.  In
{it:Identification and Inference for Econometric Models: Essays in Honor of Thomas Rothenberg},
ed. D. W. K. Andrews and J. H. Stock, 80-108.
New York: Cambridge University Press.

{marker Yogo2004}{...}
{phang}
Yogo, M. 2004. Estimating the elasticity of intertemporal substitution when
instruments are weak.  {it:Review of Economics and Statistics} 86: 797-810.
{p_end}


{marker authors}{...}
{title:Authors}

{pstd}Carolin E. Pflueger{p_end}
{pstd}University of British Columbia{p_end}
{pstd}Vancouver, Canada{p_end}
{pstd}carolin.pflueger@sauder.ubc.ca{p_end}

{pstd}Su Wang{p_end}
{pstd}London School of Economics{p_end}
{pstd}London, UK{p_end}
{pstd}s.wang50@lse.ac.uk{p_end}


{marker also}{...}
{title:Also see}

{p 4 14 2}Article:  {it:Stata Journal}, volume 15, number 1: {browse "http://www.stata-journal.com/article.html?article=st0377":st0377}{p_end}

{p 7 14 2}Help:  {helpb ivregress}, {helpb ivreg}, {helpb ivregress_postestimation}, {helpb ivreg2} (if installed), {helpb avar}
(if installed) {p_end}
