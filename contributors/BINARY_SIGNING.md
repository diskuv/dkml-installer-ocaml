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

## Technology

We'll be using a smart card that supports personal identity verification ("PIV").
A PIV device stores a private key and, through the PKCS#11 protocol, can sign
documents and files without revealing that private key.

## PIV Devices

* Yubikey 5. ~$50 USD. This is a mature product, and there have been very few
  CVEs issued against Yubikey given its widespread adoption.
* [uTrust FIDO2 NFC+ Security Key (USB-A)](https://shop.identiv.com/collections/fido2-security-keys/products/utrust-fido2-nfc-security-key).
  ~$30 USD. Be careful it is the "NFC+" product and not "NFC", because, according to
  the [product comparison](https://www.identiv.com/products/logical-access-control/fido2-security-keys/utrust-key-manager-software/),
  the "NFC" product does not allow configuration of its PIV functionality using
  the uTrust software.

Both the manufacturers above sell FIPS rated products (ie. they can sell it for
government use). But if you actually need the safety margin of a FIPS product,
you should use a hardware security module (HSM) and should not be following this
document!

The risk profile of this document is that you can trust that the manufacturers
don't have any glaring defects in their non-FIPS products (if nothing else,
a bad non-FIPS defect would reflect poorly on their FIPS government sales).

## PIV Software

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

## Compromises

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

## References

* [Best Practices for Code Signing Certificates](https://www.entrust.com/knowledgebase/ssl/best-practices-for-code-signing-certificates)
