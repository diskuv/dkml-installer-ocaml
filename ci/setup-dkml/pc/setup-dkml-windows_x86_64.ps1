# setup-dkml
#   Short form: sd4

<#
.SYNOPSIS

Setup DkML compiler on a desktop PC.

.DESCRIPTION

Setup DkML compiler on a desktop PC.

.PARAMETER PC_PROJECT_DIR
Context variable for the project directory. Defaults to the current directory.

.PARAMETER GIT_LOCATION
Context variable for the location of the git executable. Default to 'git'

.PARAMETER DKML_RUNTIME_DISTRIBUTION
Context variable for location of dkml-runtime-distribution. May be a file:// uri. Overrides PIN_DKML_RUNTIME_DISTRIBUTION and TAG_DKML_RUNTIME_DISTRIBUTION, if any.

.PARAMETER FDOPEN_OPAMEXE_BOOTSTRAP
Input variable.

.PARAMETER CACHE_PREFIX
Input variable.

.PARAMETER OCAML_COMPILER
Input variable. -DKML_COMPILER takes priority. If -DKML_COMPILER is not set and -OCAML_COMPILER is set, then the specified OCaml version tag of dkml-compiler (ex. 4.12.1) is used.

.PARAMETER DKML_COMPILER
Input variable. Unspecified or blank is the latest from the default branch (main) of dkml-compiler. @repository@ is the latest from Opam.

.PARAMETER SKIP_OPAM_MODIFICATIONS
Input variable. If true (the default is false) then the opam root and switches will not be created or modified.

.PARAMETER SECONDARY_SWITCH
Input variable. If true then the secondary switch named 'two' is created.

.PARAMETER PRIMARY_SWITCH_SKIP_INSTALL
Input variable. If true no dkml-base-compiler will be installed in the 'dkml' switch.

.PARAMETER CONF_DKML_CROSS_TOOLCHAIN
Input variable. Unspecified or blank is the latest from the default branch (main) of conf-dkml-cross-toolchain. @repository@ is the latest from Opam.

.PARAMETER OCAML_OPAM_REPOSITORY
Input variable. Defaults to the value of -DEFAULT_OCAML_OPAM_REPOSITORY_TAG (see below)

.PARAMETER DISKUV_OPAM_REPOSITORY
Input variable. Defaults to the value of -DEFAULT_DISKUV_OPAM_REPOSITORY_TAG (see below)

.PARAMETER DKML_HOME
Input variables. If specified then DiskuvOCamlHome, DiskuvOCamlBinaryPaths and DiskuvOCamlDeploymentId will be set, in addition to the always-present DiskuvOCamlVarsVersion, DiskuvOCamlVersion
and DiskuvOCamlMSYS2Dir.

# autogen from global_env_vars.
.PARAMETER DKML_VERSION
Environment variable.

.PARAMETER DEFAULT_DISKUV_OPAM_REPOSITORY_TAG
Environment variable.

.PARAMETER DEFAULT_OCAML_OPAM_REPOSITORY_TAG
Environment variable.

.PARAMETER DEFAULT_DKML_COMPILER
Environment variable.

.PARAMETER BOOTSTRAP_OPAM_VERSION
Environment variable.

.PARAMETER PIN_MLFRONT_UNPACK
Environment variable.

.PARAMETER PIN_ANGSTROM_LWT_UNIX
Environment variable.

.PARAMETER PIN_ANGSTROM
Environment variable.

.PARAMETER PIN_ASTRING
Environment variable.

.PARAMETER PIN_BASE
Environment variable.

.PARAMETER PIN_BASE64
Environment variable.

.PARAMETER PIN_BIGARRAY_COMPAT
Environment variable.

.PARAMETER PIN_BIGSTRINGAF
Environment variable.

.PARAMETER PIN_BOS
Environment variable.

.PARAMETER PIN_CAMLP_STREAMS
Environment variable.

.PARAMETER PIN_CHROME_TRACE
Environment variable.

.PARAMETER PIN_CMDLINER
Environment variable.

.PARAMETER PIN_CONF_BASH
Environment variable.

.PARAMETER PIN_CONF_DKML_SYS_OPAM
Environment variable.

.PARAMETER PIN_CONF_DKSDK
Environment variable.

.PARAMETER PIN_CONF_PKG_CONFIG
Environment variable.

.PARAMETER PIN_CONF_SDL2
Environment variable.

.PARAMETER PIN_CONF_SQLITE3
Environment variable.

.PARAMETER PIN_CPPO
Environment variable.

.PARAMETER PIN_CRUNCH
Environment variable.

.PARAMETER PIN_CSEXP
Environment variable.

.PARAMETER PIN_CSTRUCT
Environment variable.

.PARAMETER PIN_CTYPES_FOREIGN
Environment variable.

.PARAMETER PIN_CTYPES
Environment variable.

.PARAMETER PIN_CUDF
Environment variable.

.PARAMETER PIN_DAP
Environment variable.

.PARAMETER PIN_DIGESTIF
Environment variable.

.PARAMETER PIN_DISKUVBOX
Environment variable.

.PARAMETER PIN_DKML_APPS
Environment variable.

.PARAMETER PIN_DKML_BASE_COMPILER
Environment variable.

.PARAMETER PIN_DKML_BUILD_DESKTOP
Environment variable.

.PARAMETER PIN_DKML_C_PROBE
Environment variable.

.PARAMETER PIN_DKML_COMPILER_SRC
Environment variable.

.PARAMETER PIN_DKML_COMPONENT_XX_CONSOLE
Environment variable.

.PARAMETER PIN_DKML_EXE_LIB
Environment variable.

.PARAMETER PIN_DKML_EXE
Environment variable.

.PARAMETER PIN_DKML_HOST_ABI_WINDOWS_X86_64
Environment variable.

.PARAMETER PIN_DKML_HOST_ABI
Environment variable.

.PARAMETER PIN_DKML_INSTALL_INSTALLER
Environment variable.

.PARAMETER PIN_DKML_INSTALL_RUNNER
Environment variable.

.PARAMETER PIN_DKML_INSTALL
Environment variable.

.PARAMETER PIN_DKML_INSTALLER_OCAML_COMMON
Environment variable.

.PARAMETER PIN_DKML_OPTION_BX32
Environment variable.

.PARAMETER PIN_DKML_PACKAGE_CONSOLE
Environment variable.

.PARAMETER PIN_DKML_RUNTIME_COMMON_NATIVE
Environment variable.

.PARAMETER PIN_DKML_RUNTIME_COMMON
Environment variable.

.PARAMETER PIN_DKML_RUNTIME_DISTRIBUTION
Environment variable.

.PARAMETER PIN_DKML_RUNTIMELIB
Environment variable.

.PARAMETER PIN_DKML_RUNTIMESCRIPTS
Environment variable.

.PARAMETER PIN_DKML_TARGET_ABI_ANY
Environment variable.

.PARAMETER PIN_DKML_TARGET_ABI_WINDOWS_X86_64
Environment variable.

.PARAMETER PIN_DKML_WORKFLOWS
Environment variable.

.PARAMETER PIN_DUNE_ACTION_PLUGIN
Environment variable.

.PARAMETER PIN_DUNE_BUILD_INFO
Environment variable.

.PARAMETER PIN_DUNE_CONFIGURATOR
Environment variable.

.PARAMETER PIN_DUNE_GLOB
Environment variable.

.PARAMETER PIN_DUNE_PRIVATE_LIBS
Environment variable.

.PARAMETER PIN_DUNE_RPC_LWT
Environment variable.

.PARAMETER PIN_DUNE_RPC
Environment variable.

.PARAMETER PIN_DUNE_SITE
Environment variable.

.PARAMETER PIN_DUNE
Environment variable.

.PARAMETER PIN_DYN
Environment variable.

.PARAMETER PIN_EARLYBIRD
Environment variable.

.PARAMETER PIN_EITHER
Environment variable.

.PARAMETER PIN_EQAF
Environment variable.

.PARAMETER PIN_EXTLIB
Environment variable.

.PARAMETER PIN_FEATHER
Environment variable.

.PARAMETER PIN_FIBER
Environment variable.

.PARAMETER PIN_FIX
Environment variable.

.PARAMETER PIN_FMT
Environment variable.

.PARAMETER PIN_FPATH
Environment variable.

.PARAMETER PIN_GRAPHICS
Environment variable.

.PARAMETER PIN_HMAP
Environment variable.

.PARAMETER PIN_HOST_ARCH_X86_64
Environment variable.

.PARAMETER PIN_INTEGERS
Environment variable.

.PARAMETER PIN_IOSTREAM
Environment variable.

.PARAMETER PIN_ITER
Environment variable.

.PARAMETER PIN_JANE_STREET_HEADERS
Environment variable.

.PARAMETER PIN_JINGOO
Environment variable.

.PARAMETER PIN_JSONRPC
Environment variable.

.PARAMETER PIN_JST_CONFIG
Environment variable.

.PARAMETER PIN_LAMBDA_TERM
Environment variable.

.PARAMETER PIN_LOGS
Environment variable.

.PARAMETER PIN_LRU
Environment variable.

.PARAMETER PIN_LSP
Environment variable.

.PARAMETER PIN_LWT
Environment variable.

.PARAMETER PIN_LWT_PPX
Environment variable.

.PARAMETER PIN_LWT_REACT
Environment variable.

.PARAMETER PIN_MCCS
Environment variable.

.PARAMETER PIN_MDX
Environment variable.

.PARAMETER PIN_MENHIR
Environment variable.

.PARAMETER PIN_MENHIRCST
Environment variable.

.PARAMETER PIN_MENHIRLIB
Environment variable.

.PARAMETER PIN_MENHIRSDK
Environment variable.

.PARAMETER PIN_MERLIN_LIB
Environment variable.

.PARAMETER PIN_METAPP
Environment variable.

.PARAMETER PIN_METAQUOT
Environment variable.

.PARAMETER PIN_MEW
Environment variable.

.PARAMETER PIN_MEW_VI
Environment variable.

.PARAMETER PIN_MSYS2_CLANG64
Environment variable.

.PARAMETER PIN_MSYS2
Environment variable.

.PARAMETER PIN_NUM
Environment variable.

.PARAMETER PIN_OCAML_COMPILER_LIBS
Environment variable.

.PARAMETER PIN_OCAML_LSP_SERVER
Environment variable.

.PARAMETER PIN_OCAML_SYNTAX_SHIMS
Environment variable.

.PARAMETER PIN_OCAML_VERSION
Environment variable.

.PARAMETER PIN_OCAML
Environment variable.

.PARAMETER PIN_OCAMLBUILD
Environment variable.

.PARAMETER PIN_OCAMLC_LOC
Environment variable.

.PARAMETER PIN_OCAMLFIND
Environment variable.

.PARAMETER PIN_OCAMLFORMAT_LIB
Environment variable.

.PARAMETER PIN_OCAMLFORMAT_RPC_LIB
Environment variable.

.PARAMETER PIN_OCAMLFORMAT
Environment variable.

.PARAMETER PIN_OCP_INDENT
Environment variable.

.PARAMETER PIN_OCPLIB_ENDIAN
Environment variable.

.PARAMETER PIN_ODOC_PARSER
Environment variable.

.PARAMETER PIN_ODOC
Environment variable.

.PARAMETER PIN_ORDERING
Environment variable.

.PARAMETER PIN_PARSEXP
Environment variable.

.PARAMETER PIN_PATH_GLOB
Environment variable.

.PARAMETER PIN_POSIXAT
Environment variable.

.PARAMETER PIN_PP
Environment variable.

.PARAMETER PIN_PPX_ASSERT
Environment variable.

.PARAMETER PIN_PPX_BASE
Environment variable.

.PARAMETER PIN_PPX_COLD
Environment variable.

.PARAMETER PIN_PPX_COMPARE
Environment variable.

.PARAMETER PIN_PPX_DERIVERS
Environment variable.

.PARAMETER PIN_PPX_DERIVING
Environment variable.

.PARAMETER PIN_PPX_DERIVING_YOJSON
Environment variable.

.PARAMETER PIN_PPX_ENUMERATE
Environment variable.

.PARAMETER PIN_PPX_EXPECT
Environment variable.

.PARAMETER PIN_PPX_GLOBALIZE
Environment variable.

.PARAMETER PIN_PPX_HASH
Environment variable.

.PARAMETER PIN_PPX_HERE
Environment variable.

.PARAMETER PIN_PPX_IGNORE_INSTRUMENTATION
Environment variable.

.PARAMETER PIN_PPX_INLINE_TEST
Environment variable.

.PARAMETER PIN_PPX_OPTCOMP
Environment variable.

.PARAMETER PIN_PPX_PIPEBANG
Environment variable.

.PARAMETER PIN_PPX_SEXP_CONV
Environment variable.

.PARAMETER PIN_PPX_YOJSON_CONV_LIB
Environment variable.

.PARAMETER PIN_PPXLIB
Environment variable.

.PARAMETER PIN_PSQ
Environment variable.

.PARAMETER PIN_PTIME
Environment variable.

.PARAMETER PIN_QRC
Environment variable.

.PARAMETER PIN_RE
Environment variable.

.PARAMETER PIN_REACT
Environment variable.

.PARAMETER PIN_REFL
Environment variable.

.PARAMETER PIN_RESULT
Environment variable.

.PARAMETER PIN_RRESULT
Environment variable.

.PARAMETER PIN_SEQ
Environment variable.

.PARAMETER PIN_SEXPLIB
Environment variable.

.PARAMETER PIN_SEXPLIB0
Environment variable.

.PARAMETER PIN_SHA
Environment variable.

.PARAMETER PIN_SHEXP
Environment variable.

.PARAMETER PIN_SPAWN
Environment variable.

.PARAMETER PIN_SQLITE3
Environment variable.

.PARAMETER PIN_STDCOMPAT
Environment variable.

.PARAMETER PIN_STDIO
Environment variable.

.PARAMETER PIN_STDLIB_SHIMS
Environment variable.

.PARAMETER PIN_STDUNE
Environment variable.

.PARAMETER PIN_STRINGEXT
Environment variable.

.PARAMETER PIN_TIME_NOW
Environment variable.

.PARAMETER PIN_TINY_HTTPD
Environment variable.

.PARAMETER PIN_TOPKG
Environment variable.

.PARAMETER PIN_TRAVERSE
Environment variable.

.PARAMETER PIN_TRIE
Environment variable.

.PARAMETER PIN_TSORT
Environment variable.

.PARAMETER PIN_TYXML
Environment variable.

.PARAMETER PIN_UCHAR
Environment variable.

.PARAMETER PIN_URI
Environment variable.

.PARAMETER PIN_UTOP
Environment variable.

.PARAMETER PIN_UUCP
Environment variable.

.PARAMETER PIN_UUIDM
Environment variable.

.PARAMETER PIN_UUSEG
Environment variable.

.PARAMETER PIN_UUTF
Environment variable.

.PARAMETER PIN_WITH_DKML
Environment variable.

.PARAMETER PIN_XDG
Environment variable.

.PARAMETER PIN_YOJSON
Environment variable.

.PARAMETER PIN_ZED
Environment variable.

