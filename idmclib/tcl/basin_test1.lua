name = "basin test 1"
description = "basin test 1"
type = "D"
parameters = {"x1", "y1", "x2", "y2", "x3", "y3", "eps"}
variables = {"x", "y", "z", "w"}

function dist(x1, y1, x2, y2)
	return math.abs(x1 - x2) + math.abs(y1 - y2)
end

function f(x1, y1, x2, y2, x3, y3, eps, x, y, z, w)
	if (dist(x, y, x1, y1) < eps) then
		return x1, y1, 0, 0
	elseif (dist(x, y, x2, y2) < eps) then
		return x2, y2, 0, 0
	elseif (dist(x, y, x3, y3) < eps) then
		return x3, y3, 0, 0
	else
		return 1/0, 0, 0, 0
	end
end
