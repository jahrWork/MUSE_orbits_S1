

def f(x): 

    return x**2 

def g(x): 

    return x**3 



class operator:

    def __init__(self, function):
        self.function = function

    def __ror__(self, other):
        return operator(lambda x, self=self, other=other: self.function(other, x))

    def __or__(self, other):
        return self.function(other)

    def __rlshift__(self, other):
        return operator(lambda x, self=self, other=other: self.function(other, x))

    def __rshift__(self, other):
        return self.function(other)

    def __call__(self, a1, a2):
        return self.function(a1, a2)

# Examples

# function composition 
def compose(f, g):  

    def h(x): 
        return f( g(x) )

    return h 



o = operator(compose)

h = f |o| g

print( h(2.), 2**6 )


h = f <<o>> g
print( h(2.), 2**6 )

