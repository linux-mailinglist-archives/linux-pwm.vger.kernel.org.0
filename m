Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAF7260D25
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Sep 2020 10:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgIHIM4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Sep 2020 04:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbgIHIMs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Sep 2020 04:12:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9A4C061573
        for <linux-pwm@vger.kernel.org>; Tue,  8 Sep 2020 01:12:47 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kFYk3-0007xo-6w; Tue, 08 Sep 2020 10:12:39 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kFYjr-0007B6-Ee; Tue, 08 Sep 2020 10:12:27 +0200
Date:   Tue, 8 Sep 2020 10:12:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v9 06/13] pwm: add support for sl28cpld PWM controller
Message-ID: <20200908081227.mxumgqipyod6iltr@pengutronix.de>
References: <20200907213802.26745-1-michael@walle.cc>
 <20200907213802.26745-7-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mw42m5g6wzbjjufm"
Content-Disposition: inline
In-Reply-To: <20200907213802.26745-7-michael@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mw42m5g6wzbjjufm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

just a bit of nitpicking left. If Lee is going to apply, I can care for
a followup patch if need be.

On Mon, Sep 07, 2020 at 11:37:55PM +0200, Michael Walle wrote:
> [..]
> +config PWM_SL28CPLD
> +	tristate "Kontron sl28cpld PWM support"
> +	depends on MFD_SL28CPLD ||  COMPILE_TEST

s/  / / (@Lee, maybe fixup during application?)

> +	help
> +	  Generic PWM framework driver for board management controller
> +	  found on the Kontron sl28 CPLD.
> [...]
> +#define SL28CPLD_PWM_CLK			32000 /* 32 kHz */
> +#define SL28CPLD_PWM_MAX_DUTY_CYCLE(prescaler)	(1 << (7 - (prescaler)))
> +#define SL28CPLD_PWM_PERIOD(prescaler) \
> +	(NSEC_PER_SEC / SL28CPLD_PWM_CLK * SL28CPLD_PWM_MAX_DUTY_CYCLE(prescale=
r))
> +
> +/*
> + * We calculate the duty cycle like this:
> + *   duty_cycle_ns =3D pwm_cycle_reg * max_period_ns / max_duty_cycle
> + *
> + * With
> + *   max_period_ns =3D 1 << (7 - prescaler) / pwm_clk * NSEC_PER_SEC
> + *   max_duty_cycle =3D 1 << (7 - prescaler)
> + * this then simplifies to:
> + *   duty_cycle_ns =3D pwm_cycle_reg / pwm_clk * NSEC_PER_SEC
> + *
> + * NSEC_PER_SEC is a multiple of SL28CPLD_PWM_CLK, therefore we're not l=
osing
> + * precision by doing the divison first.

The division you're talking about is NSEC_PER_SEC / pwm_clk which isn't
obvious in the formula in the line above. Maybe:

	...
	this then simplifies to:

	  duty_cycle_ns =3D NSEC_PER_SEC / SL28CPLD_PWM_CLK * pwm_cycle_reg

	NSEC_PER_SEC is a multiple of SL28CPLD_PWM_CLK, therefor ...

to make it easier to understand the comment.

> + */
> +#define SL28CPLD_PWM_TO_DUTY_CYCLE(reg) \
> +	(NSEC_PER_SEC / SL28CPLD_PWM_CLK * (reg))
> +#define SL28CPLD_PWM_FROM_DUTY_CYCLE(duty_cycle) \
> +	(DIV_ROUND_DOWN_ULL((duty_cycle), NSEC_PER_SEC / SL28CPLD_PWM_CLK))
> [...]
> +	/*
> +	 * To avoid glitches when we switch the prescaler, we have to make sure
> +	 * we have a valid duty cycle for the new mode.
> +	 *
> +	 * Take the current prescaler (or the current period length) into
> +	 * account to decide whether we have to write the duty cycle or the new
> +	 * prescaler first. If the period length is decreasing we have to
> +	 * write the duty cycle first.
> +	 */
> +	write_duty_cycle_first =3D pwm->state.period > state->period;
> +
> +	if (write_duty_cycle_first) {
> +		ret =3D sl28cpld_pwm_write(priv, SL28CPLD_PWM_CYCLE, cycle);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D sl28cpld_pwm_write(priv, SL28CPLD_PWM_CTRL, ctrl);
> +	if (ret)
> +		return ret;
> +
> +	if (!write_duty_cycle_first) {
> +		ret =3D sl28cpld_pwm_write(priv, SL28CPLD_PWM_CYCLE, cycle);
> +		if (ret)
> +			return ret;
> +	}

Nice! I didn't spend the necessary brain cycles to confirm this
algorithm, but it seems you did :-)

> +
> +	return 0;
> +}
> [...]

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mw42m5g6wzbjjufm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9XPOgACgkQwfwUeK3K
7AkWZgf9FfNy+2V7VDKBMqCV2TdrX3JZQCu1jkarn2ieFnlW6nZVplR+63wxFR6p
D7E4amJzibzIwMgPt79NI+1LtwNNMI4qEbPOG1zdXo4I6ug4EABv32ih3WMkkdb+
fypHJxYyneVC9nIbRAKHkudi2QfoeikSgtmmAYMw4PG8xc/lqWS3JwNeG4YotvSz
aGgVJqFA/2KW0YywCw1ZFv3m4SVU32nFccbo9EJOztwgKKYpN2eEqqxa7baO3jVW
JgVzGkkGr9dmi5YYl4jZNcs+IhaPE2mFED7AopB+Hw4CD2FLzssJUFYfZiXtv3+4
RuG7iydfC3hp+a3JWDfv66XeBzvaJQ==
=i6C4
-----END PGP SIGNATURE-----

--mw42m5g6wzbjjufm--