#>
[CmdletBinding()]
param (
  # Context variables
  [Parameter(HelpMessage='Defaults to the current directory')]
  [string]
  $PC_PROJECT_DIR = $PWD,
  [Parameter(HelpMessage='Defaults to "git"')]
  [string]
  $GIT_LOCATION = "",
  [Parameter(HelpMessage='May be file:// uri. Overrides PIN_DKML_RUNTIME_DISTRIBUTION and TAG_DKML_RUNTIME_DISTRIBUTION, if any.')]
  [string]
  $DKML_RUNTIME_DISTRIBUTION = "",

  # Input variables
  [string]
  $FDOPEN_OPAMEXE_BOOTSTRAP = "false",
  [string]
  $CACHE_PREFIX = "v1",
  [string]
  $OCAML_COMPILER = "",
  [string]
  $DKML_COMPILER = "",
  [string]
  $SKIP_OPAM_MODIFICATIONS = "false",
  [string]
  $SECONDARY_SWITCH = "false",
  [string]
  $PRIMARY_SWITCH_SKIP_INSTALL = "false",
  [string]
  $CONF_DKML_CROSS_TOOLCHAIN = "@repository@",
  [string]
  $OCAML_OPAM_REPOSITORY = "",
  [string]
  $DISKUV_OPAM_REPOSITORY = "",
  [string]
  $DKML_HOME = ""

  # Conflicts with automatic variable $Verbose
  # [Parameter()]
  # [string]
  # $VERBOSE = "false"

  # Environment variables (can be overridden on command line)
  # autogen from global_env_vars.
  ,[Parameter()] [string] $DKML_VERSION = "2.1.4"
  ,[Parameter()] [string] $DEFAULT_DISKUV_OPAM_REPOSITORY_TAG = "2.1.4"
  ,[Parameter()] [string] $DEFAULT_OCAML_OPAM_REPOSITORY_TAG = "98ac0a55cd7b45747207396a0b8fe1cc619b4a14"
  ,[Parameter()] [string] $DEFAULT_DKML_COMPILER = "2.1.4"
  ,[Parameter()] [string] $BOOTSTRAP_OPAM_VERSION = "2.2.1"
  ,[Parameter()] [string] $PIN_MLFRONT_UNPACK = "2.1.4"
  ,[Parameter()] [string] $PIN_ANGSTROM_LWT_UNIX = "0.16.1"
  ,[Parameter()] [string] $PIN_ANGSTROM = "0.16.0"
  ,[Parameter()] [string] $PIN_ASTRING = "0.8.5"
  ,[Parameter()] [string] $PIN_BASE = "v0.16.1"
  ,[Parameter()] [string] $PIN_BASE64 = "3.5.1"
  ,[Parameter()] [string] $PIN_BIGARRAY_COMPAT = "1.1.0"
  ,[Parameter()] [string] $PIN_BIGSTRINGAF = "0.10.0"
  ,[Parameter()] [string] $PIN_BOS = "0.2.1"
  ,[Parameter()] [string] $PIN_CAMLP_STREAMS = "5.0.1"
  ,[Parameter()] [string] $PIN_CHROME_TRACE = "3.15.0"
  ,[Parameter()] [string] $PIN_CMDLINER = "1.3.0"
  ,[Parameter()] [string] $PIN_CONF_BASH = "1"
  ,[Parameter()] [string] $PIN_CONF_DKML_SYS_OPAM = "1"
  ,[Parameter()] [string] $PIN_CONF_DKSDK = "1"
  ,[Parameter()] [string] $PIN_CONF_PKG_CONFIG = "3+cpkgs"
  ,[Parameter()] [string] $PIN_CONF_SDL2 = "1"
  ,[Parameter()] [string] $PIN_CONF_SQLITE3 = "3.1+cpkgs"
  ,[Parameter()] [string] $PIN_CPPO = "1.6.9"
  ,[Parameter()] [string] $PIN_CRUNCH = "3.3.1"
  ,[Parameter()] [string] $PIN_CSEXP = "1.5.2"
  ,[Parameter()] [string] $PIN_CSTRUCT = "6.2.0"
  ,[Parameter()] [string] $PIN_CTYPES_FOREIGN = "0.19.2-windowssupport-r8"
  ,[Parameter()] [string] $PIN_CTYPES = "0.19.2-windowssupport-r8"
  ,[Parameter()] [string] $PIN_CUDF = "0.10"
  ,[Parameter()] [string] $PIN_DAP = "1.0.6"
  ,[Parameter()] [string] $PIN_DIGESTIF = "1.2.0"
  ,[Parameter()] [string] $PIN_DISKUVBOX = "0.2.0"
  ,[Parameter()] [string] $PIN_DKML_APPS = "2.1.4"
  ,[Parameter()] [string] $PIN_DKML_BASE_COMPILER = "4.14.2~v2.1.4"
  ,[Parameter()] [string] $PIN_DKML_BUILD_DESKTOP = "2.1.4"
  ,[Parameter()] [string] $PIN_DKML_C_PROBE = "3.0.0"
  ,[Parameter()] [string] $PIN_DKML_COMPILER_SRC = "2.1.4"
  ,[Parameter()] [string] $PIN_DKML_COMPONENT_XX_CONSOLE = "0.1.1"
  ,[Parameter()] [string] $PIN_DKML_EXE_LIB = "2.1.4"
  ,[Parameter()] [string] $PIN_DKML_EXE = "2.1.4"
  ,[Parameter()] [string] $PIN_DKML_HOST_ABI_WINDOWS_X86_64 = "1"
  ,[Parameter()] [string] $PIN_DKML_HOST_ABI = "1"
  ,[Parameter()] [string] $PIN_DKML_INSTALL_INSTALLER = "0.5.3"
  ,[Parameter()] [string] $PIN_DKML_INSTALL_RUNNER = "0.5.3"
  ,[Parameter()] [string] $PIN_DKML_INSTALL = "0.5.3"
  ,[Parameter()] [string] $PIN_DKML_INSTALLER_OCAML_COMMON = "2.1.3"
  ,[Parameter()] [string] $PIN_DKML_OPTION_BX32 = "1"
  ,[Parameter()] [string] $PIN_DKML_PACKAGE_CONSOLE = "0.5.3"
  ,[Parameter()] [string] $PIN_DKML_RUNTIME_COMMON_NATIVE = "2.1.1"
  ,[Parameter()] [string] $PIN_DKML_RUNTIME_COMMON = "2.1.4"
  ,[Parameter()] [string] $PIN_DKML_RUNTIME_DISTRIBUTION = "2.1.4"
  ,[Parameter()] [string] $PIN_DKML_RUNTIMELIB = "2.1.4"
  ,[Parameter()] [string] $PIN_DKML_RUNTIMESCRIPTS = "2.1.4"
  ,[Parameter()] [string] $PIN_DKML_TARGET_ABI_ANY = "1"
  ,[Parameter()] [string] $PIN_DKML_TARGET_ABI_WINDOWS_X86_64 = "1"
  ,[Parameter()] [string] $PIN_DKML_WORKFLOWS = "2.1.4"
  ,[Parameter()] [string] $PIN_DUNE_ACTION_PLUGIN = "3.15.0"
  ,[Parameter()] [string] $PIN_DUNE_BUILD_INFO = "3.15.0"
  ,[Parameter()] [string] $PIN_DUNE_CONFIGURATOR = "3.15.0"
  ,[Parameter()] [string] $PIN_DUNE_GLOB = "3.15.0"
  ,[Parameter()] [string] $PIN_DUNE_PRIVATE_LIBS = "3.15.0"
  ,[Parameter()] [string] $PIN_DUNE_RPC_LWT = "3.15.0"
  ,[Parameter()] [string] $PIN_DUNE_RPC = "3.15.0"
  ,[Parameter()] [string] $PIN_DUNE_SITE = "3.15.0"
  ,[Parameter()] [string] $PIN_DUNE = "3.15.0"
  ,[Parameter()] [string] $PIN_DYN = "3.15.0"
  ,[Parameter()] [string] $PIN_EARLYBIRD = "1.3.2+dkml-4_14-backport-linearclosures"
  ,[Parameter()] [string] $PIN_EITHER = "1.0.0"
  ,[Parameter()] [string] $PIN_EQAF = "0.9"
  ,[Parameter()] [string] $PIN_EXTLIB = "1.7.9"
  ,[Parameter()] [string] $PIN_FEATHER = "0.3.0"
  ,[Parameter()] [string] $PIN_FIBER = "3.7.0"
  ,[Parameter()] [string] $PIN_FIX = "20230505"
  ,[Parameter()] [string] $PIN_FMT = "0.9.0"
  ,[Parameter()] [string] $PIN_FPATH = "0.7.3"
  ,[Parameter()] [string] $PIN_GRAPHICS = "5.1.2"
  ,[Parameter()] [string] $PIN_HMAP = "0.8.1"
  ,[Parameter()] [string] $PIN_HOST_ARCH_X86_64 = "1"
  ,[Parameter()] [string] $PIN_INTEGERS = "0.7.0"
  ,[Parameter()] [string] $PIN_IOSTREAM = "0.2.2"
  ,[Parameter()] [string] $PIN_ITER = "1.9"
  ,[Parameter()] [string] $PIN_JANE_STREET_HEADERS = "v0.16.0"
  ,[Parameter()] [string] $PIN_JINGOO = "1.5.0"
  ,[Parameter()] [string] $PIN_JSONRPC = "1.17.0"
  ,[Parameter()] [string] $PIN_JST_CONFIG = "v0.16.0"
  ,[Parameter()] [string] $PIN_LAMBDA_TERM = "3.3.2"
  ,[Parameter()] [string] $PIN_LOGS = "0.7.0"
  ,[Parameter()] [string] $PIN_LRU = "0.3.1"
  ,[Parameter()] [string] $PIN_LSP = "1.17.0"
  ,[Parameter()] [string] $PIN_LWT = "5.7.0"
  ,[Parameter()] [string] $PIN_LWT_PPX = "5.9.1"
  ,[Parameter()] [string] $PIN_LWT_REACT = "1.2.0"
  ,[Parameter()] [string] $PIN_MCCS = "1.1+13"
  ,[Parameter()] [string] $PIN_MDX = "2.4.1"
  ,[Parameter()] [string] $PIN_MENHIR = "20231231"
  ,[Parameter()] [string] $PIN_MENHIRCST = "20231231"
  ,[Parameter()] [string] $PIN_MENHIRLIB = "20231231"
  ,[Parameter()] [string] $PIN_MENHIRSDK = "20231231"
  ,[Parameter()] [string] $PIN_MERLIN_LIB = "4.14-414"
  ,[Parameter()] [string] $PIN_METAPP = "0.4.4+win"
  ,[Parameter()] [string] $PIN_METAQUOT = "0.5.2"
  ,[Parameter()] [string] $PIN_MEW = "0.1.0"
  ,[Parameter()] [string] $PIN_MEW_VI = "0.5.0"
  ,[Parameter()] [string] $PIN_MSYS2_CLANG64 = "1"
  ,[Parameter()] [string] $PIN_MSYS2 = "0.1.0+dkml"
  ,[Parameter()] [string] $PIN_NUM = "1.5"
  ,[Parameter()] [string] $PIN_OCAML_COMPILER_LIBS = "v0.12.4"
  ,[Parameter()] [string] $PIN_OCAML_LSP_SERVER = "1.17.0"
  ,[Parameter()] [string] $PIN_OCAML_SYNTAX_SHIMS = "1.0.0"
  ,[Parameter()] [string] $PIN_OCAML_VERSION = "3.6.5"
  ,[Parameter()] [string] $PIN_OCAML = "4.14.2"
  ,[Parameter()] [string] $PIN_OCAMLBUILD = "0.14.2+win+unix"
  ,[Parameter()] [string] $PIN_OCAMLC_LOC = "3.15.0"
  ,[Parameter()] [string] $PIN_OCAMLFIND = "1.9.5"
  ,[Parameter()] [string] $PIN_OCAMLFORMAT_LIB = "0.26.1"
  ,[Parameter()] [string] $PIN_OCAMLFORMAT_RPC_LIB = "0.26.1"
  ,[Parameter()] [string] $PIN_OCAMLFORMAT = "0.26.1"
  ,[Parameter()] [string] $PIN_OCP_INDENT = "1.8.2-windowssupport"
  ,[Parameter()] [string] $PIN_OCPLIB_ENDIAN = "1.2"
  ,[Parameter()] [string] $PIN_ODOC_PARSER = "2.4.1"
  ,[Parameter()] [string] $PIN_ODOC = "2.4.1"
  ,[Parameter()] [string] $PIN_ORDERING = "3.15.0"
  ,[Parameter()] [string] $PIN_PARSEXP = "v0.16.0"
  ,[Parameter()] [string] $PIN_PATH_GLOB = "0.3"
  ,[Parameter()] [string] $PIN_POSIXAT = "v0.16.0"
  ,[Parameter()] [string] $PIN_PP = "1.2.0"
  ,[Parameter()] [string] $PIN_PPX_ASSERT = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPX_BASE = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPX_COLD = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPX_COMPARE = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPX_DERIVERS = "1.2.1"
  ,[Parameter()] [string] $PIN_PPX_DERIVING = "5.2.1"
  ,[Parameter()] [string] $PIN_PPX_DERIVING_YOJSON = "3.9.1"
  ,[Parameter()] [string] $PIN_PPX_ENUMERATE = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPX_EXPECT = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPX_GLOBALIZE = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPX_HASH = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPX_HERE = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPX_IGNORE_INSTRUMENTATION = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPX_INLINE_TEST = "v0.16.1"
  ,[Parameter()] [string] $PIN_PPX_OPTCOMP = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPX_PIPEBANG = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPX_SEXP_CONV = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPX_YOJSON_CONV_LIB = "v0.16.0"
  ,[Parameter()] [string] $PIN_PPXLIB = "0.30.0"
  ,[Parameter()] [string] $PIN_PSQ = "0.2.1"
  ,[Parameter()] [string] $PIN_PTIME = "1.1.0"
  ,[Parameter()] [string] $PIN_QRC = "0.1.1~dune"
  ,[Parameter()] [string] $PIN_RE = "1.11.0"
  ,[Parameter()] [string] $PIN_REACT = "1.2.2"
  ,[Parameter()] [string] $PIN_REFL = "0.4.1"
  ,[Parameter()] [string] $PIN_RESULT = "1.5"
  ,[Parameter()] [string] $PIN_RRESULT = "0.7.0"
  ,[Parameter()] [string] $PIN_SEQ = "base"
  ,[Parameter()] [string] $PIN_SEXPLIB = "v0.16.0"
  ,[Parameter()] [string] $PIN_SEXPLIB0 = "v0.16.0"
  ,[Parameter()] [string] $PIN_SHA = "1.15.4"
  ,[Parameter()] [string] $PIN_SHEXP = "v0.16.0"
  ,[Parameter()] [string] $PIN_SPAWN = "v0.15.1"
  ,[Parameter()] [string] $PIN_SQLITE3 = "5.2.0"
  ,[Parameter()] [string] $PIN_STDCOMPAT = "19+optautoconf"
  ,[Parameter()] [string] $PIN_STDIO = "v0.16.0"
  ,[Parameter()] [string] $PIN_STDLIB_SHIMS = "0.3.0"
  ,[Parameter()] [string] $PIN_STDUNE = "3.15.0"
  ,[Parameter()] [string] $PIN_STRINGEXT = "1.6.0"
  ,[Parameter()] [string] $PIN_TIME_NOW = "v0.16.0"
  ,[Parameter()] [string] $PIN_TINY_HTTPD = "0.16"
  ,[Parameter()] [string] $PIN_TOPKG = "1.0.7"
  ,[Parameter()] [string] $PIN_TRAVERSE = "0.3.0"
  ,[Parameter()] [string] $PIN_TRIE = "1.0.0"
  ,[Parameter()] [string] $PIN_TSORT = "2.1.0"
  ,[Parameter()] [string] $PIN_TYXML = "4.6.0"
  ,[Parameter()] [string] $PIN_UCHAR = "0.0.2"
  ,[Parameter()] [string] $PIN_URI = "4.4.0"
  ,[Parameter()] [string] $PIN_UTOP = "2.13.1"
  ,[Parameter()] [string] $PIN_UUCP = "15.0.0"
  ,[Parameter()] [string] $PIN_UUIDM = "0.9.8"
  ,[Parameter()] [string] $PIN_UUSEG = "15.0.0"
  ,[Parameter()] [string] $PIN_UUTF = "1.0.3"
  ,[Parameter()] [string] $PIN_WITH_DKML = "2.1.4"
  ,[Parameter()] [string] $PIN_XDG = "3.15.0"
  ,[Parameter()] [string] $PIN_YOJSON = "2.1.2"
  ,[Parameter()] [string] $PIN_ZED = "3.2.3"
)

$ErrorActionPreference = "Stop"

# Reset environment so no conflicts with a parent Opam or OCaml system
if (Test-Path Env:OPAMROOT)             { Remove-Item Env:OPAMROOT }
if (Test-Path Env:OPAMSWITCH)           { Remove-Item Env:OPAMSWITCH }
if (Test-Path Env:OPAM_SWITCH_PREFIX)   { Remove-Item Env:OPAM_SWITCH_PREFIX }
if (Test-Path Env:CAML_LD_LIBRARY_PATH) { Remove-Item Env:CAML_LD_LIBRARY_PATH }
if (Test-Path Env:OCAMLLIB)             { Remove-Item Env:OCAMLLIB }
if (Test-Path Env:OCAML_TOPLEVEL_PATH)  { Remove-Item Env:OCAML_TOPLEVEL_PATH }

# Pushdown context variables
$env:PC_CI = 'true'
$env:PC_PROJECT_DIR = $PC_PROJECT_DIR
$env:GIT_LOCATION = $GIT_LOCATION
$env:DKML_RUNTIME_DISTRIBUTION = $DKML_RUNTIME_DISTRIBUTION

# Pushdown input variables
$env:FDOPEN_OPAMEXE_BOOTSTRAP = $FDOPEN_OPAMEXE_BOOTSTRAP
$env:CACHE_PREFIX = $CACHE_PREFIX
$env:OCAML_COMPILER = $OCAML_COMPILER
$env:DKML_COMPILER = $DKML_COMPILER
$env:SKIP_OPAM_MODIFICATIONS = $SKIP_OPAM_MODIFICATIONS
$env:SECONDARY_SWITCH = $SECONDARY_SWITCH
$env:PRIMARY_SWITCH_SKIP_INSTALL = $PRIMARY_SWITCH_SKIP_INSTALL
$env:CONF_DKML_CROSS_TOOLCHAIN = $CONF_DKML_CROSS_TOOLCHAIN
$env:OCAML_OPAM_REPOSITORY = $OCAML_OPAM_REPOSITORY
$env:DISKUV_OPAM_REPOSITORY = $DISKUV_OPAM_REPOSITORY
$env:DKML_HOME = $DKML_HOME

# Set matrix variables
# autogen from pc_vars. only windows_x86_64
$env:dkml_host_os = "windows"
$env:opam_root_cacheable = "${env:PC_PROJECT_DIR}/.ci/o"
$env:abi_pattern = "win32-windows_x86_64"
$env:msys2_system = "CLANG64"
$env:msys2_packages = "mingw-w64-clang-x86_64-pkg-config"
$env:exe_ext = ".exe"
$env:dkml_host_abi = "windows_x86_64"
$env:dkml_target_abi = "windows_x86_64"
$env:opam_root = "${env:PC_PROJECT_DIR}/.ci/o"
$env:vsstudio_hostarch = "x64"
$env:vsstudio_arch = "x64"


