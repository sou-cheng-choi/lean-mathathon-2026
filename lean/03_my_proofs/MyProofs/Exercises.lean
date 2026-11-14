-- Run: lake env lean MyProofs/Exercises.lean
import Mathlib

open Matrix ComplexConjugate

/-! Exercises for the talk lean_talk.qmd. Replace each `sorry` with a proof.
    Check: no red underline, and `#print axioms` lists only the standard three.
    Run `make compare-exercises` to verify this file against the fixed challenge. -/

-- Exercise 1. Complex symmetric A: the conjugate transpose is the entrywise conjugate.
theorem adjoint_of_symmetric_is_conjugate (n: ℕ) (A: Matrix (Fin n) (Fin n) ℂ) (symmetry: Aᵀ = A):
    Aᴴ = A.map conj := by
  sorry   -- hint: rw [Matrix.conjTranspose, symmetry]

-- Exercise 2. The 2 x 2 example of the talk: x - conj r (r^T x) / (r* r) = x^dagger.
theorem lift_removes_second_component:
    (![1, 2]: Fin 2 → ℂ) - ((![0, 2] ⬝ᵥ ![1, 2]) / (star ![0, 2] ⬝ᵥ ![0, 2])) • star ![0, 2]
      = ![1, 0] := by
  sorry   -- hint: ext i; fin_cases i; simp [dotProduct, Fin.sum_univ_two]

-- Exercise 3. Step 3 of the proof: if x = c u + w and u is orthogonal to w, then c = <u, x> / |u|^2.
theorem coefficient_from_inner_product {V: Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
    (u w x: V) (c: ℂ) (nonzero: u ≠ 0) (decomposition: x = c • u + w) (orthogonality: inner ℂ u w = 0):
    c = inner ℂ u x / ((‖u‖ ^ 2: ℝ): ℂ) := by
  sorry
  -- hint: subst decomposition
  -- hint: rw [inner_add_right, orthogonality, inner_smul_right, inner_self_eq_norm_sq_to_K]
  -- hint: show (‖u‖: ℂ) ≠ 0, push_cast, then field_simp

#print axioms adjoint_of_symmetric_is_conjugate
#print axioms lift_removes_second_component
#print axioms coefficient_from_inner_product
