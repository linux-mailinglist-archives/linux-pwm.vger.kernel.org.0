Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FFC333BCF
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Mar 2021 12:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhCJLvB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 10 Mar 2021 06:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhCJLut (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Mar 2021 06:50:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ED1C06174A
        for <linux-pwm@vger.kernel.org>; Wed, 10 Mar 2021 03:50:49 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lJxMS-0000dy-H8; Wed, 10 Mar 2021 12:50:44 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lJxMQ-0001h5-O7; Wed, 10 Mar 2021 12:50:42 +0100
Date:   Wed, 10 Mar 2021 12:50:41 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v7 11/11] pwm: Add Raspberry Pi Firmware based PWM bus
Message-ID: <20210310115041.s7tzvgdpksws6yss@pengutronix.de>
References: <20210118123244.13669-1-nsaenzjulienne@suse.de>
 <20210118123244.13669-12-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ul6qbztvwf7nowqu"
Content-Disposition: inline
In-Reply-To: <20210118123244.13669-12-nsaenzjulienne@suse.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ul6qbztvwf7nowqu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nicolas,

On Mon, Jan 18, 2021 at 01:32:44PM +0100, Nicolas Saenz Julienne wrote:
> diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberr=
ypi-poe.c
> new file mode 100644
> index 000000000000..ca845e8fabe6
> --- /dev/null
> +++ b/drivers/pwm/pwm-raspberrypi-poe.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> + * For more information on Raspberry Pi's PoE hat see:
> + * https://www.raspberrypi.org/products/poe-hat/
> + *
> + * Limitations:
> + *  - No disable bit, so a disabled PWM is simulated by duty_cycle 0
> + *  - Only normal polarity
> + *  - Fixed 12.5 kHz period
> + *
> + * The current period is completed when HW is reconfigured.

nice.

> + */
> +
> [...]
> +static int raspberrypi_pwm_apply(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 const struct pwm_state *state)
> +{
> +	struct raspberrypi_pwm *rpipwm =3D raspberrypi_pwm_from_chip(chip);
> +	unsigned int duty_cycle;
> +	int ret;
> +
> +	if (state->period < RPI_PWM_PERIOD_NS ||
> +	    state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled)
> +		duty_cycle =3D 0;
> +	else if (state->duty_cycle < RPI_PWM_PERIOD_NS)
> +		duty_cycle =3D DIV_ROUND_DOWN_ULL(state->duty_cycle * RPI_PWM_MAX_DUTY,
> +						RPI_PWM_PERIOD_NS);
> +	else
> +		duty_cycle =3D RPI_PWM_MAX_DUTY;
> +
> +	if (duty_cycle =3D=3D rpipwm->duty_cycle)
> +		return 0;
> +
> +	ret =3D raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_CUR_DUTY=
_REG,
> +					   duty_cycle);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to set duty cycle: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	/*
> +	 * This sets the default duty cycle after resetting the board, we
> +	 * updated it every time to mimic Raspberry Pi's downstream's driver
> +	 * behaviour.
> +	 */
> +	ret =3D raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_DEF_DUTY=
_REG,
> +					   duty_cycle);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to set default duty cycle: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;

This only has an effect for the next reboot, right? If so I wonder if it
is a good idea in general. (Think: The current PWM setting enables a
motor that makes a self-driving car move at 100 km/h. Consider the rpi
crashes, do I want to car to pick up driving 100 km/h at power up even
before Linux is up again?) And if we agree it's a good idea: Should
raspberrypi_pwm_apply return 0 if setting the duty cycle succeeded and
only setting the default didn't?

Other than that the patch looks fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ul6qbztvwf7nowqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBIso0ACgkQwfwUeK3K
7An3RQgAk7LiLPojRn3qgp/eEHGcY24aQQQnYHXFzwvNNsqfY9q1T6NOjwiJlIBj
owBPtq8IteT+V4qhiiQuB4MLMbNeaBZ+iR4l7OVDwzwuPrHtZuGFxz7vZumxdIET
Eqq1G++2nk48ZFJOUnKeWM733IgWZQwaM0XEr04i58ZjnoJ9mZo7g4nC2c8O6F6A
HQshnIGC2hEIZbpmpQrBOMI92Uh0pt03ScuCXM4o/YUuKxb8oeygwt963lrJwhXp
Vb1/aPD/lELD/kAAeOa3cje1nAdfEJPzH0kjIMfXNTkX8TeEEA0klNEEOXkVxrTP
0c+bK2SaxSe/2i1555OooX7x1H2VCg==
=540n
-----END PGP SIGNATURE-----

--ul6qbztvwf7nowqu--
