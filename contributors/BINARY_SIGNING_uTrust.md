# Binary Signing with uTrust

This document is meant as a supporting document to [BINARY_SIGNING.md](BINARY_SIGNING.md).
**Do not start with this document!**

---

> The software for uTrust Key does not yet support the crypto standards we need.
> Use [Yubikey 5](BINARY_SIGNING_Yubikey.md) until this document has been updated

https://shop.identiv.com/collections/fido2-security-keys/products/utrust-fido2-nfc-security-key

## Instructions

### Shopping List

1. **$60**. Two (2) [uTrust FIDO2 NFC+ Security Keys](https://shop.identiv.com/collections/fido2-security-keys/products/utrust-fido2-nfc-security-key).
   Be careful to purchase the "NFC+" product and not "NFC" because, according to
   the [product comparison](https://www.identiv.com/products/logical-access-control/fido2-security-keys/utrust-key-manager-software/),
   the "NFC" product does not allow configuration of its
   personal identity verification (PIV) functionality using
   the uTrust software.

### Prepare a Code Signing Certificate

#### Saving private key in device

FIRST, download and install [IDENTIV - uTrust Key Manager Software](https://go.identiv.com/software/utrust-key-manager)

SECOND, in a UNIX shell run:

```bash
# Securely record the generated text as your MANAGEMENT KEY
export LC_CTYPE=C; dd if=/dev/urandom 2>/dev/null | tr -d '[:lower:]' | tr -cd '[:xdigit:]' | fold -w48 | head -1

# Securely record the generated 6 digits as your PIN
export LC_CTYPE=C; dd if=/dev/urandom 2>/dev/null | tr -cd '[:digit:]' | fold -w6 | head -1

# Securely record the generated 8 digits as your PUK
export LC_CTYPE=C; dd if=/dev/urandom 2>/dev/null | tr -cd '[:digit:]' | fold -w8 | head -1
```

THIRD, **for each security token**:

Insert the security token.

Then in the uTrust Key Manager Software:

* Go to `Applications > PIV`
  * Go to `Pin Management - Configure PINs`
    * Go to `Change Management Key`
      * Current Key: ✓ Use default
      * New Key (hex): *Use the MANAGEMENT KEY you recorded earlier*
      * Click "Change Key" button to save your changes
        > Now no one can modify the state of the PIV application on your device
        > without knowing your Management Key.
* Go to `Applications > PIV`
  * Go to `Pin Management - Configure PINs`
    * Go to `Change PUK`
      * Current PUK: ✓ Use default
      * New PUK: *Use the PUK number you recorded earlier*
      * Confirm new PUK: *Use the same 8 digit number*
      * Click "Change PUK" button to save your changes
        > Now your PINs can't be reset without knowing your PUK. Too many
        > attempts to guess your PUK will lock the device.
* Go to `Applications > PIV`
  * Go to `Pin Management - Configure PINs`
    * Go to `Change PIN`
      * Current PIN: ✓ Use default
      * New PIN: *Use the PIN number you recorded earlier*
      * Confirm new PIN: *Use the same 6 digit number*
      * Click "Change PIN" button to save your changes
        > Now no one can sign files using the security key unless they know
        > your PIN. Too many attempts to guess your PIN will lock the device.
* Go to `Applications > PIV`
  * Go to `Certificates - Configure Certificates`
    * Go to `Digital Signature - Slot 9c - Import`
      * File: `key-and-cert.crt`
      * Management key: *Use the MANAGEMENT KEY you recorded earlier*

The PUK and PIN only need to be kept until the security token is distributed.

FIFTH,

Download and install "OpenSC-0.22.0_win64.msi" from
https://github.com/OpenSC/OpenSC/releases/tag/0.22.0 using the default
options.

Download the OpenSSL OpenSC engine at
https://github.com/OpenSC/libp11/releases/download/libp11-0.4.11/libp11-0.4.11-windows.zip
. Unzip it to `C:\` so that you have `C:\libp11-0.4.11-windows\64bit\pkcs11.dll`
available.

Install `osslsigncode` and `p11tool` by getting a UNIX prompt with `with-dkml-bash` and then
running:

```bash
pacman -S mingw-w64-clang-x86_64-osslsigncode mingw-w64-clang-x86_64-gnutls
```

SIXTH,

Record the "Object *: URL" that is displaying in the following in a `with-dkml bash` shell:

```console
$ p11tool --provider "$(cygpath -F 38)/OpenSC Project/OpenSC/pkcs11/opensc-pkcs11.dll" --list-privkeys --login
Token 'PIV_II' with URL 'pkcs11:model=PKCS%2315%20emulated;manufacturer=piv_II;serial=00000000;token=PIV_II' requires user PIN
Enter PIN:
Object 0:
        URL: pkcs11:model=PKCS%2315%20emulated;manufacturer=piv_II;serial=00000000;token=PIV_II;id=%02;object=SIGN%20key;type=private
        Type: Private key (EC/ECDSA)
        Label: SIGN key
        Flags: CKA_PRIVATE; CKA_ALWAYS_AUTH; CKA_NEVER_EXTRACTABLE; CKA_SENSITIVE;
        ID: 02
```

And with that URL (the one that has `id=` inside it) enter your PIN twice to sign a test executable:

```console
$ osslsigncode sign -verbose -comm -h sha384 -pkcs11engine C:/libp11-0.4.11-windows/64bit/pkcs11.dll -pkcs11module "$(cygpath -F 38)/OpenSC Project/OpenSC/pkcs11/opensc-pkcs11.dll" -in ../x/setup-diskuv-ocaml-windows_x86_64-0.4.0.exe -out ../x/setup-resigned-diskuv-ocaml-windows_x86_64-0.4.0.exe -pkcs11cert 'pkcs11:model=PKCS%2315%20emulated;manufacturer=piv_II;serial=00000000;token=Admin;id=%02;object=SIGN%20key;type=private' -t http://timestamp.sectigo.com
Engine "pkcs11" set.
Enter PKCS#11 token PIN for Admin:
Enter PKCS#11 key PIN for SIGN key:
Succeeded
```

SEVENTH, (**FIXME** test security key)

In a ~~`with-dkml bash`~~ `& $env:DiskuvOCamlHome\..\tools\MSYS2\msys2_shell.cmd -mingw64` session:

```bash
#pacman -S mingw-w64-clang-x86_64-pkg-config mingw-w64-clang-x86_64-openssl mingw-w64-clang-x86_64-clang
pacman -S mingw-w64-x86_64-pkg-config mingw-w64-x86_64-openssl mingw-w64-x86_64-gcc

wget https://github.com/OpenSC/OpenSC/releases/download/0.22.0/opensc-0.22.0.tar.gz
echo '8d4e5347195ebea332be585df61dcc470331c26969e4b0447c851fb0844c7186 *opensc-0.22.0.tar.gz' | sha256sum -c
tar xfz opensc-0.22.0.tar.gz

wget https://github.com/Mastercard/pkcs11-tools/releases/download/v2.5.0/pkcs11-tools-2.5.0.tar.gz
echo '4e2933ba19eef64a4448dfee194083a1db1db5842cd043edb93bbf0a62a63970 *pkcs11-tools-2.5.0.tar.gz' | sha256sum -c
tar xfz pkcs11-tools-2.5.0.tar.gz

cd opensc-0.22.0
./configure
#echo CFLAGS="-Wno-implicit-function-declaration" ./configure
make
cd ..

#pkcs11-tools-2.5.0
#./configure
#make
```

Verify that your PIN works with:

```
certutil.exe -scinfo
...
Done.
CertUtil: -SCInfo command completed successfully.
```

```
 opensc-0.22.0/src/tools/pkcs11-tool.exe --module opensc-0.22.0/src/pkcs11/.libs/opensc-pkcs11.dll --list-slots

```

> Advanced: There is an [OCaml-based opkcs11-tools](https://github.com/caml-pkcs11/opkcs11-tool)
> that could be used instead of pkcs11-tools, with a slightly different command
> line syntax. It has not been tested.

### Signing an Executable

Create a file `sun_ykcs11.conf`:

```conf
name = OpenSC
library = C:\Program Files\OpenSC Project\OpenSC\pkcs11\opensc-pkcs11.dll
showInfo = true
# You may need to change this slot to a higher number if you have multiple devices
slot = 0
```

Make sure Java can access your smartcard:

```session
$ keytool -list -keystore NONE -storetype PKCS11 -providerClass sun.security.pkcs11.SunPKCS11 -providerArg sun_ykcs11.conf -v
Enter keystore password: {enter your PIN}
Keystore type: PKCS11
Keystore provider: SunPKCS11-OpenSC
...
```

We'll download a Java-based executable signer:

```session
$ wget https://github.com/ebourg/jsign/releases/download/4.1/jsign-4.1.jar
$ echo '4dddbc9e56bd6e15934122f16ce652f07d2110530418196898c31600e44109b6 *jsign-4.1.jar' | sha256sum -c
```

Now signing an executable is:

```session
# The storepass is your PIN
$ jsign --keystore sun_ykcs11.conf --tsaurl http://timestamp.sectigo.com application.exe
```
