open Sexplib0.Sexp

let _vararg_of_string token sl =
  List ([ Atom token ] @ Stdlib.List.map (fun s -> Atom s) sl)

let _arg_of_string token s = List [ Atom token; Atom s ]

let rule l = List ([ Atom "rule" ] @ l)

let install l = List ([ Atom "install" ] @ l)

let section = _arg_of_string "section"

let files l = List ([ Atom "files" ] @ l)

let destination_file ~filename ~destination =
  List [ Atom filename; Atom "as"; Atom destination ]

let executable l = List ([ Atom "executable" ] @ l)

let deps l = List ([ Atom "deps" ] @ l)

let action l = List ([ Atom "action" ] @ l)

let progn l = List ([ Atom "progn" ] @ l)

let ocamlopt_flags l = List ([ Atom "ocamlopt_flags" ] @ l)

let run = _vararg_of_string "run"

let with_stdout_to file action =
  List [ Atom "with-stdout-to"; Atom file; action ]

let diff ~actual ~expected = List [ Atom "diff"; Atom actual; Atom expected ]

let diff_q ~actual ~expected = List [ Atom "diff?"; Atom actual; Atom expected ]

let public_name = _arg_of_string "public_name"

let named_dep ~name dep = List [ Atom (":" ^ name); Atom dep ]

let name = _arg_of_string "name"

let alias = _arg_of_string "alias"

let targets = _vararg_of_string "targets"

let target = _arg_of_string "target"

let libraries = _vararg_of_string "libraries"

let modules = _vararg_of_string "modules"

let modes_byte_exe = List [ Atom "modes"; List [ Atom "byte"; Atom "exe" ] ]
