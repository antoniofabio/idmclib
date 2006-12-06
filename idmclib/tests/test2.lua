name = "test model 2"
description = "test model 2: bivariate quadratic map"
type = "D"
parameters = {"a"}
variables = {"x", "y"}

function f (a, x, y)
		return a*x*x, a*y*y
end
