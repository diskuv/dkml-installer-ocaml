open Ml_of_installer_generator_lib

let () =
  let open Alcotest in
  run "ml_of_installer_generator_lib"
    [
      ( "templatized_content",
        [
          ( "'register ()' template replaced by registration_statements",
            `Quick,
            fun () ->
              check string "equal" "<replacement>"
                (templatized_content ~registration_statements:"<replacement>"
                   ~target_abi:Linux_x86 "(* TEMPLATE: register () *)") );
          ( "'target_abi' template replaced by target_abi",
            `Quick,
            fun () ->
              check string "equal" "Dkml_install_api.Context.Abi_v2.Linux_x86"
                (templatized_content
                   ~registration_statements:"<should not be replaced>"
                   ~target_abi:Linux_x86 "failwith \"TEMPLATE: target_abi\"") );
          ( "'target_abi' template with newline replaced by target_abi",
            `Quick,
            fun () ->
              (* ocamlformat or ocp-indent may insert a break in between
                 `failwith` and `"TEMPLATE: target_abi"` *)
              check string "equal" "Dkml_install_api.Context.Abi_v2.Linux_x86"
                (templatized_content
                   ~registration_statements:"<should not be replaced>"
                   ~target_abi:Linux_x86 "failwith\n\"TEMPLATE: target_abi\"")
          );
        ] );
    ]
