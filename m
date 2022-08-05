Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7980C58B0FE
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Aug 2022 23:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbiHEVGO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Aug 2022 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiHEVGN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Aug 2022 17:06:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6671DA58
        for <linux-pwm@vger.kernel.org>; Fri,  5 Aug 2022 14:06:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oK4W9-0008E0-Mn; Fri, 05 Aug 2022 23:06:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oK4W4-001y6B-0p; Fri, 05 Aug 2022 23:05:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oK4W5-009nqE-KW; Fri, 05 Aug 2022 23:05:57 +0200
Date:   Fri, 5 Aug 2022 23:05:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 2/2] pwm: Add support for RZ/G2L GPT
Message-ID: <20220805210554.czafwmpq46prlfx7@pengutronix.de>
References: <20220805145704.951293-1-biju.das.jz@bp.renesas.com>
 <20220805145704.951293-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="frtvesny3b7u6mej"
Content-Disposition: inline
In-Reply-To: <20220805145704.951293-3-biju.das.jz@bp.renesas.com>
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


--frtvesny3b7u6mej
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Aug 05, 2022 at 03:57:04PM +0100, Biju Das wrote:
> +#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE)
> +#define RZG2L_GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH \
> +	(RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE | RZG2L_GTIOR_OAE)
> +#define RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	((RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE << 16) | RZG2L_GTIOR_OBE)

FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE)

> +#define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
> +	((RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE << 16) | RZG2L_GTIOR_OBE)
> +
> [...]
> +static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
> +				   u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	prescaled_period_cycles =3D period_cycles >> 32;
> +
> +	if (prescaled_period_cycles >=3D 256)
> +		prescale =3D 5;
> +	else
> +		prescale =3D (roundup_pow_of_two(prescaled_period_cycles + 1) + 1) / 2;

I double checked, this looks correct to me.

> +
> +	return prescale;
> +}
> +
> [...]
> +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	struct rzg2l_gpt_pwm_device *gpt =3D &rzg2l_gpt->gpt[pwm->hwpwm];
> +	unsigned long pv, dc;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u8 prescale;
> +
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> +	 * calculation.
> +	 */
> +	if (rzg2l_gpt->rate > NSEC_PER_SEC)
> +		return -EINVAL;
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, so prescale and period
> +	 * can NOT be modified when there are multiple channels in use with
> +	 * different settings.
> +	 */
> +	if (state->period !=3D rzg2l_gpt->real_period && rzg2l_gpt->user_count =
> 1)
> +		return -EBUSY;

Optional improvement here: If a period of (say) 100000 ns is requested the
hardware might likely actually implement 99875 ns. As
rzg2l_gpt->real_period corresponds to the requested period (is that a
misnomer?) you could accept state->period =3D 99900.

Accepting state->period >=3D rzg2l_gpt->real_period is fine.

> +
> +	period_cycles =3D mul_u64_u32_div(state->period, rzg2l_gpt->rate, NSEC_=
PER_SEC);
> +	prescale =3D rzg2l_calculate_prescale(rzg2l_gpt, period_cycles);
> +
> +	pv =3D period_cycles >> (2 * prescale);

If period_cycles is >=3D (1024 << 32), we get prescale =3D 5 and so
period_cycles >> (2 * prescale) doesn't fit into 32 bits. This needs
handling.

> +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rzg2l_gpt->rate, NSE=
C_PER_SEC);
> +	dc =3D duty_cycles >> (2 * prescale);
> +
> +	/* Counter must be stopped before modifying Mode and Prescaler */
> +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> +		rzg2l_gpt_disable(rzg2l_gpt);

Does this affect the other channel? If yes, that's a bad thing and it
might be worth to improve here.

> +	/* GPT set operating mode (saw-wave up-counting) */
> +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR,
> +			 RZG2L_GTCR_MD, RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> +
> +	/* Set count direction */
> +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
> +
> +	rzg2l_gpt->real_period =3D state->period;
> +	/* Select count clock */
> +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_TPCS,
> +			 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> +
> +	/* Set period */
> +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR, pv);
> +
> +	/* Set duty cycle */
> +	rzg2l_gpt_write(rzg2l_gpt, gpt->ph->duty_reg_offset, dc);
> +
> +	/* Set initial value for counter */
> +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT, 0);
> +
> +	/* Set no buffer operation */
> +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER, 0);
> +
> +	/* Enable pin output */
> +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR, gpt->ph->mask, gpt->ph->value);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	struct rzg2l_gpt_pwm_device *gpt =3D &rzg2l_gpt->gpt[pwm->hwpwm];
> +	u8 prescale;
> +	u64 tmp;
> +	u32 val;
> +
> +	/* get period */
> +	state->period =3D rzg2l_gpt->real_period;
> +
> +	pm_runtime_get_sync(chip->dev);
> +	val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR);
> +	state->enabled =3D val & RZG2L_GTCR_CST;
> +	if (state->enabled) {
> +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR);
> +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> +		state->period =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate);
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, gpt->ph->duty_reg_offset);

I still wonder if this is really better/more effective/easier to
understand than just:

/* These are actually called GTCCRA and GTCCRB */
#define RZG2L_GTCCR(i) (0x4c + 4 * (i))

plus

	val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(pwm->hwpwm));

