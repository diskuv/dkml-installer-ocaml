open Dkml_package_console_common

let build_info =
  {
    Author_types.package_name = "dkml-installer-ocaml-network"
  }

let organization =
  {
    Author_types.legal_name = "Diskuv, Inc.";
    common_name_full = "Diskuv";
    common_name_camel_case_nospaces = "Diskuv";
    common_name_kebab_lower_case = "diskuv";
  }

let program_name =
  {
    Author_types.name_full = "Diskuv OCaml";
    name_camel_case_nospaces = "DiskuvOCaml";
    name_kebab_lower_case = "diskuv-ocaml";
    installation_prefix_camel_case_nospaces_opt = None;
    installation_prefix_kebab_lower_case_opt = None;
  }

let program_version = Version.program_version

(* From ocaml-crunch defined in ./dune.

   Which comes from https://github.com/ocaml/ocaml-logo/tree/master/Colour/Favicon
*)
let program_assets =
  { Author_types.logo_icon_32x32_opt = Assets.read "win32-icon.ico" }

let program_info =
  {
    Author_types.url_info_about_opt =
      Some "https://github.com/diskuv/dkml-installer-ocaml#readme";
    url_update_info_opt =
      Some "https://gitlab.com/diskuv-ocaml/distributions/dkml/-/blob/main/CHANGES.md";
    help_link_opt = Some "https://diskuv.com/dkmlbook/";
    (*
        2116259083L bytes (2.1 GB) in DKML 1.2.0
      - "{0} B" -f (Get-ChildItem $env:DiskuvOCamlHome -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum
      - available from GitHub Actions / package.yml / vagrant-testing / "estimated_byte_size_opt=Some ..."
     *)
    estimated_byte_size_opt = Some 2_116_259_083L;
    windows_language_code_id_opt = Some 0x00000409;
    embeds_32bit_uninstaller = true;
    embeds_64bit_uninstaller = true;
  }
