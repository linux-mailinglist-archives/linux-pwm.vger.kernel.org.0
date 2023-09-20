Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E494E7A8E43
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Sep 2023 23:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjITVND (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Sep 2023 17:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjITVNC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Sep 2023 17:13:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AACDC9
        for <linux-pwm@vger.kernel.org>; Wed, 20 Sep 2023 14:12:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qj4VB-00035p-CC; Wed, 20 Sep 2023 23:12:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qj4V9-007mBu-3a; Wed, 20 Sep 2023 23:12:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qj4V8-003Pvx-QG; Wed, 20 Sep 2023 23:12:50 +0200
Date:   Wed, 20 Sep 2023 23:12:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v15 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <20230920211250.ifzt7vlpl5phjhpu@pengutronix.de>
References: <20230721060840.8546-1-biju.das.jz@bp.renesas.com>
 <20230721060840.8546-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="me5u4pyyx2wczdef"
Content-Disposition: inline
In-Reply-To: <20230721060840.8546-4-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--me5u4pyyx2wczdef
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

sorry it took so long until you got feedback.

On Fri, Jul 21, 2023 at 07:08:39AM +0100, Biju Das wrote:
> [...]
> +static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(chip->dev);
> +	if (rc)
> +		return rc;
> +
> +	state->enabled =3D rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
> +	if (state->enabled) {
> +		u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +		u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +		u8 prescale;
> +		u64 tmp;
> +		u32 val;
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTPR);
> +		tmp =3D NSEC_PER_SEC * (u64)val;
> +		state->period =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate) << (2 * presc=
ale);

You're loosing precision here. If for example we have: GTPR =3D 0xf, TPCS =
=3D 5 and
rzg2l_gpt->rate =3D 26000000, the output wave's period is:

	period =3D 0xf * 1000000000 / 26000000 << 10

The exact value is 590769.2307692308, so the right value to return is
590770. However your calculation yields 590848.

The problem is that the rounded value is further processed. Maybe we
need a function mul_u64_u64_div_u64_roundup(), or do you see a clever
alternative?

> +		val =3D rzg2l_gpt_read(rzg2l_gpt,
> +				     offs + RZG2L_GTCCR(RZG2L_IS_IOB(pwm->hwpwm)));
> +
> +		tmp =3D NSEC_PER_SEC * (u64)val;
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate) << (2 * p=
rescale);
> +
> +		if (state->duty_cycle > state->period)
> +			state->duty_cycle =3D state->period;
> +	}
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 pre=
scale)
> +{
> +	return min(period_or_duty_cycle >> (2 * prescale), (u64)U32_MAX);
> +}
> +

Maybe mention in a comment here that rzg2l_gpt_config() is only called
holding the lock?

> +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +	unsigned long pv, dc;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u8 prescale;
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, so prescale and period
> +	 * can NOT be modified when there are multiple channels in use with
> +	 * different settings.
> +	 */
> +	if (state->period !=3D rzg2l_gpt->state_period[ch] && rzg2l_gpt->user_c=
ount[ch] > 1)
> +		return -EBUSY;

this is stricter than necessary, but if you don't want to spend
additional brain cycles (we're at v15 already), that's ok. Can be
addressed later if the need arises.

> +	period_cycles =3D mul_u64_u32_div(state->period, rzg2l_gpt->rate, NSEC_=
PER_SEC);
> +	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_cycles);
> +
> +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_cycles, prescale);
> +
> +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rzg2l_gpt->rate, NSE=
C_PER_SEC);
> +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_cycles, prescale);
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, we cache the period value
> +	 * from the first enabled channel and use the same value for both
> +	 * channels.
> +	 */
> +	rzg2l_gpt->state_period[ch] =3D state->period;
> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register.
> +	 */
> +	if (!pwm->state.enabled) {
> +		int rc;
> +
> +		rc =3D pm_runtime_resume_and_get(chip->dev);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	/*
> +	 * Counter must be stopped before modifying mode, prescaler, timer
> +	 * counter and buffer enable registers. These registers are shared
> +	 * between both channels. So allow updating these registers only for the
> +	 * first enabled channel.
> +	 */
> +	if (rzg2l_gpt->enable_count[ch] > 1)
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST, 0);

It's already late here, but I wonder if the condition is wrong here?!
s/>/<=3D/ ?

> +	/* GPT set operating mode (saw-wave up-counting) */
> +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_MD,
> +			 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> +
> +	/* Set count direction */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
> +	/* Select count clock */
> +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_TPCS,
> +			 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> +
> +	/* Set period */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTPR, pv);
> +
> +	/* Set duty cycle */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCCR(RZG2L_IS_IOB(pwm->hwpwm)),
> +			dc);
> +
> +	/* Set initial value for counter */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCNT, 0);
> +
> +	/* Set no buffer operation */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTBER, 0);
> +
> +	/* Restart the counter after updating the registers */
> +	if (rzg2l_gpt->enable_count[ch] > 1)
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR,
> +				 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
> +
> +	/* If the PWM is not enabled, turn the clock off again to save power. */
> +	if (!pwm->state.enabled)
> +		pm_runtime_put(chip->dev);

rzg2l_gpt_config() is only called if state->enabled is true, i.e. the
hardware is about to be enabled. I think it's not sensible in this case
to call pm_runtime_put().

> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--me5u4pyyx2wczdef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmULYFEACgkQj4D7WH0S
/k5emwgAgZZY+y+MZYpfv9KyWPwHo1WKja2C0Ymde/y0X80srH+mjjCrYb/KY8gy
38aIrhg5i+wA6pZewRd2vp6LzDc/0HEP1tM8/pNvQbMqqRmYMnfpgtBoF+zG0BtU
cTxNSEOTQSqn0V4GPUpmPJ6ewP20MMYXSnMKDxSuJTB5Tf6bNg449er3TseWCWp4
fypn4/27MNfk7AAP/o6yvIR3YsFLfPiQ/tJhgRxorjtiI8b2bwrP6y+E+BCRbGk3
CpXiSX62E1RZtZ5ponhiVOQukwvuRUEFdQFAWSFCkCGIn3xSoKyHLQjivDolWbg/
eA2L9iMCU7bmgat+xwfIrsCo2XqHmg==
=KEKa
-----END PGP SIGNATURE-----

--me5u4pyyx2wczdef--
