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
