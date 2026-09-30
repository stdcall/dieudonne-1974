import Mathlib.Algebra.Field.Defs
import Mathlib.Algebra.Group.Prod

/-!
I §1: a collineation fixing every line is a homothety.
This file proves the key additive step for a two-dimensional right
coordinate space over an arbitrary division ring. No commutativity is
assumed. `rightScale x c` is the book's x*c. The line hypothesis supplies
a possibly different scalar for every vector; additivity forces one
common scalar. Bijectivity and the extension to higher dimension are
not formalized here.
-/

namespace Dieudonne

def rightScale {K : Type*} [DivisionRing K] (x : K × K) (c : K) : K × K :=
  (x.1 * c, x.2 * c)

theorem additive_line_preserver_scalar {K : Type*} [DivisionRing K]
    (u : K × K → K × K)
    (hadd : ∀ x y, u (x + y) = u x + u y)
    (hline : ∀ x, ∃ c, u x = rightScale x c) :
    ∃ c, ∀ x, u x = rightScale x c := by
  obtain ⟨c, hc⟩ := hline (1, 0)
  obtain ⟨d, hd⟩ := hline (0, 1)
  obtain ⟨e, he⟩ := hline (1, 1)
  have hsum : rightScale (1, 1) e =
      rightScale (1, 0) c + rightScale (0, 1) d := by
    rw [← he, ← hc, ← hd, ← hadd]
    simp
  have hec : e = c := by
    have h := congrArg Prod.fst hsum
    simpa [rightScale] using h
  have hed : e = d := by
    have h := congrArg Prod.snd hsum
    simpa [rightScale] using h
  have hdc : d = c := hed.symm.trans hec
  have hx : ∀ a, u (a, 0) = rightScale (a, 0) c := by
    intro a
    obtain ⟨p, hp⟩ := hline (a, 0)
    obtain ⟨q, hq⟩ := hline (a, 1)
    have h : rightScale (a, 1) q =
        rightScale (a, 0) p + rightScale (0, 1) d := by
      rw [← hq, ← hp, ← hd, ← hadd]
      simp
    have hqc : q = c := by
      have hs := congrArg Prod.snd h
      simpa [rightScale, hdc] using hs
    have ha : a * p = a * c := by
      have hs := congrArg Prod.fst h
      simpa [rightScale, hqc] using hs.symm
    rw [hp]
    exact Prod.ext ha (by simp [rightScale])
  have hy : ∀ b, u (0, b) = rightScale (0, b) c := by
    intro b
    obtain ⟨p, hp⟩ := hline (0, b)
    obtain ⟨q, hq⟩ := hline (1, b)
    have h : rightScale (1, b) q =
        rightScale (1, 0) c + rightScale (0, b) p := by
      rw [← hq, ← hc, ← hp, ← hadd]
      simp
    have hqc : q = c := by
      have hs := congrArg Prod.fst h
      simpa [rightScale] using hs
    have hb : b * p = b * c := by
      have hs := congrArg Prod.snd h
      simpa [rightScale, hqc] using hs.symm
    rw [hp]
    exact Prod.ext (by simp [rightScale]) hb
  refine ⟨c, ?_⟩
  rintro ⟨a, b⟩
  have h : u (a, b) = u (a, 0) + u (0, b) := by
    simpa using hadd (a, 0) (0, b)
  rw [h, hx, hy]
  simp [rightScale]

end Dieudonne

#print axioms Dieudonne.additive_line_preserver_scalar
