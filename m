Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA913635A2
	for <lists+linux-pwm@lfdr.de>; Sun, 18 Apr 2021 15:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhDRNpD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 18 Apr 2021 09:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhDRNpC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 18 Apr 2021 09:45:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B2AC06174A
        for <linux-pwm@vger.kernel.org>; Sun, 18 Apr 2021 06:44:34 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lY7im-0005Yg-G0; Sun, 18 Apr 2021 15:44:20 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lY7ig-0006c9-BO; Sun, 18 Apr 2021 15:44:14 +0200
Date:   Sun, 18 Apr 2021 15:44:11 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
Message-ID: <20210418134411.vfltokielrwuygqa@pengutronix.de>
References: <20210418110904.1942806-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210418110904.1942806-3-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bgb6vkbm2v3bjabj"
Content-Disposition: inline
In-Reply-To: <20210418110904.1942806-3-nobuhiro1.iwamatsu@toshiba.co.jp>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bgb6vkbm2v3bjabj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

just a few smaller issues left to fix.

On Sun, Apr 18, 2021 at 08:09:04PM +0900, Nobuhiro Iwamatsu wrote:
> diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
> new file mode 100644
> index 000000000000..166b18ac1a3a
> --- /dev/null
> +++ b/drivers/pwm/pwm-visconti.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Toshiba Visconti pulse-width-modulation controller driver
> + *
> + * Copyright (c) 2020 TOSHIBA CORPORATION
> + * Copyright (c) 2020 Toshiba Electronic Devices & Storage Corporation

We're in 2021, so you might want to adapt the year in the copy right
notice.

> + *
> + * Authors: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> + *
> + * Limitations:
> + * - PIPGM_PWMC is a 2-bit divider (00: 1, 01: 2, 10: 4, 11: 8).

This is too detailed for the purpose of this section. Please either drop
it or make this:

 - The fixed input clock is running at 1 MHz and is divided by either 1,
   2, 4 or 8.

> + * - Fixed input clock running at 1 MHz.
> + * - When the settings of the PWM are modified, the new values are shado=
wed
> + *   in hardware until the PIPGM_PCSR register is written and the curren=
tly
> + *   running period is completed. This way the hardware switches atomica=
lly
> + *   from the old setting to the new.
> + * - Disabling the hardware completes the currently running period and k=
eeps
> + *   the output at low level at all times.
> + */
> +
> [...]
> +	/*
> +	 * PWMC controls a divider that divides the input clk by a
> +	 * power of two between 1 and 8. As a smaller divider yields
> +	 * higher precision, pick the smallest possible one.
> +	 */
> +	if (period > 0xffff) {
> +		pwmc0 =3D ilog2(period >> 16);
> +		BUG_ON(pwmc0 > 3);
> +	} else
> +		pwmc0 =3D 0;

The linux coding style mandates that you should use braces for both
branches. (i.e.

+	if (period > 0xffff) {
+		pwmc0 =3D ilog2(period >> 16);
+		BUG_ON(pwmc0 > 3);
+	} else {
+		pwmc0 =3D 0;
+	}
)

> +	period >>=3D pwmc0;
> +	duty_cycle >>=3D pwmc0;
> +
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		pwmc0 |=3D PIPGM_PWMC_PWMACT;
> +	writel(pwmc0, priv->base + PIPGM_PWMC(pwm->hwpwm));
> +	writel(duty_cycle, priv->base + PIPGM_PDUT(pwm->hwpwm));
> +	writel(period, priv->base + PIPGM_PCSR(pwm->hwpwm));
> +
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bgb6vkbm2v3bjabj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB8N6gACgkQwfwUeK3K
7Anj2Af/WqUKM5BqP7zkeYG608r86aZH7diBe5BWPMf80rLImrviWBmFt6uw5otH
qog680Qlj2ODFIfAvFBjiW+tRakmjrqrJrcgYV5/SPS+95Eo/7Ym8Ri34eCIobWS
9lFQk1uRq8i02WymB7oQ/BEOerzCk2BiCJ7BmZu1AYVjRgydr+7QG/fLFqez3Mox
IgRRqBRTCHAnYCorF6YcG17Q5vi6iEHKb1yUymxWkK3IUDrfkOI3iOYlkcR1ZLKR
wZAngejexWOhcv+POJ28bq9PywjfmGLFxVD4AfS616FHSSCuZo54okDaSjH4dckP
mEdq5uZ48A2JhhYKG+abRo0BADLAZg==
=fos0
-----END PGP SIGNATURE-----

--bgb6vkbm2v3bjabj--
