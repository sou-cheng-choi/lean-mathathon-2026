-- Run: lake build MyProofs Challenge && lake comparator --paranoid --config my_proofs.json
import Mathlib
open Matrix ComplexConjugate

theorem conjugate_product_is_real (z: ℂ): (conj z * z).im = 0 := by sorry

theorem adjoint_of_symmetric_is_conjugate (n: ℕ) (A: Matrix (Fin n) (Fin n) ℂ) (symmetry: Aᵀ = A):
    Aᴴ = A.map conj := by sorry

theorem lift_removes_second_component:
    (![1, 2]: Fin 2 → ℂ) - ((![0, 2] ⬝ᵥ ![1, 2]) / (star ![0, 2] ⬝ᵥ ![0, 2])) • star ![0, 2]
      = ![1, 0] := by sorry

theorem coefficient_from_inner_product {V: Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
    (u w x: V) (c: ℂ) (nonzero: u ≠ 0) (decomposition: x = c • u + w) (orthogonality: inner ℂ u w = 0):
    c = inner ℂ u x / ((‖u‖ ^ 2: ℝ): ℂ) := by sorry
