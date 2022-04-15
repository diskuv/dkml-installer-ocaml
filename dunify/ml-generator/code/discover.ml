open Configurator.V1

let admin_link_flags ~ccomp_type =
  if ccomp_type = "msvc" then
    [
      (* On Windows all linking first goes through flexlink.exe, so
         we need -link to pass the option to LINK.EXE. *)
      "-cclib";
      "-link";
      "-cclib";
      "/MANIFEST:EMBED";
      "-cclib";
      "-link";
      "-cclib";
      "/MANIFESTUAC:level='requireAdministrator'";
    ]
  else []

let () =
  main ~name:"runner" (fun c ->
      let ccomp_type = ocaml_config_var_exn c "ccomp_type" in
      Flags.write_sexp "admin-link-flags.sexp" (admin_link_flags ~ccomp_type))
