"""Three bounded exact checks for accepted Dieudonne 1974 errata.

These are counterexamples to the printed statements, not proofs of the
corrected theorems. II9 checks one isotropic example over Q; II10 checks one
symplectic change of basis over F2(t); II12 checks a proper central subgroup
in SO(6) using rational matrices valid over R. No simplicity assertion for
SO(n), PSO(n), or all orthogonal groups is established by this script.
"""
from sage.all import *
import json
from pathlib import Path
import hashlib
from datetime import datetime, timezone
from sage.env import SAGE_VERSION
results = {}
# II9(8): fixing a forces the whole line Ka to be fixed.
F = QQ
a = vector(F, [1,0,0,0,0]); b=2*a; bp=3*a
B = matrix(F,5,5,lambda i,j: 1 if (i,j) in [(0,1),(1,0),(2,3),(3,2),(4,4)] else 0)
assert all(v*B*v == 0 for v in [a,b,bp])
assert a*B*b == a*B*bp == 0
assert len({tuple(a),tuple(b),tuple(bp)}) == 3
assert 2*a != bp
results['II9_p8']={'counterexample':'a=e1,b=2e1,bprime=3e1 in split Q^5','verified':True}
# II10(21): coefficient convention is row i, column j.
R=PolynomialRing(GF(2),'t'); t=R.gen(); K=R.fraction_field(); t=K(t)
e=[vector(K,[int(i==j) for i in range(4)]) for j in range(4)]
U=matrix(K,[e[1]+e[3],e[0],e[3],e[2]]).transpose()
J=block_matrix(K,[[zero_matrix(K,2),identity_matrix(K,2)],[identity_matrix(K,2),zero_matrix(K,2)]])
assert U.transpose()*J*U == J
def Q(x): return x[0]*x[2]+x[1]*x[3]+t*x[3]**2
alpha=[Q(e[i]) for i in range(2)]; beta=[Q(e[2+i]) for i in range(2)]
rows=U.transpose(); A=rows[:2,:2]; Bm=rows[:2,2:]; C=rows[2:,:2]; D=rows[2:,2:]
def dickson(use_j):
    return sum(alpha[j if use_j else i]*A[i,j]*C[i,j]+beta[j if use_j else i]*Bm[i,j]*D[i,j]+Bm[i,j]*C[i,j] for i in range(2) for j in range(2))
disc=sum(Q(e[i])*Q(e[2+i]) for i in range(2))
disc1=sum(Q(U*e[i])*Q(U*e[2+i]) for i in range(2))
old=dickson(False); new=dickson(True)
assert old == 0 and new == t and disc == 0 and disc1 == t+t**2
assert disc1 != disc+old+old**2 and disc1 == disc+new+new**2
results['II10_eq21']={'old_D':str(old),'corrected_D':str(new),'Delta1':str(disc1),'symplectic':True}
# II12: definite f over R admits nontrivial scalar -I in SO(6).
I=identity_matrix(QQ,6); z=-I
assert z.transpose()*z==I and z.det()==1 and z!=I and z**2==I
# Exact universal centrality: z is scalar, so zX=Xz for arbitrary X.
S=PolynomialRing(QQ,36,'x'); X=matrix(S,6,6,S.gens())
assert matrix(S,z)*X == X*matrix(S,z)
g=matrix(QQ,I); g[0,0]=0;g[1,1]=0;g[0,1]=-1;g[1,0]=1
assert g.transpose()*g==I and g.det()==1 and g not in [I,z]
results['II12_SO6']={'nontrivial_proper_central_subgroup':'{I,-I}','orthogonal':True,'determinant':1,'universal_centrality':True}
results["audit"] = {"sage_version": SAGE_VERSION, "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), "run_utc": datetime.now(timezone.utc).isoformat(), "cases": 3, "scope": "three exact counterexamples; no general simplicity proof"}
print(json.dumps(results,ensure_ascii=False,indent=2))
