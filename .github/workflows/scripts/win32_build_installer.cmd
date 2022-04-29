REM OCaml (dkml-base-compiler) will compile fine but any other
REM packages (ocamlbuild, etc.) which
REM need a native compiler will fail without the MSVC compiler in the
REM PATH. There isn't a `with-dkml.exe` alternative available at
REM this stage of the GitHub workflow.
call "%VS_DIR%\Common7\Tools\VsDevCmd.bat" -no_logo -host_arch=%VS_HOST_ARCH% -arch=%VS_ARCH% -vcvars_ver=%VS_VCVARSVER% -winsdk=%VS_WINSDKVER%
if %ERRORLEVEL% neq 0 (
  echo.
  echo.The "%VS_DIR%\Common7\Tools\VsDevCmd.bat" command failed
  echo.with exit code %ERRORLEVEL%.
  echo.
  exit /b %ERRORLEVEL%
)
REM VsDevCmd.bat turns off echo; put it back on
echo ON

REM We must place MSYS2 (Git Bash) in front of path so that MSYS2
REM tar.exe is used instead of Windows tar.exe.
set PATH=%CD%\bootstrap\bin;C:\Program Files\Git\usr\bin;%PATH%

if "%SHOULD_POPULATE_CACHE%" == "true" (
  if "%CAN_DOWNLOAD_ONLY%" == "true" (
    set MOREARGS=--download-only
    set ENVARGS=OPAMDOWNLOADJOBS=1
  )
)
if "%M_DKMLTARGETABI:~-4%" == "_x86" (
  set M_OPTION_32BIT=ocaml-option-32bit
)
if "%__INTERNAL__WIN32_BASH_HOOK%" == "true" (
  REM # for debugging
  env %ENVARGS% bash
)
env %ENVARGS% opam install --yes --switch installer-%INSTALLERNAME% %M_DKMLOPTIONS% %M_OPTION_32BIT% ./dkml-installer-%INSTALLERNAME%.opam %MOREARGS%
