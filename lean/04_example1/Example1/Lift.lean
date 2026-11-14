-- Run: lake env lean Example1/Lift.lean
import Example1.Basic
open Matrix Complex
/-! Example 2 of the talk (slide "Check It by Hand"): Example 1's data, the stationary iterate
`iterate` of `span {conj b}`, and the minimum-norm lift `iterate - liftCoefficient conj residualVector = solution`. -/
-- The iterate, its residual, and the scalar used for the minimum-norm correction.
noncomputable def iterate: Fin 2 → ℂ := ![1 / 3, 0]
noncomputable def residualVector: Fin 2 → ℂ := b - A *ᵥ iterate
noncomputable def liftCoefficient: ℂ := residualVector ⬝ᵥ iterate / (star residualVector ⬝ᵥ residualVector)
-- Theorems
theorem iterate_is_in_trial_space: iterate = (1 / 3: ℂ) • star b := by
  ext i; fin_cases i <;> simp [iterate, b]
theorem residual_value: residualVector = ![2 / 3, -(1 + I) / 3] := by
  ext i; fin_cases i <;> simp [residualVector, iterate, A, b] <;> ring
theorem conjugate_residual_value: star residualVector = ![2 / 3, (-1 + I) / 3] := by
  rw [residual_value]; ext i; fin_cases i <;> simp [Complex.ext_iff]
theorem iterate_is_stationary: Aᴴ *ᵥ residualVector = 0 := by
  rw [residual_value]; ext i; fin_cases i <;>
    simp [A, mulVec, dotProduct, Fin.sum_univ_two, Complex.ext_iff] <;> norm_num
theorem iterate_is_not_minimum_norm: iterate ≠ solution := by
  intro sameSolution; have firstEntry := congrFun sameSolution 0; simp [iterate, solution] at firstEntry
theorem lift_coefficient_value: liftCoefficient = 1 / 3 := by
  have numerator_value: residualVector ⬝ᵥ iterate = 2 / 9 := by
    rw [residual_value]; simp [iterate, dotProduct, Fin.sum_univ_two]; ring
  have denominator_value: star residualVector ⬝ᵥ residualVector = 2 / 3 := by
    rw [conjugate_residual_value, residual_value]; simp [dotProduct, Fin.sum_univ_two, Complex.ext_iff]; norm_num
  rw [liftCoefficient, numerator_value, denominator_value]; norm_num
theorem lift_gives_minimum_norm: iterate - liftCoefficient • star residualVector = solution := by
  rw [lift_coefficient_value, conjugate_residual_value]; ext i; fin_cases i <;> simp [iterate, solution, Complex.ext_iff] <;> norm_num
#print axioms lift_gives_minimum_norm
