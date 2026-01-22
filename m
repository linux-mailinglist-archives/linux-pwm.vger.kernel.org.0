Return-Path: <linux-pwm+bounces-7988-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJq3J65ScmnpfAAAu9opvQ
	(envelope-from <linux-pwm+bounces-7988-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 17:39:10 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4431B6A1F1
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 17:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C6E2300DCDA
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D123DA7F3;
	Thu, 22 Jan 2026 16:20:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D33624A3;
	Thu, 22 Jan 2026 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098818; cv=none; b=ipWXRreFwWRixFGiA1tIT8jjbZUEx0W2mlSmnRx0J2FmDmzkxiQPc62SCKqB84SsU72i7LZ6wmZ+E9JxB/A7ixhO+yRxkcY8Q++iekdLbEjgx4Oi0mz3QD4qgG5Vb0OVbSmPjx2+pdqQMF/MGb0CybY8TxELFhIuhWEStiIGHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098818; c=relaxed/simple;
	bh=7DXuuZmgZRJ5Xq5jx3fy08cWiDMaffcdzHdNs2i+1FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1vU8T2uKL+ar7iCOukyX6BK4mA1h6Q+bNSqcbVq7R92BSFxGU3WU+LC7trLbafwq8DvF6sBsRJWVr5EkiTils+OcoVhNcqL3DLwoDJC4fZ0LeCYhWujPFtwGXeOilM8f/fPs/pWcgDX6h3d9r3mrJ27AJImhX2+Vg2H/erkvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 711471F8005D;
	Thu, 22 Jan 2026 16:19:51 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 62807B1BB56; Thu, 22 Jan 2026 16:19:49 +0000 (UTC)
X-Spam-Level: 
Received: from shepard (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 427D3B1BB4D;
	Thu, 22 Jan 2026 16:19:47 +0000 (UTC)
Date: Thu, 22 Jan 2026 17:19:44 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Introduce Allwinner H616 PWM controller
Message-ID: <aXJOILxGXv_-f3PE@shepard>
References: <20251217082504.80226-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cf9nCAdpa1F+/l8I"
Content-Disposition: inline
In-Reply-To: <20251217082504.80226-1-richard.genoud@bootlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7988-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[sys-base.io];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,csie.org,gmail.com,sholland.org,pengutronix.de,bootlin.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulk@sys-base.io,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,paulk.fr:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sys-base.io:url]
X-Rspamd-Queue-Id: 4431B6A1F1
X-Rspamd-Action: no action


--cf9nCAdpa1F+/l8I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Richard,

On Wed 17 Dec 25, 09:25, Richard Genoud wrote:
> Allwinner H616 PWM controller is quite different from the A10 one.

Thanks for your patches!

For context here, the PWM controller in the H616 is an instance of the seco=
nd
generation Allwinner PWM controller, which was first seen in the V5 chip fr=
om
2018.

It is also present in the following SoCs: V5, A50, H616, V536, T7, A133, V8=
33,
R329, D1/T113, R128, V851, A523 and A733.

You probably missed it, but there is already an ongonig series to add suppo=
rt
for that second generation PWM controller from Aleksandr Shubin:
https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D454353&archiv=
e=3Dboth&state=3D*

And a patch was also proposed to add H616 support:
https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D409036&archiv=
e=3Dboth&state=3D*

So you should probably try these series and coordinate with their authors
instead of adding this new driver. I understand it's unfortunate that the w=
ork
was already done on your side.

All the best,

Paul

> It can drive 6 PWM channels, and like for the A10, each channel has a
> bypass that permits to output a clock, bypassing the PWM logic, when
> enabled.
>=20
> But, the channels are paired 2 by 2, sharing a first set of
> MUX/prescaler/gate.
> Then, for each channel, there's another prescaler (that will be bypassed
> if the bypass is enabled for this channel).
>=20
> It looks like that:
>             _____      ______      ________
> OSC24M --->|     |    |      |    |        |
> APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> PWM_clock_src_xy
>            |_____|    |______|    |________|
>                           ________
>                          |        |
>                       +->| /div_k |---> PWM_clock_x
>                       |  |________|
>                       |    ______
>                       |   |      |
>                       +-->| Gate |----> PWM_bypass_clock_x
>                       |   |______|
> PWM_clock_src_xy -----+   ________
>                       |  |        |
>                       +->| /div_k |---> PWM_clock_y
>                       |  |________|
>                       |    ______
>                       |   |      |
>                       +-->| Gate |----> PWM_bypass_clock_y
>                           |______|
>=20
> Where xy can be 0/1, 2/3, 4/5
>=20
> PWM_clock_x/y serve for the PWM purpose.
> PWM_bypass_clock_x/y serve for the clock-provider purpose.
> The common clock framework has been used to manage those clocks.
>=20
> This PWM driver serves as a clock-provider for PWM_bypass_clocks.
> This is needed for example by the embedded AC300 PHY which clock comes
> from PMW5 pin (PB12).
>=20
> This series is based onto v6.19-rc1
>=20
> Changes since v1:
> - rebase onto v6.19-rc1
> - add missing headers
> - remove MODULE_ALIAS (suggested by Krzysztof)
> - use sun4i-pwm binding instead of creating a new one (suggested by Krzys=
ztof)
> - retrieve the parent clocks from the devicetree
> - switch num_parents to unsigned int
>=20
> Richard Genoud (4):
>   dt-bindings: pwm: allwinner: add h616 pwm compatible
>   pwm: sun50i: Add H616 PWM support
>   arm64: dts: allwinner: h616: add PWM controller
>   MAINTAINERS: Add entry on Allwinner H616 PWM driver
>=20
>  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml |  19 +-
>  MAINTAINERS                                   |   5 +
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  47 +
>  drivers/pwm/Kconfig                           |  12 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-sun50i-h616.c                 | 892 ++++++++++++++++++
>  6 files changed, 975 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pwm/pwm-sun50i-h616.c
>=20
>=20
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> --=20
> 2.47.3
>=20
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--cf9nCAdpa1F+/l8I
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmlyTiAACgkQhP3B6o/u
lQwblQ//TuPP2uld56j19mxOPONXVvcqYj35vWi7jaFpTG/5FlLyAkltozy7KB35
EMNLfc1FsB+x4oxoyW7dz2QLl0X78frqioZx95jUiwZrsPW7dBP178sqdXvkqTh5
QHK43gywMn5FShGZtbkVTDKSr0Wp91MU7L63Pg+eCxf9+jknWQuroGGFR7nzl1Dt
Q2ScdsOBmu41MAs2iRCBcuob+6vhH1cf0ymT7M7TsXRmDciwcv3BVdleQWvWYGI6
OA2RHjCUZ2nQdUyaeGsDUtjvHJXbYFBiSmTjkXYGN4yml44WiW0FNxa3CZERZpsL
66an8uc+l1HQNJ4vwd32EGF/ctPaYe6x0VLXu4RQoleu027q9cvsnVJVJwWQoT+f
H3Pr/c0+t/SSZTWsH8FmWoi4BseughzJIinOf+6tlXfCCY6DaNnk29ptztAJPBTv
v4z0olpZw+4liXqSUmxHCgdzc1KYIJxjiKU6kZAX2sy/6F+BR0B+MZ2JkxjhU1WS
kE8HmHUhfRhxBmt6MkkRbGSpUXhyjk/EVhVQBVQabydBH3QZ2rZEFI94z2qQtPaQ
l2qr5a++/fbo1QTn6HArX3+R/UCgJR8DS8qkGFOmvQTYByzgNBL/0JgwDky2PftG
KsCvLqfxfnNE8Jt1oD+xkMf4TlQAum+mdcl8CAJm/gp1i5qySHI=
=4RNE
-----END PGP SIGNATURE-----

--cf9nCAdpa1F+/l8I--

