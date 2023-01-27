(** [to_semver] will translates semver capable opam (Debian) versions into
    semver.
    
    * 2.2.0~alpha0~20221231 -> 2.2.0-alpha0-20221231
    * 2.2.0~alpha1~20230601 -> 2.2.0-alpha1-20230601
    * 2.2.0                 -> 2.2.0
*)
let to_semver v = String.map (function '~' -> '-' | c -> c) v