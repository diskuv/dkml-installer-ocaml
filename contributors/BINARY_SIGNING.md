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

* Yubikey 5. This is a mature and more expensive product, and there have been
  very few CVEs issued against Yubikey given its widespread adoption.
* [uTrust FIDO2 NFC+ Security Key](https://shop.identiv.com/collections/fido2-security-keys/products/utrust-fido2-nfc-security-key).

Both the manufacturers above sell FIPS rated products (ie. they can sell it for
government use). But if you actually need the safety margin of a FIPS product,
you should use a hardware security module (HSM) and should not be following this
document!

The risk profile of this document is that you can trust that the manufacturers
don't have any glaring defects in their non-FIPS products (if nothing else,
a bad non-FIPS defect would reflect poorly on their FIPS government sales).

Both PIV devices will work. However this document will only describe configuring
the uTrust security key.

## Instructions

### Shopping List

All prices are quoted in USD that are current as of May 2022.

One-time costs:

1. **$20**. Two (2) waterproof USB flash drives to store code signing server keys.
2. **$60**. Two (2) [uTrust FIDO2 NFC+ Security Keys](https://shop.identiv.com/collections/fido2-security-keys/products/utrust-fido2-nfc-security-key).
   Be careful to purchase the "NFC+" product and not "NFC" because, according to
   the [product comparison](https://www.identiv.com/products/logical-access-control/fido2-security-keys/utrust-key-manager-software/),
   the "NFC" product does not allow configuration of its
   personal identity verification (PIV) functionality using
   the uTrust software.

Yearly costs:

1. **$85**. One (1) Comodo Code Signing certificate.

### Prepare a Code Signing Certificate

FIRST,

In a UNIX prompt (ie. with Windows Diskuv OCaml run `with-dkml bash`)
do the following:

```bash
openssl req -new -newkey rsa:4096 -nodes -keyout server.key -out server.csr
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

Keep the `server.key` secured for several years:
* Store `server.key` on USB flash drives under a physical
  lock and key. Other storage devices are acceptable, but make sure the
  storage devices are disconnected from the Internet.
* Keep the flash drives in different physical locations.
* Print a label for the drives that includes a public identifier of the key
  (you can use the first N characters to make it shorter):
  ```bash
  openssl rsa -in server.key -modulus -noout | awk 'BEGIN{FS="="} {print $NF}' | openssl sha3-256 -r
  ```

  The complete label used for the Diskuv, Inc. code signing was:

  ```text
  Diskuv, Inc. Code Signing Certificate
  6a48ecac5ef6e30613aa484895aab410edaccf897ca9d59fc33390dd40d76334
  ```
* You will **never** give `server.key` to a third-party.

THIRD,

You will give `server.csr` to the certificate authority so they can generate
a code signing certificate. Even if your company or organization has its
own certificate authority, Microsoft only recognizes a small list of
certificate authorities.

The [Comodo SSL store](https://comodosslstore.com/codesigning.aspx) has
Certigo Standard Validation certificates that are authorized by Microsoft.

> The Comodo SSL store will give you many warnings about only using Internet
> Explorer 8 on Windows. This document is following a different procedure that
> does not need Internet Explorer or any special web browser.

After your certificate has been generated and downloaded:
* convert the downloaded certificate (ex. `user.crt`) into the "PEM" format with:
  ```bash
  openssl x509 -inform der -in user.crt -out cert.pem
  ```
* **FIXME** combine the private key and the certificate into a "PKCS#12" file with:
  ```bash
  openssl rsa -outform DER -in server.key -out server-key.der

  openssl pkcs12 -inkey server.key -in cert.pem -export -out key-and-cert.p12
  ```
* you can delete the `server.csr` file

FOURTH, (save private key and certificate in security device)

Download and install [IDENTIV - uTrust Key Manager Software](https://go.identiv.com/software/utrust-key-manager)

In a UNIX shell run `openssl rand -hex 64 | tr -cd 0-9 | cut -c1-8`. Write
the 8 digit number on a piece of paper as the "PUK" number.

Run the uTrust Key Manager Software and insert one of the security tokens. Then:
* Go to `Applications > PIV`
  * Go to `Pin Management - Configure PINs`
    * Go to `Change PUK`
      * Current PUK: ✓ Use default
      * New PUK: *Use the PUK number you wrote down earlier*
      * Confirm new PUK: *Use the same 8 digit number*
      * Click "Change PUK" button to save your changes
        > Now your PINs can't be reset without knowing your PUK. Too many
        > attempts to guess your PUK will lock the device.
* Go to `Applications > PIV`
  * Go to `Pin Management - Configure PINs`
    * Go to `Change PIN`
      * Current PIN: ✓ Use default
      * New PIN: *Use the PIN number you wrote down earlier*
      * Confirm new PIN: *Use the same 8 digit number*
      * Click "Change PIN" button to save your changes
        > Now no one can sign files using the security key unless they know
        > your PIN. Too many attempts to guess your PIN will lock the device.
* Go to `Applications > PIV`
  * Go to `Certificates - Configure Certificates`
    * Go to `Digital Signature - Slot 9c - Import`
      * File: `cert.pem` **FIXME**
      * Management key: ✓ Use default

The PUK and PIN only need to be kept until the security token is distributed.

FIFTH, (**FIXME** test security key)

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

---

**FIXME**

signtool sign /tr http://timestamp.sectigo.com /td sha256 /fd sha256 /f ../cert.pem /v setup-diskuv-ocaml-windows_x86_64-0.4.0.exe

signtool sign /tr http://timestamp.sectigo.com /td sha256 /fd sha256 /f ../key-and-cert.p12 /v setup-diskuv-ocaml-windows_x86_64-0.4.0.exe

### Distributing your Code Signing Certificate

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

## Appendixes

### Alternative: Yubikey

Yubikey's are managed with the command line
[Yubico PIV Tool](https://developers.yubico.com/yubico-piv-tool/) or the
less-functional GUI [YubiKey Manager](https://developers.yubico.com/yubikey-manager/).

Avoid YubiKey Manager unless you are just getting familiar with your first
YubiKey. The YubiKey Manager will only let you access 4 standard PIV slots (and
only one of those you should use). But Yubikey 5 devices have an extra 20
"retired" slots that you can use for other private keys. Use the Yubico PIV Tool
instead.

> You must change the PIN and PUK codes using the PIV software before you
> distribute the PIV devices.

### References

* [Best Practices for Code Signing Certificates](https://www.entrust.com/knowledgebase/ssl/best-practices-for-code-signing-certificates)
* [How to Generate a Code Signing CSR](https://help.comodosslstore.com/support/solutions/articles/22000270319-how-to-generate-a-code-signing-csr)
* [Time Stamp Server & Stamping Protocols for Digital Signatures/Code Signing](https://sectigo.com/resource-library/time-stamping-server)