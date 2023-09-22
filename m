Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2B67AB314
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Sep 2023 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjIVNvZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Sep 2023 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjIVNvZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Sep 2023 09:51:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E990E92
        for <linux-pwm@vger.kernel.org>; Fri, 22 Sep 2023 06:51:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjgYu-0008I6-Kh; Fri, 22 Sep 2023 15:51:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjgYt-008BA2-3E; Fri, 22 Sep 2023 15:51:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjgYs-003uUD-Q3; Fri, 22 Sep 2023 15:51:14 +0200
Date:   Fri, 22 Sep 2023 15:51:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     thierry.reding@gmail.com, linux@rasmusvillemoes.dk,
        linux-pwm@vger.kernel.org, rogan@dawes.za.net,
        Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] pwm: mxs: Fix zero duty cycle
Message-ID: <20230922135115.b54nkj4njwjsbsfw@pengutronix.de>
References: <20230922121752.344965-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tfzopaalzx5d7br4"
Content-Disposition: inline
In-Reply-To: <20230922121752.344965-1-festevam@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tfzopaalzx5d7br4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Fabio,

On Fri, Sep 22, 2023 at 09:17:52AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> Currently, when a duty cycle of zero is requested, the PWM stops
> getting updated. This causes the minimal brightness of an LED to not
> turned off completely as expected.
>=20
> For example, driving an LED via led-pwm and running:
>=20
> echo 255 >  /sys/class/leds/red/brightness
>=20
> makes the LED to go to its maximum brightness as expected.
>=20
> After running:
>=20
> echo 0 >  /sys/class/leds/red/brightness
>=20
> The PWM controlled LED does not turn off. Instead, the LED brightness
> stays at its maximum.
>=20
> The reason for this behavior is that when brightness is set to 0,
> state->enabled goes to 0 and the PWM is disabled by setting the
> PWM_CTRL + CLR register.
>=20
> Fix this problem by keeping the PWM controller turned on, even in
> the case when a zero duty cycle is requested.
>=20
> Fixes: bf29c2ff82fd ("pwm: mxs: Implement ->apply()")
> Reported-by: Rogan Dawes <rogan@dawes.za.net>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Tested-by: Rogan Dawes <rogan@dawes.za.net>
> ---
>  drivers/pwm/pwm-mxs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index 766dbc58dad8..f8ad616eaba2 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -65,7 +65,7 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct =
pwm_device *pwm,
>  			return ret;
>  	}
> =20
> -	if (!state->enabled && pwm_is_enabled(pwm))
> +	if (pwm_is_enabled(pwm))
>  		writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
> =20
>  	rate =3D clk_get_rate(mxs->clk);

This patch is wrong. I'll prepare a better fix.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tfzopaalzx5d7br4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUNm9MACgkQj4D7WH0S
/k4HuAf+J2uhL/S4ZKIZstmzqj2OEJDLXrZ7vOtabLqOYDClAu0wMZw0+YziTr9s
o8+ZqCwbu1Cn2CI5sek0YhuFS9PyCkM0UQlQMh+VT83XAIBHC3XZIkqo6CoXZAz7
WoVHjXAnmzshPbGn+TmbIPIpc9ldULc6ilCZvIoZi9vfCyWLb0vcA84ouQkE2/Xw
ABhE2ItczQd40q/mvHhUUQsI00oL3FVnWFrsoINgCQbx7FhGH20LBK+sxZaTXm/W
W2lWaONDbQYRnmV9oM7waqVFZNcI8nrWb5wT0RitCsnGJMEWWHU/+mwuinybLY5a
G6MlkCnpXmlU2JgmLVe2z7XS/etgbQ==
=h416
-----END PGP SIGNATURE-----

--tfzopaalzx5d7br4--
