# Binary Signing

On Windows, unsigned .exe files are subject to:

1. Heavy warnings from the browser that the file is unsafe
2. Heavy warnings from Windows that the file is untrusted
3. Quarantine or some other forms of blocking by anti-virus software

So we choose to "code sign" the software. There are two types of code
signing certificates:

* OV (organization validation)
* EV (extended validation)

The "validation" in these certificates means a company trusted by
Microsoft has to conduct due diligence to make sure you (the organization)
are who you say you are. That means money: OV is $100 USD per year while
EV is ~$300 USD per year.

"Diskuv, Inc." is the organization that has been and will be validated every
year. But since any "DKML" product is a community supported open source
effort, Diskuv gives open source maintainers and stewards access to the
signing key. This document explains how the signing key is shared securely
and what tradeoffs were made to bring the cost low.

> This document is public for three (3) reasons. The first reason is transparency:
> you should know how your software is being secured. The second reason is to
> let outside experts expose flaws and suggest improvements. The last reason
> is to let other distributors of executables (in particular customers of
> the DKML Install API) know how to secure their own software.

## Personal Identity Verification

We'll be using a smart card that supports personal identity verification ("PIV").
A PIV device stores a private key and, through the PKCS#11 protocol, can sign
documents and files without revealing that private key.

The PIV devices we considered are:

* [Yubikey 5](BINARY_SIGNING_Yubikey.md)
* [uTrust FIDO2 NFC+ Security Key](BINARY_SIGNING_uTrust.md)

Both the manufacturers above sell FIPS rated products (ie. they can sell it for
government use). But if you actually need the safety marginf a FIPS product,
you should use a hardware security module (HSM) and should not be following this
document!

The risk profile of this document is that you can trust that the manufacturers
don't have any glaring defects in their non-FIPS products (if nothing else,
a bad non-FIPS defect would reflect poorly on their FIPS government sales).

## Crypto Standards

