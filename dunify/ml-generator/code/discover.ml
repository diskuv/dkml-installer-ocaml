open Configurator.V1
open Bos

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

let console_link_flags ~ccomp_type =
  if ccomp_type = "msvc" then
    let current_dir = Rresult.R.error_msg_to_invalid_arg (OS.Dir.current ()) in
    [
      (* On Windows all linking first goes through flexlink.exe, so
         we need -link to pass the option to LINK.EXE.

         All the /MANIFESTINPUT:filename will be merged and embedded. *)
      "-cclib";
      "-link";
      "-cclib";
      "/MANIFEST:EMBED";
      "-cclib";
      "-link";
      "-cclib";
      Fmt.str "/MANIFESTINPUT:%a" Fpath.pp
        Fpath.(current_dir / "entry.assembly.manifest");
      "-cclib";
      "-link";
      "-cclib";
      Fmt.str "/MANIFESTINPUT:%a" Fpath.pp
        Fpath.(current_dir / "entry-application.manifest");
    ]
  else []

let () =
  main ~name:"runner" (fun c ->
      let ccomp_type = ocaml_config_var_exn c "ccomp_type" in
      Flags.write_sexp "admin-link-flags.sexp" (admin_link_flags ~ccomp_type);
      Flags.write_sexp "console-link-flags.sexp"
        (console_link_flags ~ccomp_type))
