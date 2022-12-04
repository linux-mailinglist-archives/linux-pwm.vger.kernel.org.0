Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944DD641FBB
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Dec 2022 22:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiLDVEY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 4 Dec 2022 16:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiLDVEY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 4 Dec 2022 16:04:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C0F5A1
        for <linux-pwm@vger.kernel.org>; Sun,  4 Dec 2022 13:04:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1w9h-0003xM-4R; Sun, 04 Dec 2022 22:04:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1w9c-002JYK-Rs; Sun, 04 Dec 2022 22:04:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1w9c-002aKh-Nm; Sun, 04 Dec 2022 22:04:04 +0100
Date:   Sun, 4 Dec 2022 22:04:01 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] leds: qcom-lpg: Propagate errors in
 .get_state() to the caller
Message-ID: <20221204210401.eij5vujwnekjtxch@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zgjjjl7tfyxxlf2o"
Content-Disposition: inline
In-Reply-To: <20221130152148.2769768-5-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zgjjjl7tfyxxlf2o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

On Wed, Nov 30, 2022 at 04:21:41PM +0100, Uwe Kleine-K=F6nig wrote:
> .get_state() can return an error indication. Make use of it to propagate
> failing hardware accesses.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qco=
m-lpg.c
> index 741cc2fd817d..0dcc046a9a19 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -982,20 +982,20 @@ static int lpg_pwm_get_state(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> =20
>  	ret =3D regmap_read(lpg->map, chan->base + LPG_SIZE_CLK_REG, &val);
>  	if (ret)
> -		return 0;
> +		return ret;
> =20
>  	refclk =3D lpg_clk_rates[val & PWM_CLK_SELECT_MASK];
>  	if (refclk) {
>  		ret =3D regmap_read(lpg->map, chan->base + LPG_PREDIV_CLK_REG, &val);
>  		if (ret)
> -			return 0;
> +			return ret;
> =20
>  		pre_div =3D lpg_pre_divs[FIELD_GET(PWM_FREQ_PRE_DIV_MASK, val)];
>  		m =3D FIELD_GET(PWM_FREQ_EXP_MASK, val);
> =20
>  		ret =3D regmap_bulk_read(lpg->map, chan->base + PWM_VALUE_REG, &pwm_va=
lue, sizeof(pwm_value));
>  		if (ret)
> -			return 0;
> +			return ret;
> =20
>  		state->period =3D DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * LPG_RESOLUTION =
* pre_div * (1 << m), refclk);
>  		state->duty_cycle =3D DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * pwm_value *=
 pre_div * (1 << m), refclk);
> @@ -1006,7 +1006,7 @@ static int lpg_pwm_get_state(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> =20
>  	ret =3D regmap_read(lpg->map, chan->base + PWM_ENABLE_CONTROL_REG, &val=
);
>  	if (ret)
> -		return 0;
> +		return ret;
> =20
>  	state->enabled =3D FIELD_GET(LPG_ENABLE_CONTROL_OUTPUT, val);
>  	state->polarity =3D PWM_POLARITY_NORMAL;

It would be great to get an Ack from you for this patch and the led part
of patch 1 to take it via the PWM tree.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zgjjjl7tfyxxlf2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmONCz4ACgkQwfwUeK3K
7AkmMAf/TzKIWdmNQVQbrEXS1/7yj2YkiYIGwvVSUmmCycAxkefl8iR8/m2onSG7
X+cAmKKT5DHBK02vG/25wgCClDOZZNjnO0RF1zHB8rv0yC92/XXz1lJOjm5WcX4c
hWakX+7p6KpZOgIySi8fIYCeMc6M/ElwDTILCpqqPecjuN0nAOOTGK/llxkWE+Mj
EGatDmXZozpnrtnxSxez+b2wJD3HwNuxELLQUUrKULfjV+hQ5tmMBysSK70i12Ts
CR7G8MOWstUs6GcpzhCsPIwosMMiilHpC7gx5yrVuTSwhc1xb7mWxVqIc1RZ+ChA
0sQxUJR2CEsxpWtTWDBALMSQhZflrA==
=Pfei
-----END PGP SIGNATURE-----

--zgjjjl7tfyxxlf2o--
