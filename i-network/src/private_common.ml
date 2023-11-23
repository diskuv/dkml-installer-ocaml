open Dkml_package_console_common
include Private_common_base

let build_info = { Author_types.package_name = "dkml-installer-ocaml-network" }

let program_name =
  {
    Author_types.name_full = "DkML Native";

    (* Must be in sync with dkml-runtime-apps/src/runtimelib/dkml_context.ml for [dkml init --system], etc. *)
    name_camel_case_nospaces = "DkMLNative";
    name_kebab_lower_case = "dkml-native";

    installation_prefix_camel_case_nospaces_opt = None;
    installation_prefix_kebab_lower_case_opt = None;
  }

let program_info =
  {
    Author_types.url_info_about_opt =
      Some "https://github.com/diskuv/dkml-installer-ocaml#readme";
    url_update_info_opt =
      Some
        "https://gitlab.com/dkml/distributions/dkml/-/blob/main/CHANGES.md";
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
