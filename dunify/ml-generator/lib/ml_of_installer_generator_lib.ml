open Bos

let pp_module_register fmt v =
  let modulename =
    (* staging-unixutils ==> Dkml_component_staging_unixutils *)
    "dkml-component-" ^ v |> String.capitalize_ascii
    |> String.map (function '-' -> '_' | c -> c)
  in
  Fmt.pf fmt "let () = %s.register ()" modulename

(** Regex that matches ["(*TEMPLATE: register ()*)"] with varying whitespace *)
let re_register =
  let open Re in
  compile
    (seq
       [
         str "(*";
         rep space;
         str "TEMPLATE:";
         rep1 space;
         str "register";
         rep1 space;
         str "()";
         rep space;
         str "*)";
       ])

(** Regex that matches ["failwith \"TEMPLATE: target_abi\""] with varying whitespace *)
let re_target_abi =
  let open Re in
  compile (seq [ str "failwith"; rep1 space; str {|"TEMPLATE: target_abi"|} ])

let templatized_content ~registration_statements ~target_abi content =
  let s = content in
  let s =
    Re.replace_string ~all:true re_register ~by:registration_statements s
  in
  Re.replace_string ~all:true re_target_abi
    ~by:
      ("Dkml_install_api.Context.Abi_v2."
      ^ Dkml_install_api.Context.Abi_v2.to_string target_abi)
    s

let copy_with_templates ~target_abi ~components ~output_file content =
  let registration_statements =
    Fmt.str "%a" Fmt.(list ~sep:(any "@\n") pp_module_register) components
  in
  let ( let* ) = Rresult.R.bind in
  let* z =
    OS.File.with_oc output_file
      (fun oc () ->
        output_string oc
          (templatized_content ~registration_statements ~target_abi content);
        flush oc;
        Ok ())
      ()
  in
  z
