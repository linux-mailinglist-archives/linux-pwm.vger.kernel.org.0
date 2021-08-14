Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EBF3EC519
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Aug 2021 22:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhHNUrt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 14 Aug 2021 16:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhHNUrs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 14 Aug 2021 16:47:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65F5C061764
        for <linux-pwm@vger.kernel.org>; Sat, 14 Aug 2021 13:47:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mF0Yl-0005Ho-EY; Sat, 14 Aug 2021 22:47:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mF0Yj-0000Q5-BE; Sat, 14 Aug 2021 22:47:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mF0Yj-0007Vb-AC; Sat, 14 Aug 2021 22:47:13 +0200
Date:   Sat, 14 Aug 2021 22:47:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210814204710.retjwn5fycwtrypp@pengutronix.de>
References: <20210719221322.3723009-1-sean.anderson@seco.com>
 <20210719221322.3723009-3-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hekgm63irsc52ag5"
Content-Disposition: inline
In-Reply-To: <20210719221322.3723009-3-sean.anderson@seco.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--hekgm63irsc52ag5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

sorry for having you let waiting so long. Now here some more feedback:

On Mon, Jul 19, 2021 at 06:13:22PM -0400, Sean Anderson wrote:
> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *un=
used,
> +			    const struct pwm_state *state)
> +{
> +	bool enabled;
> +	struct xilinx_timer_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0, tlr1, tcsr0, tcsr1;
> +	u64 period_cycles, duty_cycles;
> +	unsigned long rate;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	/*
> +	 * To be representable by TLR, cycles must be between 2 and
> +	 * priv->max + 2. To enforce this we can reduce the duty
> +	 * cycle, but we may not increase it.
> +	 */
> +	rate =3D clk_get_rate(priv->clk);
> +	period_cycles =3D mul_u64_u32_div(state->period, rate, NSEC_PER_SEC);

cool, I didn't know mul_u64_u32_div.

Hmm, we still have a problem here if

	state->period * rate > 1000000000 * U64_MAX.=20

So to be entirely save, we either need:

	/*
	 * To ensure that period * rate / NSEC_PER_SEC fits into an u64
	 * we need:
	 *            U64_MAX * NSEC_PER_SEC
	 *   period < ----------------------
	 *                    rate
         *
	 * . If rate is not bigger than NSEC_PER_SEC this is true for
	 * sure as the RHS is bigger than U64_MAX. Otherwise we can
	 * calculate the RHS using mul_u64_u32_div.
	 */
	if (rate > NSEC_PER_SEC)
		period =3D min(state->period, mul_u64_u32_div(U64_MAX, NSEC_PER_SEC, rate=
);
	else
		period =3D state->period;

or we go a step further and check the priv->max limit in the same step:

	period =3D min(state->period, ((u64)priv->max + 2) * NSEC_PER_SEC / rate)

=2E The latter is simpler and it's safe as priv->max is an u32 and so
there is no overflow.

> +	if (period_cycles - 2 > priv->max || period_cycles < 2)

I'd check for period_cycles < 2 first, because otherwise period_cycles -
2 might underflow. Nothing bad happens in this case, but reading from
left to right my first thought was I found a bug. Also please decrease
period_cycles if it's bigger than priv->max + 2. (With the suggestion
above you don't need to check for period_cycles - 2 > priv->max any more
however.)

> +		return -ERANGE;
> +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rate, NSEC_PER_SEC);
> +
> +	/*
> +	 * If we specify 100% duty cycle, we will get 0% instead, so decrease
> +	 * the duty cycle count by one.
> +	 */
> +	if (period_cycles =3D=3D duty_cycles)
> +		duty_cycles--;
> +
> +	/* Round down to 0% duty cycle for unrepresentable duty cycles */
> +	if (duty_cycles < 2)
> +		duty_cycles =3D period_cycles;
> +
> +	regmap_read(priv->map, TCSR0, &tcsr0);
> +	regmap_read(priv->map, TCSR1, &tcsr1);
> +	tlr0 =3D xilinx_timer_tlr_cycles(priv, tcsr0, period_cycles);
> +	tlr1 =3D xilinx_timer_tlr_cycles(priv, tcsr1, duty_cycles);
> +	regmap_write(priv->map, TLR0, tlr0);
> +	regmap_write(priv->map, TLR1, tlr1);
> +
> +	enabled =3D xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> +	if (state->enabled) {
> +		/*
> +		 * If the PWM is already running, then the counters will be
> +		 * reloaded at the end of the current cycle.
> +		 */

If state->enabled is false, $enabled isn't used, so you can move the
assignment into the if body and also limit the scope of $enabled.

> +		if (!enabled) {
> +			/* Load TLR into TCR */
> +			regmap_write(priv->map, TCSR0, tcsr0 | TCSR_LOAD);
> +			regmap_write(priv->map, TCSR1, tcsr1 | TCSR_LOAD);
> +			/* Enable timers all at once with ENALL */
> +			tcsr0 =3D (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
> +			tcsr1 =3D TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
> +			regmap_write(priv->map, TCSR0, tcsr0);
> +			regmap_write(priv->map, TCSR1, tcsr1);
> +		}
> +	} else {
> +		regmap_write(priv->map, TCSR0, 0);
> +		regmap_write(priv->map, TCSR1, 0);
> +	}
> +
> +	return 0;
> +}
> +
> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
> +				 struct pwm_device *unused,
> +				 struct pwm_state *state)
> +{
> +	struct xilinx_timer_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0, tlr1, tcsr0, tcsr1;
> +
> +	regmap_read(priv->map, TLR0, &tlr0);
> +	regmap_read(priv->map, TLR1, &tlr1);
> +	regmap_read(priv->map, TCSR0, &tcsr0);
> +	regmap_read(priv->map, TCSR1, &tcsr1);
> +	state->period =3D xilinx_timer_get_period(priv, tlr0, tcsr0);

xilinx_timer_get_period rounds down, this is however wrong for
=2Eget_state().

> +	state->duty_cycle =3D xilinx_timer_get_period(priv, tlr1, tcsr1);

ditto for duty_cycle.

> +	state->enabled =3D xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> [...]
> +static int xilinx_timer_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct xilinx_timer_priv *priv;
> +	struct xilinx_pwm_device *pwm;
> +	u32 pwm_cells, one_timer;
> +	void __iomem *regs;
> +
> +	ret =3D of_property_read_u32(np, "#pwm-cells", &pwm_cells);
> +	if (ret =3D=3D -EINVAL)
> +		return -ENODEV;
> +	else if (ret)
> +		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");

Please capitalize error messages.

> [...]
> +	if (ret) {
> +		clk_rate_exclusive_put(priv->clk);
> +		clk_disable_unprepare(priv->clk);
> +		return dev_err_probe(dev, ret, "could not register pwm chip\n");

s/pwm/PWM/

> +	}
> +
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hekgm63irsc52ag5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEYK8sACgkQwfwUeK3K
7AkmJQgAmpEaLCwlqhwMmP7qpYrL3I+9BE0kzI/M/qWWBBNgv0p64QnG94HR9wPR
nDhj5sQJxY3338KHsCo+V52j1aaUfvMJ+xzjYzlnZXeUx0b+/y1KCQ2F5p5pFgD2
LvJHZDblwMK7AJtGluOl/nMqU3GTPivWONzNNbqGN9G05pvHxf24gJ/HYNm1WX7N
TVEbscIhJG5MQO3z2gCdJWHZpfaRaLVPOlCtlU/pwoJ2i8rMOjTUSho9o7j+ScOK
NVgUBoq85G3TMlbbAJ8uM9M0RtVAsZH48bM8Lo/ka6SCquzAJvTWL1yg78X7C35X
ZwJO4AD0I3hvKKBNvsBLm0Cv0maweA==
=sZTV
-----END PGP SIGNATURE-----

--hekgm63irsc52ag5--
