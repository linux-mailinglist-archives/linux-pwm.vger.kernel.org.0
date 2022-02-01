Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08CD4A5868
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Feb 2022 09:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiBAITS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Feb 2022 03:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiBAITS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Feb 2022 03:19:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6CC061714
        for <linux-pwm@vger.kernel.org>; Tue,  1 Feb 2022 00:19:18 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nEoNf-0005zp-8K; Tue, 01 Feb 2022 09:19:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nEoNe-00DnNP-9I; Tue, 01 Feb 2022 09:19:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nEoNc-002kwL-Pe; Tue, 01 Feb 2022 09:19:12 +0100
Date:   Tue, 1 Feb 2022 09:19:12 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de, Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 1/3] pwm: lpc18xx-sct: Initialize driver data and
 hardware before pwmchip_add()
Message-ID: <20220201081912.wl44iqrpfbe6gzlz@pengutronix.de>
References: <20211110084950.1053426-1-u.kleine-koenig@pengutronix.de>
 <YfjljnMC1AfJCNvA@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="32dosboc3um7si33"
Content-Disposition: inline
In-Reply-To: <YfjljnMC1AfJCNvA@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--32dosboc3um7si33
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 01, 2022 at 08:47:26AM +0100, Thierry Reding wrote:
> On Wed, Nov 10, 2021 at 09:49:48AM +0100, Uwe Kleine-K=F6nig wrote:
> > When a driver calls pwmchip_add() it has to be prepared to immediately
> > get its callbacks called. So move allocation of driver data and hardware
> > initialization before the call to pwmchip_add().
> >=20
> > This fixes a potential NULL pointer exception and a race condition on
> > register writes.
> >=20
> > Fixes: 841e6f90bb78 ("pwm: NXP LPC18xx PWM/SCT driver")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-lpc18xx-sct.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sc=
t.c
> > index 8e461f3baa05..8cc8ae16553c 100644
> > --- a/drivers/pwm/pwm-lpc18xx-sct.c
> > +++ b/drivers/pwm/pwm-lpc18xx-sct.c
> > @@ -395,12 +395,6 @@ static int lpc18xx_pwm_probe(struct platform_devic=
e *pdev)
> >  	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_LIMIT,
> >  			   BIT(lpc18xx_pwm->period_event));
> > =20
> > -	ret =3D pwmchip_add(&lpc18xx_pwm->chip);
> > -	if (ret < 0) {
> > -		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
> > -		goto disable_pwmclk;
> > -	}
> > -
> >  	for (i =3D 0; i < lpc18xx_pwm->chip.npwm; i++) {
> >  		struct lpc18xx_pwm_data *data;
> > =20
> > @@ -410,14 +404,12 @@ static int lpc18xx_pwm_probe(struct platform_devi=
ce *pdev)
> >  				    GFP_KERNEL);
> >  		if (!data) {
> >  			ret =3D -ENOMEM;
> > -			goto remove_pwmchip;
> > +			goto disable_pwmclk;
> >  		}
> > =20
> >  		pwm_set_chip_data(pwm, data);
> >  	}
> > =20
> > -	platform_set_drvdata(pdev, lpc18xx_pwm);
> > -
> >  	val =3D lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
> >  	val &=3D ~LPC18XX_PWM_BIDIR;
> >  	val &=3D ~LPC18XX_PWM_CTRL_HALT;
> > @@ -425,10 +417,16 @@ static int lpc18xx_pwm_probe(struct platform_devi=
ce *pdev)
> >  	val |=3D LPC18XX_PWM_PRE(0);
> >  	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL, val);
> > =20
> > +	ret =3D pwmchip_add(&lpc18xx_pwm->chip);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
> > +		goto disable_pwmclk;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, lpc18xx_pwm);
>=20
> Is there any particular reason why this needs to move? The driver only
> call platform_get_drvdata() from the ->remove() implementation at this
> point, so this should be fine, but it's possible that it would at some
> future point try to access this data from some code path that may get
> called as part of pwmchip_add(), so doing this prior to chip addition
> may be a better option.
>=20
> No need to resend, I can fix that up as I apply if there are no strong
> reasons to keep this after pwmchip_add().

What I actually did was:

 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_LIMIT,
 			   BIT(lpc18xx_pwm->period_event));
=20
+	for (i =3D 0; i < lpc18xx_pwm->chip.npwm; i++) {
+		struct lpc18xx_pwm_data *data;
+
+		pwm =3D &lpc18xx_pwm->chip.pwms[i];
+
+		data =3D devm_kzalloc(lpc18xx_pwm->dev, sizeof(*data),
+				    GFP_KERNEL);
+		if (!data) {
+			ret =3D -ENOMEM;
+			goto disable_pwmclk;
+		}
+
+		pwm_set_chip_data(pwm, data);
+	}
+
+	val =3D lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
+	val &=3D ~LPC18XX_PWM_BIDIR;
+	val &=3D ~LPC18XX_PWM_CTRL_HALT;
+	val &=3D ~LPC18XX_PWM_PRE_MASK;
+	val |=3D LPC18XX_PWM_PRE(0);
+	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL, val);
+
 	ret =3D pwmchip_add(&lpc18xx_pwm->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
 		goto disable_pwmclk;
 	}
=20
-	for (i =3D 0; i < lpc18xx_pwm->chip.npwm; i++) {
-		struct lpc18xx_pwm_data *data;
-
-		pwm =3D &lpc18xx_pwm->chip.pwms[i];
-
-		data =3D devm_kzalloc(lpc18xx_pwm->dev, sizeof(*data),
-				    GFP_KERNEL);
-		if (!data) {
-			ret =3D -ENOMEM;
-			goto remove_pwmchip;
-		}
-
-		pwm_set_chip_data(pwm, data);
-	}
-
 	platform_set_drvdata(pdev, lpc18xx_pwm);
=20
-	val =3D lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
-	val &=3D ~LPC18XX_PWM_BIDIR;
-	val &=3D ~LPC18XX_PWM_CTRL_HALT;
-	val &=3D ~LPC18XX_PWM_PRE_MASK;
-	val |=3D LPC18XX_PWM_PRE(0);
-	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL, val);
-
 	return 0;
=20
-remove_pwmchip:
-	pwmchip_remove(&lpc18xx_pwm->chip);
 disable_pwmclk:
 	clk_disable_unprepare(lpc18xx_pwm->pwm_clk);
 	return ret;
 }


and git simplified that making it look as if platform_set_drvdata was
moved.

Best regards
Uwe
--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--32dosboc3um7si33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmH47P0ACgkQwfwUeK3K
7AnfkAf/S8xnU8Ggdh9GHbPerfbULmF1B3ILVGZ6grxe9yAjxP7si+gGBUEtY/b2
7Yxk7QZo3kLwSYo9z3OcqtVbTVh7LjomPfCQlxyIbnCaVY31bIewAMLIV3KTi0AL
ti/KKL9VqXKaDBTfDRBL3Udut5+4UoZN2Tn7U5u6yCf2Z8VHqDEFYDbSgc5FNGQX
WiPmLrdYJyVdR3aIf0hELdStr/mytxHkTE6u7VWDU1h0pw2icdO/JBpOS61LSnhP
WuHYryXy1mIl2Z9o7/RqNqBxP0l+s0XL0Kj9qS0/aNh4c5g3kuQReQV7PCDxPvAR
19yI/UWDsWsgyA0Rgznjw6qH45mseA==
=hcme
-----END PGP SIGNATURE-----

--32dosboc3um7si33--