=09
> +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate);
> +		/*
> +		 * Ordering is important, when we set a period for the second
> +		 * channel, as pwm_request_from_chip() calling get_state() will
> +		 * have an invalid duty cycle value as the register is not
> +		 * initialized yet. So set duty_cycle to zero.

I don't understand that issue. Can you just drop the check
"rzg2l_gpt->user_count > 1"?

If you configure channel #0 while channel #1 is still untouched (in
software), does this modify the output of channel #1?

> +		 */
> +		if (state->duty_cycle > state->period &&
> +		    rzg2l_gpt->user_count > 1)
> +			state->duty_cycle =3D 0;

Does this setting (i.e. GTCCR{A,B} > GTPR) correspond to a 100% relative
duty cycle?

> +	}
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	pm_runtime_put(chip->dev);
> +}
> +
> +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	pm_runtime_get_sync(chip->dev);
> +	if (!state->enabled) {
> +		rzg2l_gpt_disable(rzg2l_gpt);
> +		ret =3D 0;
> +		goto done;
> +	}
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	ret =3D rzg2l_gpt_config(chip, pwm, state);
> +	mutex_unlock(&rzg2l_gpt->lock);
> +	if (ret)
> +		goto done;
> +
> +	return rzg2l_gpt_enable(rzg2l_gpt);
> +
> +done:
> +	pm_runtime_put(chip->dev);
> +
> +	return ret;
> +}
> +
> +static const struct pwm_ops rzg2l_gpt_ops =3D {
> +	.request =3D rzg2l_gpt_request,
> +	.free =3D rzg2l_gpt_free,
> +	.get_state =3D rzg2l_gpt_get_state,
> +	.apply =3D rzg2l_gpt_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static const struct of_device_id rzg2l_gpt_of_table[] =3D {
> +	{ .compatible =3D "renesas,rzg2l-gpt", },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
> +
> +static void rzg2l_gpt_reset_assert_pm_disable(void *data)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D data;
> +
> +	pm_runtime_disable(rzg2l_gpt->chip.dev);
> +	reset_control_assert(rzg2l_gpt->rstc);
> +}
> +
> +static int rzg2l_gpt_probe(struct platform_device *pdev)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt;
> +	struct clk *clk;
> +	int ret, i;
> +
> +	rzg2l_gpt =3D devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt), GFP_KERNEL);
> +	if (!rzg2l_gpt)
> +		return -ENOMEM;
> +
> +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rzg2l_gpt->mmio))
> +		return PTR_ERR(rzg2l_gpt->mmio);
> +
> +	rzg2l_gpt->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> +				     "get reset failed\n");
> +
> +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot deassert reset control\n");
> +
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rzg2l_gpt_reset_assert_pm_disable,
> +				       rzg2l_gpt);
> +	if (ret < 0)
> +		return ret;
> +
> +	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> +				     "cannot get clock\n");
> +
> +	rzg2l_gpt->rate =3D clk_get_rate(clk);
> +	/*
> +	 *  We need to keep the clock on, in case the bootloader enabled PWM and
> +	 *  is running during probe().
> +	 */
> +	if (!(rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST))
> +		devm_clk_put(&pdev->dev, clk);

I still think this looks wrong. Please at least comment about the idea
here. ie. devm_clk_put disables the clk and holding a reference on the
clk isn't needed because runtime-pm handles the needed enabling.

Is this really true? Does runtime-pm disable the clk if after the clk
wasn't put here both PWMs are disabled?

> +	mutex_init(&rzg2l_gpt->lock);
> +
> +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> +	rzg2l_gpt->chip.npwm =3D 2;
> +	for (i =3D 0; i < rzg2l_gpt->chip.npwm; i++)
> +		rzg2l_gpt->gpt[i].ph =3D &rzg2l_gpt_phase_params[i];
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
> +	if (ret)
> +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +
> +	return ret;
> +}
> +
> +static struct platform_driver rzg2l_gpt_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-rzg2l-gpt",
> +		.of_match_table =3D of_match_ptr(rzg2l_gpt_of_table),
> +	},
> +	.probe =3D rzg2l_gpt_probe,
> +};
> +module_platform_driver(rzg2l_gpt_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT) Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:pwm-rzg2l-gpt");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--frtvesny3b7u6mej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLthi8ACgkQwfwUeK3K
7AlDuwf+OIveqFtJ4KFSfKbDV2nF4BC65kqO03XRjmRkuXS1D2jPx87c8uQDe0j9
mLwLH5+1Uh7J+7paZWQt/fOA2d7CgCV5CBAPlJTckncdqvi/Dx9A+Jmho0tRU0+x
QJr2UUQSRu/gkSI3HyHekvye23O58BhKQmNC2RFF0NYdD73h27k6bmKIJDaIsE4H
KGNpkD7NPZX4jF5JLLsNrIe5pbsHB41dKFXt5jSN9r4n7TWu9LB6cbSu9pzNqnud
e73/Uxor9k+W8FOtOh5H7ld2C5SysrXxHhAEClwCbyyNskVL1Q0Z2QzCGqrQk4Fk
M1HWFdHKyzP24j9y6Bsa4oQh6QsZ1A==
=hmz2
-----END PGP SIGNATURE-----

--frtvesny3b7u6mej--