# Set environment variables
# autogen from global_env_vars.
$env:DKML_VERSION = $DKML_VERSION
$env:DEFAULT_DISKUV_OPAM_REPOSITORY_TAG = $DEFAULT_DISKUV_OPAM_REPOSITORY_TAG
$env:DEFAULT_OCAML_OPAM_REPOSITORY_TAG = $DEFAULT_OCAML_OPAM_REPOSITORY_TAG
$env:DEFAULT_DKML_COMPILER = $DEFAULT_DKML_COMPILER
$env:BOOTSTRAP_OPAM_VERSION = $BOOTSTRAP_OPAM_VERSION
$env:PIN_MLFRONT_UNPACK = $PIN_MLFRONT_UNPACK
$env:PIN_ANGSTROM_LWT_UNIX = $PIN_ANGSTROM_LWT_UNIX
$env:PIN_ANGSTROM = $PIN_ANGSTROM
$env:PIN_ASTRING = $PIN_ASTRING
$env:PIN_BASE = $PIN_BASE
$env:PIN_BASE64 = $PIN_BASE64
$env:PIN_BIGARRAY_COMPAT = $PIN_BIGARRAY_COMPAT
$env:PIN_BIGSTRINGAF = $PIN_BIGSTRINGAF
$env:PIN_BOS = $PIN_BOS
$env:PIN_CAMLP_STREAMS = $PIN_CAMLP_STREAMS
$env:PIN_CHROME_TRACE = $PIN_CHROME_TRACE
$env:PIN_CMDLINER = $PIN_CMDLINER
$env:PIN_CONF_BASH = $PIN_CONF_BASH
$env:PIN_CONF_DKML_SYS_OPAM = $PIN_CONF_DKML_SYS_OPAM
$env:PIN_CONF_DKSDK = $PIN_CONF_DKSDK
$env:PIN_CONF_PKG_CONFIG = $PIN_CONF_PKG_CONFIG
$env:PIN_CONF_SDL2 = $PIN_CONF_SDL2
$env:PIN_CONF_SQLITE3 = $PIN_CONF_SQLITE3
$env:PIN_CPPO = $PIN_CPPO
$env:PIN_CRUNCH = $PIN_CRUNCH
$env:PIN_CSEXP = $PIN_CSEXP
$env:PIN_CSTRUCT = $PIN_CSTRUCT
$env:PIN_CTYPES_FOREIGN = $PIN_CTYPES_FOREIGN
$env:PIN_CTYPES = $PIN_CTYPES
$env:PIN_CUDF = $PIN_CUDF
$env:PIN_DAP = $PIN_DAP
$env:PIN_DIGESTIF = $PIN_DIGESTIF
$env:PIN_DISKUVBOX = $PIN_DISKUVBOX
$env:PIN_DKML_APPS = $PIN_DKML_APPS
$env:PIN_DKML_BASE_COMPILER = $PIN_DKML_BASE_COMPILER
$env:PIN_DKML_BUILD_DESKTOP = $PIN_DKML_BUILD_DESKTOP
$env:PIN_DKML_C_PROBE = $PIN_DKML_C_PROBE
$env:PIN_DKML_COMPILER_SRC = $PIN_DKML_COMPILER_SRC
$env:PIN_DKML_COMPONENT_XX_CONSOLE = $PIN_DKML_COMPONENT_XX_CONSOLE
$env:PIN_DKML_EXE_LIB = $PIN_DKML_EXE_LIB
$env:PIN_DKML_EXE = $PIN_DKML_EXE
$env:PIN_DKML_HOST_ABI_WINDOWS_X86_64 = $PIN_DKML_HOST_ABI_WINDOWS_X86_64
$env:PIN_DKML_HOST_ABI = $PIN_DKML_HOST_ABI
$env:PIN_DKML_INSTALL_INSTALLER = $PIN_DKML_INSTALL_INSTALLER
$env:PIN_DKML_INSTALL_RUNNER = $PIN_DKML_INSTALL_RUNNER
$env:PIN_DKML_INSTALL = $PIN_DKML_INSTALL
$env:PIN_DKML_INSTALLER_OCAML_COMMON = $PIN_DKML_INSTALLER_OCAML_COMMON
$env:PIN_DKML_OPTION_BX32 = $PIN_DKML_OPTION_BX32
$env:PIN_DKML_PACKAGE_CONSOLE = $PIN_DKML_PACKAGE_CONSOLE
$env:PIN_DKML_RUNTIME_COMMON_NATIVE = $PIN_DKML_RUNTIME_COMMON_NATIVE
$env:PIN_DKML_RUNTIME_COMMON = $PIN_DKML_RUNTIME_COMMON
$env:PIN_DKML_RUNTIME_DISTRIBUTION = $PIN_DKML_RUNTIME_DISTRIBUTION
$env:PIN_DKML_RUNTIMELIB = $PIN_DKML_RUNTIMELIB
$env:PIN_DKML_RUNTIMESCRIPTS = $PIN_DKML_RUNTIMESCRIPTS
$env:PIN_DKML_TARGET_ABI_ANY = $PIN_DKML_TARGET_ABI_ANY
$env:PIN_DKML_TARGET_ABI_WINDOWS_X86_64 = $PIN_DKML_TARGET_ABI_WINDOWS_X86_64
$env:PIN_DKML_WORKFLOWS = $PIN_DKML_WORKFLOWS
$env:PIN_DUNE_ACTION_PLUGIN = $PIN_DUNE_ACTION_PLUGIN
$env:PIN_DUNE_BUILD_INFO = $PIN_DUNE_BUILD_INFO
$env:PIN_DUNE_CONFIGURATOR = $PIN_DUNE_CONFIGURATOR
$env:PIN_DUNE_GLOB = $PIN_DUNE_GLOB
$env:PIN_DUNE_PRIVATE_LIBS = $PIN_DUNE_PRIVATE_LIBS
$env:PIN_DUNE_RPC_LWT = $PIN_DUNE_RPC_LWT
$env:PIN_DUNE_RPC = $PIN_DUNE_RPC
$env:PIN_DUNE_SITE = $PIN_DUNE_SITE
$env:PIN_DUNE = $PIN_DUNE
$env:PIN_DYN = $PIN_DYN
$env:PIN_EARLYBIRD = $PIN_EARLYBIRD
$env:PIN_EITHER = $PIN_EITHER
$env:PIN_EQAF = $PIN_EQAF
$env:PIN_EXTLIB = $PIN_EXTLIB
$env:PIN_FEATHER = $PIN_FEATHER
$env:PIN_FIBER = $PIN_FIBER
$env:PIN_FIX = $PIN_FIX
$env:PIN_FMT = $PIN_FMT
$env:PIN_FPATH = $PIN_FPATH
$env:PIN_GRAPHICS = $PIN_GRAPHICS
$env:PIN_HMAP = $PIN_HMAP
$env:PIN_HOST_ARCH_X86_64 = $PIN_HOST_ARCH_X86_64
$env:PIN_INTEGERS = $PIN_INTEGERS
$env:PIN_IOSTREAM = $PIN_IOSTREAM
$env:PIN_ITER = $PIN_ITER
$env:PIN_JANE_STREET_HEADERS = $PIN_JANE_STREET_HEADERS
$env:PIN_JINGOO = $PIN_JINGOO
$env:PIN_JSONRPC = $PIN_JSONRPC
$env:PIN_JST_CONFIG = $PIN_JST_CONFIG
$env:PIN_LAMBDA_TERM = $PIN_LAMBDA_TERM
$env:PIN_LOGS = $PIN_LOGS
$env:PIN_LRU = $PIN_LRU
$env:PIN_LSP = $PIN_LSP
$env:PIN_LWT = $PIN_LWT
$env:PIN_LWT_PPX = $PIN_LWT_PPX
$env:PIN_LWT_REACT = $PIN_LWT_REACT
$env:PIN_MCCS = $PIN_MCCS
$env:PIN_MDX = $PIN_MDX
$env:PIN_MENHIR = $PIN_MENHIR
$env:PIN_MENHIRCST = $PIN_MENHIRCST
$env:PIN_MENHIRLIB = $PIN_MENHIRLIB
$env:PIN_MENHIRSDK = $PIN_MENHIRSDK
$env:PIN_MERLIN_LIB = $PIN_MERLIN_LIB
$env:PIN_METAPP = $PIN_METAPP
$env:PIN_METAQUOT = $PIN_METAQUOT
$env:PIN_MEW = $PIN_MEW
$env:PIN_MEW_VI = $PIN_MEW_VI
$env:PIN_MSYS2_CLANG64 = $PIN_MSYS2_CLANG64
$env:PIN_MSYS2 = $PIN_MSYS2
$env:PIN_NUM = $PIN_NUM
$env:PIN_OCAML_COMPILER_LIBS = $PIN_OCAML_COMPILER_LIBS
$env:PIN_OCAML_LSP_SERVER = $PIN_OCAML_LSP_SERVER
$env:PIN_OCAML_SYNTAX_SHIMS = $PIN_OCAML_SYNTAX_SHIMS
$env:PIN_OCAML_VERSION = $PIN_OCAML_VERSION
$env:PIN_OCAML = $PIN_OCAML
$env:PIN_OCAMLBUILD = $PIN_OCAMLBUILD
$env:PIN_OCAMLC_LOC = $PIN_OCAMLC_LOC
$env:PIN_OCAMLFIND = $PIN_OCAMLFIND
$env:PIN_OCAMLFORMAT_LIB = $PIN_OCAMLFORMAT_LIB
$env:PIN_OCAMLFORMAT_RPC_LIB = $PIN_OCAMLFORMAT_RPC_LIB
$env:PIN_OCAMLFORMAT = $PIN_OCAMLFORMAT
$env:PIN_OCP_INDENT = $PIN_OCP_INDENT
$env:PIN_OCPLIB_ENDIAN = $PIN_OCPLIB_ENDIAN
$env:PIN_ODOC_PARSER = $PIN_ODOC_PARSER
$env:PIN_ODOC = $PIN_ODOC
$env:PIN_ORDERING = $PIN_ORDERING
$env:PIN_PARSEXP = $PIN_PARSEXP
$env:PIN_PATH_GLOB = $PIN_PATH_GLOB
$env:PIN_POSIXAT = $PIN_POSIXAT
$env:PIN_PP = $PIN_PP
$env:PIN_PPX_ASSERT = $PIN_PPX_ASSERT
$env:PIN_PPX_BASE = $PIN_PPX_BASE
$env:PIN_PPX_COLD = $PIN_PPX_COLD
$env:PIN_PPX_COMPARE = $PIN_PPX_COMPARE
$env:PIN_PPX_DERIVERS = $PIN_PPX_DERIVERS
$env:PIN_PPX_DERIVING = $PIN_PPX_DERIVING
$env:PIN_PPX_DERIVING_YOJSON = $PIN_PPX_DERIVING_YOJSON
$env:PIN_PPX_ENUMERATE = $PIN_PPX_ENUMERATE
$env:PIN_PPX_EXPECT = $PIN_PPX_EXPECT
$env:PIN_PPX_GLOBALIZE = $PIN_PPX_GLOBALIZE
$env:PIN_PPX_HASH = $PIN_PPX_HASH
$env:PIN_PPX_HERE = $PIN_PPX_HERE
$env:PIN_PPX_IGNORE_INSTRUMENTATION = $PIN_PPX_IGNORE_INSTRUMENTATION
$env:PIN_PPX_INLINE_TEST = $PIN_PPX_INLINE_TEST
$env:PIN_PPX_OPTCOMP = $PIN_PPX_OPTCOMP
$env:PIN_PPX_PIPEBANG = $PIN_PPX_PIPEBANG
$env:PIN_PPX_SEXP_CONV = $PIN_PPX_SEXP_CONV
$env:PIN_PPX_YOJSON_CONV_LIB = $PIN_PPX_YOJSON_CONV_LIB
$env:PIN_PPXLIB = $PIN_PPXLIB
$env:PIN_PSQ = $PIN_PSQ
$env:PIN_PTIME = $PIN_PTIME
$env:PIN_QRC = $PIN_QRC
$env:PIN_RE = $PIN_RE
$env:PIN_REACT = $PIN_REACT
$env:PIN_REFL = $PIN_REFL
$env:PIN_RESULT = $PIN_RESULT
$env:PIN_RRESULT = $PIN_RRESULT
$env:PIN_SEQ = $PIN_SEQ
$env:PIN_SEXPLIB = $PIN_SEXPLIB
$env:PIN_SEXPLIB0 = $PIN_SEXPLIB0
$env:PIN_SHA = $PIN_SHA
$env:PIN_SHEXP = $PIN_SHEXP
$env:PIN_SPAWN = $PIN_SPAWN
$env:PIN_SQLITE3 = $PIN_SQLITE3
$env:PIN_STDCOMPAT = $PIN_STDCOMPAT
$env:PIN_STDIO = $PIN_STDIO
$env:PIN_STDLIB_SHIMS = $PIN_STDLIB_SHIMS
$env:PIN_STDUNE = $PIN_STDUNE
$env:PIN_STRINGEXT = $PIN_STRINGEXT
$env:PIN_TIME_NOW = $PIN_TIME_NOW
$env:PIN_TINY_HTTPD = $PIN_TINY_HTTPD
$env:PIN_TOPKG = $PIN_TOPKG
$env:PIN_TRAVERSE = $PIN_TRAVERSE
$env:PIN_TRIE = $PIN_TRIE
$env:PIN_TSORT = $PIN_TSORT
$env:PIN_TYXML = $PIN_TYXML
$env:PIN_UCHAR = $PIN_UCHAR
$env:PIN_URI = $PIN_URI
$env:PIN_UTOP = $PIN_UTOP
$env:PIN_UUCP = $PIN_UUCP
$env:PIN_UUIDM = $PIN_UUIDM
$env:PIN_UUSEG = $PIN_UUSEG
$env:PIN_UUTF = $PIN_UUTF
$env:PIN_WITH_DKML = $PIN_WITH_DKML
$env:PIN_XDG = $PIN_XDG
$env:PIN_YOJSON = $PIN_YOJSON
$env:PIN_ZED = $PIN_ZED

# https://patchwork.kernel.org/project/qemu-devel/patch/20211215073402.144286-17-thuth@redhat.com/
$env:CHERE_INVOKING = "yes" # Preserve the current working directory
$env:MSYS2_PATH_TYPE = "inherit" # Keep the existing environment when sh -l, especially MSVC environment
$env:MSYSTEM = $env:msys2_system # Start a 64 bit environment if CLANG64, etc.

########################### before_script ###############################

# Troubleshooting
If ( "${env:VERBOSE}" -eq "true" ) { Get-ChildItem 'env:' }

# -----
# MSYS2
# -----
#
# https://www.msys2.org/docs/ci/
# https://patchwork.kernel.org/project/qemu-devel/patch/20211215073402.144286-17-thuth@redhat.com/

if ( Test-Path -Path msys64\usr\bin\pacman.exe ) {
  Write-Host "Re-using MSYS2 from cache."
}
else {
  Write-Host "Download the archive ..."
  If ( !(Test-Path -Path msys64\var\cache ) ) { New-Item msys64\var\cache -ItemType Directory | Out-Null }
  If ( !(Test-Path -Path msys64\var\cache\msys2.exe ) ) { Invoke-WebRequest "https://github.com/msys2/msys2-installer/releases/download/2024-01-13/msys2-base-x86_64-20240113.sfx.exe" -outfile "msys64\var\cache\msys2.exe" }

  Write-Host "Extract the archive ..."
  msys64\var\cache\msys2.exe -y # Extract to .\msys64
  Remove-Item msys64\var\cache\msys2.exe # Delete the archive again
  ((Get-Content -path msys64\etc\post-install\07-pacman-key.post -Raw) -replace '--refresh-keys', '--version') | Set-Content -Path msys64\etc\post-install\07-pacman-key.post
  msys64\usr\bin\bash -lc "sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"

  Write-Host "Run for the first time ..."
  msys64\usr\bin\bash -lc ' '
}
Write-Host "Update MSYS2 ..."
msys64\usr\bin\bash -lc 'pacman --noconfirm -Syuu' # Core update (in case any core packages are outdated)
msys64\usr\bin\bash -lc 'pacman --noconfirm -Syuu' # Normal update
if ("${env:CI}" -eq "true") { taskkill /F /FI "MODULES eq msys-2.0.dll" } # Only safe to kill MSYS2 in CI

Write-Host "Install matrix, required and CI packages ..."
#   Packages for GitLab CI:
#     dos2unix (used to translate PowerShell written files below in this CI .yml into MSYS2 scripts)
msys64\usr\bin\bash -lc 'set -x; pacman -Sy --noconfirm --needed ${msys2_packages}  wget make rsync diffutils patch unzip git tar xz dos2unix'

Write-Host "Uninstall MSYS2 conflicting executables ..."
msys64\usr\bin\bash -lc 'rm -vf /usr/bin/link.exe' # link.exe interferes with MSVC's link.exe

# Avoid https://microsoft.github.io/PSRule/v2/troubleshooting/#windows-powershell-is-in-noninteractive-mode
# during `Install-Module VSSetup`.
Write-Host "Installing NuGet ..."
if ($Null -eq (Get-PackageProvider -Name NuGet -ErrorAction Ignore)) { Install-PackageProvider -Name NuGet -Force -Scope CurrentUser; }

Write-Host "Installing VSSetup for the Get-VSSetupInstance function ..."
Install-Module VSSetup -Scope CurrentUser -Force

Write-Host "Writing scripts ..."

# POSIX and AWK scripts

If ( !(Test-Path -Path.ci\sd4 ) ) { New-Item .ci\sd4 -ItemType Directory | Out-Null }

$Content = @'
#!/bin/sh

# ------------------------ Log Formatting ------------------------

TXT_SECTION="\e[94m" # bright blue
TXT_CLEAR="\e[0m"

if [ "${GITLAB_CI:-}" = "true" ]; then
    # https://docs.gitlab.com/ee/ci/jobs/#expand-and-collapse-job-log-sections
    print_section_start() {
        print_section_start_NAME=$1
        shift
        printf "\e[0Ksection_start:%s:%s[collapsed=true]\r\e[0K" \
            "$(date +%s)" \
            "$print_section_start_NAME"
    }
    print_section_end() {
        print_section_end_NAME=$1
        shift
        printf "\e[0Ksection_end:%s:%s\r\e[0K\n" \
            "$(date +%s)" \
            "$print_section_end_NAME"
    }
