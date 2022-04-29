open Cmdliner
open Bos

let copy_as_is file =
  let content =
    match Code.read file with
    | Some x -> x
    | None -> failwith (Fmt.str "No %s in crunched code.ml" file)
  in
  let ( let* ) = Rresult.R.bind in
  let* z =
    OS.File.with_oc (Fpath.v file)
      (fun oc () ->
        let fmt = Format.formatter_of_out_channel oc in
        Fmt.pf fmt "%s" content;
        Format.pp_print_flush fmt ();
        Ok ())
      ()
  in
  z

let pp_module_register fmt v =
  let modulename =
    (* staging-unixutils ==> Dkml_component_staging_unixutils *)
    "dkml-component-" ^ v |> String.capitalize_ascii
    |> String.map (function '-' -> '_' | c -> c)
  in
  Fmt.pf fmt "let () = %s.register ()" modulename

(** [copy_with_templates ~components file] copies [file] into the current
    directory with replacing the comment ["(* TEMPLATE: register () *)"]
    with [component.register ()] invocations for all [components]. *)
let copy_with_templates ~components file =
  let content = Option.get (Code.read file) in
  let registration_statements =
    Fmt.str "%a" Fmt.(list ~sep:(any "@\n") pp_module_register) components
  in
  let templatized_content =
    (Str.global_replace
       (Str.regexp_string "(* TEMPLATE: register () *)")
       registration_statements)
      content
  in
  let ( let* ) = Rresult.R.bind in
  let* z =
    OS.File.with_oc (Fpath.v file)
      (fun oc () ->
        let fmt = Format.formatter_of_out_channel oc in
        Fmt.pf fmt "%s" templatized_content;
        Format.pp_print_flush fmt ();
        Ok ())
      ()
  in
  z

let main () =
  let components = Common_installer_generator.ocamlfind () in

  Rresult.R.error_msg_to_invalid_arg
    (let ( let* ) = Rresult.R.bind in
     let* () = copy_as_is "discover.ml" in
     let* () = copy_as_is "entry_main.ml" in
     let* () = copy_as_is "entry-application.manifest" in
     let* () = copy_as_is "entry_assembly_manifest.ml" in
     let* () = copy_with_templates ~components "create_installers.ml" in
     let* () = copy_with_templates ~components "runner_admin.ml" in
     let* () = copy_with_templates ~components "runner_user.ml" in
     let* () = copy_with_templates ~components "package_setup.ml" in
     let* () = copy_with_templates ~components "package_uninstaller.ml" in
     Ok ())

let main_t = Term.(const main $ const ())

let () =
  let doc =
    "Writes $(b,.ml) files that are used by dune-of-installer-generator.exe"
  in
  Term.(exit @@ eval (main_t, info "ml-of-installer-generator" ~doc))
