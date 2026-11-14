-- Run: lean bad.lean   (core Lean, no project; or paste the file into https://live.lean-lang.org)
/-! Backup slide "The Three Axioms and sorry": a false statement compiles with `sorry`,
and `#print axioms` shows it. -/
theorem unproved_false_claim: 1 + 1 = 3 := by sorry  -- false, admitted
#print axioms unproved_false_claim                   -- axioms: [sorryAx]
theorem one_plus_one_equals_two: 1 + 1 = 2 := rfl    -- a real proof, by computation
#print axioms one_plus_one_equals_two                -- 'one_plus_one_equals_two' does not depend on any axioms
