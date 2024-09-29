
from numpy import array 
from ODES.Temporal_schemes import RK4, Embedded_RK 

import Milestone1
import Milestone2
import Milestone7

print( "*************** Results of Milestone1 ***************")
Milestone1.first_version()
Milestone1.abstraction_for_F()
Milestone1.abstraction_for_F_and_Euler()

print( "************** Results of Milestone2 ******************")
Milestone2.Simulation(  tf = 10, N = 600, U0 = array( [ 1., 0., 0., 1. ] ) )

print( "************** Results of Milestone7 ******************")
Milestone7.Arenstorf_orbit(tf = 17.0652165601579625,   
                           N = 10000, scheme = RK4) 
