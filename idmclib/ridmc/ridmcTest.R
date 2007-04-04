source("ridmc.R")

model <- Model("logistic.lua")
model$f(3.8, 0.7)

model <- Model("lorenz.lua")
trajectory <- CTrajectory(model, 
	c(10, 28, 2.667), c(1.0, 2.0, 1.0), 
	0.005, 0 )
for(i in 1:1000)
	trajectory$step()

mat <- matrix(NA, 20000, 3)
for(j in 1:NROW(mat)) {
	trajectory$step()
	mat[j,] <- trajectory$getValue()
}

system.time(ly <- lexp_ode(model, c(10, 28, 2.667), c(1.0, 2.0, 1.0), 2000.0, 0.005))

model <- Model("logistic.lua")
res <- cycles_find(model, 3.25, 0.5, 2, 1e-6)
tr <- numeric(50)
tr[1] <- res$result
for(i in 2:length(tr))
	tr[i] <- model$f(3.25, tr[i-1])
plot(ts(tr))

m <- Model("test2.lua")
b <- Basin(m, 1, c(-1.5,1.5), 600, c(-1.5, 1.5), 600, 100, 20) 
system.time( while(!b$finished()) b$step() )
mat <- b$getData()
image(mat[,600:1], breaks=c(0.5, 1.5, 2.5, 3.5) , col=rainbow(3) )

m <- Model("OL3G.lua")
b <- Basin(m, c(1,55,150,0.3,4.46,1), c(0,55), 600, c(0, 55), 600, 300, 150)
system.time( while(!b$finished()) b$step() )
mat <- b$getData()
image(mat[,600:1], breaks=c(1:8-0.5) , col=rainbow(7) )
