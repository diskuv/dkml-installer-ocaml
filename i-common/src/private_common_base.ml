open Dkml_package_console_common

let organization =
  {
    Author_types.legal_name = "Diskuv, Inc.";
    common_name_full = "Diskuv";
    common_name_camel_case_nospaces = "Diskuv";
    common_name_kebab_lower_case = "diskuv";
  }

let program_version = Version.program_version

(* From ocaml-crunch defined in ./dune.

   Which comes from https://github.com/ocaml/ocaml-logo/tree/master/Colour/Favicon
*)
let program_assets =
  { Author_types.logo_icon_32x32_opt = Assets.read "win32-icon.ico" }
