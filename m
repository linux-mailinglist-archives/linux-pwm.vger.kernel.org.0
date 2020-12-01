Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029322C980B
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Dec 2020 08:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgLAHV1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Dec 2020 02:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgLAHV0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Dec 2020 02:21:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1647DC0613D3
        for <linux-pwm@vger.kernel.org>; Mon, 30 Nov 2020 23:20:46 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjzxm-0001lI-9c; Tue, 01 Dec 2020 08:20:38 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjzxc-000762-JP; Tue, 01 Dec 2020 08:20:28 +0100
Date:   Tue, 1 Dec 2020 08:20:26 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20201201072026.a736ikf3k4udpvfv@pengutronix.de>
References: <20201201011513.1627028-1-j.neuschaefer@gmx.net>
 <20201201011513.1627028-5-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u22gzovpzo4ufbuv"
Content-Disposition: inline
In-Reply-To: <20201201011513.1627028-5-j.neuschaefer@gmx.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--u22gzovpzo4ufbuv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

very nice driver, just a few minor comments below.

On Tue, Dec 01, 2020 at 02:15:10AM +0100, Jonathan Neusch=E4fer wrote:
> +static struct ntxec_pwm *pwmchip_to_priv(struct pwm_chip *chip)

a function prefix would be great here, I'd pick ntxec_pwm_from_chip as
name.

> +{
> +	return container_of(chip, struct ntxec_pwm, chip);
> +}
> +
> +[...]
> +static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm=
_dev,
> +			   const struct pwm_state *state)
> +{
> +	struct ntxec_pwm *priv =3D pwmchip_to_priv(pwm_dev->chip);
> +	unsigned int period, duty;
> +	struct reg_sequence regs[] =3D {
> +		{ NTXEC_REG_PERIOD_HIGH },
> +		{ NTXEC_REG_PERIOD_LOW },
> +		{ NTXEC_REG_DUTY_HIGH },
> +		{ NTXEC_REG_DUTY_LOW }
> +	};
> +	int res;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	period =3D min_t(u64, state->period, MAX_PERIOD_NS);
> +	duty   =3D min_t(u64, state->duty_cycle, period);

I'm not a big fan of aligning =3D. (As if you have to add a longer
variable you have to realign all otherwise unrelated lines.) But that's
subjective and it's up to you if you want to change this.

> +	period /=3D TIME_BASE_NS;
> +	duty   /=3D TIME_BASE_NS;
> +
> +	/*
> +	 * Changes to the period and duty cycle take effect as soon as the
> +	 * corresponding low byte is written, so the hardware may be configured
> +	 * to an inconsistent state after the period is written and before the
> +	 * duty cycle is fully written. If, in such a case, the old duty cycle
> +	 * is longer than the new period, the EC may output 100% for a moment.
> +	 */
> +
> +	regs[0].def =3D ntxec_reg8(period >> 8);
> +	regs[1].def =3D ntxec_reg8(period);
> +	regs[2].def =3D ntxec_reg8(duty >> 8);
> +	regs[3].def =3D ntxec_reg8(duty);

You could even minimize the window by changing the order here to

	NTXEC_REG_PERIOD_HIGH
	NTXEC_REG_DUTY_HIGH
	NTXEC_REG_PERIOD_LOW
	NTXEC_REG_DUTY_LOW

but it gets less readable. Maybe move that to a function to have the
reg_sequence and the actual write nearer together? Or somehow name the
indexes to make it more obvious?

> +	res =3D regmap_multi_reg_write(priv->ec->regmap, regs, ARRAY_SIZE(regs)=
);
> +	if (res)
> +		return res;
> +
> +	/*
> +	 * Writing a duty cycle of zero puts the device into a state where
> +	 * writing a higher duty cycle doesn't result in the brightness that it
> +	 * usually results in. This can be fixed by cycling the ENABLE register.
> +	 *
> +	 * As a workaround, write ENABLE=3D0 when the duty cycle is zero.

If the device already has duty_cycle =3D 0 but ENABLE =3D 1, you might get
a failure. But I guess this doesn't need addressing in the code. But
maybe point it out in a comment?

> +	 */
> +	if (state->enabled && duty !=3D 0) {
> +		res =3D regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(1)=
);
> +		if (res)
> +			return res;
> +
> +		/* Disable the auto-off timer */
> +		res =3D regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_re=
g8(0xff));
> +		if (res)
> +			return res;
> +
> +		return regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_reg=
8(0xff));

Given that you cannot read back period and duty anyhow: Does it make
sense to write these only if (state->enabled && duty !=3D 0)?

> +	} else {
> +		return regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(0));
> +	}
> +}

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--u22gzovpzo4ufbuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/F7rcACgkQwfwUeK3K
7Alt8gf/XraVPH6btA/jmysBDXmmpKYQXUUMLc3b+HfFt6mJPYkDH8ARHZHvJTF7
sZ2yWrm0erhFNUiovVw4dk3w+fJ3GJS+p1HDw/lq+gc4DlEMdvl63KdIVEbNA5Gf
5xIwyQnrh9sUbwoc76fvrJ10+iygGM3gkqIH+g4ALoUh/pniK0ZgxytmO37gWN90
GMLIvk/yGYKaqvIcgag90CcBD5Mc0N3jIOYGu9aMvybbAjBYoqwrVhi3glik/dIP
jvoknFYpQkw+Tg2dCuCOSc/1fWKZR0EhOi5pvu7cXNSHFgmt5NMEBEakmKkkCdzP
VOpLcgcoMsJmvzsbCk+RZGCPh9xlPw==
=ur6O
-----END PGP SIGNATURE-----

--u22gzovpzo4ufbuv--
