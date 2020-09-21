Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54345271E69
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Sep 2020 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIUIzC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Sep 2020 04:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgIUIzC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Sep 2020 04:55:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00721C061755
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2020 01:55:01 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKHb6-0004O9-Bu; Mon, 21 Sep 2020 10:54:56 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKHb4-0000X4-Lf; Mon, 21 Sep 2020 10:54:54 +0200
Date:   Mon, 21 Sep 2020 10:54:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, michal.vokac@ysoft.com,
        l.majewski@majess.pl, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] pwm: imx27: track clock enable/disable to simplify
 code
Message-ID: <20200921085454.yqvfpif77y7isquz@pengutronix.de>
References: <20200909130739.26717-1-m.felsch@pengutronix.de>
 <20200909130739.26717-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ihiyisjixxu4dmpy"
Content-Disposition: inline
In-Reply-To: <20200909130739.26717-2-m.felsch@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ihiyisjixxu4dmpy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Sep 09, 2020 at 03:07:37PM +0200, Marco Felsch wrote:
> Introduce a simple clock state so we can enable/disable the clock
> without the need to check if we are running or not.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/pwm/pwm-imx27.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

This doesn't suggest to be more simple.

> @@ -223,6 +234,10 @@ static int pwm_imx27_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	int ret;
>  	u32 cr;
> =20
> +	ret =3D pwm_imx27_clk_prepare_enable(imx);
> +	if (ret)
> +		return ret;
> +
>  	pwm_get_state(pwm, &cstate);
> =20
>  	clkrate =3D clk_get_rate(imx->clk_per);
> @@ -254,10 +269,6 @@ static int pwm_imx27_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	if (cstate.enabled) {
>  		pwm_imx27_wait_fifo_slot(chip, pwm);
>  	} else {
> -		ret =3D pwm_imx27_clk_prepare_enable(imx);
> -		if (ret)
> -			return ret;
> -
>  		pwm_imx27_sw_reset(chip);
>  	}

There are two clocks, I assume one if for register access and the other
to actually drive the PWM. With that what I would consider simple is to
enable the register clock at the start of each function and disable it
at the end. And for the hardware clock enable it when the hardware
should be enabled and disable it when it should be disabled.

Probably this doesn't reduce the line count, too, but it makes the
function more efficient (if this is measurable at all).

If you want to keep the pwm_imx27_clk_prepare_enable() function that
handles both clocks, just calling pwm_imx27_clk_prepare_enable
unconditionally at the function entry and
pwm_imx27_clk_disable_unprepare at the end should be easier and not
require the .on member in the driver struct.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ihiyisjixxu4dmpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9oalsACgkQwfwUeK3K
7AkRDwf/dOg4mbKSqU0h+WNvo9Q1m2OJr3esWILoPIw53a31uifLEDPrCRQng3Km
z5n6wlNGE+kGa5FBff9jIP46cQJYQ94XwY0YS4k/1MnkOK4JQpDudS27/HnK4lXF
O4/aKnUnPQzgdDw4A/if5jniKp/XLmW+fZIrrfiYln1EZZ0deOycZtDXaTAxrgrs
0EIFkaY81CHtFtg/2vyIoG5hOQHkFOj/W/DD/co6dIgKR6+m/GPF86+zgToJbCHH
no+2Qp/Dz+kyMce8XnveU/uZl47qYV2/pguuUOOUZoe53EA8mJlx3L/sdy7EWd0A
TAb+oCisvzfxVE6i+BojsAHBwM6n+Q==
=v8nZ
-----END PGP SIGNATURE-----

--ihiyisjixxu4dmpy--
