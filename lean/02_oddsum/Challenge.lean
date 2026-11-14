-- Run: lake build Oddsum Challenge && lake comparator --paranoid --config oddsum.json
def sumOfOddNumbers: Nat → Nat
  | 0 => 0
  | n + 1 => sumOfOddNumbers n + (2 * n + 1)

theorem sum_of_odds_equals_square (n: Nat): sumOfOddNumbers n = n * n := by
  sorry
