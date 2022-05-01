val templatized_content :
  registration_statements:string ->
  target_abi:Dkml_install_api.Context.Abi_v2.t ->
  string ->
  string
(** [templatized_content ~registration_statements ~target_abi content]
    replaces the exact text ["(* TEMPLATE: register () *)"] in [content]
    with [registration_statements], and
    replacing the whitespace-insensitive text ["failwith \"TEMPLATE: target_abi\""]
    in [content] with [target_abi]. *)

val copy_with_templates :
  target_abi:Dkml_install_api.Context.Abi_v2.t ->
  components:string list ->
  output_file:Fpath.t ->
  string ->
  (unit, [> Rresult.R.msg ]) result
(** [copy_with_templates ~target_abi ~components ~output_file content] copies [file] into the current
    directory while replacing the exact text ["(* TEMPLATE: register () *)"]
    with [component.register ()] invocations for all [components], and
    replacing the whitespace-insensitive text ["failwith \"TEMPLATE: target_abi\""]
    with the enumeration value of [target_abi] (ex. ["Linux_x86"]). *)
