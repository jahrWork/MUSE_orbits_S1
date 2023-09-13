
from numpy import array 

import Milestone1
import Milestone2

Milestone1.first_version()
Milestone1.abstraction_for_F()
Milestone1.abstraction_for_F_and_Euler()

Milestone2.Simulation(  tf = 10, N = 600, U0 = array( [ 1., 0., 0., 1. ] ) )


Milestone7.Simulation(  tf = 10000, N = 1000000, U0 = array( [ 1., 0., 0., 1. ] ) )
Milestone7.Simulation( U0 = array( [ 1., 0., 0., 1. ] ) )
Milestone7.Simulation( U0 = array( [ 1., 0., 0. ] ) )
Milestone7.Simulation(  tf = 10000, N = 1000000, U0 = array( [ 1., 0., 0., 1. ] ) )

