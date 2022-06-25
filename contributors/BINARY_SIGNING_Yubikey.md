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
[US government recommendation of at least 3072 bits](https://media.defense.gov/2021/Aug/04/2002821837/-1/-1/1/Quantum_FAQs_20210804.PDF).

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

Download the OpenSSL OpenSC engine at
[https://github.com/OpenSC/libp11/releases/download/libp11-0.4.11/libp11-0.4.11-windows.zip](https://github.com/OpenSC/libp11/releases/download/libp11-0.4.11/libp11-0.4.11-windows.zip)
Unzip it to `C:\` so that you have `C:\libp11-0.4.11-windows\64bit\pkcs11.dll`
available.

Install `osslsigncode` and `p11tool` by getting a UNIX prompt with `with-dkml-bash` and then
running:

```bash
pacman -S mingw-w64-clang-x86_64-osslsigncode mingw-w64-clang-x86_64-gnutls
```

FIFTH,

Import the server key and your certificate into the device with:

```bash
# On Windows you need:
export PATH="$(cygpath -F 38)/Yubico/Yubico PIV Tool/bin:$PATH"

# Enter Management Key when prompted. Imports your server key
yubico-piv-tool -s 9c -a import-key -i server-key.pem -k

# Enter Management Key when prompted. Imports both the CA root certificate and your CA-signed certificate
yubico-piv-tool -s 9c -a import-certificate -i full-chain.pem -k
```

SIXTH,

Record the `Object XX: URL: pkcs11:...` that is displayed for **ID: 02** from the following in a `with-dkml bash` shell:

```console
$ p11tool --provider "$(cygpath -wF 38)"'\Yubico\Yubico PIV Tool\bin\libykcs11.dll' --list-privkeys --login
Token 'YubiKey PIV #12345678' with URL 'pkcs11:model=YubiKey%20YK5;manufacturer=Yubico%20%28www.yubico.com%29;serial=12345678;token=YubiKey%20PIV%20%2312345678' requires user PIN
Enter PIN:
Object 0:
        URL: pkcs11:model=YubiKey%20YK5;manufacturer=Yubico%20%28www.yubico.com%29;serial=12345678;token=YubiKey%20PIV%20%2312345678;id=%02;object=Private%20key%20for%20Digital%20Signature;type=private
        Type: Private key (EC/ECDSA)
        Label: Private key for Digital Signature
        Flags: CKA_PRIVATE; CKA_ALWAYS_AUTH; CKA_NEVER_EXTRACTABLE; CKA_SENSITIVE;
        ID: 02

Object 1:
        URL: pkcs11:model=YubiKey%20YK5;manufacturer=Yubico%20%28www.yubico.com%29;serial=12345678;token=YubiKey%20PIV%20%2312345678;id=%19;object=Private%20key%20for%20PIV%20Attestation;type=private
        Type: Private key (RSA-2048)
        Label: Private key for PIV Attestation
        Flags: CKA_PRIVATE; CKA_NEVER_EXTRACTABLE; CKA_SENSITIVE;
        ID: 19
```

> The `ID` numbers are the hexadecimal versions of the Key Mapping table's "ykcs11 id" in
> https://developers.yubico.com/yubico-piv-tool/YKCS11/.
> * ID 02 (ykcs11 id 2) is PIV slot 9c, which is [reserved for Digital Signatures](https://developers.yubico.com/PIV/Introduction/Certificate_slots.html)
> * ID 19 (ykcs11 id 25) is preloaded by Yubico.

Double-check:
1. You have the URL that has the format `pkcs11:...;id=%02;...Signature;type=private`.
2. The key has the four (4) flags `Flags: CKA_PRIVATE; CKA_ALWAYS_AUTH; CKA_NEVER_EXTRACTABLE; CKA_SENSITIVE;`.
   It can have more than those flags, but none of those flags can be missing. **Stop if you don't see those flags!**

Use that URL to sign a test executable:

```console
# Use the URL you just double-checked
$ DIGITALSIGNCERT='pkcs11:model=YubiKey%20YK5;manufacturer=Yubico%20%28www.yubico.com%29;serial=12345678;token=YubiKey%20PIV%20%2312345678;id=%02;object=Private%20key%20for%20Digital%20Signature;type=private'

# We need a test executable to sign. /clang64/bin/zstd.exe will have only standard Win32 DLL dependencies so it can run from anywhere.
$ pacman -S --needed --noconfirm mingw-w64-clang-x86_64-zstd

$ YUBICOBIN_W32="$(cygpath -wF 38)"'\Yubico\Yubico PIV Tool\bin'
$ YUBICOBIN_UNIX=$(cygpath -a "$YUBICOBIN_W32")

# You will need to enter the same PIN three times
$ env PATH="$YUBICOBIN_UNIX:$PATH" osslsigncode sign -verbose -comm -h sha384 -pkcs11engine C:/libp11-0.4.11-windows/64bit/pkcs11.dll -pkcs11module "$YUBICOBIN_W32\\libykcs11.dll" -in "$(cygpath -aw /clang64/bin/zstd.exe)" -out signed-zstd.exe -pkcs11cert "$DIGITALSIGNCERT" -t http://timestamp.sectigo.com
Engine "pkcs11" set.
Enter PKCS#11 token PIN for YubiKey PIV #12345678:
Enter PKCS#11 key PIN for Private key for Digital Signature:
Enter PKCS#11 key PIN for Private key for Digital Signature:
Succeeded
```

Verify `signed-zstd.exe`:
* Right-click on `signed-zstd.exe` in the File Explorer, go to its Properties
  and check its Digital Signatures.
* Run `signed-zstd.exe --help` from a Command Prompt. You should get a help
  screen and no any anti-virus or Windows operating system errors.

Congratulations!

Now you can check in the public certificate chain `full-chain.p7.pem`
into the `contributors/` directory. That will be used by the signing script
[`contributors/sign.sh`](./sign.sh).

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
