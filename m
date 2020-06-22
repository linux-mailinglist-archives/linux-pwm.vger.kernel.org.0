Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179512030EC
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jun 2020 09:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgFVH5o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Jun 2020 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgFVH5o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Jun 2020 03:57:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C50C061794
        for <linux-pwm@vger.kernel.org>; Mon, 22 Jun 2020 00:57:44 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jnHKc-0001oP-PG; Mon, 22 Jun 2020 09:57:30 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jnHKc-0002V0-Ec; Mon, 22 Jun 2020 09:57:30 +0200
Date:   Mon, 22 Jun 2020 09:57:30 +0200
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
Subject: Re: [PATCH v3 11/15] pwm: crc: Implement get_state() method
Message-ID: <20200622075730.lenaflptqnemagff@taurus.defre.kleine-koenig.org>
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <20200620121758.14836-12-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mw6jshimogmdgtin"
Content-Disposition: inline
In-Reply-To: <20200620121758.14836-12-hdegoede@redhat.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mw6jshimogmdgtin
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2020 at 02:17:54PM +0200, Hans de Goede wrote:
> Implement the pwm_ops.get_state() method to complete the support for the
> new atomic PWM API.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Add Andy's Reviewed-by tag
> - Remove extra whitespace to align some code after assignments (requested=
 by
>   Uwe Kleine-K=F6nig)
> ---
>  drivers/pwm/pwm-crc.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> index 8a7f4707279c..b311354d40a3 100644
> --- a/drivers/pwm/pwm-crc.c
> +++ b/drivers/pwm/pwm-crc.c
> @@ -119,8 +119,37 @@ static int crc_pwm_apply(struct pwm_chip *chip, stru=
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
> +
> +	clk_div =3D (clk_div_reg & ~PWM_OUTPUT_ENABLE) + 1;
> +
> +	state->period =3D clk_div * NSEC_PER_USEC * 256 / PWM_BASE_CLK_MHZ;
> +	state->duty_cycle =3D duty_cycle_reg * state->period / PWM_MAX_LEVEL;

Please round up here.

> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->enabled =3D !!(clk_div_reg & PWM_OUTPUT_ENABLE);
> +}
> +

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mw6jshimogmdgtin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7wZGcACgkQwfwUeK3K
7AnHYQf/UHqz0iNoAxOSBKo9y/pZht9suxpbM0Dp6bl4N2KZwBFN1vRfXlrVWMJG
qWIz+M0A3GBYongVW69fl0CauYETSXE5fovQEmBVi6f+XcWHgH5LcktEXfBKPkY/
x0ZoDxdgT8/8ON4bLXxOmC0GaNV8/Ba5adw3mLO02RMYkTwOlL/v9uyS/++yXv6u
XrJla8RQxooyswhJAQHMrN8es6OrlHb3C2/kEr7Bk4Zdhr6JSmL6jcLKyGXmcwpv
fcc3RiYvvDU06sWU1Gw3W3qUqvoNRtFofHL7ocfsLzxqdAzWZqoQRSuLuHaxP/9n
jAO635ahwfhHvpPtCa1nnE5Gm8HRug==
=DPSI
-----END PGP SIGNATURE-----

--mw6jshimogmdgtin--