elif [ -n "${GITHUB_ENV:-}" ]; then
    # https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#grouping-log-lines
    print_section_start() {
        print_section_start_NAME=$1
        shift
        printf "::group::"
    }
    print_section_end() {
        print_section_end_NAME=$1
        shift
        printf "::endgroup::\n"
    }
else
    print_section_start() {
        print_section_start_NAME=$1
        shift
    }
    print_section_end() {
        print_section_end_NAME=$1
        shift
    }
fi

section_begin() {
    # https://docs.gitlab.com/ee/ci/yaml/script.html#add-color-codes-to-script-output
    section_NAME=$1
    shift
    section_HEADER=$1
    shift
    print_section_start "$section_NAME"
    printf "${TXT_SECTION}%s${TXT_CLEAR}\n" "$section_HEADER"
}

section_end() {
    section_NAME=$1
    shift
    print_section_end "$section_NAME"
}

# ------------------- Other Functions -----------------

transfer_dir() {
    transfer_dir_SRC=$1
    shift
    transfer_dir_DST=$1
    shift
    # Remove the destination directory completely, but make sure the parent of the
    # destination directory exists so `mv` will work
    install -d "$transfer_dir_DST"
    rm -rf "$transfer_dir_DST"
    # Move
    if [ -d "$transfer_dir_SRC" ]; then
        mv "$transfer_dir_SRC" "$transfer_dir_DST"
    fi
}

# Set TEMP variable which is used, among other things, for OCaml's
# [Filename.temp_dir_name] on Win32, and by with-dkml.exe on Windows
export_temp_for_windows() {
    if [ -x /usr/bin/cygpath ]; then
        if [ -n "${RUNNER_TEMP:-}" ]; then
            # GitHub Actions
            TEMP=$(cygpath -am "$RUNNER_TEMP")
        else
            # GitLab CI/CD or desktop
            install -d .ci/sd4/tmp
            TEMP=$(cygpath -am ".ci/sd4/tmp")
        fi
        export TEMP
    fi
}

# Fixup opam_root on Windows to be mixed case.
# On input the following variables must be present:
# - opam_root
# - opam_root_cacheable
# On output the input variables will be modified _and_ the
# following variables will be available:
# - original_opam_root
# - original_opam_root_cacheable
# - unix_opam_root
# - unix_opam_root_cacheable
fixup_opam_root() {
    # shellcheck disable=SC2034
    original_opam_root=$opam_root
    # shellcheck disable=SC2034
    original_opam_root_cacheable=$opam_root_cacheable
    if [ -x /usr/bin/cygpath ]; then
        opam_root=$(/usr/bin/cygpath -m "$opam_root")
        opam_root_cacheable=$(/usr/bin/cygpath -m "$opam_root_cacheable")
        unix_opam_root=$(/usr/bin/cygpath -u "$opam_root")
        unix_opam_root_cacheable=$(/usr/bin/cygpath -u "$opam_root_cacheable")
    else
        # shellcheck disable=SC2034
        unix_opam_root=$opam_root
        # shellcheck disable=SC2034
        unix_opam_root_cacheable=$opam_root_cacheable
    fi
}
'@
Set-Content -Path ".ci\sd4\common-values.sh" -Encoding Unicode -Value $Content
msys64\usr\bin\bash -lc 'dos2unix .ci/sd4/common-values.sh'


$Content = @'
#!/bin/sh

# ================
# checkout-code.sh
# ================
#
# Checkouts all of the git source code.
#
# This should be done outside of
# dockcross (used by Linux) since a Docker-in-Docker container can have
# difficulties doing a git checkout (the Git credentials for any private
# repositories are likely not present). We don't care about any private
# repositories for DkML but any code that extends this (ex. DKSDK) may
# need to use private repositories.

set -euf

setup_WORKSPACE_VARNAME=$1
shift
setup_WORKSPACE=$1
shift

if [ -x /usr/bin/cygpath ]; then
    setup_WORKSPACE=$(/usr/bin/cygpath -au "$setup_WORKSPACE")
fi

# ------------------------ Functions ------------------------

# shellcheck source=./common-values.sh
. .ci/sd4/common-values.sh

do_git() {
    if [ -z "${GIT_LOCATION:-}" ]; then
        git "$@"
    else
        PATH="$GIT_LOCATION:$PATH" git "$@"
    fi
}

# Disable automatic garbage collection
git_disable_gc() {
    git_disable_gc_NAME=$1
    shift
    do_git -C ".ci/sd4/g/$git_disable_gc_NAME" config --local gc.auto 0
}

# Mimic the behavior of GitHub's actions/checkout@v4
# - the plus symbol in 'git fetch ... origin +REF:refs/tags/v0.0' overrides any existing REF
git_checkout() {
    git_checkout_NAME=$1
    shift
    git_checkout_URL=$1
    shift
    git_checkout_REF=$1
    shift

    case "$git_checkout_REF" in
      file://*)
        git_checkout_FILEURI=$(printf "%s" "$git_checkout_REF" | sed 's#^file://##')
        rm -rf ".ci/sd4/g/$git_checkout_NAME"
        cp -rp "$git_checkout_FILEURI" ".ci/sd4/g/$git_checkout_NAME" ;;
      *)
        if [ -e ".ci/sd4/g/$git_checkout_NAME" ]; then
            git_disable_gc "$git_checkout_NAME"
            do_git -C ".ci/sd4/g/$git_checkout_NAME" remote set-url origin "$git_checkout_URL"
            do_git -C ".ci/sd4/g/$git_checkout_NAME" fetch --no-tags --progress --no-recurse-submodules --depth=1 origin "+${git_checkout_REF}:refs/tags/v0.0"
        else
            install -d ".ci/sd4/g/$git_checkout_NAME"
            do_git -C ".ci/sd4/g/$git_checkout_NAME" -c init.defaultBranch=main init
            git_disable_gc "$git_checkout_NAME"
            do_git -C ".ci/sd4/g/$git_checkout_NAME" remote add origin "$git_checkout_URL"
            do_git -C ".ci/sd4/g/$git_checkout_NAME" fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin "+${git_checkout_REF}:refs/tags/v0.0"
        fi
        do_git -C ".ci/sd4/g/$git_checkout_NAME" -c advice.detachedHead=false checkout --progress --force refs/tags/v0.0
        do_git -C ".ci/sd4/g/$git_checkout_NAME" log -1 --format='%H' ;;
    esac
}

# ---------------------------------------------------------------------

section_begin checkout-info "Summary: code checkout"

PIN_DKML_RUNTIME_DISTRIBUTION=${PIN_DKML_RUNTIME_DISTRIBUTION:-}
TAG_DKML_RUNTIME_DISTRIBUTION=${TAG_DKML_RUNTIME_DISTRIBUTION:-$PIN_DKML_RUNTIME_DISTRIBUTION}
DKML_RUNTIME_DISTRIBUTION=${DKML_RUNTIME_DISTRIBUTION:-$TAG_DKML_RUNTIME_DISTRIBUTION}

# shellcheck disable=SC2154
echo "
================
checkout-code.sh
================
.
---------
Arguments
---------
WORKSPACE_VARNAME=$setup_WORKSPACE_VARNAME
WORKSPACE=$setup_WORKSPACE
.
------
Inputs
------
VERBOSE=${VERBOSE:-}
.
-------
Context
-------
GIT_LOCATION=${GIT_LOCATION:-}
.
------
Matrix
------
dkml_host_abi=$dkml_host_abi
.
---------
Constants
---------
PIN_DKML_RUNTIME_DISTRIBUTION=${PIN_DKML_RUNTIME_DISTRIBUTION}
TAG_DKML_RUNTIME_DISTRIBUTION=${TAG_DKML_RUNTIME_DISTRIBUTION}
DKML_RUNTIME_DISTRIBUTION=${DKML_RUNTIME_DISTRIBUTION}
.
"

section_end checkout-info

install -d .ci/sd4/g

# dkml-runtime-distribution

#   For 'Diagnose Visual Studio environment variables (Windows)' we need dkml-runtime-distribution
#   so that 'Import-Module Machine' and 'Get-VSSetupInstance' can be run.
#   More importantly, for 'Locate Visual Studio (Windows)' we need dkml-runtime-distribution's
#   'Get-CompatibleVisualStudios' and 'Get-VisualStudioProperties'.
case "$dkml_host_abi" in
windows_*)
    section_begin checkout-dkml-runtime-distribution 'Checkout dkml-runtime-distribution'
    git_checkout dkml-runtime-distribution https://github.com/diskuv/dkml-runtime-distribution.git "$DKML_RUNTIME_DISTRIBUTION"
    section_end checkout-dkml-runtime-distribution
    ;;
esac

'@
Set-Content -Path ".ci\sd4\run-checkout-code.sh" -Encoding Unicode -Value $Content
msys64\usr\bin\bash -lc 'dos2unix .ci/sd4/run-checkout-code.sh'


$Content = @'
#!/bin/sh
set -euf

setup_WORKSPACE_VARNAME=$1
shift
setup_WORKSPACE=$1
shift

if [ -x /usr/bin/cygpath ]; then
    setup_WORKSPACE=$(/usr/bin/cygpath -au "$setup_WORKSPACE")
fi

# ------------------ Variables and functions ------------------------

# shellcheck source=./common-values.sh
. .ci/sd4/common-values.sh

if [ "${VERBOSE:-}" = "true" ]; then
    do_tar_rf() {
        tar rvf "$@"
    }
else
    do_tar_rf() {
        tar rf "$@"
    }
fi

# Make the standard input work as an OCaml string.
# This currently only escapes backslashes and double quotes.
escape_arg_as_ocaml_string() {
    escape_arg_as_ocaml_string_ARG=$1
    shift
    printf "%s" "$escape_arg_as_ocaml_string_ARG" | sed 's#\\#\\\\#g; s#"#\\"#g;'
}

# Fixup opam_root on Windows to be mixed case. Set original_* and unix_* as well.
fixup_opam_root

# Set TEMP variable for Windows
export_temp_for_windows

# Load VS studio environment
if [ -e .ci/sd4/vsenv.sh ]; then
    # shellcheck disable=SC1091
    . .ci/sd4/vsenv.sh
fi

# -------------------------------------------------------------------

docker_image_id=
docker_fqin_preusername= # fully qualified image name (hostname[:port]/username/reponame[:tag]), the parts before the username (hostname[:port]/)
if [ -n "${docker_registry:-}" ]; then
    docker_fqin_preusername="$docker_registry/"
fi

# Extend dockcross. https://github.com/dockcross/dockcross#how-to-extend-dockcross-images
dockcross_cli_image_args=
if [ "${in_docker:-}" = "true" ] && [ -n "${dockcross_image:-}" ]; then
    echo "Doing docker build"
    section_begin dockcross-build "Summary: docker build --quiet --tag ${docker_fqin_preusername}dkml-workflows/dockcross"

    install -d .ci/sd4/docker-image
    #   Since GitLab CI limits environment variables to 255 characters, if you need to exceed that there are five (5)
    #   variations of `dockcross_packages_apt` and `dockcross_packages_yum` to spread the packages over.
    printf "FROM %s\nENV DEFAULT_DOCKCROSS_IMAGE %sdkml-workflows/dockcross:latest\nRUN if command -v apt-get; then apt-get update -y && apt-get install -y rsync %s %s %s %s %s && rm -rf /var/lib/apt/lists/*; fi\nRUN if command -v yum; then yum update -y && yum install -y rsync %s %s %s %s %s && yum clean all && rm -rf /var/cache/yum; fi; %s\n" \
        "${dockcross_image:-}" "${docker_fqin_preusername}" \
        "${dockcross_packages_apt:-}" "${dockcross_packages_apt2:-}" "${dockcross_packages_apt3:-}" "${dockcross_packages_apt4:-}" "${dockcross_packages_apt5:-}" \
        "${dockcross_packages_yum:-}" "${dockcross_packages_yum2:-}" "${dockcross_packages_yum3:-}" "${dockcross_packages_yum4:-}" "${dockcross_packages_yum5:-}" \
        "${docker_assemble_command:-true}" \
        |tee .ci/sd4/docker-image/Dockerfile
    docker build --quiet --tag "${docker_fqin_preusername}dkml-workflows/dockcross:latest" .ci/sd4/docker-image

    # Save image id to re-use for all remaining invocations
    docker images --format "{{.ID}} {{.CreatedAt}}" | sort -rk 2 | awk 'NR==1{print $1}' | tee .ci/sd4/docker-image-id
    docker_image_id=$(cat .ci/sd4/docker-image-id)
    dockcross_cli_image_args="--image $docker_image_id"

    section_end dockcross-build
fi

# Extend docker_image.
if [ "${in_docker:-}" = "true" ] && [ -n "${docker_image:-}" ]; then
    echo "Doing docker build"
    section_begin docker-build "Summary: docker build --quiet --tag ${docker_fqin_preusername}dkml-workflows/docker"

    install -d .ci/sd4/docker-image
    printf "FROM %s\nRUN %s\n" "$docker_image" "${docker_assemble_command:-true}" \
        |tee .ci/sd4/docker-image/Dockerfile
    docker build --quiet --tag "${docker_fqin_preusername}dkml-workflows/docker:latest" .ci/sd4/docker-image

    # Save image id to re-use for all remaining invocations
    docker images --format "{{.ID}} {{.CreatedAt}}" | sort -rk 2 | awk 'NR==1{print $1}' | tee .ci/sd4/docker-image-id
    docker_image_id=$(cat .ci/sd4/docker-image-id)

    section_end docker-build
fi

# -------------------------------------------------------------------

section_begin setup-info "Summary: setup-dkml"

SKIP_OPAM_MODIFICATIONS=${SKIP_OPAM_MODIFICATIONS:-false} # default is false

if [ "$SKIP_OPAM_MODIFICATIONS" = "false" ]; then
    if [ -z "${dkml_target_abi:-}" ]; then
        echo "dkml_target_abi environment variable is required unless SKIP_OPAM_MODIFICATIONS=true" >&2
        exit 2
    fi
fi

# shellcheck disable=SC2154
echo "
=============
setup-dkml.sh
=============
.
---------
Arguments
---------
WORKSPACE_VARNAME=$setup_WORKSPACE_VARNAME
WORKSPACE=$setup_WORKSPACE
.
------
Inputs
------
DISKUV_OPAM_REPOSITORY=${DISKUV_OPAM_REPOSITORY:-}
OCAML_OPAM_REPOSITORY=${OCAML_OPAM_REPOSITORY:-}
DKML_COMPILER=${DKML_COMPILER:-}
OCAML_COMPILER=${OCAML_COMPILER:-}
CONF_DKML_CROSS_TOOLCHAIN=${CONF_DKML_CROSS_TOOLCHAIN:-}
SKIP_OPAM_MODIFICATIONS=${SKIP_OPAM_MODIFICATIONS:-}
SECONDARY_SWITCH=${SECONDARY_SWITCH:-}
PRIMARY_SWITCH_SKIP_INSTALL=${PRIMARY_SWITCH_SKIP_INSTALL:-}
MANYLINUX=${MANYLINUX:-}
DKML_HOME=${DKML_HOME:-}
VERBOSE=${VERBOSE:-}
.
----------------------
DkML Release Constants
----------------------
DKML_VERSION=$DKML_VERSION
DEFAULT_DISKUV_OPAM_REPOSITORY_TAG=$DEFAULT_DISKUV_OPAM_REPOSITORY_TAG
DEFAULT_OCAML_OPAM_REPOSITORY_TAG=$DEFAULT_OCAML_OPAM_REPOSITORY_TAG
DEFAULT_DKML_COMPILER=$DEFAULT_DKML_COMPILER
BOOTSTRAP_OPAM_VERSION=$BOOTSTRAP_OPAM_VERSION
.
-------
Context
-------
PC_PROJECT_DIR=${PC_PROJECT_DIR:-}
GIT_LOCATION=${GIT_LOCATION:-}
.
------
Matrix
------
dkml_host_abi=$dkml_host_abi
dkml_target_abi=${dkml_target_abi:-}
abi_pattern=$abi_pattern
opam_root=${opam_root}
opam_root_cacheable=${opam_root_cacheable}
original_opam_root=${original_opam_root}
original_opam_root_cacheable=${original_opam_root_cacheable}
unix_opam_root=${unix_opam_root}
unix_opam_root_cacheable=${unix_opam_root_cacheable}
docker_registry=${docker_registry:-}
in_docker=${in_docker:-}
dockcross_image=${dockcross_image:-}
dockcross_run_extra_args=${dockcross_run_extra_args:-}
docker_image=${docker_image:-}
docker_runner=${docker_runner:-}
ocaml_options=${ocaml_options:-}
.
----
Pins
----
"
set | grep ^PIN_
echo ".
"
case "$dkml_host_abi" in
windows_*)
    # shellcheck disable=SC2153
    echo "
-------------
Visual Studio
-------------
VS_DIR=$VS_DIR
VS_VCVARSVER=$VS_VCVARSVER
VS_WINSDKVER=$VS_WINSDKVER
VS_MSVSPREFERENCE=$VS_MSVSPREFERENCE
VS_CMAKEGENERATOR=$VS_CMAKEGENERATOR
.
"
    ;;
esac
section_end setup-info

