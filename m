Return-Path: <linux-pwm+bounces-516-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E285180DBDA
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 21:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 832A5B2153F
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 20:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E3D53E3B;
	Mon, 11 Dec 2023 20:42:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5F3E4
	for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2023 12:42:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rCn6S-0005UC-35; Mon, 11 Dec 2023 21:42:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rCn6Q-00FBGh-SY; Mon, 11 Dec 2023 21:42:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rCn6Q-0018Fb-Iq; Mon, 11 Dec 2023 21:42:10 +0100
Date: Mon, 11 Dec 2023 21:42:10 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nylon Chen <nylon.chen@sifive.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, thierry.reding@gmail.com,
	emil.renner.berthing@canonical.com, vincent.chen@sifive.com,
	greentime.hu@sifive.com, zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [v5 1/2] riscv: dts: sifive: unleashed/unmatched: Remove PWM
 controlled LED's active-low properties
Message-ID: <20231211204210.ioeyyufiz646ht5j@pengutronix.de>
References: <20231024101902.6689-1-nylon.chen@sifive.com>
 <20231024101902.6689-2-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ii53zkpujb4nxf65"
Content-Disposition: inline
In-Reply-To: <20231024101902.6689-2-nylon.chen@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ii53zkpujb4nxf65
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 06:19:01PM +0800, Nylon Chen wrote:
> This removes the active-low properties of the PWM-controlled LEDs in
> the HiFive Unmatched device tree.
>=20
> The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schemat=
ics-v3.pdf[1].
>=20
> Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf845=
3f8698_hifive-unleashed-a00-schematics-1.pdf [0]
> Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce7=
6f4192_hifive-unmatched-schematics-v3.pdf [1]

IMHO the commit log should mention that the driver got inversion wrong
and so both dts and driver need adaption.

Otherwise looks fine to me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ii53zkpujb4nxf65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV3dCEACgkQj4D7WH0S
/k6tVAf7Bj1RKTbaCo6ITu+NYR1r155+J1T19OHpefrybgzQXZ2X+LaixXbycEk/
bkGT88XTQVJSmNlu5Af1zKpOF/Uqs3XZovcEPiipnTGQFW/cuQfys/Yryxr1/9ei
DssK8PavR+upBKmz2n0Amhh5gISU75gAGgExhTDMV4atIrlopAl0zGQUSphCFaLQ
u+HfMiBhG18K6hfk/tsA1KYf8v/bzg2DZ9rArCSycr8/8BqSUO1R6SAWlrSUWRrU
I+JfkIFJNWwP1sXz0i9+tAoOKYCgcLdtqLBbi9QT5vYcKSVig+m5h/3ofeJMu9Tw
B9IcMycyPSaYA56AqG1k79Mv021yUg==
=KPhB
-----END PGP SIGNATURE-----

--ii53zkpujb4nxf65--

