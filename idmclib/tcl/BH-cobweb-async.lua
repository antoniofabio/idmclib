name = "BH-coweb-async"
description = "FIXME"
type = "D"
parameters = {"beta", "a", "b", "s", "C", "w", "delta"}
variables = {"p", "n1", "n2", "u1", "u2"}

function f(beta,a,b,s,C,w,delta, p,n1,n2,u1,u2)
-- lagged variables
	plag = p
	n1lag = n1
	u1lag = u1
	u2lag = u2
-- price
	p = (a-n2*s*plag)/(b+n1*s)
-- fitness
	u1 = w*u1lag + (1-w)*((b/2)*p*p-C)
	u2 = w*u2lag + (1-w)*(b/2)*plag*(2*p-lag)
--fractions
	q1 = math.exp(beta*u1)
	q2 = math.exp(beta*u2)
	z = q1+q2
	n1 = delta*n1lag + (1-delta)*q1/z
	n2 = 1 - n1
-- price change
	pchange = p - plag
	return p,n1,n2,u1,u2
end

