Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C385603ABA
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Oct 2022 09:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiJSHfP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Oct 2022 03:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJSHfO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Oct 2022 03:35:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F7F5973D
        for <linux-pwm@vger.kernel.org>; Wed, 19 Oct 2022 00:35:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3bb-00057p-Ea; Wed, 19 Oct 2022 09:35:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3ba-0003yL-95; Wed, 19 Oct 2022 09:35:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3bZ-00917n-62; Wed, 19 Oct 2022 09:35:09 +0200
Date:   Wed, 19 Oct 2022 09:35:09 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Doug Brown <doug@schmorgal.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 3/5] pwm: pxa: Remove clk enable/disable from
 pxa_pwm_config
Message-ID: <20221019073509.ky26xddaqicvptb7@pengutronix.de>
References: <20221003015546.202308-1-doug@schmorgal.com>
 <20221003015546.202308-4-doug@schmorgal.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="caeaqwm73zttzkkr"
Content-Disposition: inline
In-Reply-To: <20221003015546.202308-4-doug@schmorgal.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--caeaqwm73zttzkkr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 02, 2022 at 06:55:44PM -0700, Doug Brown wrote:
> Now that pxa_pwm_apply always enables the clock first, there is no need
> for pxa_pwm_config to do any clock enabling/disabling.
>=20
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  drivers/pwm/pwm-pxa.c | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index 9ee9b41d62b8..cf4d22c91929 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -64,7 +64,6 @@ static int pxa_pwm_config(struct pwm_chip *chip, struct=
 pwm_device *pwm,
>  	unsigned long long c;
>  	unsigned long period_cycles, prescale, pv, dc;
>  	unsigned long offset;
> -	int rc;
> =20
>  	offset =3D pwm->hwpwm ? 0x10 : 0;
> =20
> @@ -86,18 +85,10 @@ static int pxa_pwm_config(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  	else
>  		dc =3D mul_u64_u64_div_u64(pv + 1, duty_ns, period_ns);
> =20
> -	/* NOTE: the clock to PWM has to be enabled first
> -	 * before writing to the registers
> -	 */
> -	rc =3D clk_prepare_enable(pc->clk);
> -	if (rc < 0)
> -		return rc;
> -
>  	writel(prescale, pc->mmio_base + offset + PWMCR);
>  	writel(dc, pc->mmio_base + offset + PWMDCR);
>  	writel(pv, pc->mmio_base + offset + PWMPCR);
> =20
> -	clk_disable_unprepare(pc->clk);
>  	return 0;
>  }

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--caeaqwm73zttzkkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNPqKoACgkQwfwUeK3K
7AkXZAf7B/dj+mG290sU9U3RNbtH6wdfjStwt1PG5BiEtJ4bxaEtXSN56u5DkdwZ
/yA/8jXt1Wa8sBXzSILmO9c35EP9l143O9wDT4GceAL2TDg0qKQvKxOZA9DvQZvF
D85kLrm17cFYm4Rl7wnf0jEDyDvBrq175WE/B0l9rvyMk/beb3sQINmdVJ++kSfS
zFsAq4kVPYut99g9+JvA9X2mXola6az/oWGKRJlYS67K1+IzxL3t6IlJtYOwhHCY
DEY450P/+Imko7B3ldqMjMAgTFEdDeLB1az7S+AvNtvUf4q8IFrUNjL7WmGoFe6J
yBpVQ9z2bYXfHOlohrB4fLKwFy1rtg==
=a0rE
-----END PGP SIGNATURE-----

--caeaqwm73zttzkkr--
