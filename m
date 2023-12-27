Return-Path: <linux-pwm+bounces-650-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD4181EEC7
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Dec 2023 13:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2621F22067
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Dec 2023 12:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16342446C1;
	Wed, 27 Dec 2023 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="c6D88c7r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257E446BE
	for <linux-pwm@vger.kernel.org>; Wed, 27 Dec 2023 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 6CCDB240029
	for <linux-pwm@vger.kernel.org>; Wed, 27 Dec 2023 13:20:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1703679617; bh=4WymL+679CZE5r/fhQuVDvBDfKE0M7tgF+zDLQ1/jUk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Autocrypt:OpenPGP:
	 From;
	b=c6D88c7rjVqVaA9hw5035sLe21CLmnapX3fw/j3C3TCkJ9o3E0Hv4p7RHwMBfg4vp
	 MNCS0gFOo1a2+BfVakxaRCx0uw/9N3I/IG0GWML+3QQC/Ra2Xio2Yh/jXvDeyos4z8
	 /4Abz3dXo9oSuzRnG1ivNr8UohbWBU1X3FQYYy+UbZRx5bBCzM2PGj6Y438mhZfKpk
	 YuwgGZe39zBR23LHkZ2gx5Pq5BcTzBCZOtakmUvGIrqLa37+IW31ZKGoUP1Hhx92DU
	 q1J72o1e0XNrGvPIWcbdqhh7YBdNEKls8CGaaDzFPTBqFz0+d4wq5oBasKV3EsMwcA
	 RbiHqckoQ0R4w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4T0W1Y0mVrz9rxB
	for <linux-pwm@vger.kernel.org>; Wed, 27 Dec 2023 13:20:16 +0100 (CET)
Message-ID: <e91c4495-c32f-9de1-6f48-af16239bc3b6@posteo.de>
Date: Wed, 27 Dec 2023 12:20:16 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: de-DE
To: linux-pwm <linux-pwm@vger.kernel.org>
From: Patrick Menschel <menschel.p@posteo.de>
Subject: [PCA9685] Possible bug in PCA9685 driver
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sHgSmd7VydvZ0eTEA79xqieK"
Autocrypt: addr=menschel.p@posteo.de; prefer-encrypt=mutual;
  keydata=xjMEZWoDbRYJKwYBBAHaRw8BAQdAPnitZJKgRkA5F6Wn0CDr6DKJu33iFUFd5UofbM6vExTNICAo
  cG9zdGVvKSA8bWVuc2NoZWwucEBwb3N0ZW8uZGU+wpYEExYIAD4WIQQO6LhiIelOcmTibl1UVEfM
  9nzU+gUCZWoDbQIbAwUJBaOagAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRBUVEfM9nzU+sNA
  AQDc9USeUpTlQJLNbBv+6w9r6p3DvH/3MqtyvwhV8vNgyQEAvXnWykqofrPbE3Rhtb14sZfP1BQC
  6957ILBBrXmCLwTOOARlagNtEgorBgEEAZdVAQUBAQdA/0A1N2M4AgK4+MQEiM3SIm23NOzRMepv
  xLTN8nX2AD0DAQgHwn4EGBYIACYWIQQO6LhiIelOcmTibl1UVEfM9nzU+gUCZWoDbQIbDAUJBaOa
  gAAKCRBUVEfM9nzU+gt+AP9UC/gBqsbdOFf3eCt/ayBX91SoisFqYYw6LVILENEYmgEApXCtCQK4
  iGvszIRZCyEtqYXyfHrotRS+aZZE6yxzGgc=
OpenPGP: url=https://posteo.de/keys/menschel.p@posteo.de.asc; preference=encrypt

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------sHgSmd7VydvZ0eTEA79xqieK
Content-Type: multipart/mixed; boundary="------------ae0uDLW1S5a1HoMkqEqaYw4f";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: linux-pwm <linux-pwm@vger.kernel.org>
Message-ID: <e91c4495-c32f-9de1-6f48-af16239bc3b6@posteo.de>
Subject: [PCA9685] Possible bug in PCA9685 driver

