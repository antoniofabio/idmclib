name = "basin test 3"
description = "basin test 3"
type = "D"
parameters = {"r","s"}
variables = {"x", "y", "z", "w"}

function dist(x1, y1, x2, y2)
	return math.abs(x1 - x2) + math.abs(y1 - y2)
end

function f(r, s, x, y, z, w)
	if (dist(x, y, 0, 0) < (r-s)) then
		return 0, 0, 0, 0
	elseif ((dist(x, y, 0, 0) >= (r-s)) and (dist(x, y, 0, 0) <= (r+s))) then
		return -x, -y, 0, 0
	elseif (dist(x, y, w, z) > (r+s)) then
		return 1/0, 0, 0, 0
	end
end
