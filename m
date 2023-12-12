Return-Path: <linux-pwm+bounces-543-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CE980F7F8
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 21:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9AC282057
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 20:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEE264127;
	Tue, 12 Dec 2023 20:34:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00056BC
	for <linux-pwm@vger.kernel.org>; Tue, 12 Dec 2023 12:33:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD9Rx-0003vB-Q5; Tue, 12 Dec 2023 21:33:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD9Rx-00FQ7M-7K; Tue, 12 Dec 2023 21:33:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD9Rw-001sD2-UN; Tue, 12 Dec 2023 21:33:52 +0100
Date: Tue, 12 Dec 2023 21:33:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-pwm@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Kevin Hilman <khilman@baylibre.com>, kernel@pengutronix.de,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] pwm: meson: Simplify using dev_err_probe()
Message-ID: <20231212203352.wl3rzob75fct4lov@pengutronix.de>
References: <20231206214817.1783227-2-u.kleine-koenig@pengutronix.de>
 <ZXM72QYBbb32Q_aL@orome.fritz.box>
 <20231208190620.5qobgtyii2wt7tfa@pengutronix.de>
 <ZXbsDRslZNKCeJF9@orome.fritz.box>
 <20231211141900.x6tpyctch5fv3uqf@pengutronix.de>
 <ZXcpswXxb1oQldp5@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="guvbhg2l75sxu7tf"
Content-Disposition: inline
In-Reply-To: <ZXcpswXxb1oQldp5@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--guvbhg2l75sxu7tf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Mon, Dec 11, 2023 at 04:24:35PM +0100, Thierry Reding wrote:
> It all adds up in the end and keeps me from doing other things.

If that means you'd be glad to give up the PWM maintainer job, I'd
happily take over this post.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--guvbhg2l75sxu7tf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV4w68ACgkQj4D7WH0S
/k5SoAf9EwwocC3g0tzyS34LMplwo3g493B3KjpWEfjKrQfSTLU0gbTb6BJH8AeX
bdwuibpcxFBfBNJ41T0V8z2G9j1nWB8+TEKj8WDuUV6jmu8wP5TjXe7acBd5SR9f
WJCbuei2OpWIovqasuWpmFkc6tfUfbupmRw7WbdnbMgj0k39/c6dZ935W+vcAy8w
SFkPTWOdyzEe+hQEk2WuquyBebDQZwS2HIbzGuPg/H7BwIE+XYd9wRgnA0Mg0xpV
lHVConqd5P7GYwrjQj4bU4YAzdScaGHUADvG45MNgJIjRyykrpzl2f9iorGMjliW
3CkcpJFjQlOYPUo93f4iQg1fvkTQkg==
=58Vq
-----END PGP SIGNATURE-----

--guvbhg2l75sxu7tf--

