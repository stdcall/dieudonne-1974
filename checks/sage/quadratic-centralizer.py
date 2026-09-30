"""I §4, (7)–(8): exact noncommutative counterexample to printed (8).

K = (F_4(t)/F_2(t), Frobenius, t), written a+b*rho, rho²=t.
theta in F_4 satisfies theta²+theta=1; rho*theta=(theta+1)*rho.
This cyclic quaternion algebra is a division algebra: the t-adic
valuations of N(a) and t*N(b) have different parity, so their sum cannot
vanish for (a,b) != (0,0). The computer checks the algebraic identities;
the valuation argument is separate and does not follow from sampling.
"""
from datetime import datetime, timezone
import json
from sage.all import GF, PolynomialRing, matrix
from sage.env import SAGE_VERSION

F4 = GF(4, name='theta')
theta0 = F4.gen()
L = PolynomialRing(F4, 't').fraction_field()
t = L.gen()
one = (L.one(), L.zero())
zero = (L.zero(), L.zero())


def frobenius(x):
    def apply(p):
        return L.ring()([c ** 2 for c in p.list()])
    return L(apply(x.numerator())) / L(apply(x.denominator()))


def add(x, y):
    return (x[0] + y[0], x[1] + y[1])


def mul(x, y):
    a, b = x
    c, d = y
    return (a*c + t*b*frobenius(d), a*d + b*frobenius(c))


def inverse(x):
    a, b = x
    norm = a*frobenius(a) + t*b*frobenius(b)
    assert norm != 0
    return (frobenius(a)/norm, b/norm)


def conjugate(c, x):
    return mul(mul(inverse(c), x), c)


theta = (L(theta0), L.zero())
rho = (L.zero(), L.one())
c = add(one, rho)
beta = one
sigma = lambda x: conjugate(rho, x)
tau = lambda x: conjugate(c, x)
D = lambda x: add(mul(theta, x), mul(x, theta))
lam = add(tau(theta), theta)
assert add(mul(theta, theta), theta) == beta
assert mul(rho, rho) == (t, L.zero())
assert sigma(theta) == add(theta, one)
assert D(rho) == rho
assert mul(c, inverse(c)) == one == mul(inverse(c), c)
basis = (one, theta, rho, mul(theta, rho))
for x in basis:
    assert sigma(sigma(x)) == x
    assert tau(sigma(x)) == sigma(tau(x))
    for y in basis:
        assert tau(mul(x, y)) == mul(tau(x), tau(y))
        for z in basis:
            assert mul(mul(x, y), z) == mul(x, mul(y, z))
for xi in (one, rho):
    assert sigma(xi) == xi
    assert add(tau(D(xi)), D(tau(xi))) == add(
        mul(lam, tau(xi)), mul(tau(xi), lam))
lhs = add(tau(beta), beta)
printed_rhs = add(mul(lam, lam), lam)
corrected_rhs = add(D(lam), printed_rhs)
assert lhs == zero
assert printed_rhs != lhs
assert corrected_rhs == lhs
assert D(lam) == (L.zero(), 1/(1+t))

print(json.dumps({
    'checked_at': datetime.now(timezone.utc).isoformat(),
    'sage_version': SAGE_VERSION,
    'passages': ['eq:centralizer-characteristic-two-derivation',
                 'eq:centralizer-characteristic-two-scalar'],
    'basis_associativity_cases': 64,
    'automorphism_multiplicativity_cases': 16,
    'lambda': [str(v) for v in lam],
    'D_lambda': [str(v) for v in D(lam)],
    'printed_rhs': [str(v) for v in printed_rhs],
    'corrected_rhs': [str(v) for v in corrected_rhs],
    'status': 'passed',
}, ensure_ascii=False))
