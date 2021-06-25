Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36D3B4438
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhFYNRy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 09:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhFYNRv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Jun 2021 09:17:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE40C061574
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jun 2021 06:15:30 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwlfz-0008VS-Qv; Fri, 25 Jun 2021 15:15:19 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwlfw-0006nK-Sv; Fri, 25 Jun 2021 15:15:16 +0200
Date:   Fri, 25 Jun 2021 15:15:16 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH v9 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <20210625131516.qw3ig6dvmp4ftzos@pengutronix.de>
References: <20210623035039.772660-1-bjorn.andersson@linaro.org>
 <20210623035039.772660-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="urhwmfrrttawmmmp"
Content-Disposition: inline
In-Reply-To: <20210623035039.772660-2-bjorn.andersson@linaro.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--urhwmfrrttawmmmp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On Tue, Jun 22, 2021 at 08:50:39PM -0700, Bjorn Andersson wrote:
> +static const unsigned int lpg_clk_rates[] =3D {1024, 32768, 19200000};
> +static const unsigned int lpg_pre_divs[] =3D {1, 3, 5, 6};
> +
> +static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
> +{
> +	unsigned int clk, best_clk =3D 0;
> +	unsigned int div, best_div =3D 0;
> +	unsigned int m, best_m =3D 0;
> +	unsigned int error;
> +	unsigned int best_err =3D UINT_MAX;
> +	u64 denom;
> +	u64 best_period =3D 0;
> +	u64 actual;
> +	u64 ratio;
> +	u64 nom;
> +
> +	/*
> +	 * The PWM period is determined by:
> +	 *
> +	 *          resolution * pre_div * 2^M
> +	 * period =3D --------------------------
> +	 *                   refclk
> +	 *
> +	 * With resolution fixed at 2^9 bits, pre_div =3D {1, 3, 5, 6} and
> +	 * M =3D [0..7].
> +	 *
> +	 * This allows for periods between 27uS and 381s, as the PWM framework
> +	 * wants a period of equal or lower length than requested, reject
> +	 * anything below 27uS.
> +	 */
> +	if (period <=3D (u64)NSEC_PER_SEC * LPG_RESOLUTION / 19200000)
> +		return -EINVAL;
> +
> +	/* Limit period to largest possible value, to avoid overflows */
> +	if (period > 381 * (u64)NSEC_PER_SEC)
> +		period =3D 381 * (u64)NSEC_PER_SEC;

Where does the magic 381 come from? This would be more obviously correct
if you write out the formula as you did for the check above.

> +	/*
> +	 * Search for the pre_div, clk and M by solving the rewritten formula
> +	 * for each clk and pre_div value:
> +	 *
> +	 *                       period * clk
> +	 * M =3D log2 -------------------------------------
> +	 *           NSEC_PER_SEC * pre_div * resolution
> +	 */
> +	for (clk =3D 0; clk < ARRAY_SIZE(lpg_clk_rates); clk++) {
> +		nom =3D period * lpg_clk_rates[clk];

nom is only used in this block, so the declaration can be put in here,
too. Ditto for at least ratio and actual.

> +
> +		for (div =3D 0; div < ARRAY_SIZE(lpg_pre_divs); div++) {
> +			denom =3D (u64)NSEC_PER_SEC * lpg_pre_divs[div] * (1 << 9);
> +
> +			if (nom < denom)
> +				continue;
> +
> +			ratio =3D div64_u64(nom, denom);
> +			m =3D ilog2(ratio);
> +			if (m > LPG_MAX_M)
> +				m =3D LPG_MAX_M;
> +
> +			actual =3D DIV_ROUND_UP_ULL(denom * (1 << m), lpg_clk_rates[clk]);
> +
> +			error =3D period - actual;
> +			if (error < best_err) {
> +				best_err =3D error;
> +
> +				best_div =3D div;
> +				best_m =3D m;
> +				best_clk =3D clk;
> +				best_period =3D actual;
> +			}
> +		}
> +	}
> +
> +	chan->clk =3D best_clk;
> +	chan->pre_div =3D best_div;
> +	chan->pre_div_exp =3D best_m;
> +	chan->period =3D best_period;
> +
> +	return 0;
> +}
> +
> +static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
> +{
> +	unsigned int max =3D LPG_RESOLUTION - 1;
> +	unsigned int val =3D div_u64(duty * max, chan->period);

You're losing precision here as chan->period is a rounded value.

duty * max might overflow.

> +	chan->pwm_value =3D min(val, max);
> +}
> [...]
> +static void lpg_apply(struct lpg_channel *chan)
> +{
> +	lpg_disable_glitch(chan);

Why do you have to do this?

> +	lpg_apply_freq(chan);
> +	lpg_apply_pwm_value(chan);
> +	lpg_apply_control(chan);
> +	lpg_apply_sync(chan);
> +	lpg_apply_lut_control(chan);
> +	lpg_enable_glitch(chan);
> +}
> [...]
> +/*
> + * Limitations:
> + * - Updating both duty and period is not done atomically, so the output=
 signal
> + *   will momentarily be a mix of the settings.
> + */
> +static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct lpg *lpg =3D container_of(chip, struct lpg, pwm);
> +	struct lpg_channel *chan =3D &lpg->channels[pwm->hwpwm];
> +	int ret;
> +

