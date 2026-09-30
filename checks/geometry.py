"""Bounded checks of the two constructions and III.3 matrix distance.

Exact Fraction arithmetic; exhaustive symmetric 2x2 matrices over F_3.
These examples supplement, rather than replace, the source proof.
"""
from fractions import Fraction as F
from itertools import product
import platform

def sub(a, b): return tuple(x-y for x,y in zip(a,b))
def add(a, b): return tuple(x+y for x,y in zip(a,b))
def scale(a, t): return tuple(x*t for x in a)
def det(a, b): return a[0]*b[1]-a[1]*b[0]
e1, e2 = (F(5,2), F(0)), (F(7,10), F(17,10))
for a,b in [(F(17,10),F(13,20)), (F(1,2),F(14,5))]:
    u = add(scale(e1,a), e2)
    r = scale(e1,a+b)
    assert det(sub(u, scale(e1,a)),e2)==0
    assert det(sub(r,u),sub(scale(e1,b),e2))==0
    upper = scale(e2,b)
    result = scale(e1,a*b)
    assert det(sub(result,upper),sub(scale(e1,a),e2))==0
    assert det(sub(scale(e1,b),upper),sub(e1,e2))==0
print('Python', platform.python_version())
print('Two affine constructions: exact parallels and sum/product verified.')

def rank(a, p=3):
    a = [[x%p for x in row] for row in a]
    r = 0
    for j in range(len(a[0])):
        i = next((i for i in range(r,len(a)) if a[i][j]),None)
        if i is None: continue
        a[r],a[i]=a[i],a[r]
        inv = pow(a[r][j],-1,p)
        a[r]=[(x*inv)%p for x in a[r]]
        for i in range(len(a)):
            if i!=r:
                t=a[i][j]
                a[i]=[(x-t*y)%p for x,y in zip(a[i],a[r])]
        r+=1
    return r

matrices = [[[a,b],[b,c]] for a,b,c in product(range(3),repeat=3)]
checks=0
for z in matrices:
    w=[z[0]+[1,0],z[1]+[0,1]]
    assert rank(w)==2
    for z1 in matrices:
        w1=[z1[0]+[1,0],z1[1]+[0,1]]
        difference=[[z[i][j]-z1[i][j] for j in range(2)] for i in range(2)]
        deviation=rank(w+w1)-2
        assert deviation == rank(difference)
        checks+=1
print('III.3: rank(F)=rank(Z-Z1)=projective deviation:',checks,'pairs over F_3.')
