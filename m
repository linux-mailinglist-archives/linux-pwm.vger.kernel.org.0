Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235CB454597
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Nov 2021 12:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbhKQL1e (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Nov 2021 06:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhKQL1e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Nov 2021 06:27:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E10CC061570
        for <linux-pwm@vger.kernel.org>; Wed, 17 Nov 2021 03:24:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnJ3F-0006ji-PW; Wed, 17 Nov 2021 12:24:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnJ3B-000M5S-Gz; Wed, 17 Nov 2021 12:24:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnJ3A-0003az-75; Wed, 17 Nov 2021 12:24:24 +0100
Date:   Wed, 17 Nov 2021 12:24:00 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     cgel.zte@gmail.com
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] pwm: Use div64_ul instead of do_div
Message-ID: <20211117112400.bkscb2pyavonpfsn@pengutronix.de>
References: <20211117020426.159242-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mjecz3xyrkcwg42p"
Content-Disposition: inline
In-Reply-To: <20211117020426.159242-1-deng.changcheng@zte.com.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mjecz3xyrkcwg42p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Nov 17, 2021 at 02:04:26AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>=20
> do_div() does a 64-by-32 division. If the divisor is unsigned long, using
> div64_ul can avoid truncation to 32-bit.

After some research I understood your commit log. I'd write:

	do_div() does a 64-by-32 division. Here the divsor is an
	unsigned long which on some platforms is 64 bit wide. So use
	div64_ul instead of do_div to avoid a possible truncation.

The priority of this patch seems to be low, as the device seems to exist
only on (32bit) arm.

> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index a43b2babc809..1ae3d73b9832 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -60,7 +60,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, st=
ruct pwm_device *pwm,
>  				return -EINVAL;
> =20
>  			clk_period_ns =3D (u64)NSEC_PER_SEC * 256;
> -			do_div(clk_period_ns, clk_freq);
> +			div64_ul(clk_period_ns, clk_freq);

This must be

	clk_period_ns =3D div64_ul(clk_period_ns, clk_freq);

as div64_ul has a different calling convention than do_div. Same problem
in the next hunk.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mjecz3xyrkcwg42p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGU5k0ACgkQwfwUeK3K
7An4+Af+OP2VhxA5quV4sEd1vi1tJowfr76mjpf4Z2zzOGA56nPX+wnz/g0Jaa+B
Kag+Hnr/ycZw77SUzbWh4DotdoJA0uja+IystuQYVs31R4s7vTbI3jk/0zl8baws
S4A3t5Fk6oUl04rRvVvwUMWhrxt8sqk803YO0APqcy0X6SOcsMHnXmOVZdiDJ+cl
I6HJu5JAQ4tJ5B6MBgXYA3fYWhbagxtxQEpa4z5plYYtoJ3RvuBSWETskmFxrCVT
LXYD+P6Ft9wQOd/lxHrcss/eVVjZKWJ9amxZnInW7g0HLVMtRXZN0z+uuP6Go+2V
tZXmGQxqWtQavVAS8b1aL1GG64dG1g==
=E16E
-----END PGP SIGNATURE-----

--mjecz3xyrkcwg42p--
