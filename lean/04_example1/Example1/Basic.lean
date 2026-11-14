import Mathlib  -- Run: lake build
open Matrix Complex
-- Definitions: the data of Example 1
def A: Matrix (Fin 2) (Fin 2) ℂ := !![1, 1 + I; 1 + I, 2 * I]
def b: Fin 2 → ℂ := ![1, 0]
noncomputable def solution: Fin 2 → ℂ := ![1 / 9, (1 - I) / 9]  -- x-dagger
-- Theorems and proofs
theorem matrix_is_symmetric: Aᵀ = A := by ext i j; fin_cases i <;> fin_cases j <;> rfl
theorem solution_is_least_squares: Aᴴ *ᵥ (b - A *ᵥ solution) = 0 := by
  ext i; fin_cases i <;>
    simp [A, b, solution, mulVec, dotProduct, Fin.sum_univ_two, Complex.ext_iff] <;> norm_num
theorem solution_is_in_adjoint_range: solution = Aᴴ *ᵥ ![1 / 9, 0] := by
  ext i; fin_cases i <;> simp [A, solution, mulVec, dotProduct, Fin.sum_univ_two]; ring_nf
-- List the proof's axiom dependencies
#print axioms solution_is_least_squares
