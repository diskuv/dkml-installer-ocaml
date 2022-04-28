(* TEMPLATE: register () *)

let () =
  Cmdliner.Term.(
    exit
    @@ Dkml_package_console_setup.create_installers Private_common.organization
         Private_common.program_name)
