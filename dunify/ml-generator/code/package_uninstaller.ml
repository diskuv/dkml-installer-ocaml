open Cmdliner
open Dkml_package_console_uninstaller

(* TEMPLATE: register () *)

let uninstall_cmd =
  let doc = "the DKML OCaml uninstaller" in
  ( Term.(
      const uninstall
      $ const (failwith "TEMPLATE: target_abi")
      $ const Private_common.program_name
      $ Dkml_package_console_common.package_args_t
          ~program_name:Private_common.program_name
          ~target_abi:(failwith "TEMPLATE: target_abi")),
    Term.info "dkml-package-uninstaller" ~version:"%%VERSION%%" ~doc )

let () =
  Term.(
    exit
    @@ Dkml_install_runner.Error_handling.catch_cmdliner_eval
         (fun () -> eval ~catch:false uninstall_cmd)
         (`Error `Exn))