[Minimum Key Length](https://media.defense.gov/2021/Aug/04/2002821837/-1/-1/1/Quantum_FAQs_20210804.PDF):
RSA 3072 is the recommended minimum for RSA keys, and ECC P-256 and
P-384 keys are recommended for ECC keys.

PIV Standards: The official PIV standard is 1024 and 2048 bit RSA keys. Many PIV
tools (libp11 in particular) will not deviate from this standard.

ECC P-384 is roughly equivalent in strength to RSA 7680 bits. ECC keys are
relatively recent for code signing so they may have new implementation
bugs like [CVE-2020-0601](https://www.cve.org/CVERecord?id=CVE-2020-0601).
In a future version of this document we may choose ECC keys rather than RSA keys,
but for now we'll stick to 4096-bit RSA keys.

## Instructions

### Shopping List

All prices are quoted in USD that are current as of May 2022.

One-time costs:

1. **$20**. Two (2) waterproof USB flash drives to store code signing server keys.
2. **$90** for [Shopping List - Yubikey 5](BINARY_SIGNING_Yubikey.md#shopping-list)
   or **$60** for [Shopping List - uTrust FIDO2 NFC+ Security Key](BINARY_SIGNING_uTrust.md#shopping-list)

Yearly costs:

1. **$85**. One (1) Comodo Code Signing certificate.

### Prepare a Code Signing Certificate

FIRST,

In a UNIX prompt (ie. with Windows Diskuv OCaml run `with-dkml bash`)
do the following:

```bash
openssl ecparam -out server-key.pem -name secp384r1 -genkey
openssl req -new -key server-key.pem -out server-key.csr

# It is not supported, but advanced users may be able to get RSA 4096 keys working:
#openssl req -new -newkey rsa:4096 -nodes -keyout server-key.pem -out server-key.csr

# If you know what you are doing, the keys can be self-signed:
#openssl req -x509 -key server-key.pem -out cert.pem
```

For code signing certificates it is important that your "Common Name" is the
same as the "Organization Name". Also the "Organizational Unit Name" should be
empty. Here is the complete transcript we used for the `Diskuv, Inc.` code
certificate:

```text
-----
Country Name (2 letter code) [AU]:US
State or Province Name (full name) [Some-State]:Washington
Locality Name (eg, city) []:Mill Creek
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Diskuv, Inc.
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:Diskuv, Inc.
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
```

SECOND,

Keep the `server-key.pem` secured for several years:

* Store `server-key.pem` on USB flash drives under a physical
  lock and key. Other storage devices are acceptable, but make sure the
  storage devices are disconnected from the Internet.
* Keep the flash drives in different physical locations.
* Print a label for the drives that includes a public identifier of the key
  (you can use the first N characters to make it shorter):

  ```bash
  openssl ec -in server-key.pem -pubout -outform der | openssl sha3-256 -r

  # Advanced: If you had used RSA keys:
  #openssl rsa -in server-key.pem -pubout -outform der | openssl sha3-256 -r
  #(older) openssl rsa -in server-key.pem -modulus -noout | awk 'BEGIN{FS="="} {print $NF}' | dos2unix | openssl sha3-256 -r
  ```

  The complete label used for the Diskuv, Inc. code signing was:

  ```text
  Diskuv, Inc. Code Signing Certificate
  134bbcb9c230235cfbf99a36258ed0338a5cc81ff8a85216fac1bb76ce3a11c9
  ```

* You will **never** give `server-key.pem` to a third-party.

THIRD,

You will give `server-key.csr` to the certificate authority so they can generate
a code signing certificate. Even if your company or organization has its
own certificate authority, Microsoft only recognizes a small list of
certificate authorities.

The [Comodo SSL store](https://comodosslstore.com/codesigning.aspx) has
Certigo Standard Validation certificates that are authorized by Microsoft.

> The Comodo SSL store will give you many warnings about only using Internet
> Explorer 8 on Windows. This document is following a different procedure that
> does not need Internet Explorer or any special web browser.
>
> Comodo lets you re-issue the certificates if you made a mistake.

After your certificate has been generated and downloaded:

* convert the downloaded certificate (ex. `user.crt`) into the "PEM" format with:

  ```bash
  openssl x509 -inform der -in user.crt -out cert.pem
  ```

* download the latest Code Signing CA certificate from <https://help.comodosslstore.com/support/solutions/articles/22000218266-comodo-intermediate-certificates-and-ca-bundle->
  (ex. Standard Sectigo Public Code Signing CA R36) and save it
  (ex. `SectigoPublicCodeSigningCAR36.crt`)
* create a certificate chain in a X509 and "PKCS#7" file with:

  ```bash
  
  openssl x509 -in SectigoPublicCodeSigningCAR36.crt -out SectigoPublicCodeSigningCAR36.pem
  cat cert.pem SectigoPublicCodeSigningCAR36.pem > full-chain.pem

  openssl crl2pkcs7 -nocrl --certfile cert.pem -certfile SectigoPublicCodeSigningCAR36.crt -out full-chain.p7.pem
  ```

* you can delete the `server-key.csr` file

FOURTH, we'll be saving the private key and certificate in the security device.

Follow the [Saving private key in device: Yubikey 5](BINARY_SIGNING_Yubikey.md#saving-private-key-in-device)
or [Saving private key in device: uTrust FIDO2 NFC+ Security Key](BINARY_SIGNING_uTrust.md#saving-private-key-in-device)
instructions.

### Signing an Executable

Follow the [Signing an Executable: Yubikey 5](BINARY_SIGNING_Yubikey.md#signing-executable)
or [Signing an Executable: uTrust FIDO2 NFC+ Security Key](BINARY_SIGNING_uTrust.md#signing-executable)
instructions.

---

**FIXME**

signtool sign /tr <http://timestamp.sectigo.com> /td sha256 /fd sha256 /f ../cert.pem /v setup-diskuv-ocaml-windows_x86_64-0.4.0.exe

signtool sign /tr <http://timestamp.sectigo.com> /td sha256 /fd sha256 /f ../key-and-cert.p12 /v setup-diskuv-ocaml-windows_x86_64-0.4.0.exe

### Distributing your Code Signing Certificate

You must change the management key and PIN and PUK codes
before you distribute the PIV devices.

* Send one of your three security keys to the recipient, in person or by mail.
* Send the PIN (not the PUK) to the recipient in a different transport than the
  security key. For example, send the PIN by encrypted chat, phone or email.

## Threat Scenarios

With the PUK code someone can change the PIN code.
With the PIN code someone, if they have the PIV device, can sign your documents
and files.

So to sign a binary you need both:

1. either the PUK or PIN code *and*
2. the PIV device

Let's say you forget the PUK or PIN code:

* What you already did: You distributed the PIV device to at least
  one other person, and through a separate channel you distributed the PIN (there
  is no reason to send them the PUK code).
* Consequence? Someone else has the PIN code. You can still sign binaries.

Let's say your PUK or PIN code is compromised (leaked, etc.), or your PIV
device was lost or stolen, or your software was compromised (perhaps a virus
was inserted into your code):

* What you already did: You signed each of your binaries with a
  [timestamp service](https://sectigo.com/resource-library/time-stamping-server)
  by using an extra command line option in the SignTool.exe command.
* What you will do if you have only one PIV device remaining: Generate a new
  private key. Copy that new private key to some newly purchased PIV devices.
  Contact the certificate authority and ask for code
  signing certificate to be revoked with an effective date *before* you were
  compromised.
  Generate a new certificate request (CSR) using one of the PIV
  devices.
  Send the new CSR to the certificate authority so you can get a new certificate.
  Once the new certificate arrives, copy it to your PIV devices.
* What you will do if you have more than one PIV device remaining:
  Contact the certificate authority and ask for code
  signing certificate to be revoked with an effective date *before* you were
  compromised.
  Generate a new certificate request (CSR) using a PIV
  device that has not been lost. Send the
  new CSR to the certificate authority so you can get a new certificate.
  Once the new certificate arrives, copy it to your PIV devices.
* Consequence? Since you are timestamping your binaries, any binaries signed
  before you were compromised (before the effectively revoked date) can still be
  used. Your new certificate is not known to the bad actor, so they cannot sign
  new binaries.

### SOP: Unblock PIN

1. Download and install "OpenSC-0.22.0_win64.msi" from <https://github.com/OpenSC/OpenSC/releases/tag/0.22.0>
2. In PowerShell run the following:

   ```powershell
   & "$env:ProgramFiles\OpenSC Project\OpenSC\tools\pkcs15-tool" --unblock-pin
   ```

## Appendixes

### Unorganized

In a ~~`with-dkml bash`~~ `& $env:DiskuvOCamlHome\..\tools\MSYS2\msys2_shell.cmd -mingw64` session:

```bash
echo NO: pacman -S autoconf automake libtool mingw-w64-clang-x86_64-pkg-config mingw-w64-clang-x86_64-openssl
pacman -S autoconf2.69 automake libtool pkg-config openssl-devel
git clone https://github.com/OpenSC/libp11.git

cd libp11
autoreconf-2.69 -fi
./configure --disable-static
make
```

### References

* [Best Practices for Code Signing Certificates](https://www.entrust.com/knowledgebase/ssl/best-practices-for-code-signing-certificates)
* [Time Stamp Server & Stamping Protocols for Digital Signatures/Code Signing](https://sectigo.com/resource-library/time-stamping-server)