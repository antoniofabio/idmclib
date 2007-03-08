name = "TestError2"
description = "TestError2 model"
type = "D"
parameters = {"a","b"}
variables = {"x"}

function f(a,b,x)
	if(x < 10) then
		x1 = a+b*x
		return x1
	else
		return 0+x1
	end
end