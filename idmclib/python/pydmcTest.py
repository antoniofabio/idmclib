from Numeric import array
from idmc import *
mod = model(open("test2.lua").read())
mod.par()
mod.var()
mod.f([1], [2, 3])
array(mod.NumJf([1], [2, 3]))

from idmc import *
traj = trajectory(mod, [1], [0.5, 2])
traj.var()
traj.dostep()
traj.var()

mod = model(open("lorenz.lua").read())
par = [10, 28, 2.667]
var = [1, 2, 1]
c_traj = ctrajectory(mod, par, var, 0.005, gsl_odeiv_step_rk4)
z = []
for i in range(1000):
	c_traj.dostep()

for i in range(20000):
	c_traj.dostep()
	z.append(c_traj.var())

from pylab import plot, show
zz = array(z)
plot(zz[:, 0], zz[:,1], '-')
show()

#test lyapunov exponents
from Numeric import array
from idmc import *
from idmc import idmc_lexp_new
mod = model(open("inflation.lua").read())
par = [0.95, 0.5, 0.0001, 55500, 1, 0.35, 0.05, 0.02]
var = [0, 0.01, 0, 0.01]
niter = 2000
idmc_lexp_new(mod, par, var, niter)
le = []
ind = 55000 + (array(range(600))/599.0)*1000.0
for i in ind:
	par[3] = i
	le.append(idmc_lexp_new(mod, par, var, niter))

from pylab import plot, show
lee = array(le)
plot(ind, lee[:,0], '-')
plot(ind, lee[:,1], '-')
show()

#test cycle finding
from Numeric import array
import idmc
mod = idmc.model(open("logistic.lua").read())
par=[3.9]
var=[0.133]
point, eigmod  = idmc.find(mod, par, var, 3, 1e-9, 1000)
idmc.powF(mod, 3, par, point)
a = idmc.powNumJac(mod, 3, par, point)
eigval(a[0],1)


