Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C8A5F23C2
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Oct 2022 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJBPEt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Oct 2022 11:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJBPEs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Oct 2022 11:04:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EFDFD1C
        for <linux-pwm@vger.kernel.org>; Sun,  2 Oct 2022 08:04:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1of0WI-0002GX-4Q; Sun, 02 Oct 2022 17:04:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1of0WI-004CQb-Kr; Sun, 02 Oct 2022 17:04:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1of0WF-0056Bi-PH; Sun, 02 Oct 2022 17:04:39 +0200
Date:   Sun, 2 Oct 2022 17:04:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Doug Brown <doug@schmorgal.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: pxa: Enable clock before applying config
Message-ID: <20221002150436.mhtdv56tjfaxdfbc@pengutronix.de>
References: <20221002061552.45479-1-doug@schmorgal.com>
 <20221002061552.45479-2-doug@schmorgal.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uwlqodbylxbwhsui"
Content-Disposition: inline
In-Reply-To: <20221002061552.45479-2-doug@schmorgal.com>
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


--uwlqodbylxbwhsui
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Doug,

On Sat, Oct 01, 2022 at 11:15:51PM -0700, Doug Brown wrote:
> The clock has to be on before we can apply the config anyway, so there
> is no need to turn the clock on, off, and back on again.
>=20
> This fixes an issue discovered on the PXA168 where sometimes the PWM
> output doesn't activate properly if the clock is turned off and back on
> too quickly. Removing the on/off/on sequence eliminates the problem.
>=20
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  drivers/pwm/pwm-pxa.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index 0bcaa58c6a91..208c32c79453 100644
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
> @@ -86,18 +85,11 @@ static int pxa_pwm_config(struct pwm_chip *chip, stru=
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
> +	/* Clock is required here. We can assume it's already on. */
>  	writel(prescale, pc->mmio_base + offset + PWMCR);
>  	writel(dc, pc->mmio_base + offset + PWMDCR);
>  	writel(pv, pc->mmio_base + offset + PWMPCR);
> =20
> -	clk_disable_unprepare(pc->clk);
>  	return 0;
>  }
> =20
> @@ -130,12 +122,17 @@ static int pxa_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  		return 0;
>  	}
> =20
> +	if (!pwm->state.enabled) {
> +		err =3D pxa_pwm_enable(chip, pwm);
> +		if (err)
> +			return err;
> +	}

First, would you mind adding a first patch that just replaces
pxa_pwm_enable() by clk_prepare_enable(pc->clk) and pxa_pwm_disable() by
clk_disable_unprepare(pc->clk)? Given that the dedicated .enable() and
=2Edisable() callbacks are not needed any more, this would simplify the
driver a bit.

Then I think to understand that you need the clk enabled for operating
the output and for register access, right? I'm not sure, but after the
above change it might be simpler/more efficient to enable the clk here
unconditionally (and adapt the end of the function accordingly).

>  	err =3D pxa_pwm_config(chip, pwm, state->duty_cycle, state->period);
> -	if (err)
> +	if (err) {
> +		pxa_pwm_disable(chip, pwm);
>  		return err;
> -
> -	if (!pwm->state.enabled)
> -		return pxa_pwm_enable(chip, pwm);
> +	}

If there is a transistion say from:

	.period =3D A, .duty_cycle =3D B, .enabled =3D false

to

	.period =3D C, .duty_cycle =3D D, .enabled =3D true

can it happen that you (shortly) see A and B on the wire? (I think this
is orthogonal to this patch and happens with and without it.) If so it
might be prudent do configure duty_cycle =3D 0 for the .enabled =3D false
case.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uwlqodbylxbwhsui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM5qIEACgkQwfwUeK3K
7AlKYQgAnjVVHNALfJIg9bZuBJicGQDOO0CjXJzOU/Np0smpc0XUi9r2YgKx2xRD
jNAtfg51Jy3Z7eJJcdTUuSB4z+VkeoKyHx1msBneIrkWeBFclp2jPIQA4r5MCy+o
iXdedLF/UYAetyqZmIbxkQT6lGj39NOglGXRZo+8BJUI+LVq0a/Zn86XewmqpV8l
DNEwTWTqiainFnfufBdDLTAeOJ19FRP4RRbQMtdlp/cR0ZCltBHxj3XduG/prsUW
vpXkBH1EnbpcPetu1nsBHa7G7AZCmZ/cizMEs/1+NkQzkYHsDsFwOlMMfbFieQy0
jnBriw1SnrsncYsnSB1gOMvhIKwz6g==
=5nZY
-----END PGP SIGNATURE-----

--uwlqodbylxbwhsui--
