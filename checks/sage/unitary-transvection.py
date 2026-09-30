"""II §4, lemma 2: limited exact check of the printed sign.

Scope: alternating rank-two form, J=id, a=(1,0), b=(0,1),
over QQ and GF(3), GF(5), GF(7), GF(2). Both signs preserve the form;
only the corrected minus sends a onto b*mu outside characteristic two.
This is a counterexample to the printed plus, not a general proof.
The general identity is f(c,a)=1 and a-c=b*mu.
"""
from sage.all import QQ, GF, matrix, vector, version

print(version())
tests = 0
for K in [QQ, GF(3), GF(5), GF(7), GF(2)]:
    F = matrix(K, [[0, 1], [-1, 0]])
    a = vector(K, [1, 0])
    b = vector(K, [0, 1])
    mu = (a * F * b) ** (-1)
    c = a - b * mu
    original = matrix.identity(K, 2) + c.column() * c.row() * F
    corrected = matrix.identity(K, 2) - c.column() * c.row() * F
    assert original.transpose() * F * original == F
    tests += 1
    assert corrected.transpose() * F * corrected == F
    tests += 1
    assert corrected * a == b * mu
    tests += 1
    if K.characteristic() != 2:
        assert matrix(K, [original * a, b]).det() != 0
        tests += 1
    print(K, "mu=", mu, "original u(a)=", original * a,
          "corrected u(a)=", corrected * a)
print("PASS", tests, "exact Sage assertions")
