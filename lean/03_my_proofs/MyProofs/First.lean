import Mathlib  -- Run: lake env lean MyProofs/First.lean
open ComplexConjugate

theorem conjugate_product_is_real (z: ℂ): (conj z * z).im = 0 := by
  simp [Complex.mul_im]   -- expand the imaginary part
  ring                    -- prove the two terms sum to zero
