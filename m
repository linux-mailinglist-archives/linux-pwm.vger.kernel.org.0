Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1E76E1C97
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Apr 2023 08:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjDNG1f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Apr 2023 02:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDNG1e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2023 02:27:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8E06595
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 23:27:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnCtQ-0004uj-98; Fri, 14 Apr 2023 08:26:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnCtO-00B8Vk-Cq; Fri, 14 Apr 2023 08:26:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnCtN-00D4nG-Oa; Fri, 14 Apr 2023 08:26:41 +0200
Date:   Fri, 14 Apr 2023 08:26:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v15 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Message-ID: <20230414062641.76no7jz7uluixwdg@pengutronix.de>
References: <20230330111632.169434-1-biju.das.jz@bp.renesas.com>
 <20230330111632.169434-7-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l7awkgl2o3zkxwkd"
Content-Disposition: inline
In-Reply-To: <20230330111632.169434-7-biju.das.jz@bp.renesas.com>
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


--l7awkgl2o3zkxwkd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Mar 30, 2023 at 12:16:32PM +0100, Biju Das wrote:
> +static struct rz_mtu3_pwm_channel *
> +rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32 hwpwm)
> +{
> +	struct rz_mtu3_pwm_channel *priv =3D rz_mtu3_pwm->channel_data;
> +	unsigned int ch;
> +
> +	for (ch =3D 0; ch < RZ_MTU3_MAX_HW_CHANNELS; ch++, priv++) {
> +		if (priv->map->channel + priv->map->num_channel_ios >  hwpwm)

s/  / /

> +			break;
> +	}
> +
> +	return priv;
> +}
> +
> +static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip *rz_mtu3_p=
wm,
> +				      u32 hwpwm)
> +{
> +	struct rz_mtu3_pwm_channel *priv;
> +	bool is_channel_en;
> +	u8 val;
> +
> +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, hwpwm);
> +	is_channel_en =3D rz_mtu3_is_enabled(priv->mtu);
> +	if (!is_channel_en)
> +		return false;
> +
> +	if (priv->map->channel =3D=3D hwpwm)
> +		val =3D rz_mtu3_8bit_ch_read(priv->mtu, RZ_MTU3_TIORH);
> +	else
> +		val =3D rz_mtu3_8bit_ch_read(priv->mtu, RZ_MTU3_TIORL);
> +
> +	return (is_channel_en && (val & RZ_MTU3_TIOR_IOA));

Here you already know that is_channel_en =3D=3D true, so it can be dropped
here.

> +}
> +
> [...]
> +static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> +			      struct pwm_device *pwm)
> +{
> +	struct rz_mtu3_pwm_channel *priv;
> +	u32 ch;
> +	u8 val;
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(rz_mtu3_pwm->chip.dev);
> +	if (rc)
> +		return rc;
> +
> +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch =3D priv - rz_mtu3_pwm->channel_data;
> +	val =3D RZ_MTU3_TIOR_OC_IOB_TOGGLE | RZ_MTU3_TIOR_OC_IOA_H_COMP_MATCH;
> +
> +	rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_MD_PWMMOD=
E1);
> +	if (priv->map->channel =3D=3D pwm->hwpwm)

This condition identifies the first PWM of a channel. I was surprised
here that the channel numbering has a hole after each channel that
manages two IOs. OTOH, in the comment at the top of the driver there is:

	(The channels are MTU{0..4, 6, 7}.)

which I would have expected to see in channel_map. I think the first
member of this struct is really the base pwm number and so is misnamed?

> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORH, val);
> +	else
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORL, val);
> +
> +	mutex_lock(&rz_mtu3_pwm->lock);
> +	if (!rz_mtu3_pwm->enable_count[ch])
> +		rz_mtu3_enable(priv->mtu);
> +
> +	rz_mtu3_pwm->enable_count[ch]++;
> +	mutex_unlock(&rz_mtu3_pwm->lock);
> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> +				struct pwm_device *pwm)
> +{
> +	struct rz_mtu3_pwm_channel *priv;
> +	u32 ch;
> +
> +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch =3D priv - rz_mtu3_pwm->channel_data;
> +
> +	/* Return to normal mode and disable output pins of MTU3 channel */
> +	if (rz_mtu3_pwm->user_count[ch] <=3D 1)
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_MD_NORMA=
L);

This never triggers if both PWMs of a channel are requested, even if
both are disabled. Is this intended?

