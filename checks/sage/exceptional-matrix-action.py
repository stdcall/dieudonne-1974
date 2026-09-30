"""Exact validation of IV §8 case8, printed page 174.

Checks the corrected matrix action's group law, determinant, quadratic-form
coordinates and K-rationality. DOES NOT prove the full exceptional isomorphism
PSL2(K1) -> POmega4(K,f), especially surjectivity. No numerical approximation.

Source hypotheses: charK != 2, a2 != 0, -a3/a2 nonsquare; K1=K(omega),
omega^2=-a3/a2. Printed action lacks transpose on bar(U) and gives the
coordinate-change basis B where the action requires B^-1. Both printed
readings remain refuted tests beside the corrected checks below.

The generic symbolic computation uses QQ(a,omega), a2=a, a3=-a*omega^2.
Generic SL2 chart r!=0 validates all four columns. Universal composition
and determinant identities hold for arbitrary matrices, independent of chart.
The source's form is xi1*xi4-a2*xi2^2-a3*xi3^2. Additional exact example:
K=QQ, K1=QQ(sqrt2), a2=1,a3=-2. Corrected labels retain
case:four-dimensional-nonsplit-isomorphism.
"""
from sage.all import QQ, QuadraticField, matrix, identity_matrix, vector

F = QuadraticField(2, "w")
w = F.gen()
U = matrix(F, [[1, 1], [0, 1]])
V = matrix(F, [[1, 0], [1, 1]])
X = identity_matrix(F, 2)
def bar(A):
    return A.apply_map(lambda x: x.galois_conjugate())
def printed(A, Y):
    return A * Y * bar(A)
def transposed(A, Y):
    return A * Y * bar(A).transpose()
def inverse(A, Y):
    return A * Y * bar(A).inverse()
assert U.det() == V.det() == 1
assert w**2 == 2
assert not QQ(2).is_square()
assert printed(U, printed(V, X)) != printed(U*V, X)
assert transposed(U, transposed(V, X)) == transposed(U*V, X)
assert inverse(U, inverse(V, X)) == inverse(U*V, X)
print("ok printed174 matrix group law: printed refuted, transpose/inverse pass")
print("printed composition", printed(U, printed(V, X)))
print("printed product", printed(U*V, X))

# Read the canonical coordinates as E11,E12,E21,E22, as in case7.
# This is an explicit interpretation, not an assertion that the author
# specified the matrix identification unambiguously in case8.
units = [matrix(F, [[1, 0], [0, 0]]), matrix(F, [[0, 1], [0, 0]]),
         matrix(F, [[0, 0], [1, 0]]), matrix(F, [[0, 0], [0, 1]])]
basis = [units[0], (w*units[1]+units[2])/(2*w),
         (w*units[1]-units[2])/(2*w), units[3]]
B = matrix(F, [x.list() for x in basis]).transpose()
assert B.det() != 0
for name, action in [("printed", printed), ("transpose", transposed),
                     ("inverse", inverse)]:
    M = B.inverse()*matrix(F, [action(U, x).list() for x in basis]).transpose()
    rational = all(x.galois_conjugate() == x for x in M.list())
    assert not rational
    assert all(action(U, x).det() == x.det() for x in basis)
    assert action(U, X).det() == X.det()
    print(name, "preserves determinant; not K-rational in printed basis", M)

# Exact verification of the corrected inverse basis.
# K = QQ(a,w^2,parameters), K1=K(w), w^2=-a3/a; conjugation w -> -w.
# Parameters r0,r1,etc. permit a generic matrix in SL2(K1) (r != 0).
from sage.all import PolynomialRing
R = PolynomialRing(QQ, names="a,z,r0,r1,s0,s1,t0,t1")
a,z,r0,r1,s0,s1,t0,t1 = R.gens()
L = R.fraction_field()
def conj_scalar(x):
    x = L(x)
    return L(x.numerator().subs({z:-z}))/L(x.denominator().subs({z:-z}))
def conjugate(A):
    return A.apply_map(conj_scalar)
P = matrix(L, [[1,0],[0,1/a]])
I = identity_matrix(L,2)
unit = [matrix(L, [[1,0],[0,0]]), matrix(L, [[0,1],[0,0]]),
        matrix(L, [[0,0],[1,0]]), matrix(L, [[0,0],[0,1]])]
