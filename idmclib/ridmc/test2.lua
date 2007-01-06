--%  ft| TRAJECTORY_T0_V0_A1_O0 sn| unif:~0.5~~norm:~0~~pois:~5~~lapl:~0~~expo:~2~~beta:~0.5~~logn:~1~~logi:~1~~ n| #0 d| 0.5 n| #1 d| 0 n| #2 d| 5 n| #3 d| 0 n| #4 d| 2 n| #5 d| 0.5 n| #6 d| 1 n| #7 d| 1 n| #8 d| 0.8 n| #9 d| 1 n| #10 d| 0 n| #11 d| 1000 n| #12 d| 1000 n| #13 d| norm n| #14 d| unif 
--@@
name = "rng test 2"
description = "rng test 2"
type = "D"
parameters = {"a"}
variables = {"x", "y"}

function f (a, x, y)
		return a*x*x, a*y*y
end