do_bootstrap() {
    install -d .ci/sd4/bs
    cd .ci/sd4/bs

    if [ ! -e stamp ] || [ "$(cat stamp)" != "${BOOTSTRAP_OPAM_VERSION}${dkml_host_abi}" ]; then
        echo 'Bootstrap opam from dkml-component-opam release ...'
        if command -v curl > /dev/null 2> /dev/null; then
            curl -s -L -o opam.tar.gz "https://github.com/diskuv/dkml-component-opam/releases/download/${BOOTSTRAP_OPAM_VERSION}/dkml-component-staging-opam.tar.gz"
        else
            wget -q -O opam.tar.gz "https://github.com/diskuv/dkml-component-opam/releases/download/${BOOTSTRAP_OPAM_VERSION}/dkml-component-staging-opam.tar.gz"
        fi
        tar tfz opam.tar.gz
        tar xfz opam.tar.gz "./staging-files/${dkml_host_abi}/"
        rm -rf bin/
        mv "staging-files/${dkml_host_abi}/bin" .
        rm -rf "${abi_pattern}"
        printf "%s" "${BOOTSTRAP_OPAM_VERSION}${dkml_host_abi}" >stamp
    fi

    rm -f opam.tar.gz
    cd ../../..
}
section_begin bootstrap-opam 'Bootstrap opam'
do_bootstrap
section_end bootstrap-opam

# Start environment distribution tarball
#   We use .tar rather than .tar.gz/.tar.bz2 because we can repeatedly add to an uncompressed .tar. But we need to
#   start with an empty tarball since some tar programs will only add ('tar rf xyz.tar') to an existing .tar.
install -d .ci/sd4/dist
tar cf .ci/sd4/dist/run-with-env.tar -T /dev/null

