(** The ARP (Add Remove Program) version.

    The sort order for ARP versions, which determines what is an upgrade,
    is described at:

    https://github.com/microsoft/winget-cli/blob/a989c11e91b78c070bcc97c6ac2c0308a97fb867/doc/specs/%23980%20-%20Apps%20and%20Features%20entries%20version%20mapping.md#solution-design
*)
let arp_version = "2.1.4"

(** The version reported to DkML Install API *)
let program_version = arp_version
