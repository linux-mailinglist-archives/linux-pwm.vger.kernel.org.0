Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF9038E4BD
	for <lists+linux-pwm@lfdr.de>; Mon, 24 May 2021 13:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhEXLE7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 May 2021 07:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhEXLE5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 May 2021 07:04:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1575C061574
        for <linux-pwm@vger.kernel.org>; Mon, 24 May 2021 04:03:28 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ll8MZ-00043h-Df; Mon, 24 May 2021 13:03:11 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ll8MO-0002iH-Ii; Mon, 24 May 2021 13:03:00 +0200
Date:   Mon, 24 May 2021 13:02:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v6 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20210524110257.izcgx4kdmj5c7dou@pengutronix.de>
References: <20210518005517.9036-1-billy_tsai@aspeedtech.com>
 <20210518005517.9036-3-billy_tsai@aspeedtech.com>
 <20210522160708.ryr7n7klapszu2da@pengutronix.de>
 <9EA46360-8F43-4D1B-9004-3965A6182FA1@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p3cy6gevslqiqnpq"
Content-Disposition: inline
In-Reply-To: <9EA46360-8F43-4D1B-9004-3965A6182FA1@aspeedtech.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--p3cy6gevslqiqnpq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Billy,

On Mon, May 24, 2021 at 01:56:19AM +0000, Billy Tsai wrote:
> On 2021/5/23, 12:07 AM,Uwe Kleine-K=C3=B6nigwrote:
>     On Tue, May 18, 2021 at 08:55:17AM +0800, Billy Tsai wrote:
>     >   > +static u64 aspeed_pwm_get_period(struct pwm_chip *chip, struct=
 pwm_device *pwm)
>     >   > +{
>     >   > +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip=
);
>     >   > +	unsigned long rate;
>     >   > +	u32 index =3D pwm->hwpwm;
>     >   > +	u32 val;
>     >   > +	u64 period, div_h, div_l, clk_period;
>     >   > +
>     >   > +	rate =3D clk_get_rate(priv->clk);
>     >   > +	regmap_read(priv->regmap, PWM_ASPEED_CTRL_CH(index), &val);
>     >   > +	div_h =3D FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_H, val);
>     >   > +	div_l =3D FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_L, val);
>     >   > +	regmap_read(priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index), &v=
al);
>     >   > +	clk_period =3D FIELD_GET(PWM_ASPEED_DUTY_CYCLE_PERIOD, val);
>     >   > +	period =3D (NSEC_PER_SEC * BIT(div_h) * (div_l + 1) * (clk_pe=
riod + 1));
>=20
>     > The outer pair of parenthesis on the RHS isn't necessary. The maxim=
al
>     > value that period can have here is:
>=20
>     >	1000000000 * 2**15 * 256 * 256
>=20
>     > This fits into an u64, but as all but the last factor are 32 bit va=
lues
>     > you might get an overflow here.
>=20
> I don=E2=80=99t know in which case the value will overflow, when my param=
eter types are all u64.
> Can you tell me what is "the last factor"?

Ah, I missed that div_l is u64. NSEC_PER_SEC and BIT(div_h) are both
long quantities only and 1000000000 * 2**15 might overflow that.

>     >   > +static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_=
device *pwm,
>     >   > +			    const struct pwm_state *state)
>     >   > +{
>     >   > +	struct device *dev =3D chip->dev;
>     >   > +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip=
);
>     >   > +	u32 index =3D pwm->hwpwm;
>     >   > +	int ret;
>     >   > +
>     >   > +	dev_dbg(dev, "apply period: %lldns, duty_cycle: %lldns", stat=
e->period,
>     >   > +		state->duty_cycle);
>     >   > +
>     >   > +	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
>     >   > +			   PWM_ASPEED_CTRL_PIN_ENABLE,
>     >   > +			   state->enabled ? PWM_ASPEED_CTRL_PIN_ENABLE : 0);
>     >   > +	/*
>     >   > +	 * Fixed the period to the max value and rising point to 0
>     >   > +	 * for high resolution and simplify frequency calculation.
>     >   > +	 */
>     >   > +	regmap_update_bits(priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(ind=
ex),
>     >   > +			   (PWM_ASPEED_DUTY_CYCLE_PERIOD |
>     >   > +			    PWM_ASPEED_DUTY_CYCLE_RISING_POINT),
>     >   > +			   FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_PERIOD,
>     >   > +				      PWM_ASPEED_FIXED_PERIOD));
>     >   > +
>     >   > +	ret =3D aspeed_pwm_set_period(chip, pwm, state);
>     >   > +	if (ret)
>     >   > +		return ret;
>     >   > +	aspeed_pwm_set_duty(chip, pwm, state);
>=20
>     > aspeed_pwm_set_duty calls aspeed_pwm_get_period() which is a bit
>     > ineffective after just having set the period.
>=20
> When I call aspeed_pwm_set_period it doesn't mean the period is equal to =
what I set (It may
> lose some precision Ex: When I set the period 40000ns, the actual period =
I set is 39680ns) and
> I didn't get this information when I call aspeed_pwm_set_period. Thus, I =
need to get the actual
> period first before set duty.

I'm aware it might lose precision. But calling aspeed_pwm_get_period()
determines the setting from reading registers, if you reuse all
information available in aspeed_pwm_set_period() this is cheaper. Also
it might be beneficial to first compute all necessary register values
and then write them in quick sequence to keep the window for glitches
small. Given that aspeed_pwm_set_period and aspeed_pwm_set_duty both
have only a single caller, doing both in a single function might be an
idea.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--p3cy6gevslqiqnpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCrh94ACgkQwfwUeK3K
7An++AgAh1gL5iovGBXJHgZiS4/Qh9dNgycwY3goMgTLH3o9NfZ2Mc/ziOpEphOO
2iwXtYaDcoapVOrXFNWdWTUbKfaKd5jHDA1j9QwNUHMJoBmyf+RNR+VU9XpfioZl
nk6xNcwrWIPQtMbh1c0Dj3cfQ21QT3MS+vfZEBStpbqTQ6nOWUQ+FP5/Y0DWNpay
JsyTAe4Fzl7HYVmTxtpMp0QHB3BOroo9PwEC6Xq3Gvm+SVyMiiEdEshhNwzePhnh
hs1lXdaBXSuM1ZacPh838IFRRRfCI4eeK5SeVskrW8cyMYfra47j/N8EK4eIFDw4
Mssd1Whz5NQeQxyMXbqs9Hfa0CJRVQ==
=L/9W
-----END PGP SIGNATURE-----

--p3cy6gevslqiqnpq--
