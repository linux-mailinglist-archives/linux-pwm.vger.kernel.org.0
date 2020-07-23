Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBFA22B343
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jul 2020 18:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgGWQP7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jul 2020 12:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGWQP7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jul 2020 12:15:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C69C0619DC
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jul 2020 09:15:59 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jydsx-00081u-KY; Thu, 23 Jul 2020 18:15:55 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jydsv-0006Eg-Tl; Thu, 23 Jul 2020 18:15:53 +0200
Date:   Thu, 23 Jul 2020 18:15:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v5 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200723161553.ey47oijnwitf4hvu@pengutronix.de>
References: <cover.1595489518.git.rahul.tanwar@linux.intel.com>
 <0f47648107ec23f72868ca37f29ea43e15c08e08.1595489518.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3hlam5iwxswnzw5y"
Content-Disposition: inline
In-Reply-To: <0f47648107ec23f72868ca37f29ea43e15c08e08.1595489518.git.rahul.tanwar@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3hlam5iwxswnzw5y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jul 23, 2020 at 03:44:18PM +0800, Rahul Tanwar wrote:
> +static int lgm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct lgm_pwm_chip *pc =3D to_lgm_pwm_chip(chip);
> +	u32 duty_cycle, val;
> +	int ret;
> +
> +	if (!state->enabled) {
> +		ret =3D lgm_pwm_enable(chip, 0);
> +		return ret;
> +	}
> +
> +	/*
> +	 * HW only supports NORMAL polarity
> +	 * HW supports fixed period which can not be changed/configured by user
> +	 */
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL ||
> +	    state->period !=3D pc->period)
> +		return -EINVAL;

At least for state->polarity you have to check before state->enabled, as
the expectation on

        .enabled =3D false
        .polarity =3D PWM_POLARITY_INVERSED

is that the output becomes constant high. Also as confirmed at the end
of v4, state->period < pc->period was the right check to do.

> +	duty_cycle =3D min_t(u64, state->duty_cycle, state->period);
> +	/* reg_value =3D duty_ns * LGM_PWM_MAX_DUTY_CYCLE(0xff) / period_ns */
> +	val =3D duty_cycle * LGM_PWM_MAX_DUTY_CYCLE / state->period;

The comment adds only little compared to the code line below. Please
drop it.

Dividing by state->period is wrong. I think you need pc->period here.

> +	ret =3D regmap_update_bits(pc->regmap, LGM_PWM_FAN_CON0, LGM_PWM_FAN_DC=
_MSK,
> +				 FIELD_PREP(LGM_PWM_FAN_DC_MSK, val));
> +	if (ret)
> +		return ret;
> +
> +	if (state->enabled)
> +		ret =3D lgm_pwm_enable(chip, 1);
> +
> +	return ret;
> +}
> +
> +static void lgm_pwm_get_state(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      struct pwm_state *state)
> +{
> +	struct lgm_pwm_chip *pc =3D to_lgm_pwm_chip(chip);
> +	u32 duty, val;
> +
> +	state->enabled =3D regmap_test_bits(pc->regmap, LGM_PWM_FAN_CON0,
> +					  LGM_PWM_FAN_EN_EN);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->period =3D pc->period; /* fixed period */
> +
> +	regmap_read(pc->regmap, LGM_PWM_FAN_CON0, &val);
> +	duty =3D FIELD_GET(LGM_PWM_FAN_DC_MSK, val);
> +	state->duty_cycle =3D DIV_ROUND_UP(duty * pc->period,
> +					 LGM_PWM_MAX_DUTY_CYCLE);
> +}
> +
> +static const struct pwm_ops lgm_pwm_ops =3D {
> +	.get_state =3D lgm_pwm_get_state,
> +	.apply =3D lgm_pwm_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static void lgm_pwm_init(struct lgm_pwm_chip *pc)
> +{
> +	struct device *dev =3D pc->chip.dev;
> +	struct regmap *regmap =3D pc->regmap;
> +	u32 max_rpm, fan_wire, con0_val, con0_mask;
> +
> +	if (device_property_read_u32(dev, "intel,fan-wire", &fan_wire))
> +		fan_wire =3D 2; /* default is 2 wire mode */
> +
> +	con0_mask =3D LGM_PWM_FAN_MODE_MSK;
> +
> +	switch (fan_wire) {
> +	case 4:
> +		con0_val =3D FIELD_PREP(LGM_PWM_FAN_MODE_MSK, LGM_PWM_FAN_MODE_4WIRE);
> +		pc->period =3D LGM_PWM_PERIOD_4WIRE_NSECS;
> +		break;
> +	default:
> +		/* default is 2wire mode */
> +		con0_val =3D FIELD_PREP(LGM_PWM_FAN_MODE_MSK, LGM_PWM_FAN_MODE_2WIRE);
> +		pc->period =3D LGM_PWM_PERIOD_2WIRE_NSECS;
> +		break;
> +	}
> +
> +	if (device_property_read_u32(dev, "intel,max-rpm", &max_rpm))
> +		max_rpm =3D LGM_PWM_DEFAULT_RPM;

This property isn't in the binding!?

> +	max_rpm =3D min_t(u32, max_rpm, LGM_PWM_MAX_RPM);
> +	if (max_rpm =3D=3D 0)
> +		max_rpm =3D LGM_PWM_DEFAULT_RPM;
> +
> +	regmap_update_bits(regmap, LGM_PWM_FAN_CON1, LGM_PWM_FAN_MAX_RPM_MSK, m=
ax_rpm);
> +	regmap_update_bits(regmap, LGM_PWM_FAN_CON0, con0_mask, con0_val);
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3hlam5iwxswnzw5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8Zt7YACgkQwfwUeK3K
7AmMJQf+IOPqsaAt0rmo75wbf7nQBu9/apJAED4ZCHhuPgL7Y9eHeyZ3MdaCo80d
tWUxL2jPfQVJ4MIjPGfuKZHjMnx6q0qG5XMsTcDoQWb99ijOhbRhi7HWqF0oM6eX
EC2lrppB8IBtvtR9HZFW2dZjFoDMTaZjk7UBla5/5032VC15h/z4jpd8wMEzEXoh
sxsXlTQdSaxyTEryy/56AreRP7Gm9532HYKfafzWwp7qP6IrWKJAXS61LIKuSSw/
XlvNFbDj5IdXR/e66HYdQEFKgOIPF+E1z93HxWRMeb/eaXv/FtDYmovbCehIJcsh
itwD09BWGYs8/2Z6ClhT5uUfitTtNg==
=Nimh
-----END PGP SIGNATURE-----

--3hlam5iwxswnzw5y--
