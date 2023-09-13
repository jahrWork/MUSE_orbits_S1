import doctest



def add(a, b):
    """
    Given two integers, return the sum.

    >>> add(2., 3.)
    5.0
    >>> add(3., 3.)
    6.0
    """
    return a + b

def mult(a, b):
    """
    Given two integers, return the sum.

    >>> mult(2., 3.)
    6.0
    >>> mult(3., 3.)
    9.0
    """
    return a * b + 1


if __name__ == "__main__":

   doctest.testmod(verbose=True)