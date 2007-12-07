name = "test error model"
description = "test error model: functions give bad results"
type = "D"
parameters = {"a"}
variables = {"x", "y"}

function f (a, x, y)
	return a*x*x, "y"
end

function g (a, x, y)
        x1 = x + "a"
	return x, y
end