--------------ae0uDLW1S5a1HoMkqEqaYw4f
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkknZCBsaWtlIHRvIHJlcG9ydCBhIHBvc3NpYmxlIGJ1ZyBpbiB0aGUgcGNh
OTg2NSBkcml2ZXIuDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9yYXNwYmVycnlwaS9saW51eC9i
bG9iL3JwaS02LjEueS9kcml2ZXJzL3B3bS9wd20tcGNhOTY4NS5jDQoNClRoZSByZXN1bHRp
bmcgZnJlcXVlbmN5IGlzIDEwJSBvZmYuDQoNCkknbSBjdXJyZW50bHkgdXNpbmcgYW4gYWRh
ZnJ1aXQgcGNhOTY4NSBib2FyZCB0byB6ZXJvLWluIHNvbWUgc2Vydm9zIHZpYSANClNZU0ZT
Lg0KDQpBcyBhbHdheXMsIGZpcnN0IGF0dGVtcHQgd2FzIGEgZGlzYXN0ZXIgYnV0IGFmdGVy
IHRoYXQsIEkgc3RhcnRlZCB0byANCm1lYXN1cmUgdGhpbmdzIHdpdGggYSBCZW5uaW5nIE1N
IDctMSBhbmQgd2hlbiBJIHNldCB0aGUgcGVyaW9kIHRvIDIwbXMgDQp2aWEgU3lzRnMsIEkg
cmVhZCA1NUh6IG9uIHRoZSBtdWx0aW1ldGVyLg0KDQpJIGhhZCB0byBzZXQgdGhlIHBlcmlv
ZCB0byAyMm1zIHRvIGdldCA0OSw4OEh6Lg0KDQpgYGANCiQgY2QgL3N5cy9jbGFzcy9wd20v
cHdtY2hpcDAvDQokIGVjaG8gMCA+IGV4cG9ydA0KJCBjZCBwd20wLw0KDQokIGVjaG8gMjAw
MDAwMDAgPiBwZXJpb2QNCiQgZWNobyAxMTAwMDAwMCA+IGR1dHlfY3ljbGUNCiQgZWNobyAx
ID4gZW5hYmxlDQojIHJlc3VsdHMgaW4gfjU1SHoNCg0KJCBlY2hvIDAgPiBlbmFibGUNCiQg
ZWNobyAyMjAwMDAwMCA+IHBlcmlvZA0KJCBlY2hvIDExMDAwMDAwID4gZHV0eV9jeWNsZQ0K
JCBlY2hvIDEgPiBlbmFibGUNCiMgcmVzdWx0cyBpbiB+NTBIeiwgYW5kIGl0J3MgNTAlIGR1
dHkgY3ljbGUgdG8gZ2V0IGEgc3ltZXRyaWMgc2lnbmFsDQoNCg0KJCBlY2hvIDAgPiBlbmFi
bGUNCiMgYWZ0ZXIgY29ubmVjdGluZyBhIHNlcnZvIGFuZCBzZXR0aW5nIGR1dHkgdG8gMS0y
bXMgZXZlcnl0aGluZyB3b3JrcyBhcyANCmV4cGVjdGVkLg0KJCBlY2hvIDEgPiBlbmFibGUN
CiQgZWNobyAxMDAwMDAwID4gZHV0eV9jeWNsZQ0KJCBlY2hvIDE1MDAwMDAgPiBkdXR5X2N5
Y2xlDQokIGVjaG8gMjAwMDAwMCA+IGR1dHlfY3ljbGUNCmBgYA0KSW4gdGhlIGVuZCBpdCBk
b2VzIG5vdCBtYXR0ZXIgdG8gdGhlIHNlcnZvIG9yIHRoZSBhcHBsaWNhdGlvbiBhbmQgSSdt
IA0Kbm90IHN1cmUgaWYgSSBtZWFzdXJlZCBjb3JyZWN0bHkuDQoNCkJSDQpQYXRyaWNrIE1l
bnNjaGVsDQo=

--------------ae0uDLW1S5a1HoMkqEqaYw4f--

--------------sHgSmd7VydvZ0eTEA79xqieK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQO6LhiIelOcmTibl1UVEfM9nzU+gUCZYwWgAUDAAAAAAAKCRBUVEfM9nzU+ivD
AP4w55oDMNAXjy/l+vxy3eZ972o4GHVsySNisNYFPlNhFwEA8Wv6LqubiOugDqAuPSt23P6TH3ZK
w4wvk40eqN0YfAc=
=eklh
-----END PGP SIGNATURE-----

--------------sHgSmd7VydvZ0eTEA79xqieK--

