Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CBA1F6F83
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jun 2020 23:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgFKVh7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 11 Jun 2020 17:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgFKVh7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 Jun 2020 17:37:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3F3C08C5C1
        for <linux-pwm@vger.kernel.org>; Thu, 11 Jun 2020 14:37:58 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jjUtQ-0006Nh-Qd; Thu, 11 Jun 2020 23:37:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jjUtP-0005wH-Ot; Thu, 11 Jun 2020 23:37:47 +0200
Date:   Thu, 11 Jun 2020 23:37:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 11/15] pwm: crc: Implement get_state() method
Message-ID: <20200611213744.6gg2oy45cende6ba@taurus.defre.kleine-koenig.org>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-12-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zx4xnht5tvc5agd3"
Content-Disposition: inline
In-Reply-To: <20200607181840.13536-12-hdegoede@redhat.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zx4xnht5tvc5agd3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Jun 07, 2020 at 08:18:36PM +0200, Hans de Goede wrote:
> Implement the pwm_ops.get_state() method to complete the support for the
> new atomic PWM API.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-crc.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> index 58c7e9ef7278..6c75a3470bc8 100644
> --- a/drivers/pwm/pwm-crc.c
> +++ b/drivers/pwm/pwm-crc.c
> @@ -114,8 +114,37 @@ static int crc_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  	return 0;
>  }
> =20
> +static void crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			       struct pwm_state *state)
> +{
> +	struct crystalcove_pwm *crc_pwm =3D to_crc_pwm(chip);
> +	struct device *dev =3D crc_pwm->chip.dev;
> +	unsigned int clk_div, clk_div_reg, duty_cycle_reg;
> +	int error;
> +
> +	error =3D regmap_read(crc_pwm->regmap, PWM0_CLK_DIV, &clk_div_reg);
> +	if (error) {
> +		dev_err(dev, "Error reading PWM0_CLK_DIV %d\n", error);
> +		return;
> +	}
> +
> +	error =3D regmap_read(crc_pwm->regmap, PWM0_DUTY_CYCLE, &duty_cycle_reg=
);
> +	if (error) {
> +		dev_err(dev, "Error reading PWM0_DUTY_CYCLE %d\n", error);
> +		return;
> +	}

I assume that duty_cycle_reg cannot be bigger than 0xff? Would it make
sense to mask the value accordingly to get more robust code?

> +	clk_div =3D (clk_div_reg & ~PWM_OUTPUT_ENABLE) + 1;
> +
> +	state->period     =3D clk_div * NSEC_PER_MHZ * 256 / PWM_BASE_CLK_MHZ;
> +	state->duty_cycle =3D duty_cycle_reg * state->period / PWM_MAX_LEVEL;
> +	state->polarity   =3D PWM_POLARITY_NORMAL;
> +	state->enabled    =3D !!(clk_div_reg & PWM_OUTPUT_ENABLE);

These aligned =3D look strange (IMHO). If you don't feel strong here I'd
like to see a single space before a =3D.

Unrelated to your series I think we should change .get_state() to return
an error indication.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zx4xnht5tvc5agd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7ipCQACgkQwfwUeK3K
7AkDQQgAhCr0b+oxbYjfh2z4WfLZOGF5W1hB1COjpmxeKaGL8xpCEc/dnjT7fxJX
uB0sF9bAF8OAVNpkrIOrnZtw7aBK3SFynWAOpXf98Z8Kb9FodW8FL6C/a27ZVGqc
byX4ZUKbU66PyWFa7yT/s+lmc8l5aANu/apc+QQtEiARmRtPSQ8lzXdoZ8Am7zXw
empFZFcffWxK/ZoCPr5Mf+d6edogPrj5o11QGhNS6RqNl6tvC5kEmq6mkYEelu6f
eM5q33YnGKgMaAiwZMPmSGNoYsaK2ZkDnMK5MMw7tCtJs5c6BfwVni1oHAiuYPl9
jGebXYXjKp8HsebBbbotUcspHgxMIg==
=Ox3L
-----END PGP SIGNATURE-----

--zx4xnht5tvc5agd3--
