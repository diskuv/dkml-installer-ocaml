# Binary Signing with Yubikey

This document is meant as a supporting document to [BINARY_SIGNING.md](BINARY_SIGNING.md).
**Do not start with this document!**

---

This is a mature and more expensive product, and there have been
very few CVEs issued against Yubikey given its widespread adoption. One
drawback is that [YubiKey 5 accepted key sizes](https://developers.yubico.com/yubico-piv-tool/Actions/key_import.html)
imports private RSA keys of 3049 bits or shorter; anything bigger requires
non-standard compression options. However we'll be using these non-standard
options so as not to conflict with the
[US government recommendation of at least 3072 bits](https://cryptome.org/2016/01/CNSA-Suite-and-Quantum-Computing-FAQ.pdf).

Yubikey's are managed with the command line
[Yubico PIV Tool](https://developers.yubico.com/yubico-piv-tool/) or the
less-functional GUI [YubiKey Manager](https://developers.yubico.com/yubikey-manager/).

Avoid YubiKey Manager unless you are just getting familiar with your first
YubiKey. The YubiKey Manager will only let you access 4 standard PIV slots (and
only one of those you should use). But Yubikey 5 devices have an extra 20
"retired" slots that you can use for other private keys. Use the Yubico PIV Tool
instead.

## Instructions

### Shopping List

1. **$90**. Two (2) [YubiKey 5 NFC](https://www.yubico.com/product/yubikey-5-nfc/).

### Prepare a Code Signing Certificate

#### Saving private key in device

FIRST, download and install [yubico-piv-tool-2.3.0-win64.msi](https://developers.yubico.com/yubico-piv-tool/Releases) or a more recent version.

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

Then run in a UNIX shell:

```bash
# On Windows you need:
export PATH="$(cygpath -F 38)/Yubico/Yubico PIV Tool/bin:$PATH"

# Enter the default management key: 010203040506070801020304050607080102030405060708
# and then your new MANAGEMENT KEY when prompted
yubico-piv-tool -aset-mgm-key -k

# Enter your new PUK when prompted
yubico-piv-tool -achange-puk -P12345678 -k

# Enter your new PUK when prompted
yubico-piv-tool -achange-pin -P123456 -k
```

The PUK and PIN only need to be kept until the security token is distributed.

FOURTH,

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

FIFTH,

Import the server key and the CA-signed certificate into the device with:

```bash
# On Windows you need:
export PATH="$(cygpath -F 38)/Yubico/Yubico PIV Tool/bin:$PATH"

# Enter PIN when prompted
# We use compression for RSA 4096 keys: https://developers.yubico.com/yubico-piv-tool/Actions/key_import.html
yubico-piv-tool -s 9c -a import-key -i server-key.pem -k
yubico-piv-tool -s 9c -a import-key -a import-certificate -i key-and-cert.crt.gz -K GZIP -k
```

SIXTH,

Record the "Object *: URL" that is displaying in the following in a `with-dkml bash` shell:

```console
$ p11tool --provider "$(cygpath -wF 38)"'\Yubico\Yubico PIV Tool\bin\libykcs11.dll' --list-privkeys --login
Token 'YubiKey PIV #12345678' with URL 'pkcs11:model=YubiKey%20YK5;manufacturer=Yubico%20%28www.yubico.com%29;serial=12345678;token=YubiKey%20PIV%20%2312345678' requires user PIN
Enter PIN:
Object 0:
        URL: pkcs11:model=YubiKey%20YK5;manufacturer=Yubico%20%28www.yubico.com%29;serial=12345678;token=YubiKey%20PIV%20%2312345678;id=%19;object=Private%20key%20for%20PIV%20Attestation;type=private
        Type: Private key (RSA-2048)
        Label: Private key for PIV Attestation
        Flags: CKA_PRIVATE; CKA_NEVER_EXTRACTABLE; CKA_SENSITIVE;
        ID: 19
```

And with that URL (the one that has `id=` inside it) enter your PIN twice to sign a test executable:

```console
$ osslsigncode sign -verbose -comm -h sha384 -pkcs11engine C:/libp11-0.4.11-windows/64bit/pkcs11.dll -pkcs11module "$(cygpath -wF 38)"'\Yubico\Yubico PIV Tool\bin\libykcs11.dll' -in ../x/setup-diskuv-ocaml-windows_x86_64-0.4.0.exe -out ../x/setup-resigned-diskuv-ocaml-windows_x86_64-0.4.0.exe -pkcs11cert 'pkcs11:model=YubiKey%20YK5;manufacturer=Yubico%20%28www.yubico.com%29;serial=12345678;token=YubiKey%20PIV%20%2312345678;id=%19;object=Private%20key%20for%20PIV%20Attestation;type=private' -t http://timestamp.sectigo.com
Engine "pkcs11" set.
Enter PKCS#11 token PIN for Admin:
Enter PKCS#11 key PIN for SIGN key:
Succeeded
```

### Signing an Executable

We'll download a Java-based executable signer which supports ECC keys:

```session
$ wget https://github.com/ebourg/jsign/releases/download/4.1/jsign-4.1.jar
$ echo '4dddbc9e56bd6e15934122f16ce652f07d2110530418196898c31600e44109b6 *jsign-4.1.jar' | sha256sum -c
```

Now signing an executable is:

```session
# The storepass is your PIN
$ jsign --storetype YUBIKEY --certfile full-chain.p7.pem application.exe
```
