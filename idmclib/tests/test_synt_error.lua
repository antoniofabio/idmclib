name = "test syntax error model"
description = "test syntax error model: syntactic errors"
type = "D"
parameters = {"a"}
variables = {"x", "y"}

function f (a, x, y)
	return a*, y
end