do_get_dockcross() {
    if [ "${in_docker:-}" = "true" ] && [ -n "${dockcross_image:-}" ]; then
        # The dockcross script is super-slow
        section_begin get-dockcross 'Get dockcross binary (ManyLinux)'
        install -d .ci/sd4
        #   shellcheck disable=SC2086
        docker run ${dockcross_run_extra_args:-} --rm "${docker_image_id}" >.ci/sd4/dockcross.gen

        # PROBLEM 1
        # ---------
        # Super-annoying stderr output from dockcross at line:
        #    tty -s && [ -z "$MSYS" ] && TTY_ARGS=-ti
        # When there is no tty, get:
        #   tty: ignoring all arguments
        #   not a tty
        # So replace 'tty -s &&' with 'false &&'
        sed 's/tty -s &&/false \&\&/' .ci/sd4/dockcross.gen >.ci/sd4/dockcross-real
        rm -f .ci/sd4/dockcross.gen
        chmod +x .ci/sd4/dockcross-real

        # PROBLEM 2
        # ---------
        # By default dockcross for ManyLinux will chown -R all python packages; super-slow (~10 seconds)!
        # Confer: https://github.com/dockcross/dockcross/blob/master/manylinux-common/pre_exec.sh
        # That kills speed for any repetitive dockcross invocation.
        #
        # BUT it is unnecessary to chown -R when the current user is root, because inside the Docker container
        # the files are already root!
        #
        # The chown -R (within pre_exec.sh) is not run when the user ids are not passed in.
        # Confer: https://github.com/dockcross/dockcross/blob/96d87416f639af0204bdd42553e4b99315ca8476/imagefiles/entrypoint.sh#L21-L53
        #
        # So explicitly call the entrypoint if root!
        if echo "${dockcross_run_extra_args:-}" | grep -q linux/386; then
            # https://github.com/dockcross/dockcross/blob/master/linux-x86/linux32-entrypoint.sh
            # But only when `--platform linux/386` because the container image may be overridden.
            dockcross_entrypoint=/dockcross/linux32-entrypoint.sh
        else
            dockcross_entrypoint=/dockcross/entrypoint.sh
        fi
        cat > .ci/sd4/dockcross <<EOF
#!/bin/bash
set -euf
BUILDER_UID="\$( id -u )"
BUILDER_GID="\$( id -g )"
if [ "\$BUILDER_UID" = 0 ] && [ "\$BUILDER_GID" = 0 ]; then
    # ---------- Start of dockcross script snippet -------
    # Verbatim from
    # https://github.com/dockcross/dockcross/blob/96d87416f639af0204bdd42553e4b99315ca8476/imagefiles/dockcross#L175-L204
    # except 1) disabling of USER_IDS

    # Bash on Ubuntu on Windows
    UBUNTU_ON_WINDOWS=\$([ -e /proc/version ] && grep -l Microsoft /proc/version || echo "")
    # MSYS, Git Bash, etc.
    MSYS=\$([ -e /proc/version ] && grep -l MINGW /proc/version || echo "")
    # CYGWIN
    CYGWIN=\$([ -e /proc/version ] && grep -l CYGWIN /proc/version || echo "")

    #if [ -z "\$UBUNTU_ON_WINDOWS" -a -z "\$MSYS" -a "\$OCI_EXE" != "podman" ]; then
    #    USER_IDS=(-e BUILDER_UID="\$( id -u )" -e BUILDER_GID="\$( id -g )" -e BUILDER_USER="\$( id -un )" -e BUILDER_GROUP="\$( id -gn )")
    #fi

    # Change the PWD when working in Docker on Windows
    if [ -n "\$UBUNTU_ON_WINDOWS" ]; then
        WSL_ROOT="/mnt/"
        CFG_FILE=/etc/wsl.conf
            if [ -f "\$CFG_FILE" ]; then
                    CFG_CONTENT=\$(cat \$CFG_FILE | sed -r '/[^=]+=[^=]+/!d' | sed -r 's/\s+=\s/=/g')
                    eval "\$CFG_CONTENT"
                    if [ -n "\$root" ]; then
                            WSL_ROOT=\$root
                    fi
            fi
        HOST_PWD=\`pwd -P\`
        HOST_PWD=\${HOST_PWD/\$WSL_ROOT//}
    elif [ -n "\$MSYS" ]; then
        HOST_PWD=\$PWD
        HOST_PWD=\${HOST_PWD/\//}
        HOST_PWD=\${HOST_PWD/\//:\/}
    elif [ -n "\$CYGWIN" ]; then
        for f in pwd readlink cygpath ; do
            test -n "\$(type "\${f}" )" || { echo >&2 "Missing functionality (\${f}) (in cygwin)." ; exit 1 ; } ;
        done ;
        HOST_PWD="\$( cygpath -w "\$( readlink -f "\$( pwd ;)" ; )" ; )" ;
    else
        HOST_PWD=\$PWD
        [ -L \$HOST_PWD ] && HOST_PWD=\$(readlink \$HOST_PWD)
    fi

    # ---------- End of dockcross script snippet -------

    # Handle: dockcross --args "-v X:Y --platform P"
    ARGS=
    if [ "\$#" -ge 1 ] && [ "\$1" = "--args" ]; then
        shift
        ARGS=\$1
        shift
    fi

    # Handle: dockcross --args "-v X:Y --platform P" --image "..." --
    # Confer: https://github.com/dockcross/dockcross/blob/96d87416f639af0204bdd42553e4b99315ca8476/imagefiles/dockcross#L97C1-L134
    ARG_ARGS=
    ARG_IMAGE="${docker_image_id}"
    while [[ \$# != 0 ]]; do
        case \$1 in
            --)
                shift
                break
                ;;
            --args|-a)
                ARG_ARGS="\$2"
                shift 2
                ;;
            --image|-i)
                ARG_IMAGE="\$2"
                shift 2
                ;;
            -*)
                echo Unknown option \"\$1\" >&2
                exit 67
                ;;
            *)
                break
                ;;
        esac
    done

    # Directly invoke entrypoint
    exec docker run --entrypoint /bin/bash \
        --rm \
        \${ARG_ARGS} \
         -v "\$HOST_PWD":/work \
        "\${ARG_IMAGE}" ${dockcross_entrypoint} "\$@"
else
    HERE=\$(dirname "\$0")
    HERE=\$(cd "\$HERE" && pwd)
    export OCI_EXE=docker # default to podman if available, which breaks complaining about HTTPS vs HTTP on GitHub Actions communicating to http (docker) local registry.
    exec "\$HERE/dockcross-real" "\$@"
fi
EOF
        chmod +x .ci/sd4/dockcross

        # Bundle for consumers of setup-dkml.yml
        do_tar_rf .ci/sd4/dist/run-with-env.tar .ci/sd4/dockcross .ci/sd4/dockcross-real

        section_end get-dockcross
    fi
}
do_get_dockcross

# Get Opam Cache
do_get_opam_cache() {
    if [ "$unix_opam_root_cacheable" = "$unix_opam_root" ]; then return; fi
    if [ ! -e "$unix_opam_root_cacheable" ]; then return; fi
    section_begin get-opam-cache "Transferring Opam cache to $original_opam_root_cacheable"
    echo Starting transfer # need some output or GitLab CI will not display the section duration
    transfer_dir "$unix_opam_root_cacheable" "$unix_opam_root"
    echo Finished transfer
    section_end get-opam-cache
}
do_get_opam_cache

# Setup Opam

do_write_opam_scripts() {
    # ---------------------
    # Empty opam repository
    # ---------------------

    install -d .ci/sd4/eor
    cat >.ci/sd4/eor/repo <<EOF
opam-version: "2.0"
browse: "https://opam.ocaml.org/pkg/"
upstream: "https://github.com/ocaml/opam-repository/tree/master/"
EOF

    # ---------------
    # Create Opam troubleshooting script
    #   Dump logs modified within the last 4 hours
    # ---------------

    cat >.ci/sd4/troubleshoot-opam.sh <<EOF
#!/bin/sh
set -euf
OPAMROOT=\$1
shift
if find . -maxdepth 0 -mmin -240 2>/dev/null >/dev/null; then
    FINDARGS="-mmin -240" # is -mmin supported? BSD (incl. macOS), MSYS2, GNU
else
    FINDARGS="-mtime -1" # use 1 day instead. Solaris
fi
printf "\n\n========= [START OF TROUBLESHOOTING] ===========\n\n" >&2
find "\$OPAMROOT"/log -mindepth 1 -maxdepth 1 \$FINDARGS -name "*.out" ! -name "log-*.out" ! -name "ocaml-variants-*.out" | while read -r dump_on_error_LOG; do
    dump_on_error_BLOG=\$(basename "\$dump_on_error_LOG")
    printf "\n\n========= [TROUBLESHOOTING] %s ===========\n\n" "\$dump_on_error_BLOG" >&2
    awk -v BLOG="\$dump_on_error_BLOG" '{print "[" BLOG "]", \$0}' "\$dump_on_error_LOG" >&2
done
printf "\nScroll up to see the [TROUBLESHOOTING] logs that begin at the [START OF TROUBLESHOOTING] line\n" >&2
EOF

    chmod +x .ci/sd4/troubleshoot-opam.sh
    do_tar_rf .ci/sd4/dist/run-with-env.tar .ci/sd4/troubleshoot-opam.sh

    # ---------------
    # Create Opam support scripts (not needed for all platforms)
    #   The PATH to find opam must work internally in setup-dkml.yml (sd4/bs/bin)
    # ---------------

    USER_ID=$(id -u)
    GROUP_ID=$(id -g)
    USER_NAME=$(id -un)
    GROUP_NAME=$(id -gn)

    case "${opam_root}" in
    /* | ?:*) # /a/b/c or C:\Windows
        validate_supports_docker() {
            echo "Docker only supported with relative paths for the opam root, not: ${opam_root}"
            exit 3
        }
        ;;
    *) # relative path
        validate_supports_docker() {
            true
        }
        cat >.ci/sd4/run-in-docker <<EOF
#!/bin/sh
set -euf
export PATH="/work/.ci/local/bin:/work/.ci/sd4/bs/bin:\$PATH"
export OPAMROOT=/work/${opam_root}
export OPAMROOTISOK=1

# Reset environment so no conflicts with a parent Opam or OCaml system
unset OPAM_SWITCH_PREFIX
unset OPAMSWITCH
unset CAML_LD_LIBRARY_PATH
unset OCAMLLIB
unset OCAML_TOPLEVEL_PATH

prog=\$1
shift

# Optionally skip troubleshooting
troubleshooting=1
if [ "\$#" -ge 1 ] && [ "\$prog" = opam ] && [ "\$1" = "--no-troubleshooting" ]; then
    shift
    troubleshooting=0
fi

echo "Running inside Docker container: \$prog \$*" >&2
set +e
"\$prog" "\$@"
exitcode=\$?
if [ \$troubleshooting = 1 ] && [ \$prog = opam ]; then
    [ \$exitcode = 0 ] || "/work/.ci/sd4/troubleshoot-opam.sh" \$OPAMROOT
fi
exit \$exitcode
EOF
        chmod +x .ci/sd4/run-in-docker
        ;;
    esac

    cat >.ci/sd4/deescalate <<EOF
#!/bin/sh
set -euf

if [ -e /work/.ci/sd4/bs/bin/deps.tar.gz ]; then
    tar xCfz / /work/.ci/sd4/bs/bin/deps.tar.gz
fi

groupadd -g ${GROUP_ID} ${GROUP_NAME}
useradd -l -m -u ${USER_ID} -g ${GROUP_ID} ${USER_NAME}
exec runuser -u ${USER_NAME} -g ${GROUP_NAME} -- "\$@"
EOF

    chmod +x .ci/sd4/deescalate

    # -----------------------------------
    # Create run-with-env
    # -----------------------------------

    install -d .ci/sd4/dist

    if [ -x .ci/sd4/dockcross ]; then
        # Adding empty dockcross root volume avoids:
        #    cp: target ‘/home/root/’ is not a directory
        #    chown: cannot access ‘/home/root’: No such file or directory
        # from https://github.com/dockcross/dockcross/blob/96d87416f639af0204bdd42553e4b99315ca8476/imagefiles/entrypoint.sh#L31-L32
        install -d .ci/sd4/edr

        cat >.ci/sd4/run-with-env <<EOF
#!/bin/sh
set -euf

HERE=\$(dirname "\$0")
HERE=\$(cd "\$HERE" && pwd)
PROJECT_DIR=\$(cd "\$HERE"/../.. && pwd)

# Optionally enable terminal if and only if '-it' option given
termargs=
if [ "\$#" -ge 1 ] && [ "\$1" = "-it" ]; then
    shift
    termargs=-it
fi

exec bash "\${PROJECT_DIR}"/.ci/sd4/dockcross ${dockcross_cli_image_args} --args "\${termargs} -v \${PROJECT_DIR}/.ci/sd4/edr:/home/root ${dockcross_run_extra_args:-}" /work/.ci/sd4/run-in-docker "\$@"
EOF
        chmod +x .ci/sd4/run-with-env

        validate_supports_docker

        # Bundle for consumers of setup-dkml.yml
        echo '__ run-in-docker __'
        cat .ci/sd4/run-in-docker
        echo '___________________'
        do_tar_rf .ci/sd4/dist/run-with-env.tar .ci/sd4/run-with-env .ci/sd4/run-in-docker .ci/sd4/edr

    elif [ "${in_docker:-}" = "true" ] && [ -n "${docker_image:-}" ]; then

        cat >.ci/sd4/run-with-env <<EOF
#!/bin/sh
set -euf
exec ${docker_runner:-docker run --rm --workdir /work} -v "\$PWD:/work" '$docker_image_id' /work/.ci/sd4/run-in-docker "\$@"
EOF
        chmod +x .ci/sd4/run-with-env

        validate_supports_docker

        # Bundle for consumers of setup-dkml.yml
        echo '__ run-in-docker __'
        cat .ci/sd4/run-in-docker
        echo '________________________'
        echo '__ deescalate __'
        cat .ci/sd4/deescalate
        echo '________________'
        do_tar_rf .ci/sd4/dist/run-with-env.tar .ci/sd4/run-with-env .ci/sd4/run-in-docker .ci/sd4/deescalate

    else

        cat >.ci/sd4/run-with-env <<EOF
#!/bin/sh
set -euf

HERE=\$(dirname "\$0")
HERE=\$(cd "\$HERE" && pwd)
PROJECT_DIR=\$(cd "\$HERE"/../.. && pwd)

export PATH="\${PROJECT_DIR}/.ci/local/bin:\${PROJECT_DIR}/.ci/sd4/bs/bin:\$PATH"
export OPAMROOT='${opam_root}'
export OPAMROOTISOK=1

# Reset environment so no conflicts with a parent Opam or OCaml system
unset OPAM_SWITCH_PREFIX
unset OPAMSWITCH
unset CAML_LD_LIBRARY_PATH
unset OCAMLLIB
unset OCAML_TOPLEVEL_PATH

prog=\$1
shift

# Optionally skip troubleshooting
troubleshooting=1
if [ "\$#" -ge 1 ] && [ "\$prog" = opam ] && [ "\$1" = "--no-troubleshooting" ]; then
    shift
    troubleshooting=0
fi

echo "Running: \$prog \$*" >&2
set +e
"\$prog" "\$@"
exitcode=\$?
if [ \$troubleshooting = 1 ] && [ \$prog = opam ]; then
    [ \$exitcode = 0 ] || "\${PROJECT_DIR}/.ci/sd4/troubleshoot-opam.sh" \$OPAMROOT
fi
exit \$exitcode
EOF
        chmod +x .ci/sd4/run-with-env

        # Bundle for consumers of setup-dkml.yml
        do_tar_rf .ci/sd4/dist/run-with-env.tar .ci/sd4/run-with-env

    fi
    echo '__ run-with-env __'
    cat .ci/sd4/run-with-env
    echo '__________________'

    # ------
    # cmdrun
    # ------

    install -d .ci/sd4/opamrun
    cat >.ci/sd4/opamrun/cmdrun <<EOF
#!/bin/sh
set -euf

HERE=\$(dirname "\$0")
HERE=\$(cd "\$HERE" && pwd)
PROJECT_DIR=\$(cd "\$HERE"/../../.. && pwd)

# Add MSVC compiler environment if available
if [ -e "\${PROJECT_DIR}/.ci/sd4/msvcenv" ]; then
    _oldpath="\$PATH"
    # shellcheck disable=SC1091
    . "\${PROJECT_DIR}/.ci/sd4/msvcenv"
    PATH="\$PATH:\$_oldpath"

    # MSVC (link.exe) needs a TMP as well.
    # Confer: https://docs.microsoft.com/en-us/cpp/build/reference/linking?view=msvc-170#link-environment-variables
    if [ -z "\${TMP:-}" ]; then
        # GitHub Actions as of 2022-10 does not set TMP. GitLab CI/CD does.
        TMP="\$RUNNER_TEMP"
    fi
    export TMP
    if [ -x /usr/bin/cygpath ]; then
        TMP=\$(/usr/bin/cygpath -aw "\$TMP")
    fi
fi

# Windows
if [ -n "\${COMSPEC:-}" ]; then
    # We must place MSYS2 in front of path so that MSYS2
    # tar.exe is used instead of Windows tar.exe.
    PATH="/usr/bin:\$PATH"
fi

# Propagate important CI environment variables
export CI='${CI:-}'

exec "\${PROJECT_DIR}/.ci/sd4/run-with-env" "\$@"
EOF
    chmod +x .ci/sd4/opamrun/cmdrun
    echo '__ cmdrun __'
    cat .ci/sd4/opamrun/cmdrun
    echo '____________'

    # -------
    # opamrun
    # -------

    install -d .ci/sd4/opamrun
    cat >.ci/sd4/opamrun/opamrun <<EOF
#!/bin/sh
set -euf

HERE=\$(dirname "\$0")
HERE=\$(cd "\$HERE" && pwd)
PROJECT_DIR=\$(cd "\$HERE"/../../.. && pwd)

exec "\${PROJECT_DIR}/.ci/sd4/opamrun/cmdrun" opam "\$@"
EOF
    chmod +x .ci/sd4/opamrun/opamrun
    echo '__ opamrun __'
    cat .ci/sd4/opamrun/opamrun
    echo '_____________'

    # Bundle for consumers of setup-dkml.yml
    do_tar_rf .ci/sd4/dist/run-with-env.tar .ci/sd4/opamrun
}
section_begin 'write-opam-scripts' 'Write opam scripts'
do_write_opam_scripts
section_end 'write-opam-scripts'

# Expose opamrun (also used for consumers of setup-dkml.yml) to GitHub
if [ -n "${GITHUB_PATH:-}" ]; then
    opamrunabs="$setup_WORKSPACE/.ci/sd4/opamrun"
    if [ -x /usr/bin/cygpath ]; then opamrunabs=$(/usr/bin/cygpath -aw "$opamrunabs"); fi
    echo "$opamrunabs" >>"$GITHUB_PATH"
    # Special case: GITHUB_PATH does not influence msys2.CMD of msys2/setup-msys2@v2, so place in real MSYS2 PATH
    if [ -n "${MSYSTEM:-}" ]; then
        install -d /usr/local/bin
        install .ci/sd4/opamrun/opamrun /usr/local/bin/opamrun
    fi
fi

# Place opamrun in the immediate PATH
PATH="$setup_WORKSPACE/.ci/sd4/opamrun:$PATH"

#   Complicated Opam sequence is because:
#   1. Opam's default curl does not work on Windows,
#      and `opam init` does not provide a way to change it (TODO: need
#      a PR!).
#   2. We have to separate the Opam download cache from the other Opam
#      caches
if [ "${SKIP_OPAM_MODIFICATIONS:-}" = "false" ] && [ ! -s "$opam_root/.ci.root-init" ]; then # non-empty init file so can be cached irrespective of existence
    section_begin opam-init 'Initialize opam root'

    # Clear any partial previous attempt
    rm -rf "$opam_root"
    
    # Set --git-location variant
    if [ -n "${GIT_LOCATION:-}" ]; then
        if [ -x /usr/bin/cygpath ]; then
            GIT_LOCATION_MIXED=$(/usr/bin/cygpath -am "$GIT_LOCATION")
            opamrun_gitloc() {
                opamrun "$@" "--git-location=$GIT_LOCATION_MIXED"
            }
        else
            opamrun_gitloc() {
                opamrun "$@" "--git-location=$GIT_LOCATION"
            }
        fi
    else
        opamrun_gitloc() {
            opamrun "$@"
        }
    fi

    case "$dkml_host_abi,${in_docker:-}" in
    windows_*,*)
        eor=$(/usr/bin/cygpath -am "$setup_WORKSPACE"/.ci/sd4/eor)
        cygloc=$(/usr/bin/cygpath -am /)
        case "$(opamrun --version)" in
         2.1.*|2.0.*|1.*) opamrun init --disable-sandboxing --no-setup --kind local --bare "$eor" ;;
         *) opamrun_gitloc init --disable-sandboxing --no-setup --kind local "--cygwin-location=$cygloc" --bare "$eor" ;;
        esac
        case "$(opamrun --version)" in
         2.0.*) echo 'download-command: wget' >>"$opam_root/config" ;;
         *) opamrun option --yes --global download-command=wget ;;
        esac
        ;;
    *,true)
        #  no --git-location needed inside Docker container
        opamrun init --disable-sandboxing --no-setup --kind local --bare "/work/.ci/sd4/eor"
        ;;
    *)
        case "$(opamrun --version)" in
         2.1.*|2.0.*|1.*) opamrun init --disable-sandboxing --no-setup --kind local --bare "$setup_WORKSPACE/.ci/sd4/eor" ;;
         *) opamrun_gitloc init --disable-sandboxing --no-setup --kind local --bare "$setup_WORKSPACE/.ci/sd4/eor" ;;
        esac
        ;;
    esac
    echo yes > "$opam_root/.ci.root-init"

    section_end opam-init
fi

if [ "${SKIP_OPAM_MODIFICATIONS:-}" = "false" ]; then
    section_begin opam-vars "Summary: opam global variables"
    opamrun --no-troubleshooting var --global || true
    section_end opam-vars
fi

# Build OCaml

do_switch_create() {
    do_switch_create_NAME=$1
    shift

    section_begin "switch-create-$do_switch_create_NAME" "Create opam switch '$do_switch_create_NAME'"
    # Create, or recreate, the Opam switch. The Opam switch should not be
    # cached except for the compiler (confer docs for setup-ocaml GitHub
    # Action) which is the 'dkml' switch (or the 'two' switch).
    # Check if the switch name is present in the Opam root (which may come from cache)
    NOMINALLY_PRESENT=false
    if opamrun switch list --short | grep "^${do_switch_create_NAME}\$"; then NOMINALLY_PRESENT=true; fi

    # Check if the switch is actually present in case of cache incoherence
    # or corrupt Opam state that could result in:
    #   Error:  No config file found for switch dkml. Switch broken?
    if [ $NOMINALLY_PRESENT = true ] && [ ! -e "$opam_root/$do_switch_create_NAME/.opam-switch/switch-config" ]; then
        # Remove the switch name from Opam root, and any partial switch state.
        # Ignore inevitable warnings/failure about missing switch.
        opamrun --no-troubleshooting switch remove "$do_switch_create_NAME" --yes || true
        rm -rf "${opam_root:?}/$do_switch_create_NAME"
        NOMINALLY_PRESENT=false
    fi

    if [ $NOMINALLY_PRESENT = false ]; then
        opamrun switch create "$do_switch_create_NAME" --empty --yes
    fi
    section_end "switch-create-$do_switch_create_NAME"
}
if [ "${SKIP_OPAM_MODIFICATIONS:-}" = "false" ]; then
    do_switch_create dkml
    if [ "${SECONDARY_SWITCH:-}" = "true" ]; then
        do_switch_create two
    else
        section_begin "switch-create-two" "Create empty opam switch 'two'"
        # Always create a secondary switch ... just empty. Avoid problems with cache content missing
        # and idempotency.
        opamrun --no-troubleshooting switch remove two --yes || true
        rm -rf "$opam_root/two"
        opamrun switch create two --empty --yes
        section_end "switch-create-two"
    fi
fi

do_switch_active() {
    section_begin "switch-active" "Set dkml as active switch"
    opamrun switch set dkml --yes
    section_end "switch-active"
}
if [ "${SKIP_OPAM_MODIFICATIONS:-}" = "false" ]; then
    do_switch_active
fi

case "${DISKUV_OPAM_REPOSITORY:-}" in
  file://*) 
    DISKUV_OPAM_REPOSITORY_URI="${DISKUV_OPAM_REPOSITORY}" ;;
  *)
    DISKUV_OPAM_REPOSITORY_URI="git+https://github.com/diskuv/diskuv-opam-repository.git#${DISKUV_OPAM_REPOSITORY:-$DEFAULT_DISKUV_OPAM_REPOSITORY_TAG}" ;;
esac

do_opam_repositories_add() {
    section_begin "opam-repo-add" "Add 'diskuv' opam repository"
    if ! opamrun --no-troubleshooting repository list -s | grep '^diskuv'; then
        opamrun repository add diskuv "${DISKUV_OPAM_REPOSITORY_URI}" --yes --dont-select
    fi
    section_end "opam-repo-add"
}
if [ "${SKIP_OPAM_MODIFICATIONS:-}" = "false" ]; then
    do_opam_repositories_add
fi

do_opam_repositories_config() {
    do_opam_repositories_config_NAME=$1
    shift

    section_begin "opam-repo-$do_opam_repositories_config_NAME" "Attach repositories to $do_opam_repositories_config_NAME"

    if [ ! -s "$opam_root/.ci.$do_opam_repositories_config_NAME.repo-init" ]; then # non-empty init file so can be cached irrespective of existence
        opamrun --no-troubleshooting repository remove default --switch "$do_opam_repositories_config_NAME" --yes || true
        opamrun --no-troubleshooting repository remove diskuv --switch "$do_opam_repositories_config_NAME" --yes || true
        opamrun repository add default --switch "$do_opam_repositories_config_NAME" --yes
        opamrun repository add diskuv --switch "$do_opam_repositories_config_NAME" --yes
        echo yes > "$opam_root/.ci.$do_opam_repositories_config_NAME.repo-init"
    fi

    section_end "opam-repo-$do_opam_repositories_config_NAME"
}
if [ "${SKIP_OPAM_MODIFICATIONS:-}" = "false" ]; then
    do_opam_repositories_config dkml
    if [ "${SECONDARY_SWITCH:-}" = "true" ]; then
        do_opam_repositories_config two
    fi
fi

do_opam_repositories_update() {
    section_begin "opam-repo-update" "Update opam repositories"
    # The default repository may be the initial 'eor' (empty) repository
    opamrun repository set-url default "git+https://github.com/ocaml/opam-repository.git#${OCAML_OPAM_REPOSITORY:-$DEFAULT_OCAML_OPAM_REPOSITORY_TAG}" --yes
    # Always set the `diskuv` repository url since it can change
    opamrun repository set-url diskuv "${DISKUV_OPAM_REPOSITORY_URI}" --yes --dont-select
    # Update both `default` and `diskuv` Opam repositories
    opamrun update default diskuv
    section_end "opam-repo-update"
}
if [ "${SKIP_OPAM_MODIFICATIONS:-}" = "false" ]; then
    do_opam_repositories_update
fi

do_pins() {
    do_pins_NAME=$1
    shift

    section_begin "opam-pins-$do_pins_NAME" "Opam pins for $do_pins_NAME switch"
    #   adapted from dkml-runtime-common's _common_tool.sh:get_opam_switch_state_toplevelsection
    if [ -e "$opam_root/$do_pins_NAME/.opam-switch/switch-state" ]; then
        #       shellcheck disable=SC2016
        awk -v section="pinned" \
            '$1 ~ ":" {state=0} $1==(section ":") {state=1} state==1{print}' \
            "$opam_root/$do_pins_NAME/.opam-switch/switch-state" \
            > "$opam_root/.ci.$do_pins_NAME.pinned"
    else
        touch "$opam_root/.ci.$do_pins_NAME.pinned"
    fi
    printf "#!/bin/sh\nset -eufx\n" > "$opam_root/.ci.$do_pins_NAME.do.sh"
    do_pin_add() {
        do_pin_add_NAME=$1; shift
        do_pin_add_VER=$1; shift
        # ex. "astring.1.0.2" - The double-quotes are necessary.
        if ! grep -q "\"$do_pin_add_NAME.$do_pin_add_VER\"" "$opam_root/.ci.$do_pins_NAME.pinned"; then
            printf "opam pin add --switch '%s' --yes --no-action -k version '%s' '%s'\n" "$do_pins_NAME" "$do_pin_add_NAME" "$do_pin_add_VER" >> "$opam_root/.ci.$do_pins_NAME.do.sh"
        fi
    }
    ### BEGIN pin-adds. DO NOT EDIT THE LINES IN THIS SECTION
    # Managed by bump-packages.cmake
    do_pin_add MlFront_Unpack "${PIN_MLFRONT_UNPACK}"
    do_pin_add angstrom "${PIN_ANGSTROM}"
    do_pin_add angstrom-lwt-unix "${PIN_ANGSTROM_LWT_UNIX}"
    do_pin_add astring "${PIN_ASTRING}"
    do_pin_add base "${PIN_BASE}"
    do_pin_add base64 "${PIN_BASE64}"
    do_pin_add bigarray-compat "${PIN_BIGARRAY_COMPAT}"
    do_pin_add bigstringaf "${PIN_BIGSTRINGAF}"
    do_pin_add bos "${PIN_BOS}"
    do_pin_add camlp-streams "${PIN_CAMLP_STREAMS}"
    do_pin_add chrome-trace "${PIN_CHROME_TRACE}"
    do_pin_add cmdliner "${PIN_CMDLINER}"
    do_pin_add conf-bash "${PIN_CONF_BASH}"
    do_pin_add conf-dkml-sys-opam "${PIN_CONF_DKML_SYS_OPAM}"
    do_pin_add conf-dksdk "${PIN_CONF_DKSDK}"
    do_pin_add conf-pkg-config "${PIN_CONF_PKG_CONFIG}"
    do_pin_add conf-sdl2 "${PIN_CONF_SDL2}"
    do_pin_add conf-sqlite3 "${PIN_CONF_SQLITE3}"
    do_pin_add cppo "${PIN_CPPO}"
    do_pin_add crunch "${PIN_CRUNCH}"
    do_pin_add csexp "${PIN_CSEXP}"
    do_pin_add cstruct "${PIN_CSTRUCT}"
    do_pin_add ctypes "${PIN_CTYPES}"
    do_pin_add ctypes-foreign "${PIN_CTYPES_FOREIGN}"
    do_pin_add cudf "${PIN_CUDF}"
    do_pin_add dap "${PIN_DAP}"
    do_pin_add digestif "${PIN_DIGESTIF}"
    do_pin_add diskuvbox "${PIN_DISKUVBOX}"
    do_pin_add dkml-apps "${PIN_DKML_APPS}"
    do_pin_add dkml-base-compiler "${PIN_DKML_BASE_COMPILER}"
    do_pin_add dkml-build-desktop "${PIN_DKML_BUILD_DESKTOP}"
    do_pin_add dkml-c-probe "${PIN_DKML_C_PROBE}"
    do_pin_add dkml-compiler-src "${PIN_DKML_COMPILER_SRC}"
    do_pin_add dkml-component-xx-console "${PIN_DKML_COMPONENT_XX_CONSOLE}"
    do_pin_add dkml-exe "${PIN_DKML_EXE}"
    do_pin_add dkml-exe-lib "${PIN_DKML_EXE_LIB}"
    do_pin_add dkml-host-abi "${PIN_DKML_HOST_ABI}"
    do_pin_add dkml-host-abi-windows_x86_64 "${PIN_DKML_HOST_ABI_WINDOWS_X86_64}"
    do_pin_add dkml-install "${PIN_DKML_INSTALL}"
    do_pin_add dkml-install-installer "${PIN_DKML_INSTALL_INSTALLER}"
    do_pin_add dkml-install-runner "${PIN_DKML_INSTALL_RUNNER}"
    do_pin_add dkml-installer-ocaml-common "${PIN_DKML_INSTALLER_OCAML_COMMON}"
    do_pin_add dkml-option-bx32 "${PIN_DKML_OPTION_BX32}"
    do_pin_add dkml-package-console "${PIN_DKML_PACKAGE_CONSOLE}"
    do_pin_add dkml-runtime-common "${PIN_DKML_RUNTIME_COMMON}"
    do_pin_add dkml-runtime-common-native "${PIN_DKML_RUNTIME_COMMON_NATIVE}"
    do_pin_add dkml-runtime-distribution "${PIN_DKML_RUNTIME_DISTRIBUTION}"
    do_pin_add dkml-runtimelib "${PIN_DKML_RUNTIMELIB}"
    do_pin_add dkml-runtimescripts "${PIN_DKML_RUNTIMESCRIPTS}"
    do_pin_add dkml-target-abi-any "${PIN_DKML_TARGET_ABI_ANY}"
    do_pin_add dkml-target-abi-windows_x86_64 "${PIN_DKML_TARGET_ABI_WINDOWS_X86_64}"
    do_pin_add dkml-workflows "${PIN_DKML_WORKFLOWS}"
    do_pin_add dune "${PIN_DUNE}"
    do_pin_add dune-action-plugin "${PIN_DUNE_ACTION_PLUGIN}"
    do_pin_add dune-build-info "${PIN_DUNE_BUILD_INFO}"
    do_pin_add dune-configurator "${PIN_DUNE_CONFIGURATOR}"
    do_pin_add dune-glob "${PIN_DUNE_GLOB}"
    do_pin_add dune-private-libs "${PIN_DUNE_PRIVATE_LIBS}"
    do_pin_add dune-rpc "${PIN_DUNE_RPC}"
    do_pin_add dune-rpc-lwt "${PIN_DUNE_RPC_LWT}"
    do_pin_add dune-site "${PIN_DUNE_SITE}"
    do_pin_add dyn "${PIN_DYN}"
    do_pin_add earlybird "${PIN_EARLYBIRD}"
    do_pin_add either "${PIN_EITHER}"
    do_pin_add eqaf "${PIN_EQAF}"
    do_pin_add extlib "${PIN_EXTLIB}"
    do_pin_add feather "${PIN_FEATHER}"
    do_pin_add fiber "${PIN_FIBER}"
    do_pin_add fix "${PIN_FIX}"
    do_pin_add fmt "${PIN_FMT}"
    do_pin_add fpath "${PIN_FPATH}"
    do_pin_add graphics "${PIN_GRAPHICS}"
    do_pin_add hmap "${PIN_HMAP}"
    do_pin_add host-arch-x86_64 "${PIN_HOST_ARCH_X86_64}"
    do_pin_add integers "${PIN_INTEGERS}"
    do_pin_add iostream "${PIN_IOSTREAM}"
    do_pin_add iter "${PIN_ITER}"
    do_pin_add jane-street-headers "${PIN_JANE_STREET_HEADERS}"
    do_pin_add jingoo "${PIN_JINGOO}"
    do_pin_add jsonrpc "${PIN_JSONRPC}"
    do_pin_add jst-config "${PIN_JST_CONFIG}"
    do_pin_add lambda-term "${PIN_LAMBDA_TERM}"
    do_pin_add logs "${PIN_LOGS}"
    do_pin_add lru "${PIN_LRU}"
    do_pin_add lsp "${PIN_LSP}"
    do_pin_add lwt "${PIN_LWT}"
    do_pin_add lwt_ppx "${PIN_LWT_PPX}"
    do_pin_add lwt_react "${PIN_LWT_REACT}"
    do_pin_add mccs "${PIN_MCCS}"
    do_pin_add mdx "${PIN_MDX}"
    do_pin_add menhir "${PIN_MENHIR}"
    do_pin_add menhirCST "${PIN_MENHIRCST}"
    do_pin_add menhirLib "${PIN_MENHIRLIB}"
    do_pin_add menhirSdk "${PIN_MENHIRSDK}"
    do_pin_add merlin-lib "${PIN_MERLIN_LIB}"
    do_pin_add metapp "${PIN_METAPP}"
    do_pin_add metaquot "${PIN_METAQUOT}"
    do_pin_add mew "${PIN_MEW}"
    do_pin_add mew_vi "${PIN_MEW_VI}"
    do_pin_add msys2 "${PIN_MSYS2}"
    do_pin_add msys2-clang64 "${PIN_MSYS2_CLANG64}"
    do_pin_add num "${PIN_NUM}"
    do_pin_add ocaml "${PIN_OCAML}"
    do_pin_add ocaml-compiler-libs "${PIN_OCAML_COMPILER_LIBS}"
    do_pin_add ocaml-lsp-server "${PIN_OCAML_LSP_SERVER}"
    do_pin_add ocaml-syntax-shims "${PIN_OCAML_SYNTAX_SHIMS}"
    do_pin_add ocaml-version "${PIN_OCAML_VERSION}"
    do_pin_add ocamlbuild "${PIN_OCAMLBUILD}"
    do_pin_add ocamlc-loc "${PIN_OCAMLC_LOC}"
    do_pin_add ocamlfind "${PIN_OCAMLFIND}"
    do_pin_add ocamlformat "${PIN_OCAMLFORMAT}"
    do_pin_add ocamlformat-lib "${PIN_OCAMLFORMAT_LIB}"
    do_pin_add ocamlformat-rpc-lib "${PIN_OCAMLFORMAT_RPC_LIB}"
    do_pin_add ocp-indent "${PIN_OCP_INDENT}"
    do_pin_add ocplib-endian "${PIN_OCPLIB_ENDIAN}"
    do_pin_add odoc "${PIN_ODOC}"
    do_pin_add odoc-parser "${PIN_ODOC_PARSER}"
    do_pin_add ordering "${PIN_ORDERING}"
    do_pin_add parsexp "${PIN_PARSEXP}"
    do_pin_add path_glob "${PIN_PATH_GLOB}"
    do_pin_add posixat "${PIN_POSIXAT}"
    do_pin_add pp "${PIN_PP}"
    do_pin_add ppx_assert "${PIN_PPX_ASSERT}"
    do_pin_add ppx_base "${PIN_PPX_BASE}"
    do_pin_add ppx_cold "${PIN_PPX_COLD}"
    do_pin_add ppx_compare "${PIN_PPX_COMPARE}"
    do_pin_add ppx_derivers "${PIN_PPX_DERIVERS}"
    do_pin_add ppx_deriving "${PIN_PPX_DERIVING}"
    do_pin_add ppx_deriving_yojson "${PIN_PPX_DERIVING_YOJSON}"
    do_pin_add ppx_enumerate "${PIN_PPX_ENUMERATE}"
    do_pin_add ppx_expect "${PIN_PPX_EXPECT}"
    do_pin_add ppx_globalize "${PIN_PPX_GLOBALIZE}"
    do_pin_add ppx_hash "${PIN_PPX_HASH}"
    do_pin_add ppx_here "${PIN_PPX_HERE}"
    do_pin_add ppx_ignore_instrumentation "${PIN_PPX_IGNORE_INSTRUMENTATION}"
    do_pin_add ppx_inline_test "${PIN_PPX_INLINE_TEST}"
    do_pin_add ppx_optcomp "${PIN_PPX_OPTCOMP}"
    do_pin_add ppx_pipebang "${PIN_PPX_PIPEBANG}"
    do_pin_add ppx_sexp_conv "${PIN_PPX_SEXP_CONV}"
    do_pin_add ppx_yojson_conv_lib "${PIN_PPX_YOJSON_CONV_LIB}"
    do_pin_add ppxlib "${PIN_PPXLIB}"
    do_pin_add psq "${PIN_PSQ}"
    do_pin_add ptime "${PIN_PTIME}"
    do_pin_add qrc "${PIN_QRC}"
    do_pin_add re "${PIN_RE}"
    do_pin_add react "${PIN_REACT}"
    do_pin_add refl "${PIN_REFL}"
    do_pin_add result "${PIN_RESULT}"
    do_pin_add rresult "${PIN_RRESULT}"
    do_pin_add seq "${PIN_SEQ}"
    do_pin_add sexplib "${PIN_SEXPLIB}"
    do_pin_add sexplib0 "${PIN_SEXPLIB0}"
    do_pin_add sha "${PIN_SHA}"
    do_pin_add shexp "${PIN_SHEXP}"
    do_pin_add spawn "${PIN_SPAWN}"
    do_pin_add sqlite3 "${PIN_SQLITE3}"
    do_pin_add stdcompat "${PIN_STDCOMPAT}"
    do_pin_add stdio "${PIN_STDIO}"
    do_pin_add stdlib-shims "${PIN_STDLIB_SHIMS}"
    do_pin_add stdune "${PIN_STDUNE}"
    do_pin_add stringext "${PIN_STRINGEXT}"
    do_pin_add time_now "${PIN_TIME_NOW}"
    do_pin_add tiny_httpd "${PIN_TINY_HTTPD}"
    do_pin_add topkg "${PIN_TOPKG}"
    do_pin_add traverse "${PIN_TRAVERSE}"
    do_pin_add trie "${PIN_TRIE}"
    do_pin_add tsort "${PIN_TSORT}"
    do_pin_add tyxml "${PIN_TYXML}"
    do_pin_add uchar "${PIN_UCHAR}"
    do_pin_add uri "${PIN_URI}"
    do_pin_add utop "${PIN_UTOP}"
    do_pin_add uucp "${PIN_UUCP}"
    do_pin_add uuidm "${PIN_UUIDM}"
    do_pin_add uuseg "${PIN_UUSEG}"
    do_pin_add uutf "${PIN_UUTF}"
    do_pin_add with-dkml "${PIN_WITH_DKML}"
    do_pin_add xdg "${PIN_XDG}"
    do_pin_add yojson "${PIN_YOJSON}"
    do_pin_add zed "${PIN_ZED}"
    ### END pin-adds. DO NOT EDIT THE LINES ABOVE
    cmdrun sh "$opam_root/.ci.$do_pins_NAME.do.sh"
    section_end "opam-pins-$do_pins_NAME"

    # --------------
    # REMAINING PINS
    # --------------

    # These come after [pin-adds] section since [pin-adds] may need to be overridden by
    # users' choice.

    # dkml-base-compiler

    if [ "${DKML_COMPILER:-}" != '@repository@' ] && [ -z "${DKML_COMPILER:-}" ] && [ -z "${OCAML_COMPILER:-}" ]; then
        section_begin checkout-dkml-base-compiler "Pin dkml-base-compiler to default ${DEFAULT_DKML_COMPILER} (neither dkml-base-compiler nor OCAML_COMPILER specified) for $do_pins_NAME switch"
        opamrun pin add --switch "$do_pins_NAME" --yes --no-action dkml-base-compiler "https://github.com/diskuv/dkml-compiler.git#${DEFAULT_DKML_COMPILER}"
        section_end checkout-dkml-base-compiler
    elif [ "${DKML_COMPILER:-}" != '@repository@' ] && [ -n "${DKML_COMPILER:-}" ] && [ -z "${OCAML_COMPILER:-}" ]; then
        section_begin checkout-dkml-base-compiler "Pin dkml-base-compiler to $DKML_COMPILER (dkml-base-compiler specified; no OCAML_COMPILER specified) for $do_pins_NAME switch"
        case "$DKML_COMPILER" in
         file://*) opamrun pin add --switch "$do_pins_NAME" --yes --no-action dkml-base-compiler "${DKML_COMPILER}" ;;
         *) opamrun pin add --switch "$do_pins_NAME" --yes --no-action dkml-base-compiler "https://github.com/diskuv/dkml-compiler.git#${DKML_COMPILER}" ;;
        esac
        section_end checkout-dkml-base-compiler
    elif [ -n "${OCAML_COMPILER:-}" ]; then
        # Validate OCAML_COMPILER (OCAML_COMPILER specified)
        case "${OCAML_COMPILER:-}" in
        4.12.1) true ;;
        4.14.0) true ;;
        4.14.2) true ;;
        *)
            echo "OCAML_COMPILER version ${OCAML_COMPILER:-} is not supported"
            exit 109
            ;;
        esac

        section_begin checkout-dkml-base-compiler "Pin dkml-base-compiler (OCAML_COMPILER specified) for $do_pins_NAME switch"
        opamrun pin add --switch "$do_pins_NAME" --yes --no-action dkml-base-compiler "https://github.com/diskuv/dkml-compiler.git#${OCAML_COMPILER}-v${DKML_VERSION}"
        section_end checkout-dkml-base-compiler
    fi

    # conf-dkml-cross-toolchain

    if [ "${CONF_DKML_CROSS_TOOLCHAIN:-}" != '@repository@' ]; then
        section_begin checkout-conf-dkml-cross-toolchain "Pin conf-dkml-cross-toolchain for $do_pins_NAME switch"
        opamrun pin add --switch "$do_pins_NAME" --yes --no-action conf-dkml-cross-toolchain "https://github.com/diskuv/conf-dkml-cross-toolchain.git#$CONF_DKML_CROSS_TOOLCHAIN"
        section_end checkout-conf-dkml-cross-toolchain
    fi
}

if [ "${SKIP_OPAM_MODIFICATIONS:-}" = "false" ]; then
    do_pins dkml
    if [ "${SECONDARY_SWITCH:-}" = "true" ]; then
        do_pins two
    fi
fi

do_use_vsstudio() {
    do_use_vsstudio_NAME=$1
    shift
    case "$dkml_host_abi" in
    windows_*)
        section_begin "use-vsstudio-$do_use_vsstudio_NAME" "Use Visual Studio in dkml-* Opam packages (Windows) for $do_use_vsstudio_NAME switch"

        # shellcheck disable=SC2153
        E_VS_DIR=$(escape_arg_as_ocaml_string "$VS_DIR")
        # shellcheck disable=SC2153
        E_VS_VCVARSVER=$(escape_arg_as_ocaml_string "$VS_VCVARSVER")
        # shellcheck disable=SC2153
        E_VS_WINSDKVER=$(escape_arg_as_ocaml_string "$VS_WINSDKVER")
        # shellcheck disable=SC2153
        E_VS_MSVSPREFERENCE=$(escape_arg_as_ocaml_string "$VS_MSVSPREFERENCE")
        # shellcheck disable=SC2153
        E_VS_CMAKEGENERATOR=$(escape_arg_as_ocaml_string "$VS_CMAKEGENERATOR")

        case "$(opamrun --version)" in
        2.0.*)
            if [ "${in_docker}" = "true" ]; then
                echo Opam 2.0 support in dockcross to use a portable opam var prefix not yet implemented
                exit 67
            fi
            OP=$(opamrun var prefix --switch "$do_use_vsstudio_NAME")
            OPSC=$OP/.opam-switch/switch-config
            if grep setenv: "$OPSC"; then
                echo "INFO: Updating switch-config. Old was:"
                awk '{print ">> " $0}' "$OPSC"

                awk '$1=="setenv:"{x=1} x==0{print} x==1 && $0=="]"{x=0}' "$OPSC" >"$OPSC".trimmed
                mv "$OPSC".trimmed "$OPSC"
            fi
            echo 'setenv: [' >>"$OPSC"
            echo '  [DKML_COMPILE_SPEC = "1"]' >>"$OPSC"
            echo '  [DKML_COMPILE_TYPE = "VS"]' >>"$OPSC"
            echo "  [DKML_COMPILE_VS_DIR = \"$E_VS_DIR\"]" >>"$OPSC"
            echo "  [DKML_COMPILE_VS_VCVARSVER = \"$E_VS_VCVARSVER\"]" >>"$OPSC"
            echo "  [DKML_COMPILE_VS_WINSDKVER = \"$E_VS_WINSDKVER\"]" >>"$OPSC"
            echo "  [DKML_COMPILE_VS_MSVSPREFERENCE = \"$E_VS_MSVSPREFERENCE\"]" >>"$OPSC"
            echo "  [DKML_COMPILE_VS_CMAKEGENERATOR = \"$E_VS_CMAKEGENERATOR\"]" >>"$OPSC"
            echo "  [DKML_HOST_ABI = \"${dkml_host_abi}\"]" >>"$OPSC"
            echo "  [DKML_TARGET_ABI = \"${dkml_target_abi}\"]" >>"$OPSC"
            echo ']' >>"$OPSC"
            cat "$OPSC" # print
            ;;
        *)
            opamrun option --switch "$do_use_vsstudio_NAME" setenv= # reset
            opamrun option --switch "$do_use_vsstudio_NAME" setenv+='DKML_COMPILE_SPEC = "1"'
            opamrun option --switch "$do_use_vsstudio_NAME" setenv+='DKML_COMPILE_TYPE = "VS"'
            opamrun option --switch "$do_use_vsstudio_NAME" setenv+="DKML_COMPILE_VS_DIR = \"$E_VS_DIR\""
            opamrun option --switch "$do_use_vsstudio_NAME" setenv+="DKML_COMPILE_VS_VCVARSVER = \"$E_VS_VCVARSVER\""
            opamrun option --switch "$do_use_vsstudio_NAME" setenv+="DKML_COMPILE_VS_WINSDKVER = \"$E_VS_WINSDKVER\""
            opamrun option --switch "$do_use_vsstudio_NAME" setenv+="DKML_COMPILE_VS_MSVSPREFERENCE = \"$E_VS_MSVSPREFERENCE\""
            opamrun option --switch "$do_use_vsstudio_NAME" setenv+="DKML_COMPILE_VS_CMAKEGENERATOR = \"$E_VS_CMAKEGENERATOR\""
            opamrun option --switch "$do_use_vsstudio_NAME" setenv+="DKML_HOST_ABI = \"${dkml_host_abi}\""
            opamrun option --switch "$do_use_vsstudio_NAME" setenv+="DKML_TARGET_ABI = \"${dkml_target_abi}\""
            opamrun option --switch "$do_use_vsstudio_NAME" setenv # print
            ;;
        esac

        # shellcheck disable=SC2016
        opamrun exec --switch "$do_use_vsstudio_NAME" -- sh -c 'echo $VCToolsRedistDir'

        section_end "use-vsstudio-$do_use_vsstudio_NAME"
        ;;
    esac
}
if [ "${SKIP_OPAM_MODIFICATIONS:-}" = "false" ]; then
    do_use_vsstudio dkml
    if [ "${SECONDARY_SWITCH:-}" = "true" ]; then
        do_use_vsstudio two
    fi
fi

# Because dune.X.Y.Z+shim (and any user DkML packages) requires DkML installed (after all, it is just
# a with-dkml.exe shim), we need either dkmlvars-v2.sexp or DkML environment
# variables. Confer: Dkml_runtimelib.Dkml_context.get_dkmlversion
#
# grep matches either:
#   [... [DiskuvOCamlVersion = "1.0.1"] ...]
#   DiskuvOCamlVersion = "1.0.1"
do_setenv() {
    do_setenv_SWITCH=$1
    shift
    section_begin "setenv-$do_setenv_SWITCH" "Set opam option for $do_setenv_SWITCH switch"
    opamrun option --switch "$do_setenv_SWITCH" setenv > ".ci/sd4/setenv.$do_setenv_SWITCH.txt"
    if ! grep -q '\(^|\[\)DiskuvOCamlVarsVersion ' ".ci/sd4/setenv.$do_setenv_SWITCH.txt"; then
        opamrun option --switch "$do_setenv_SWITCH" setenv+='DiskuvOCamlVarsVersion = "2"'
    fi
    if ! grep -q '\(^|\[\)DiskuvOCamlVersion ' ".ci/sd4/setenv.$do_setenv_SWITCH.txt"; then
        opamrun option --switch "$do_setenv_SWITCH" setenv+="DiskuvOCamlVersion = \"$DKML_VERSION\""
    fi
    if [ "$do_setenv_SWITCH" = dkml ] && [ -n "${DKML_HOME:-}" ]; then
      do_setenv_DKMLHOME_ESCAPED="$DKML_HOME"
      do_setenv_USRBIN_ESCAPED="$DKML_HOME/usr/bin"
      do_setenv_BIN_ESCAPED="$DKML_HOME/bin"
      if [ -x /usr/bin/cygpath ]; then
        do_setenv_DKMLHOME_ESCAPED=$(/usr/bin/cygpath -aw "$do_setenv_DKMLHOME_ESCAPED" | sed 's/\\/\\\\/g')
        do_setenv_USRBIN_ESCAPED=$(/usr/bin/cygpath -aw "$do_setenv_USRBIN_ESCAPED" | sed 's/\\/\\\\/g')
        do_setenv_BIN_ESCAPED=$(/usr/bin/cygpath -aw "$do_setenv_BIN_ESCAPED" | sed 's/\\/\\\\/g')
      fi
      if ! grep -q '\(^|\[\)DiskuvOCamlHome ' ".ci/sd4/setenv.$do_setenv_SWITCH.txt"; then
          opamrun option --switch "$do_setenv_SWITCH" setenv+="DiskuvOCamlHome = \"$do_setenv_DKMLHOME_ESCAPED\""
      fi
      if ! grep -q '\(^|\[\)DiskuvOCamlBinaryPaths ' ".ci/sd4/setenv.$do_setenv_SWITCH.txt"; then
          opamrun option --switch "$do_setenv_SWITCH" setenv+="DiskuvOCamlBinaryPaths = \"$do_setenv_USRBIN_ESCAPED;$do_setenv_BIN_ESCAPED\""
      fi
      if ! grep -q '\(^|\[\)DiskuvOCamlDeploymentId ' ".ci/sd4/setenv.$do_setenv_SWITCH.txt"; then
          opamrun option --switch "$do_setenv_SWITCH" setenv+="DiskuvOCamlDeploymentId = \"setup-dkml-switch-$do_setenv_SWITCH\""
      fi
    fi
    case "${dkml_host_abi}" in
    windows_*)
        if ! grep -q '\(^|\[\)DiskuvOCamlMSYS2Dir ' ".ci/sd4/setenv.$do_setenv_SWITCH.txt"; then
            if [ -x /usr/bin/cygpath ]; then
                MSYS2_DIR_NATIVE=$(/usr/bin/cygpath -aw /)
            else
                # If we are already inside MSYS2 then MSYSTEM_PREFIX should be set. But cygpath should be there as well!!
                echo "FATAL: Could not locate MSYS2: there was no cygpath"
                exit 3
            fi
            MSYS2_DIR_NATIVE_ESCAPED=$(printf "%s" "$MSYS2_DIR_NATIVE" | sed 's/\\/\\\\/g')
            opamrun option --switch "$do_setenv_SWITCH" setenv+="DiskuvOCamlMSYS2Dir = \"$MSYS2_DIR_NATIVE_ESCAPED\""
        fi
    esac
    section_end "setenv-$do_setenv_SWITCH"
}
if [ "${SKIP_OPAM_MODIFICATIONS:-}" = "false" ]; then
    do_setenv dkml
    if [ "${SECONDARY_SWITCH:-}" = "true" ]; then
        do_setenv two
    fi
fi

do_install_compiler() {
    do_install_compiler_NAME=$1
    shift
    section_begin "install-compiler-$do_install_compiler_NAME" "Install OCaml compiler for $do_install_compiler_NAME switch"
    opamrun pin list --switch "$do_install_compiler_NAME"
    # --assume-depexts: CI needs system packages? For reproducibility do it explicitly elsewhere. Example: g++-multilib gcc-multilib for linux_x86.
    #   shellcheck disable=SC2086
    opamrun upgrade --switch "$do_install_compiler_NAME" --assume-depexts --yes dkml-base-compiler conf-dkml-cross-toolchain "dkml-host-abi-${dkml_host_abi}" "dkml-target-abi-${dkml_target_abi}" ${ocaml_options:-}
    section_end "install-compiler-$do_install_compiler_NAME"
}
do_summary() {
    do_summary_NAME=$1
    shift
    section_begin "summary-$do_summary_NAME" "Summary: $do_summary_NAME switch"
    opamrun var --switch "$do_summary_NAME"
    opamrun exec --switch "$do_summary_NAME" -- ocamlc -config
    section_end "summary-$do_summary_NAME"
}
if [ "${SKIP_OPAM_MODIFICATIONS:-}" = "false" ]; then
    if ! [ "${PRIMARY_SWITCH_SKIP_INSTALL:-}" = "true" ]; then
        do_install_compiler dkml
    fi
    if [ "${SECONDARY_SWITCH:-}" = "true" ]; then
        do_install_compiler two
    fi
    if ! [ "${PRIMARY_SWITCH_SKIP_INSTALL:-}" = "true" ]; then
        do_summary dkml
    fi
    if [ "${SECONDARY_SWITCH:-}" = "true" ]; then
        do_summary two
    fi
fi

'@
Set-Content -Path ".ci\sd4\run-setup-dkml.sh" -Encoding Unicode -Value $Content
msys64\usr\bin\bash -lc 'dos2unix .ci/sd4/run-setup-dkml.sh'

$Content = @'
# MSVC environment variables:
# 1. https://docs.microsoft.com/en-us/cpp/build/reference/cl-environment-variables?view=msvc-170
# 2. https://docs.microsoft.com/en-us/cpp/build/reference/linking?view=msvc-170#link-environment-variables (except TMP)
# 3. VCToolsRedistDir: https://docs.microsoft.com/en-us/cpp/windows/redistributing-visual-cpp-files?view=msvc-170#locate-the-redistributable-files
BEGIN{FS="="}
$1=="CL"||$1=="_CL_"||$1=="INCLUDE"||$1=="LIBPATH" {print "export " $0}
$1=="LINK"||$1=="_LINK_"||$1=="LIB"||$1=="PATH"    {print "export " $0}
$1=="VCToolsRedistDir"                             {print "export " $0}

'@
Set-Content -Path ".ci\sd4\msvcenv.awk" -Encoding Unicode -Value $Content
msys64\usr\bin\bash -lc 'dos2unix .ci/sd4/msvcenv.awk'


$Content = @'
{
    # trim leading and trailing space
    sub(/^ */, "");
    sub(/ *$/, "");

    print "export PATH='" $0 "'";
}
'@
Set-Content -Path ".ci\sd4\msvcpath.awk" -Encoding Unicode -Value $Content
msys64\usr\bin\bash -lc 'dos2unix .ci/sd4/msvcpath.awk'

# PowerShell (UTF-16) and Batch (ANSI) scripts


$Content = @'
# Diagnose Visual Studio environment variables (Windows)
# This wastes time and has lots of rows! Only run if "VERBOSE" GitHub input key.
if ( "${env:VERBOSE}" -eq "true" ) {
    if (Test-Path -Path "C:\Program Files (x86)\Windows Kits\10\include") {
        Get-ChildItem "C:\Program Files (x86)\Windows Kits\10\include"
    }
    if (Test-Path -Path "C:\Program Files (x86)\Windows Kits\10\Extension SDKs\WindowsDesktop") {
        Get-ChildItem "C:\Program Files (x86)\Windows Kits\10\Extension SDKs\WindowsDesktop"
    }

    $env:PSModulePath += "$([System.IO.Path]::PathSeparator).ci\sd4\g\dkml-runtime-distribution\src\windows"
    Import-Module Machine

    $allinstances = Get-VSSetupInstance
    $allinstances | ConvertTo-Json -Depth 5
}

# Make export expression [SN]NAME=[SV]VALUE[EV]
# where [SN] is start name and [SV] and [EV] are start and end value
if (("${env:GITLAB_CI}" -eq "true") -or ("${env:PC_CI}" -eq "true")) {
    # Executed immediately in POSIX shell, so must be a real POSIX shell variable declaration
    $ExportSN = "export "
    $ExportSV = "'"
    $ExportEV = "'"
    $ExportExt = ".sh"
} else {
    # Goes into $env:GITHUB_ENV, so must be plain NAME=VALUE
    $ExportSN = ""
    $ExportSV = ""
    $ExportEV = ""
    $ExportExt = ".github"
}

# Locate Visual Studio (Windows)
if ("${env:vsstudio_dir}" -eq "" -and (!(Test-Path -Path .ci/sd4/vsenv${ExportExt}) -or !(Test-Path -Path .ci/sd4/vsenv.ps1))) {
    $env:PSModulePath += "$([System.IO.Path]::PathSeparator).ci\sd4\g\dkml-runtime-distribution\src\windows"
    Import-Module Machine

    $CompatibleVisualStudios = Get-CompatibleVisualStudios -ErrorIfNotFound
    $CompatibleVisualStudios
    $ChosenVisualStudio = ($CompatibleVisualStudios | Select-Object -First 1)
    $VisualStudioProps = Get-VisualStudioProperties -VisualStudioInstallation $ChosenVisualStudio
    $VisualStudioProps

    Write-Output "${ExportSN}VS_DIR=${ExportSV}$($VisualStudioProps.InstallPath)${ExportEV}" > .ci/sd4/vsenv${ExportExt}
    Write-Output "${ExportSN}VS_VCVARSVER=${ExportSV}$($VisualStudioProps.VcVarsVer)${ExportEV}" >> .ci/sd4/vsenv${ExportExt}
    Write-Output "${ExportSN}VS_WINSDKVER=${ExportSV}$($VisualStudioProps.WinSdkVer)${ExportEV}" >> .ci/sd4/vsenv${ExportExt}
    Write-Output "${ExportSN}VS_MSVSPREFERENCE=${ExportSV}$($VisualStudioProps.MsvsPreference)${ExportEV}" >> .ci/sd4/vsenv${ExportExt}
    Write-Output "${ExportSN}VS_CMAKEGENERATOR=${ExportSV}$($VisualStudioProps.CMakeGenerator)${ExportEV}" >> .ci/sd4/vsenv${ExportExt}

    Write-Output "`$env:VS_DIR='$($VisualStudioProps.InstallPath)'" > .ci/sd4/vsenv.ps1
    Write-Output "`$env:VS_VCVARSVER='$($VisualStudioProps.VcVarsVer)'" >> .ci/sd4/vsenv.ps1
    Write-Output "`$env:VS_WINSDKVER='$($VisualStudioProps.WinSdkVer)'" >> .ci/sd4/vsenv.ps1
    Write-Output "`$env:VS_MSVSPREFERENCE='$($VisualStudioProps.MsvsPreference)'" >> .ci/sd4/vsenv.ps1
    Write-Output "`$env:VS_CMAKEGENERATOR='$($VisualStudioProps.CMakeGenerator)'" >> .ci/sd4/vsenv.ps1
}

