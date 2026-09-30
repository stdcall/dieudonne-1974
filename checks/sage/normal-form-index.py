"""I §16, printed 59 / physical 58: check the polar ranks of the
printed and corrected finite-field normal forms for p=2..8 over GF(2).
The printed last hyperbolic cross term xi_(p-1) xi_(2p-2) is kept as
a refuted check. This does not establish classification over all fields.
"""
from sage.all import GF, matrix, version

print('SageMath', version())
checks = 0
for p in range(2, 9):
    corrected = matrix(GF(2), 2*p)
    printed = matrix(GF(2), 2*p)
    for i in range(p):
        j = p+i
        corrected[i,j] += 1
        corrected[j,i] += 1
        if i == p-2:
            j = 2*p-3
        printed[i,j] += 1
        printed[j,i] += 1
    assert corrected.rank() == 2*p
    assert printed.rank() != 2*p
    print(f'p={p}: printed rank={printed.rank()}, corrected rank={corrected.rank()}, expected={2*p}')
    checks += 2
print(f'ok normal-form-index: {checks} exact GF(2) rank checks')
