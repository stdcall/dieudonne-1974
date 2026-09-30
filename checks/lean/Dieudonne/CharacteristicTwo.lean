import Mathlib.Algebra.Ring.Basic
import Mathlib.Tactic.NoncommRing

/-!
I §3 and I §4, (8). Here `R` can be a noncommutative endomorphism ring.
The explicit assumption `1+1=0` expresses characteristic two. The first
claim is the algebraic step u²=1 iff (u−1)²=0; the second derives the
missing Dλ term when replacing theta by theta+lambda. No division ring
classification or extension-of-automorphisms theorem is claimed.
-/

namespace Dieudonne

theorem involution_iff_nilpotent_shift {R : Type*} [Ring R]
    (hchar : (1 : R) + 1 = 0) (u : R) :
    u * u = 1 ↔ (u - 1) * (u - 1) = 0 := by
  have hdouble : u + u = 0 := by
    have h := congrArg (fun a : R => a * u) hchar
    simpa [add_mul] using h
  have hexpand : (u - 1) * (u - 1) = u * u - (u + u) + 1 := by
    noncomm_ring
  rw [hexpand, hdouble, sub_zero]
  constructor
  · intro h
    simpa [h] using hchar
  · intro h
    have hs := congrArg (fun a : R => a - 1) hchar
    have hneg : -(1 : R) = 1 := by simpa using hs.symm
    exact (eq_neg_of_add_eq_zero_left h).trans hneg

theorem artin_schreier_shift {R : Type*} [Ring R]
    (theta lambda : R) :
    ((theta + lambda) * (theta + lambda) + (theta + lambda)) -
        (theta * theta + theta) =
      (theta * lambda + lambda * theta) + lambda * lambda + lambda := by
  noncomm_ring

end Dieudonne

#print axioms Dieudonne.involution_iff_nilpotent_shift
#print axioms Dieudonne.artin_schreier_shift
