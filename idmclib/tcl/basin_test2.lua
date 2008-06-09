name = "basin test 2"
description = "basin test 2"
type = "D"
parameters = {"y1", "w1", "y2", "w2", "y3", "w3", "eps"}
variables = {"x", "y", "z", "w"}

function dist(y1, w1, y2, w2)
	return math.max(math.abs(y1 - y2), math.abs(w1 - w2))
end

function f(y1, w1, y2, w2, y3, w3, eps, x, y, z, w)
	if (dist(y, w, y1, w1) < eps) then
		return 0, y1, 0, w1
	elseif (dist(y, w, y2, w2) < eps) then
		return 0, y2, 0, w2
	elseif (dist(y, w, y3, w3) < eps) then
		return 0, y3, 0, w3
	else
		return 1/0, 0, 0, 0
	end
end
