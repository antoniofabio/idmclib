#{"gamma", "delta", "C", "lambda", "alpha", "beta", "m", "gn"}
./trajectory.tcl infjac.lua "0.95 0.5 0.0001 30000 1 0.35 0.05 0.02" "0 0.01 0 0.01" 3 1e5

#gamma=0.7
./find_attractors.tcl infjac.lua \
	"0.7 0.5 0.0001 30000 1 0.35 0.05 0.02" \
	"0.01 0.05 100" "0.01 0.05 100" \
	1e-4 5000 100 \
	20 0 1 \
	"0.01 0.01 0.01 0.01"

#lambda=12500
./find_attractors.tcl infjac.lua \
	"0.95 0.5 0.0001 12500 1 0.35 0.05 0.02" \
	"0.01 0.05 100" "0.01 0.05 100" \
	1e-4 5000 100 \
	20 0 1 \
	"0.01 0.01 0.01 0.01"

#lambda=12500, more tries, less attractor iterations
./find_attractors.tcl infjac.lua \
	"0.95 0.5 0.0001 12500 1 0.35 0.05 0.02" \
	"0.01 0.05 100" "0.01 0.05 100" \
	1e-4 5000 10 \
	100 0 1 \
	"0.01 0.01 0.01 0.01"

##FULL ALGORITHM
#lambda=12500
./basin_multi.tcl infjac.lua infjac.dat "0.95 0.5 0.0001 12500 1 0.35 0.05 0.02" "0.01 0.05 100" "0.01 0.05 100" 1e-4 5000 100 20 0 1 "0.01 0.01 0.01 0.01"
