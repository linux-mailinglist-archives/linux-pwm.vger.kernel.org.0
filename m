Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B77B35BA88
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 09:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhDLHDG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 03:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbhDLHDF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 03:03:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB9BC061574
        for <linux-pwm@vger.kernel.org>; Mon, 12 Apr 2021 00:02:48 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVqah-0002Yf-Kn; Mon, 12 Apr 2021 09:02:35 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVqae-00059Z-JF; Mon, 12 Apr 2021 09:02:32 +0200
Date:   Mon, 12 Apr 2021 09:02:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
Message-ID: <20210412070232.6q3cgqvuj53p4cmi@pengutronix.de>
References: <20210409230837.1919744-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409230837.1919744-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210410135321.oissremqropvrpd3@pengutronix.de>
 <20210412025536.i5chpp6sighunvfx@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dbinp4a6o4qjki4w"
Content-Disposition: inline
In-Reply-To: <20210412025536.i5chpp6sighunvfx@toshiba.co.jp>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dbinp4a6o4qjki4w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 11:55:36AM +0900, Nobuhiro Iwamatsu wrote:
> Hi Uwe,
>=20
> Thanks for your review.
>=20
> On Sat, Apr 10, 2021 at 03:53:21PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > just a few small details left to criticize ...
> >=20
> > On Sat, Apr 10, 2021 at 08:08:37AM +0900, Nobuhiro Iwamatsu wrote:
> > > diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
> > > new file mode 100644
> > > index 000000000000..99d83f94ed86
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-visconti.c
> > > @@ -0,0 +1,188 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Toshiba Visconti pulse-width-modulation controller driver
> > > + *
> > > + * Copyright (c) 2020 TOSHIBA CORPORATION
> > > + * Copyright (c) 2020 Toshiba Electronic Devices & Storage Corporati=
on
> > > + *
> > > + * Authors: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > > + *
> > > + */
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pwm.h>
> > > +
> > > +#define PIPGM_PCSR(ch) (0x400 + 4 * (ch))
> > > +#define PIPGM_PDUT(ch) (0x420 + 4 * (ch))
> > > +#define PIPGM_PWMC(ch) (0x440 + 4 * (ch))
> > > +
> > > +#define PIPGM_PWMC_PWMACT		BIT(5)
> > > +#define PIPGM_PWMC_CLK_MASK		GENMASK(1, 0)
> > > +#define PIPGM_PWMC_POLARITY_MASK	GENMASK(5, 5)
> > > +
> > > +struct visconti_pwm_chip {
> > > +	struct pwm_chip chip;
> > > +	void __iomem *base;
> > > +};
> > > +
> > > +static inline struct visconti_pwm_chip *to_visconti_chip(struct pwm_=
chip *chip)
> > > +{
> > > +	return container_of(chip, struct visconti_pwm_chip, chip);
> > > +}
> > > +
> > > +static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> > > +			      const struct pwm_state *state)
> > > +{
> > > +	struct visconti_pwm_chip *priv =3D to_visconti_chip(chip);
> > > +	u32 period, duty_cycle, pwmc0;
> > > +
> > > +	/*
> > > +	 * pwmc is a 2-bit divider for the input clock running at 1 MHz.
> > > +	 * When the settings of the PWM are modified, the new values are sh=
adowed in hardware until
> > > +	 * the period register (PCSR) is written and the currently running =
period is completed. This
> > > +	 * way the hardware switches atomically from the old setting to the=
 new.
> > > +	 * Also, disabling the hardware completes the currently running per=
iod and keeps the output
> > > +	 * at low level at all times.
> >=20
> > Can you please put a paragraph analogous to the one in pwm-sifive in the
> > same format. This simplified keeping an overview about the oddities of
> > the various supported chips.
>=20
> OK, I will check pwm-sifive's, and add.
>=20
> >=20
> > > +	 */
> > > +	if (!state->enabled) {
> > > +		writel(0, priv->base + PIPGM_PCSR(pwm->hwpwm));
> > > +		return 0;
> > > +	}
> > > +
> > > [...]
> > > +
> > > +static void visconti_pwm_get_state(struct pwm_chip *chip, struct pwm=
_device *pwm,
> > > +				   struct pwm_state *state)
> > > +{
> > > +	struct visconti_pwm_chip *priv =3D chip_to_priv(chip);
> > > +	u32 period, duty, pwmc0, pwmc0_clk;
> > > +
> > > +	period =3D readl(priv->base + PIPGM_PCSR(pwm->hwpwm));
> > > +	if (period)
> > > +		state->enabled =3D true;
> > > +	else
> > > +		state->enabled =3D false;
> >=20
> > If PIPGM_PCSR is 0 the hardware is still active and setting a new
> > configuration completes the currently running period, right? Then I
> > think having always state->enabled =3D true is a better match.
>
> If PIPGM_PCSR is 0, the hardware is stopped. Even if the settings of
> other registers are written, the values of other registers will not work
> unless PIPGM_PCSR is written.

Correct me if I'm wrong, but how I understand it, PCSR is special as the
other registers are shadow until PCSR is written. (And that is
irrespective of which value is active in PCSR or what is written to
PCSR.)
=20
> However, as a logic, if PIPGM_PCSR becomes 0, it is only
> visconti_pwm_apply () in this driver,
> so I think that this process should always be state-> enabled =3D true
> as you pointed out.
> I wil drop this, thanks.

For me the critical (and only) difference between "off" and
"duty cycle =3D 0" is that when a new configuration is to be applied. In
the "off" state a new period can (and should) start immediately, while
with "duty_cycle =3D 0" the rising edge should be delayed until the
currently running period is over.[1]

So the thing to do here (IMHO) is:

Iff with PIPGM_PCSR =3D 0 configuring a new setting (that is finalized
with writing a non-zero value to PIPGM_PCSR) completes the currently
running period, then always assume the PWM as enabled.

And so if the hardware is stopped and the counter is reset when 0 is
written to PIPGM_PCSR, model that as enabled =3D false.

Best regards
Uwe

[1] In practise this is more difficult because several PWMs don't
complete periods in general. But the hardware under discussion luckily
isn't one of these. And (worse) there are other hardware implementations
where off doesn't emit an inactive level.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dbinp4a6o4qjki4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBz8IUACgkQwfwUeK3K
7Anv+ggAgcYjZXZNUVrkCgcupmpCm3IMfKahkwjrc5xduTQHdRPMTqPrJhyuwF7a
G8bOQ5pxUHH5MEqns/nG8HTPawjKDgy36NLfDdY7yDQdKT15PsvXkHD6wUydcXzd
Hn41ovzjGJUi4bkqjI8iLwCARX6ypaKh66IVZ/yRjJA1B2FkCbqfRgE8PHu78NJd
GU+OrhCgmXyJ5e7FAcfDn5dlMVTpHbzxyGouC8PXtCCFgC5YLy2+Ajp3Y2ldv5Qs
ceQ7LOzHqJ4NsiBq74KTOUFo2lTMZW9kzLl/upBxEhh/7jLRlJHFmx4jyb/LJOKe
V+HuRxtoXSlhoOcb2azTl12IPVESZw==
=+9VN
-----END PGP SIGNATURE-----

--dbinp4a6o4qjki4w--
