Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF54234BC0
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Jul 2020 21:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgGaTrY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 Jul 2020 15:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgGaTrX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 Jul 2020 15:47:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0E2C061574
        for <linux-pwm@vger.kernel.org>; Fri, 31 Jul 2020 12:47:23 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k1azu-0001Q4-JC; Fri, 31 Jul 2020 21:47:18 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k1azs-00073r-Kt; Fri, 31 Jul 2020 21:47:16 +0200
Date:   Fri, 31 Jul 2020 21:47:16 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, lee.jones@linaro.org,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v6 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200731194716.xxin4cl672tk2bkc@pengutronix.de>
References: <cover.1595926036.git.rahul.tanwar@linux.intel.com>
 <63e44ece4c0da860963d0ff09dd52912d557c7e0.1595926036.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rqwv5fncrzwpgutc"
Content-Disposition: inline
In-Reply-To: <63e44ece4c0da860963d0ff09dd52912d557c7e0.1595926036.git.rahul.tanwar@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rqwv5fncrzwpgutc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I only found a two minor issues this round, see below.

On Tue, Jul 28, 2020 at 04:52:13PM +0800, Rahul Tanwar wrote:
> +static int lgm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct lgm_pwm_chip *pc =3D to_lgm_pwm_chip(chip);
> +	u32 duty_cycle, val;
> +	int ret;
> +
> +	/*
> +	 * HW only supports only NORMAL polarity
> +	 * HW supports fixed period

there are too many "only"s here. What about:

	/*
	 * The hardware only supports
	 * normal polarity and fixed period.
	 */

?

> +	 */
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL ||
> +	    state->period < pc->period)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		ret =3D lgm_pwm_enable(chip, 0);
> +		return ret;
> +	}
> +
> +	duty_cycle =3D min_t(u64, state->duty_cycle, pc->period);
> +	val =3D duty_cycle * LGM_PWM_MAX_DUTY_CYCLE / pc->period;
> +
> +	ret =3D regmap_update_bits(pc->regmap, LGM_PWM_FAN_CON0, LGM_PWM_FAN_DC=
_MSK,
> +				 FIELD_PREP(LGM_PWM_FAN_DC_MSK, val));
> +	if (ret)
> +		return ret;
> +
> +	if (state->enabled)
> +		ret =3D lgm_pwm_enable(chip, 1);

You can do this unconditionally, if state->enabled is false the function
returns a few lines above already.

> +
> +	return ret;
> +}

The rest looks fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rqwv5fncrzwpgutc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8kdUEACgkQwfwUeK3K
7AlDuAf+OUQhgl11k0kBK4onw9aPuszKQmlS6tkxYg4C+HMThoc1U6OiLARNbsYp
CU8S45+GGemAHqf40rAPUW1uX9SRBv4nRuge3p7Rm8XZwyJIIVfpW1agD+Efgv7n
AXUnLh3vBEpMMsdGhfpqCn0138mddsyAjzxgB4+cYgJJd3kB5d0LiIz2X8dhJ0bK
LKGNNo6UzlYsvGOgzNkjNbdWJS+T1tKvAsiLtPCNS7s5DjCJ2YRm1AisZMXzoU6I
tnhRwTKXG+wMFTfrRyqPpj97RSL66uJr4JU6nemrRcmMchTCT7BsZvsX7b94Ej2q
R6q/XH/q+/G3+jV8bzgZAa1ffflMGQ==
=QVLW
-----END PGP SIGNATURE-----

--rqwv5fncrzwpgutc--
