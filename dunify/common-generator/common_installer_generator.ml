(** [ocamlfind ()] performs the equivalent
    of ["ocamlfind query -format '%p' -d -r dkml-install.register"]
    and also does a lexographic sort for stability *)
let ocamlfind () =
  Fmt.epr "Initializing findlib: ";
  Findlib.init ();
  Fmt.epr "done.@.";

  let descendants =
    Fl_package_base.package_users ~preds:[] [ "dkml-install.register" ]
    |> List.sort String.compare
  in
  Fmt.epr "@[<hov 2>Descendants of dkml-install.register:@ @[%a@]@]@."
    Fmt.(list ~sep:sp string)
    descendants;

  let components =
    let prefix = "dkml-component-" in
    List.filter (Astring.String.is_prefix ~affix:prefix) descendants
    |> List.map (fun s ->
           Astring.String.(sub ~start:(String.length prefix) s |> Sub.to_string))
    |> List.sort String.compare
  in
  Fmt.epr "@[<hov 2>Components of dkml-install.register:@ @[%a@]@]@."
    Fmt.(list ~sep:sp string)
    components;
  components
