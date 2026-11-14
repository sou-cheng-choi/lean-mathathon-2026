-- Run: lake build
/-- `sumOfOddNumbers n = 1 + 3 + ... + (2n - 1)`, the sum of the first `n` odd numbers. -/
def sumOfOddNumbers: Nat → Nat
  | 0 => 0
  | n + 1 => sumOfOddNumbers n + (2 * n + 1)

theorem sum_of_odds_equals_square (n: Nat): sumOfOddNumbers n = n * n := by
  induction n with
  | zero => rfl
  | succ n inductionHypothesis => rw [sumOfOddNumbers, inductionHypothesis, Nat.add_mul, Nat.mul_add]; omega