# Link to hardcoded Visual Studio (Windows)
if ("${env:vsstudio_dir}" -ne "") {
    Write-Output "${ExportSN}VS_DIR=${ExportSV}${env:vsstudio_dir}${ExportEV}" > .ci/sd4/vsenv${ExportExt}
    Write-Output "${ExportSN}VS_VCVARSVER=${ExportSV}${env:vsstudio_vcvarsver}${ExportEV}" >> .ci/sd4/vsenv${ExportExt}
    Write-Output "${ExportSN}VS_WINSDKVER=${ExportSV}${env:vsstudio_winsdkver}${ExportEV}" >> .ci/sd4/vsenv${ExportExt}
    Write-Output "${ExportSN}VS_MSVSPREFERENCE=${ExportSV}${env:vsstudio_msvspreference}${ExportEV}" >> .ci/sd4/vsenv${ExportExt}
    Write-Output "${ExportSN}VS_CMAKEGENERATOR=${ExportSV}${env:vsstudio_cmakegenerator}${ExportEV}" >> .ci/sd4/vsenv${ExportExt}

    Write-Output "`$env:VS_DIR='${env:vsstudio_dir}'" > .ci/sd4/vsenv.ps1
    Write-Output "`$env:VS_VCVARSVER='${env:vsstudio_vcvarsver}'" >> .ci/sd4/vsenv.ps1
    Write-Output "`$env:VS_WINSDKVER='${env:vsstudio_winsdkver}'" >> .ci/sd4/vsenv.ps1
    Write-Output "`$env:VS_MSVSPREFERENCE='${env:vsstudio_msvspreference}'" >> .ci/sd4/vsenv.ps1
    Write-Output "`$env:VS_CMAKEGENERATOR='${env:vsstudio_cmakegenerator}'" >> .ci/sd4/vsenv.ps1
}

