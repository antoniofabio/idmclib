--%  ft| TRAJECTORY_T0_V0_A1_O0 sn| k:~1~~z:~1.1~~r1:~0.75~~r2:~-7~~r3:~2.85~~r4:~1~~r5:~1~~tran:~300~~ n| #0 d| 1 n| #1 d| 1.1 n| #2 d| 0.75 n| #3 d| -7 n| #4 d| 2.85 n| #5 d| 1 n| #6 d| 1 n| #7 d| 300 n| #8 d| 1000 n| #9 d| 1300 n| #10 d| k n| #11 d| z 
--%  ft| TRAJECTORY_T0_V0_A1_O0 sn| k:~1~~z:~1.1~~r1:~0.311~~r2:~-7~~r3:~2.8~~r4:~1~~r5:~1~~tran:~1000~~ n| #0 d| 1 n| #1 d| 1.1 n| #2 d| 0.311 n| #3 d| -7 n| #4 d| 2.8 n| #5 d| 1 n| #6 d| 1 n| #7 d| 1000 n| #8 d| 1000 n| #9 d| 2000 n| #10 d| k n| #11 d| z 
--%  ft| TRAJECTORY_T0_V0_A1_O0 sn| k:~1~~z:~1.1~~r1:~0.75~~r2:~-7~~r3:~2.8~~r4:~1~~r5:~1~~tran:~1000~~ n| #0 d| 1 n| #1 d| 1.1 n| #2 d| 0.75 n| #3 d| -7 n| #4 d| 2.8 n| #5 d| 1 n| #6 d| 1 n| #7 d| 1000 n| #8 d| 1000 n| #9 d| 2000 n| #10 d| k n| #11 d| z 
--%  ft| TRAJECTORY_T0_V0_A1_O0 sn| k:~1.1~~z:~1.3~~c:~0~~St:~0~~r1:~0.75~~r2:~-2.75~~r3:~17~~r4:~3~~ n| #0 d| 1.1 n| #1 d| 1.3 n| #2 d| 0 n| #3 d| 0 n| #4 d| 0.75 n| #5 d| -2.75 n| #6 d| 17 n| #7 d| 3 n| #8 d| 1 n| #9 d| 1000 n| #10 d| 1000 n| #11 d| 2000 n| #12 d| k n| #13 d| z 
--%  ft| TRAJECTORY_T0_V0_A1_O0 sn| k:~0.8~~z:~0.9~~C:~0~~W:~0~~r1:~0.71~~r2:~-7~~r3:~3~~tran:~1000~~ n| #0 d| 0.8 n| #1 d| 0.9 n| #2 d| 0 n| #3 d| 0 n| #4 d| 0.71 n| #5 d| -7 n| #6 d| 3 n| #7 d| 1000 n| #8 d| 1000 n| #9 d| 2000 n| #10 d| C n| #11 d| W 
--%  ft| TRAJECTORY_T0_V0_A1_O0 sn| chaosarnold n| #0 d| 0.8 n| #1 d| 0.9 n| #2 d| 0 n| #3 d| 0 n| #4 d| 0 n| #5 d| 0.39 n| #6 d| -5 n| #7 d| 1 n| #8 d| 1000 n| #9 d| 2000 n| #10 d| 3000 n| #11 d| k n| #12 d| z 
--@@
name = "OLG4double"
description = "See Model refs in user's guide"
type = "D"
parameters = {"r1", "r2","r3"}
variables = {"k", "z", "C","W", "S"}

function f (r1,r2,r3,k,z,C, W,S)


                  alpha=r1
                  gamma=r2
                  mu=r3
                  PFt=(1/alpha)*(1-alpha+alpha*k^(gamma))^(1/gamma)
                  PFs=(1/alpha)*(1-alpha+alpha*z^(gamma))^(1/gamma)
                  rot=(alpha+(1-alpha)*k^(-gamma))^((1-gamma)/gamma)
                  ros=(alpha+(1-alpha)*z^(-gamma))^((1-gamma)/gamma)
                  wt=PFt-rot*k
                  ws=PFs-ros*z
                  St=(wt+math.log(rot/r3))/(1+rot)
                  Ss=(ws+math.log(ros/r3))/(1+ros)
                 
               

	k1=St-rot*(Ss-k)
                  z1=k

                  PFtt=(1/alpha)*(1-alpha+alpha*k1^(gamma))^(1/gamma)
                  rott=(alpha+(1-alpha)*k1^(-gamma))^((1-gamma)/gamma)
                  W1=PFtt-rott*k1

                  C1=(1/(1+rott))*(rott*W1+math.log(r3/rott))
                  S1=W1-C1

return     k1, z1,C1,W1,S1

end

