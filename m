Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D1340F412
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Sep 2021 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhIQI1L (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Sep 2021 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238435AbhIQI1L (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Sep 2021 04:27:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CF7C061574
        for <linux-pwm@vger.kernel.org>; Fri, 17 Sep 2021 01:25:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mR9Bo-0003zm-Ki; Fri, 17 Sep 2021 10:25:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mR9Bn-0006ev-9m; Fri, 17 Sep 2021 10:25:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mR9Bn-00051c-8K; Fri, 17 Sep 2021 10:25:43 +0200
Date:   Fri, 17 Sep 2021 10:25:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/2] pwm: renesas-tpu: better errno for impossible rates
Message-ID: <20210917082543.2f5wum23nkvmzbdi@pengutronix.de>
References: <20210915065542.1897-1-wsa+renesas@sang-engineering.com>
 <20210915065542.1897-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aegnhihdgqyrwamy"
Content-Disposition: inline
In-Reply-To: <20210915065542.1897-2-wsa+renesas@sang-engineering.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--aegnhihdgqyrwamy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 15, 2021 at 08:55:40AM +0200, Wolfram Sang wrote:
> From: Duc Nguyen <duc.nguyen.ub@renesas.com>
>=20
> ENOTSUP has confused users. EINVAL has been considered clearer. Change
> the errno, we were the only ones using ENOTSUP in this subsystem anyhow.
>=20
> Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
> [wsa: split and reworded commit message]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/pwm/pwm-renesas-tpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> index 4381df90a527..754440194650 100644
> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -269,7 +269,7 @@ static int tpu_pwm_config(struct pwm_chip *chip, stru=
ct pwm_device *_pwm,
> =20
>  	if (prescaler =3D=3D ARRAY_SIZE(prescalers) || period =3D=3D 0) {
>  		dev_err(&tpu->pdev->dev, "clock rate mismatch\n");
> -		return -ENOTSUPP;
> +		return -EINVAL;
>  	}

prescaler =3D=3D ARRAY_SIZE(prescalers) means that period_ns * clk_rate is
too big for the hardware. Given that the driver considers clk_rate as
constant, the interpretation is that period_ns is too big to be
implemented. In this case the expectation for a new driver would be to
round down to the biggest possible rate. period =3D=3D 0 means the requested
period is too small, in this case -EINVAL is right.

The danger to make the driver behave like new drivers should is that it
ends in regressions, but when we touch the behaviour this might be a
good opportunity to "fix" this driver?

This would look as follows:

	max_period_ns =3D 0xffff * NSEC_PER_SEC * 64 / clk_rate;

	period_ns =3D min(period_ns, max_period_ns);
	duty_ns =3D min(duty_ns, period_ns);

	/*
	 * First assume a prescaler factor of 1 to calculate the period
	 * value, if this yields a value that doesn't fit into the 16
	 * bit wide register field, pick a bigger prescaler. The valid
	 * range for the prescaler register value is [0..3] and yields a
	 * factor of (1 << (2 * prescaler)).
	 */

	period =3D clk_rate * period_ns / NSEC_PER_SEC;
	if (period =3D=3D 0)
		return -EINVAL;

	if (period <=3D 0xffff)
		prescaler =3D 0;
	else {
		prescaler =3D (ilog2(period) - 14) / 2;
		BUG_ON(prescaler > 3);
	}

	period >>=3D 2 * prescaler;

	duty =3D clk_rate * duty_ns >> (2 * prescaler) / NSEC_PER_SEC;

(Note: This needs more care to handle overflows, e.g. 0xffff *
NSEC_PER_SEC * 64 doesn't fit into a long, also clk_rate * period_ns
might overflow. I skipped this for the purpose of this mail.)

The code comment "TODO: Pick the highest acceptable prescaler." is
unclear to me, as a smaller prescaler allows more possible settings for
the duty_cycle and I don't see any reason to pick a bigger prescaler.

If we choose to not adapt the behaviour, I suggest to replace

        if (duty_ns) {
                duty =3D clk_rate / prescalers[prescaler]
                     / (NSEC_PER_SEC / duty_ns);
                if (duty > period)
                        return -EINVAL;
        } else {
                duty =3D 0;
        }

by:

	duty =3D clk_rate * duty_ns >> (2 * prescaler) / NSEC_PER_SEC;

(probably using u64 math after asserting that period_ns * clk_rate
doesn't overflow a u64. Then given that duty_ns <=3D period_ns the case
duty > period cannot happen, the special case for duty_ns =3D=3D 0 doesn't
need to be explicitly handled and precision is improved.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--aegnhihdgqyrwamy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFEUQQACgkQwfwUeK3K
7AmZjAf+K6tfnkjU09jiI3HkEAVsrfqpqs/1MtBXERu9SJiPHCPJwznh4hYfvXDP
chx/ZHDCa9jTULG3V0eCprGf8s2ty/i0VEXxhFhoDt3+50ociyl42CvwSTFvEvZb
Pxw16rC+DNPylENeAoNpsUlofBVXRd7VpuoIANJA5nV5WxpMvKRxRnCyP9Z36krl
GiDh6GIs6jM/lPM0NifFsm2OqXZwgKbDLOIr2Ua4dbyzDApj7Y/VZJz6iVVcAbxr
Ce+VVD155Nbkl5m/bcV/lB/wtzJDdxZjOYj5QBbGKZ5ZpXrBhzkOzaUPsT3okipC
AOP7rq0DIs3qxx41FeqBqieJ3l7Enw==
=fxmx
-----END PGP SIGNATURE-----

--aegnhihdgqyrwamy--
