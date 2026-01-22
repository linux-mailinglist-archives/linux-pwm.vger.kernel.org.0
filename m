Return-Path: <linux-pwm+bounces-7989-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLk8J7FgcmnbjAAAu9opvQ
	(envelope-from <linux-pwm+bounces-7989-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 18:38:57 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4004D6B800
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 18:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7ECDD30F250E
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C24E3915C1;
	Thu, 22 Jan 2026 16:43:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145E2877F7;
	Thu, 22 Jan 2026 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100230; cv=none; b=ocjq/lK5snEodl2rDqio5NNZVrSae0UjiTrNqTj/m6d5JGDEMJhc6DvRvlc7vpsfnaQBxkeAn9BTykWB+xeZzjqB+bLx766GfHyJ2nHtG3MIAPvbyjED+pIpTcqxKBcMgY/5s3rmcjsWBDyqhnSZC+RR77YoAEXbweAK9OyNOgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100230; c=relaxed/simple;
	bh=lOOGgXNAcV5Kj7qstozfHh4KfxndROOrlFnru7vLM7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKwfh+DG9rU2Tny22vhzhq9NenikNm5BZPqw59qOY1O++60YapqSHKg/0hxclsCLbcXJD0PDmFZZgYxcZR+3GWJB4hk1gccW3Ljn1RjB2oxjcuWpg3l1JA3GagPmvCcIWIgPQJVxmbQ3r8y+ZpaMFqOhoQRe5EeGn1R1kGHF1eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id BB4CB1F8004F;
	Thu, 22 Jan 2026 16:43:31 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id B82FCB1BB88; Thu, 22 Jan 2026 16:43:28 +0000 (UTC)
X-Spam-Level: 
Received: from shepard (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 4E8C9B1BB7B;
	Thu, 22 Jan 2026 16:43:26 +0000 (UTC)
Date: Thu, 22 Jan 2026 17:43:23 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 0/3] Add support for Allwinner PWM on D1/T113s/R329
 SoCs
Message-ID: <aXJTqzZaBrCMnTvv@shepard>
References: <20250427142500.151925-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8kvUD8u6sGarMbR3"
Content-Disposition: inline
In-Reply-To: <20250427142500.151925-1-privatesub2@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7989-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[sys-base.io];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,csie.org,gmail.com,sholland.org,sifive.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,lists.infradead.org,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulk@sys-base.io,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sys-base.io:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ozlabs.org:url,paulk.fr:url]
X-Rspamd-Queue-Id: 4004D6B800
X-Rspamd-Action: no action


--8kvUD8u6sGarMbR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Aleksandr,

On Sun 27 Apr 25, 17:24, Aleksandr Shubin wrote:
> Aleksandr Shubin (3):
>   dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
>     controller
>   pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
>   riscv: dts: allwinner: d1: Add pwm node
>=20
>  .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  84 ++++
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +
>  drivers/pwm/Kconfig                           |  10 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-sun20i.c                      | 379 ++++++++++++++++++
>  5 files changed, 486 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20=
i-pwm.yaml
>  create mode 100644 drivers/pwm/pwm-sun20i.c

Thanks for your work on this driver!

For context, this PWM controller seems to be a second-generation design from
Allwinner, which is found in the following chips: V5, A50, H616, V536, T7, =
A133,
V833, R329, D1/T113, R128, V851, A523 and A733.

I've tested your driver on A133, which works fine too. It seems that H616 u=
ses
a similar (but slightly different) register layout.

In case you've missed it, there's a follow-up series adding H616 support at:
https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D409036&archiv=
e=3Dboth&state=3D*

And there's also a standalone effort (which I've redirected to your series)=
 at:
https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D485644&archiv=
e=3Dboth&state=3D*

Now given that the new controller was introduced with the V5 (sun8iw12) from
2018, I think it would be a bit confusing to keep the sun20i-pwm name.

How about renaming the driver to sun8i-pwm instead? That would be more
consistent with how other second generation designs from Allwinner are usua=
lly
called in Linux and makes it more clear that it also targets sun8i and sun5=
0i
chips, in addition to sun20i.

All the best,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--8kvUD8u6sGarMbR3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmlyU6sACgkQhP3B6o/u
lQzLzw/7BSyJlA0VQWydAMnYMSXVRR1nWvDgL2BacWvoFGeQZLvkPIS+bS0Y1oje
CuoZsMChx9onTi+/OKOGwqLUfKtA7nmvp2LLJhelqIKfX1fMRmbXU7BnhoH4jqUc
Tnr0UHIUSXP6rzcY+/4bevCUC+iHKf4jJceuGZTFsHF0LZi8c62oOrXNBMTNia+/
joy6c/9RN5N4RxfbcEfBqmUc0cu88EErW17t8FhALQ6oEftzsNCju3gsOQ4S7lUB
SRH6ffY/o8LqXPZ/kqGDC5ipyFPJyuORXK3xS9zh1xDz+OSvmRh8v2hBsU0V4jxS
99oGXAOXJGljK1415Ush1uRcMKa+YXuF2deG9qJAfEaDq+kRhp2gXdzvN1/0HCgN
rQnyICWywvjX/oznc6j7gt1i+nzKofeXvVyT+Ym/Uk+2K4V2kZmUIGkO9vAgCb7d
KAZNs7Yf79OcoCNZBXAqec7tO2jS0ihWjQ3vSwhzlFa8EcF/nTQJJDgiu3JLPZtQ
Lu2PLgsmNarnKGk9AX8m7EirKdMJduYk5G7oyBxeGXeqNkf9nWf99WqH2cmzDz4o
GhVyfKf2rBfQv9MKU0Qz2CBRXA/rZl21s+kZ9NZEG6RHqGaGTfjOJgRjQo9SS07f
67gd5SFjE8HJPruOtaZrwhBq+ZLF1vGsCwlmvLRJLABl2NY7a8o=
=mx2z
-----END PGP SIGNATURE-----

--8kvUD8u6sGarMbR3--

