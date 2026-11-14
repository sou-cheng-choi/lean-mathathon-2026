-- Run: lake build Example1 Challenge && lake comparator
import Mathlib
open Matrix Complex

def A: Matrix (Fin 2) (Fin 2) ℂ := !![1, 1 + I; 1 + I, 2 * I]
def b: Fin 2 → ℂ := ![1, 0]
noncomputable def solution: Fin 2 → ℂ := ![1 / 9, (1 - I) / 9]
noncomputable def iterate: Fin 2 → ℂ := ![1 / 3, 0]
noncomputable def residualVector: Fin 2 → ℂ := b - A *ᵥ iterate
noncomputable def liftCoefficient: ℂ := residualVector ⬝ᵥ iterate / (star residualVector ⬝ᵥ residualVector)

theorem matrix_is_symmetric: Aᵀ = A := by sorry

theorem solution_is_least_squares: Aᴴ *ᵥ (b - A *ᵥ solution) = 0 := by sorry

theorem solution_is_in_adjoint_range: solution = Aᴴ *ᵥ ![1 / 9, 0] := by sorry

theorem iterate_is_in_trial_space: iterate = (1 / 3: ℂ) • star b := by sorry

theorem residual_value: residualVector = ![2 / 3, -(1 + I) / 3] := by sorry

theorem conjugate_residual_value: star residualVector = ![2 / 3, (-1 + I) / 3] := by sorry

theorem iterate_is_stationary: Aᴴ *ᵥ residualVector = 0 := by sorry

theorem iterate_is_not_minimum_norm: iterate ≠ solution := by sorry

theorem lift_coefficient_value: liftCoefficient = 1 / 3 := by sorry

theorem lift_gives_minimum_norm: iterate - liftCoefficient • star residualVector = solution := by sorry