'@
Set-Content -Path ".ci\sd4\config-vsstudio.ps1" -Encoding Unicode -Value $Content


$Content = @'
@ECHO OFF

REM The OCaml dkml-base-compiler will compile fine but any other
REM packages (ocamlbuild, etc.) which
REM need a native compiler will fail without the MSVC compiler in the
REM PATH. There isn't a `with-dkml.exe` alternative available at
REM this stage of the GitHub workflow.
SET VSCMD_DEBUG=2
SET VSCMD_SKIP_SENDTELEMETRY=1
call "%VS_DIR%\Common7\Tools\VsDevCmd.bat" -no_logo -host_arch=%vsstudio_hostarch% -arch=%vsstudio_arch% -vcvars_ver=%VS_VCVARSVER% -winsdk=%VS_WINSDKVER%
if %ERRORLEVEL% neq 0 (
    echo.
    echo.The "%VS_DIR%\Common7\Tools\VsDevCmd.bat" command failed
    echo.with exit code %ERRORLEVEL%.
    echo.
    exit /b %ERRORLEVEL%
)

REM VsDevCmd.bat turns off echo; be explicit if we want it on or off
@echo OFF

REM MSVC environment variables in Unix format.
echo %PATH% > .ci\sd4\msvcpath


REM * We can't use `bash -lc` directly to query for all MSVC environment variables
REM   because it stomps over the PATH. So we are inside a Batch script to do the query.
msys64\usr\bin\bash -lc "set | grep -v '^PATH=' | awk -f .ci/sd4/msvcenv.awk > .ci/sd4/msvcenv"
'@
Set-Content -Path ".ci\sd4\get-msvcpath-into-msys2.bat" -Encoding Default -Value $Content

msys64\usr\bin\bash -lc "sh .ci/sd4/run-checkout-code.sh PC_PROJECT_DIR '${env:PC_PROJECT_DIR}'"
if ($LASTEXITCODE -ne 0) {
  Write-Error "run-checkout-code.sh failed"
  Exit 79
}

# Diagnose Visual Studio environment variables (Windows)
# This wastes time and has lots of rows! Only run if "VERBOSE" GitHub input key.

If ( "${env:VERBOSE}" -eq "true" ) {
  if (Test-Path -Path "C:\Program Files (x86)\Windows Kits\10\include") {
    Get-ChildItem "C:\Program Files (x86)\Windows Kits\10\include"
  }
  if (Test-Path -Path "C:\Program Files (x86)\Windows Kits\10\Extension SDKs\WindowsDesktop") {
    Get-ChildItem "C:\Program Files (x86)\Windows Kits\10\Extension SDKs\WindowsDesktop"
  }

  $env:PSModulePath += "$([System.IO.Path]::PathSeparator).ci\sd4\g\dkml-runtime-distribution\src\windows"
  Import-Module Machine

  $allinstances = Get-VSSetupInstance
  $allinstances | ConvertTo-Json -Depth 5
}
.ci\sd4\config-vsstudio.ps1
msys64\usr\bin\bash -lc "dos2unix .ci/sd4/vsenv.sh"
Get-Content .ci/sd4/vsenv.sh
Get-Content .ci/sd4/vsenv.ps1

# Capture Visual Studio compiler environment
& .ci\sd4\vsenv.ps1
& .ci\sd4\get-msvcpath-into-msys2.bat
msys64\usr\bin\bash -lc "cat .ci/sd4/msvcpath | tr -d '\r' | cygpath --path -f - | awk -f .ci/sd4/msvcpath.awk >> .ci/sd4/msvcenv"
msys64\usr\bin\bash -lc "tail -n100 .ci/sd4/msvcpath .ci/sd4/msvcenv"

msys64\usr\bin\bash -lc "sh .ci/sd4/run-setup-dkml.sh PC_PROJECT_DIR '${env:PC_PROJECT_DIR}'"
if ($LASTEXITCODE -ne 0) {
  Write-Error "run-setup-dkml.sh failed"
  Exit 79
}

########################### script ###############################

Write-Host @"
Finished setup.

To continue your testing, run in PowerShell:
  `$env:CHERE_INVOKING = "yes"
  `$env:MSYSTEM = "$env:msys2_system"
  `$env:dkml_host_abi = "$env:dkml_host_abi"
  `$env:dkml_target_abi = "$env:dkml_target_abi"
  `$env:abi_pattern = "$env:abi_pattern"
  `$env:opam_root = "$env:opam_root"
  `$env:exe_ext = "$env:exe_ext"

Now you can use 'opamrun' to do opam commands like:

  msys64\usr\bin\bash -lc 'PATH="`$PWD/.ci/sd4/opamrun:`$PATH"; opamrun install XYZ.opam'
  msys64\usr\bin\bash -lc 'PATH="`$PWD/.ci/sd4/opamrun:`$PATH"; opamrun exec -- bash'
  msys64\usr\bin\bash -lc 'sh ci/build-test.sh'
"@
