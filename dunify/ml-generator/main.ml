open Cmdliner
open Bos

let write_create_installers_ml fmt =
  Fmt.pf fmt "%s"
    {|
    let () = Cmdliner.Term.(exit @@ Dkml_package_console_setup.create_installers ())
    |};
  Format.pp_print_flush fmt ()

let write_package_setup_ml fmt =
  Fmt.pf fmt "%s"
    {|
    open Cmdliner
    open Dkml_package_console_setup
    
    let setup_cmd =
      let doc = "the DKML OCaml installer" in
      ( Term.(
          const setup
          $ const Private_common.program_name
          $ Dkml_package_console_common.package_args_t
              ~program_name:Private_common.program_name),
        Term.info "dkml-package-setup" ~version:"%%VERSION%%" ~doc )
    
    let () =
      Term.(
        exit
        @@ Dkml_install_runner.Error_handling.catch_cmdliner_eval
             (fun () -> eval ~catch:false setup_cmd)
             (`Error `Exn))    
    |};
  Format.pp_print_flush fmt ()

let write_package_uninstaller_ml fmt =
  Fmt.pf fmt "%s"
    {|
    open Cmdliner
    open Dkml_package_console_uninstaller
    
    let uninstall_cmd =
      let doc = "the DKML OCaml uninstaller" in
      ( Term.(
          const uninstall
          $ const Private_common.program_name
          $ Dkml_package_console_common.package_args_t
              ~program_name:Private_common.program_name),
        Term.info "dkml-package-uninstaller" ~version:"%%VERSION%%" ~doc )
    
    let () =
      Term.(
        exit
        @@ Dkml_install_runner.Error_handling.catch_cmdliner_eval
             (fun () -> eval ~catch:false uninstall_cmd)
             (`Error `Exn))        
    |};
  Format.pp_print_flush fmt ()

let main () =
  Rresult.R.error_msg_to_invalid_arg
    (let ( let* ) = Rresult.R.bind in
     let* z =
       OS.File.with_oc
         (Fpath.v "create_installers.ml")
         (fun oc () ->
           let fmt = Format.formatter_of_out_channel oc in
           write_create_installers_ml fmt;
           Ok ())
         ()
     in
     let* () = z in
     let* z =
       OS.File.with_oc
         (Fpath.v "package_setup.ml")
         (fun oc () ->
           let fmt = Format.formatter_of_out_channel oc in
           write_package_setup_ml fmt;
           Ok ())
         ()
     in
     let* () = z in
     let* z =
       OS.File.with_oc
         (Fpath.v "package_uninstaller.ml")
         (fun oc () ->
           let fmt = Format.formatter_of_out_channel oc in
           write_package_uninstaller_ml fmt;
           Ok ())
         ()
     in
     z)

let main_t = Term.(const main $ const ())

let () =
  let doc =
    "Writes $(b,.ml) files that are used by dune-of-installer-generator.exe"
  in
  Term.(exit @@ eval (main_t, info "ml-of-installer-generator" ~doc))
