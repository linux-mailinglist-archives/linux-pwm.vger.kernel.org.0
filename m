Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9584C75F903
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jul 2023 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGXN4M (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jul 2023 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjGXN4B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jul 2023 09:56:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712FD3AB5
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jul 2023 06:54:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qNw1V-0003Lb-N4; Mon, 24 Jul 2023 15:54:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qNw1U-001lwZ-IK; Mon, 24 Jul 2023 15:54:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qNw1T-007Pcl-RK; Mon, 24 Jul 2023 15:54:51 +0200
Date:   Mon, 24 Jul 2023 15:54:51 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-pwm@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux@tycoint.com>
Subject: Re: [bug report] pwm: lpc32xx: Don't modify HW state in .probe()
 after the PWM chip was registered
Message-ID: <20230724135451.w6t5wcqll7dfjw2o@pengutronix.de>
References: <919cac5d-491e-4534-baed-bf813181192d@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ewsfzy5jgkonzx6j"
Content-Disposition: inline
In-Reply-To: <919cac5d-491e-4534-baed-bf813181192d@moroto.mountain>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ewsfzy5jgkonzx6j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dan,

[added a few people who were interested in this driver before]

On Mon, Jul 24, 2023 at 12:30:28PM +0300, Dan Carpenter wrote:
> The patch 3d2813fb17e5: "pwm: lpc32xx: Don't modify HW state in
> .probe() after the PWM chip was registered" from Jul 7, 2021
> (linux-next), leads to the following Smatch static checker warning:
>=20
> 	drivers/pwm/pwm-lpc32xx.c:144 lpc32xx_pwm_probe()
> 	warn: pointer dereferenced without being set 'lpc32xx->chip.pwms'
>=20
> drivers/pwm/pwm-lpc32xx.c
>     121 static int lpc32xx_pwm_probe(struct platform_device *pdev)
>     122 {
>     123         struct lpc32xx_pwm_chip *lpc32xx;
>     124         int ret;
>     125         u32 val;
>     126=20
>     127         lpc32xx =3D devm_kzalloc(&pdev->dev, sizeof(*lpc32xx), GF=
P_KERNEL);
>     128         if (!lpc32xx)
>     129                 return -ENOMEM;
>     130=20
>     131         lpc32xx->base =3D devm_platform_ioremap_resource(pdev, 0);
>     132         if (IS_ERR(lpc32xx->base))
>     133                 return PTR_ERR(lpc32xx->base);
>     134=20
>     135         lpc32xx->clk =3D devm_clk_get(&pdev->dev, NULL);
>     136         if (IS_ERR(lpc32xx->clk))
>     137                 return PTR_ERR(lpc32xx->clk);
>     138=20
>     139         lpc32xx->chip.dev =3D &pdev->dev;
>     140         lpc32xx->chip.ops =3D &lpc32xx_pwm_ops;
>     141         lpc32xx->chip.npwm =3D 1;
>     142=20
>     143         /* If PWM is disabled, configure the output to the defaul=
t value */
> --> 144         val =3D readl(lpc32xx->base + (lpc32xx->chip.pwms[0].hwpw=
m << 2));
>                                              ^^^^^^^^^^^^^^^^^^^^^
> This is a NULL dereference

oh indeed. Given that this was found by a static analysis tool this
probably means noone is using a recent kernel on lpc32xx.

Note that the patch
https://lore.kernel.org/r/20230717155257.2568627-1-u.kleine-koenig@pengutro=
nix.de
fixes this en passant.

(I wasn't aware of this. I didn't look properly and thought
lpc32xx->chip.pwms[0].hwpwm was 0 because of the devm_kzalloc, didn't
notice the pointer dereference.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ewsfzy5jgkonzx6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS+gqoACgkQj4D7WH0S
/k7srAf+MWjasUo7lkX7f7ujIQ4bFopae5LvkHlhtfi8/SENzIUIWdr5KbimXspy
2JJCT/olidRsQZ2e0IBEO9vY4xdSKYSsCKXK6Me9qlAHk/YxkJ/Kb7qqkxYSb3Bl
6rjjlPhNu+Z3KqWVVXeOPzvKueW9CMrx5PezWG7iA2sYf82Xg6FbGTWS20QeSqv7
q3sDn95B01eO03EYNbPPGVDxNW421fR+iMUfIuLL4NilKS4lTy6FmCCPD8wvsvvl
4KCWkZcY21MsdK/eXx1wymLOSHWe+mC2/nWvUdpJzbjy1w3io68pdxU0lngqGXZ1
t7oBT0FopsToJn2cTSl+EnTDqDjhkg==
=7e/a
-----END PGP SIGNATURE-----

--ewsfzy5jgkonzx6j--
