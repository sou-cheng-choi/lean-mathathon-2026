-- Run: lake env lean MyProofs/Solutions.lean
import Mathlib

open Matrix ComplexConjugate

theorem adjoint_of_symmetric_is_conjugate (n: ℕ) (A: Matrix (Fin n) (Fin n) ℂ) (symmetry: Aᵀ = A):
    Aᴴ = A.map conj := by
  rw [Matrix.conjTranspose, symmetry]
  rfl

theorem lift_removes_second_component:
    (![1, 2]: Fin 2 → ℂ) - ((![0, 2] ⬝ᵥ ![1, 2]) / (star ![0, 2] ⬝ᵥ ![0, 2])) • star ![0, 2]
      = ![1, 0] := by
  ext i
  fin_cases i <;> simp [dotProduct, Fin.sum_univ_two]

theorem coefficient_from_inner_product {V: Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
    (u w x: V) (c: ℂ) (nonzero: u ≠ 0) (decomposition: x = c • u + w) (orthogonality: inner ℂ u w = 0):
    c = inner ℂ u x / ((‖u‖ ^ 2: ℝ): ℂ) := by
  subst decomposition
  rw [inner_add_right, orthogonality, inner_smul_right, inner_self_eq_norm_sq_to_K]
  have: (‖u‖: ℂ) ≠ 0 := by exact_mod_cast norm_ne_zero_iff.mpr nonzero
  push_cast
  field_simp
  simp

#print axioms adjoint_of_symmetric_is_conjugate
#print axioms lift_removes_second_component
#print axioms coefficient_from_inner_product