You have to care for state->polarity here.

> +	ret =3D lpg_calc_freq(chan, state->period);
> +	if (ret < 0)
> +		return ret;
> +
> +	lpg_calc_duty(chan, state->duty_cycle);
> +	chan->enabled =3D state->enabled;
> +
> +	lpg_apply(chan);
> +
> +	triled_set(lpg, chan->triled_mask, chan->enabled ? chan->triled_mask : =
0);
> +
> +	return 0;
> +}
> [...]
> +static int lpg_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	struct lpg *lpg;
> +	int ret;
> +	int i;
> +
> +	lpg =3D devm_kzalloc(&pdev->dev, sizeof(*lpg), GFP_KERNEL);
> +	if (!lpg)
> +		return -ENOMEM;
> +
> +	lpg->data =3D of_device_get_match_data(&pdev->dev);
> +	if (!lpg->data)
> +		return -EINVAL;
> +
> +	lpg->dev =3D &pdev->dev;
> +
> +	lpg->map =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!lpg->map) {
> +		dev_err(&pdev->dev, "parent regmap unavailable\n");
> +		return -ENXIO;
> +	}
> +
> +	ret =3D lpg_init_channels(lpg);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D lpg_parse_dtest(lpg);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D lpg_init_triled(lpg);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D lpg_init_lut(lpg);
> +	if (ret < 0)
> +		return ret;
> +
> +	for_each_available_child_of_node(pdev->dev.of_node, np) {
> +		ret =3D lpg_add_led(lpg, np);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i =3D 0; i < lpg->num_channels; i++)
> +		lpg_apply_dtest(&lpg->channels[i]);

I wonder what all these register initialisations do. You should not do
anything that modifies the PWM output here that the bootloader might
have setup. Is this given?

> +
> +	ret =3D lpg_add_pwm(lpg);

The patch would be easier to review if you split it into a led part and
a pwm part. Then the responsibilities would be more clear, too.

> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, lpg);
> +
> +	return 0;

If you do the platform_set_drvdata() earlier you can just

	return ret;

here.

> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--urhwmfrrttawmmmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDV1t8ACgkQwfwUeK3K
7AmAtwf/c17eW42kzb7FB0diljMy2ariD9OysT3gu7h1RVCmn8TveFAhfHEikYGm
iORU9fbX/Hp8qMj7o0uyg/X4zJSuIkeZ4sMhdrtiaguPI+PWnvDvUJKqBxMy/0fu
xVQZTeOYvpvdZpLg6UZgBcLpGXw95KJc3ErUmEZX7kc3RlqtK2Xteug1LZgMa0OZ
+/l/7u4efQvVbwtBFKSzjUFW3/UizxNYh/xRokccQntt3yf44Gp9+F40R/fWEHC/
uYc7f8PcsJBWiCmIkv/6w9q290UsXQKB8c0gwaV4AkkMdZHjz+wSpASxYeiLadUV
LkfsIvB4j0Q8IgcVWyWLnd/EbwBKRA==
=0hd9
-----END PGP SIGNATURE-----

--urhwmfrrttawmmmp--