> +	if (priv->map->channel =3D=3D pwm->hwpwm)
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORH, RZ_MTU3_TIOR_OC_RETAIN=
);
> +	else
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORL, RZ_MTU3_TIOR_OC_RETAIN=
);
> +
> +	mutex_lock(&rz_mtu3_pwm->lock);
> +	rz_mtu3_pwm->enable_count[ch]--;
> +	if (!rz_mtu3_pwm->enable_count[ch])
> +		rz_mtu3_disable(priv->mtu);
> +
> +	mutex_unlock(&rz_mtu3_pwm->lock);
> +
> +	pm_runtime_put_sync(rz_mtu3_pwm->chip.dev);
> +}
> +
> [...]
> +static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      const struct pwm_state *state)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_pwm_channel *priv;
> +	unsigned long pv, dc;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u8 prescale;
> +	u8 val;
> +
> +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
> +					NSEC_PER_SEC);
> +	prescale =3D rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm, period_cycles);
> +
> +	if (period_cycles >> (2 * prescale) <=3D U16_MAX)
> +		pv =3D period_cycles >> (2 * prescale);
> +	else
> +		pv =3D U16_MAX;
> +
> +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rz_mtu3_pwm->rate,
> +				      NSEC_PER_SEC);
> +	if (duty_cycles >> (2 * prescale) <=3D U16_MAX)
> +		dc =3D duty_cycles >> (2 * prescale);
> +	else
> +		dc =3D U16_MAX;
> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register.
> +	 */
> +	if (!pwm->state.enabled)
> +		pm_runtime_get_sync(chip->dev);
> +
> +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> +	if (priv->map->channel =3D=3D pwm->hwpwm) {
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_TGRA | val);

If the sibling PWM on the same channel is on, you're overwriting its
prescale value here, are you not?

> +		rz_mtu3_16bit_ch_write(priv->mtu, RZ_MTU3_TGRB, dc);
> +		rz_mtu3_16bit_ch_write(priv->mtu, RZ_MTU3_TGRA, pv);
> +	} else {
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_TGRC | val);
> +		rz_mtu3_16bit_ch_write(priv->mtu, RZ_MTU3_TGRD, dc);
> +		rz_mtu3_16bit_ch_write(priv->mtu, RZ_MTU3_TGRC, pv);
> +	}
> +
> +	/* If the PWM is not enabled, turn the clock off again to save power. */
> +	if (!pwm->state.enabled)
> +		pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> [...]
> +static int rz_mtu3_pwm_probe(struct platform_device *pdev)
> +{
> +	struct rz_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);

Nitpick: I would have called that parent_ddata.

> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
> +	struct device *dev =3D &pdev->dev;
> +	unsigned int i, j =3D 0;
> +	int ret;
> +
> +	rz_mtu3_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm), GFP_KERN=
EL);
> +	if (!rz_mtu3_pwm)
> +		return -ENOMEM;
> +
> +	rz_mtu3_pwm->clk =3D ddata->clk;
> +
> +	for (i =3D 0; i < RZ_MTU_NUM_CHANNELS; i++) {
> +		if (i =3D=3D RZ_MTU3_CHAN_5 || i =3D=3D RZ_MTU3_CHAN_8)
> +			continue;
> +
> +		rz_mtu3_pwm->channel_data[j].mtu =3D &ddata->channels[i];
> +		rz_mtu3_pwm->channel_data[j].mtu->dev =3D dev;
> +		rz_mtu3_pwm->channel_data[j].map =3D &channel_map[j];
> +		j++;
> +	}
> +

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--l7awkgl2o3zkxwkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ48iAACgkQj4D7WH0S
/k6JGgf+Nd1UnIEzopIR516y/NNr9Zq+ZFDOdr4Out3p/QTal4dQuSSg+9CZvPka
t7YY3mciU2InwbkZlYTOVbuoDxYpyZ59axKyUlzRFMNW8hCsZufxjkIrzickGbr3
qMxWqWhl1jV6jDNGVNAJXUgIx9inziSNgcECZJS2do5JOO7cBSic1l+WWYPnqFpr
NvoV6Nvc4/QasYP8lEzR/DyMgraDgCRmILutiWCcuaAzVN1PzUX7sXyygw10JED6
liHIUYH8YZOKcScxmc7OXISoFCQippqQP0OGvEiow8C6QKuMCcX6j2RuDPN8a7Wi
Ib3lXw34IH3Tikq4OmKq3V5lRAg6tw==
=b/uM
-----END PGP SIGNATURE-----

--l7awkgl2o3zkxwkd--
