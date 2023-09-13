
counter = 0 

def pure0(x): 
    
    return x + counter 

def impure1(x): 
    global counter
    counter = counter + 1 
  
    return x + counter 

def pure2(l): 

    #print( "id =", id(l)) 
    l = l + ["a"] 
    #print( "id =", id(l)) 
  
    return l  

def impure3(l): 
    
    #print( "id =", id(l)) 
    l +=  ["a"] 
    #print( "id =", id(l)) 
  
    return l 


print("pure0(10) =", pure0(10))
print("pure0(10) =", pure0(10))
print("impure1(10) =", impure1(10))
print("impure1(10) =", impure1(10))


l = [ "a", "b"]
print( "pure2(l) = ", pure2(l) )
print( "pure2(l) = ", pure2(l) )


l = [ "a", "b"]
print( "impure3(l) = ", impure3(l) )
print( "impure3(l) = ", impure3(l) )
