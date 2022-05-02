open Cmdliner
open Bos
open Dkml_install_api

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

let main () =
  let components = Common_installer_generator.ocamlfind () in

  let copy ~target_abi ~components filename =
    let content = Option.get (Code.read filename) in
    Ml_of_installer_generator_lib.copy_with_templates ~target_abi ~components
      ~output_file:(Fpath.v filename) content
  in

  Rresult.R.error_msg_to_invalid_arg
    (let ( let* ) = Rresult.R.bind in
     let* target_abi =
       Rresult.R.error_to_msg ~pp_error:Fmt.string
         (Dkml_install_runner.Ocaml_abi.create_v2 ())
     in
     let* () = copy_as_is "discover.ml" in
     let* () = copy_as_is "entry-application.manifest" in
     let* () = copy_as_is "entry_assembly_manifest.ml" in
     let* () = copy ~target_abi ~components "entry_main.ml" in
     let* () = copy ~target_abi ~components "create_installers.ml" in
     let* () = copy ~target_abi ~components "runner_admin.ml" in
     let* () = copy ~target_abi ~components "runner_user.ml" in
     let* () = copy ~target_abi ~components "package_setup.ml" in
     let* () = copy ~target_abi ~components "package_uninstaller.ml" in
     Ok ())

let target_abi_t =
  let open Context.Abi_v2 in
  let l =
    List.map (fun v -> (to_canonical_string v, v)) Context.Abi_v2.values
  in
  Arg.(required & opt (some (enum l)) None & info [ "abi" ])

let main_t = Term.(const main $ const ())

let () =
  let doc =
    "Writes $(b,.ml) files that are used by dune-of-installer-generator.exe"
  in
  Term.(exit @@ eval (main_t, info "ml-of-installer-generator" ~doc))
