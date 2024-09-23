module Orbits 

 function Kepler(U, t)

    # x, y, dxdt, dydt = U[1], U[2], U[3], U[4]
    x = U[1]; y =U[2];  dxdt = U[3]; dydt = U[4]
    d = ( x^2 + y^2 )^1.5

    return   [ dxdt, dydt, -x/d, -y/d ] 

 end 

 function Arenstorf_equations(U, t)          
   
     mu = 0.012277471
           
     x, y, vx, vy = U[1], U[2], U[3], U[4]   
 
     D1 =  ( (x+mu)^2     + y^2 )^1.5
     D2 =  ( (x-(1-mu))^2 + y^2 )^1.5
     
     dxdt = vx  
     dydt = vy  
     dvxdt = x + 2 * vy - (1-mu)*( x + mu )/D1 - mu*(x-(1-mu))/D2
     dvydt = y - 2 * vx - (1-mu) * y/D1 - mu * y/D2
    
     return [ dxdt, dydt, dvxdt, dvydt ] 

 end 

end 