printed_basis = [unit[0], (z*unit[1]+unit[2])/(2*z*a),
                 (z*unit[1]-unit[2])/(2*z),unit[3]]
correct_basis = [unit[0],a*unit[1]+unit[2],
                 z*(a*unit[1]-unit[2]),unit[3]]
B0 = matrix(L,[x.list() for x in printed_basis]).transpose()
B1 = matrix(L,[x.list() for x in correct_basis]).transpose()
assert B0*B1 == identity_matrix(L,4)
Q = matrix(L,[[0,0,0,QQ(1)/2],[0,-a,0,0],
             [0,0,a*z*z,0],[QQ(1)/2,0,0,0]])
Qdet = matrix(L,[[0,0,0,QQ(1)/2],[0,0,-QQ(1)/2,0],
                [0,-QQ(1)/2,0,0],[QQ(1)/2,0,0,0]])
assert B0.transpose()*Q*B0 == Qdet
assert B1.transpose()*Qdet*B1 == Q
r,s,t = r0+z*r1,s0+z*s1,t0+z*t1
Ug = matrix(L,[[r,s],[t,(1+s*t)/r]])
assert Ug.det() == 1
def action(A,X):
    return A*X*P*conjugate(A).transpose()*P.inverse()
M = B1.inverse()*matrix(L,[action(Ug,x).list()
                          for x in correct_basis]).transpose()
assert conjugate(M) == M
assert M.transpose()*Q*M == Q
assert all(conjugate(x*P).transpose() == x*P for x in correct_basis)
# Composition checked symbolically with unconstrained generic 2x2 U,V;
# this identity does not require either determinant condition.
S = PolynomialRing(QQ,names="a,z,u11,u12,u21,u22,v11,v12,v21,v22,x11,x12,x21,x22")
aa,zz,*entries = S.gens()
Fsym = S.fraction_field()
UU = matrix(Fsym,2,entries[:4])
VV = matrix(Fsym,2,entries[4:8])
XX = matrix(Fsym,2,entries[8:])
PP = matrix(Fsym,[[1,0],[0,1/aa]])
def b_sym(A):
    return A.apply_map(lambda x:Fsym(x.numerator().subs({zz:-zz}))/
                      Fsym(x.denominator().subs({zz:-zz})))
def a_sym(A,X):
    return A*X*PP*b_sym(A).transpose()*PP.inverse()
assert a_sym(UU,a_sym(VV,XX)) == a_sym(UU*VV,XX)
assert a_sym(UU,XX).det() == UU.det()*b_sym(UU).det()*XX.det()
print("ok inverse basis B0*B1=I; det realizes full generic quadratic form")
print("ok generic SL2 matrix: all four columns K-rational and M^t Q M=Q")
print("ok symbolic composition and determinant for arbitrary 2x2 matrices")

# Numeric nonsquare case from the original source hypotheses.
N = QuadraticField(2,"ww")
ww = N.gen()
nnunits = [matrix(N,2,x.list()) for x in unit]
nbasis = [nnunits[0],nnunits[1]+nnunits[2],
          ww*(nnunits[1]-nnunits[2]),nnunits[3]]
NB = matrix(N,[x.list() for x in nbasis]).transpose()
def nbar(A):
    return A.apply_map(lambda x:x.galois_conjugate())
def nact(A,X):
    return A*X*nbar(A).transpose()
NU = matrix(N,[[1,ww],[0,1]])
NV = matrix(N,[[1,0],[1+ww,1]])
NM = NB.inverse()*matrix(N,[nact(NU,x).list() for x in nbasis]).transpose()
assert nbar(NM)==NM
assert nact(NU,nact(NV,identity_matrix(N,2))) == nact(NU*NV,identity_matrix(N,2))
QN=matrix(N,[[0,0,0,QQ(1)/2],[0,-1,0,0],[0,0,2,0],[QQ(1)/2,0,0,0]])
assert NM.transpose()*QN*NM==QN
print("ok QQ(sqrt2),a2=1,a3=-2: rationality, group law, quadratic form")
print("numeric corrected action matrix",NM)

print("ok exceptional matrix action: 22 assertion statements, three printed-basis candidate checks; scope excludes surjectivity")
