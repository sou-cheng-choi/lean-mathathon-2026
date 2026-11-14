-- Run from csminares-reproduce/lean: lake environment lean ../../talk_caltech_mathathon/code/lean/lift_deps.lean
/-
What `csminares_lift` uses from our Lean code, for the slide "The Theorem We Will Prove" in
lean_talk.qmd. It walks the statement and proof of `csminares_lift`, and of every project
declaration (namespace `Csminares`) reached that way, and prints the names found. Names that Lean
generates internally (`_proof_1`, `_abel_1_1`, ...) are walked but not printed.

Conditionally reproducible (CR): it must run inside the Lean project, which is not yet released.
  cd csminares-reproduce/lean && lake environment lean ../../talk_caltech_mathathon/code/lean/lift_deps.lean
Expected (Lean 4.35.0): 15 declarations, 6 of them definitions, in Invariant, Trial, Lift, Matrix.
-/
import Csminares
open Lean Elab Command

run_cmd do
  let environment ← getEnv
  let isProjectDeclaration (name: Name): Bool := (`Csminares).isPrefixOf name
  let mut visited: NameSet := {}
  let mut pending: Array Name := #[`Csminares.csminares_lift]
  while !pending.isEmpty do
    let name := pending.back!
    pending := pending.pop
    if visited.contains name then continue
    visited := visited.insert name
    if let some declaration := environment.find? name then
      let mut dependencies := declaration.type.getUsedConstants
      if let some body := declaration.value? (allowOpaque := true) then
        dependencies := dependencies ++ body.getUsedConstants
      for dependency in dependencies do
        if isProjectDeclaration dependency && !visited.contains dependency then pending := pending.push dependency
  let namedDeclarations := (visited.toArray.filter (fun name => !name.isInternal)).qsort (fun first second => first.toString < second.toString)
  let definitions := namedDeclarations.filter (fun name => match environment.find? name with
    | some (.thmInfo _) => false
    | _ => true)
  logInfo m!"{namedDeclarations.size} declarations, {definitions.size} of them definitions {definitions.toList}: {namedDeclarations.toList}"
