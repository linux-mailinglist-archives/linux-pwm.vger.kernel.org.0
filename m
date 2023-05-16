Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42709704569
	for <lists+linux-pwm@lfdr.de>; Tue, 16 May 2023 08:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjEPGnR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 16 May 2023 02:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjEPGnQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 May 2023 02:43:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515322D6B
        for <linux-pwm@vger.kernel.org>; Mon, 15 May 2023 23:43:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyoOq-00088s-0Z; Tue, 16 May 2023 08:43:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyoOo-000XgG-Bb; Tue, 16 May 2023 08:43:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyoOn-004v23-GO; Tue, 16 May 2023 08:43:05 +0200
Date:   Tue, 16 May 2023 08:43:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Message-ID: <20230516064304.cdiifro7lb7ne2jp@pengutronix.de>
References: <20230418102037.346405-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d7tviladg6msy3zz"
Content-Disposition: inline
In-Reply-To: <20230418102037.346405-1-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--d7tviladg6msy3zz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

here now comes my promised review. Took a bit longer than anticipated,
sorry for that.

On Tue, Apr 18, 2023 at 11:20:37AM +0100, Biju Das wrote:
> +static u8 rz_mtu3_pwm_calculate_prescale(struct rz_mtu3_pwm_chip *rz_mtu=
3,
> +					 u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	prescaled_period_cycles =3D period_cycles >> 16;
> +	if (prescaled_period_cycles >=3D 16)
> +		prescale =3D 3;
> +	else
> +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> +
> +	return prescale;

That value is supposed to be written to RZ_MTU3_TCR_TPCS, right? This is
a 3bit register field and in .get_state() you handle values up to 7. I
wonder why the max here is 3 only.

> +}
> +
> [...]
> +static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +
> +	pm_runtime_get_sync(chip->dev);

Return value checking?

> +	state->enabled =3D rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, pwm->hwpwm);
> +	if (state->enabled) {
> +		struct rz_mtu3_pwm_channel *priv;
> +		u8 prescale, val;
> +		u16 dc, pv;
> +		u64 tmp;
> +
> +		priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> +		if (priv->map->base_pwm_number =3D=3D pwm->hwpwm)
> +			rz_mtu3_pwm_read_tgr_registers(priv, RZ_MTU3_TGRA, &pv,
> +						       RZ_MTU3_TGRB, &dc);
> +		else
> +			rz_mtu3_pwm_read_tgr_registers(priv, RZ_MTU3_TGRC, &pv,
> +						       RZ_MTU3_TGRD, &dc);
> +
> +		val =3D rz_mtu3_8bit_ch_read(priv->mtu, RZ_MTU3_TCR);
> +		prescale =3D FIELD_GET(RZ_MTU3_TCR_TPCS, val);
> +
> +		/* With prescale <=3D 7 and pv <=3D 0xffff this doesn't overflow. */
> +		tmp =3D NSEC_PER_SEC * (u64)pv << (2 * prescale);
> +		state->period =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
> +		tmp =3D NSEC_PER_SEC * (u64)dc << (2 * prescale);
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
> +	}
> +
> +	if (state->duty_cycle > state->period)
> +		state->duty_cycle =3D state->period;

Without having assigned a value to duty_cycle and period this looks a
bit strange. Maybe move it into the if block above?

> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static u16 rz_mtu3_pwm_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 p=
rescale)
> +{
> +	return (period_or_duty_cycle >> (2 * prescale)) <=3D U16_MAX ?
> +		period_or_duty_cycle >> (2 * prescale) : U16_MAX;

This is equivalent to

	return min(period_or_duty_cycle >> (2 * prescale), (u64)U16_MAX);

I like this variant better, but maybe that's subjective?

> +}
> +
> +static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      const struct pwm_state *state)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_pwm_channel *priv;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u8 prescale;
> +	u16 pv, dc;
> +	u8 val;
> +	u32 ch;
> +
> +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch =3D priv - rz_mtu3_pwm->channel_data;
> +
> +	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
> +					NSEC_PER_SEC);
> +	prescale =3D rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm, period_cycles);
> +
> +	/*
> +	 * Prescalar is shared by multiple channels, so prescale can
> +	 * NOT be modified when there are multiple channels in use with
> +	 * different settings. Modify prescalar if other PWM is off or handle
> +	 * it, if current prescale value is less than the one we want to set.
> +	 */
> +	if (rz_mtu3_pwm->enable_count[ch] > 1) {
> +		if (rz_mtu3_pwm->prescale[ch] > prescale)
> +			return -EBUSY;
> +
> +		prescale =3D rz_mtu3_pwm->prescale[ch];
> +	}
> +
> +	pv =3D rz_mtu3_pwm_calculate_pv_or_dc(period_cycles, prescale);
> +
> +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rz_mtu3_pwm->rate,
> +				      NSEC_PER_SEC);
> +	dc =3D rz_mtu3_pwm_calculate_pv_or_dc(duty_cycles, prescale);
> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register.
> +	 */
> +	if (!pwm->state.enabled)
> +		pm_runtime_get_sync(chip->dev);

Error checking?

> +
> +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> +
> +	/* Counter must be stopped while updating TCR register */
> +	if (rz_mtu3_pwm->prescale[ch] !=3D prescale && rz_mtu3_pwm->enable_coun=
t[ch])
> +		rz_mtu3_disable(priv->mtu);
> +
> +	if (priv->map->base_pwm_number =3D=3D pwm->hwpwm) {
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_TGRA | val);
> +		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRA, pv,
> +						RZ_MTU3_TGRB, dc);
> +	} else {
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_TGRC | val);
> +		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRC, pv,
> +						RZ_MTU3_TGRD, dc);
> +	}
> +
> +	if (rz_mtu3_pwm->prescale[ch] !=3D prescale) {
> +		/*
> +		 * Prescalar is shared by multiple channels, we cache the
> +		 * prescalar value from first enabled channel and use the same
> +		 * value for both channels.
> +		 */
> +		rz_mtu3_pwm->prescale[ch] =3D prescale;
> +
> +		if (rz_mtu3_pwm->enable_count[ch])
> +			rz_mtu3_enable(priv->mtu);
> +	}
> +
> +	/* If the PWM is not enabled, turn the clock off again to save power. */
> +	if (!pwm->state.enabled)
> +		pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}

Looks fine otherwise.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d7tviladg6msy3zz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRjJfcACgkQj4D7WH0S
/k4PuwgAuwH+Nv9AxWRPXfViDE+u3ugOvs0Ijvqgd//M+QBjJp6iuXGMMk67uU50
R4vwwpKddzcxLQiAz7nLD3twsgZH3lDRQ+n2FuH+E2Kf2VVSxaxkxLs201fT+bds
9cfQdSxa8PhX0YzIMQ0FIMYgWh0FXRhU69EVBnN/NmEhZQSGxy7yRJt9ZY6s2k6Z
48atP2sA2PCJHOA0a5YKR/NE66PIxAmYu3F9Oa88fQKS6LWmuCkedFqIdwEp3Qeb
mt8knLXCPvAzP1T78HP3owjlqDi64bUhuYwM7rEirtXj3/ZDCcJKK9YaePj7CVyD
03v68Sbs2qeYpOilU8ujQzaGI9F7OA==
=JnHb
-----END PGP SIGNATURE-----

--d7tviladg6msy3zz--
