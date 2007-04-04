--%  ft| TRAJECTORY_T0_V1_A0_O0 sn| limit1 n| #0 d| 3 n| #1 d| 2000 n| #2 d| 10000 n| #3 d| -0.05 n| #4 d| 0.1 n| #5 d| -0.05 n| #6 d| 0.1 n| #7 d| x1 n| #8 d| x2
--%  ft| BIFURCATION_1 sn| bif1 n| #0 d| 0.01 n| #1 d| 0.03 n| #2 d| 0.01 n| #3 d| 0.03 n| #4 d| 0.95 n| #5 d| 0.6 n| #6 d| 0.001 n| #7 d| 1 n| #8 d| 0.35 n| #9 d| 0.05 n| #10 d| 0.03 n| #11 d| lambda n| #12 d| 0 n| #13 d| 4000 n| #14 d| -0.2 n| #15 d| 0.2 n| #16 d| 2000 n| #17 d| 1000 n| #18 d| x1
--%  ft| LYAPUNOV_VP sn| x1:~0~~x2:~0.01~~x3:~0~~x4:~0.01~~gamm:~0.95~~delt:~0.5~~C:~0.0001~~alph:~1~~ n| #0 d| 0 n| #1 d| 0.01 n| #2 d| 0 n| #3 d| 0.01 n| #4 d| 0.95 n| #5 d| 0.5 n| #6 d| 0.0001 n| #7 d| 1 n| #8 d| 0.35 n| #9 d| 0.05 n| #10 d| 0.02 n| #11 d| lambda n| #12 d| 55000 n| #13 d| 56000 n| #14 d| -1.1 n| #15 d| 0.2 n| #16 d| 2000 
--%  ft| BIFURCATION_1 sn| ex1 n| #0 d| 0 n| #1 d| 0.01 n| #2 d| 0 n| #3 d| 0.01 n| #4 d| 0.95 n| #5 d| 0.5 n| #6 d| 0.0001 n| #7 d| 1 n| #8 d| 0.35 n| #9 d| 0.05 n| #10 d| 0.02 n| #11 d| lambda n| #12 d| 55000 n| #13 d| 56000 n| #14 d| -0.05 n| #15 d| 0.1 n| #16 d| 2000 n| #17 d| 1000 n| #18 d| x1 
--%  ft| TRAJECTORY_T0_V1_A1_O0 sn| ex1 n| #0 d| 10 n| #1 d| 2000 n| #2 d| 1000 n| #3 d| 3000 n| #4 d| x1 n| #5 d| x2 
--%  ft| LYAPUNOV_VT sn| x1:~0.01279935~~x2:~0.01466969~~x3:~0.01517522~~x4:~0.02690097~~gamm:~0.95~~delt:~0.5~~C:~0.0001~~lamb:~55102.453~~ n| #0 d| 0.01279935 n| #1 d| 0.01466969 n| #2 d| 0.01517522 n| #3 d| 0.02690097 n| #4 d| 0.95 n| #5 d| 0.5 n| #6 d| 0.0001 n| #7 d| 55102.453 n| #8 d| 1 n| #9 d| 0.35 n| #10 d| 0.05 n| #11 d| 0.02 n| #12 d| 1 n| #13 d| 10 n| #14 d| -1.1 n| #15 d| 1.19 
--@@
name = "inflation"
description = "See"
type = "D"
parameters = {"gamma", "delta", "C", "lambda", "alpha", "beta", "m", "gn"}
variables = {"x1", "x2", "x3", "x4"}

function f(gamma, delta, C, lambda, alpha, beta, m, gn, x1, x2, x3, x4)

       ex0 = x1 + gamma * (x1 - x2)
       rg0 = x1 + delta * (m - gn - x1)
       ex1 = x2 + gamma * (x2 - x3)
       rg1 = x2 + delta * (m - gn - x2)
       ex2 = x3 + gamma * (x3 - x4)
       rg2 = x3 + delta * (m - gn - x3)

       aex0 = - (ex1 - x1)^2
       arg0 = - (rg1 - x1)^2 - C
       da0 = arg0 - aex0
       aex1 = -(ex2 - x2)^2
       arg1 = -(rg2 - x2)^2 - C
       da1 = arg1 - aex1

       wex0 = 1 / ( 1 + math.exp(lambda  * da0) )
       wrg0 = 1 - wex0
       wex1 = 1 / ( 1 + math.exp(lambda * da1) )
       wrg1 = 1 - wex1

       e0 = wex0 * ex0 + wrg0 * rg0
       e1 = wex1 * ex1 + wrg1 * rg1
       de = e0 - e1

       x0 = (alpha * beta * (m - gn) + x1 + de) / (1 + alpha * beta)

       return x0, x1, x2, x3

end

