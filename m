Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB66A227B6B
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jul 2020 11:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgGUJNt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 Jul 2020 05:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUJNs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Jul 2020 05:13:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8259FC061794
        for <linux-pwm@vger.kernel.org>; Tue, 21 Jul 2020 02:13:48 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jxoLK-0007cc-KB; Tue, 21 Jul 2020 11:13:46 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jxoLI-000544-SG; Tue, 21 Jul 2020 11:13:44 +0200
Date:   Tue, 21 Jul 2020 11:13:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     vineetha.g.jaya.kumaran@intel.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH v2 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20200721091344.eka44xmkwmqbchm6@pengutronix.de>
References: <1595083628-20734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1595083628-20734-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n2tquz4ug3774r33"
Content-Disposition: inline
In-Reply-To: <1595083628-20734-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--n2tquz4ug3774r33
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Jul 18, 2020 at 10:47:07PM +0800, vineetha.g.jaya.kumaran@intel.com=
 wrote:
> From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
>=20
> Enable PWM support for the Intel Keem Bay SoC.
>=20
> Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.co=
m>
> ---
>  drivers/pwm/Kconfig       |   9 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-keembay.c | 239 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 249 insertions(+)
>  create mode 100644 drivers/pwm/pwm-keembay.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index cb8d739..2b0419b 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -569,4 +569,13 @@ config PWM_ZX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-zx.
> =20
> +config PWM_KEEMBAY
> +	tristate "Intel Keem Bay PWM driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  The platform driver for Intel Keem Bay PWM controller.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-keembay.
> +
>  endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index a59c710..0c84ff2 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -55,3 +55,4 @@ obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
>  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
>  obj-$(CONFIG_PWM_ZX)		+=3D pwm-zx.o
> +obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
> diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
> new file mode 100644
> index 00000000..fa5fe95
> --- /dev/null
> +++ b/drivers/pwm/pwm-keembay.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Keem Bay PWM driver
> + *
> + * Copyright (C) 2020 Intel Corporation
> + * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
> + *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> + */

If possible, please add a link here to documentation for this chip.

> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +#define KMB_TOTAL_PWM_CHANNELS		6
> +#define KMB_PWM_COUNT_MAX		65535

If you write this as hexadecimal constant it is more obvious.

> +#define KMB_PWM_EN_BIT			BIT(31)
> +
> +/* Mask */
> +#define KMB_PWM_HIGH_MASK		GENMASK(31, 16)
> +#define KMB_PWM_LOW_MASK		GENMASK(15, 0)
> +#define KMB_PWM_COUNT_MASK		GENMASK(31, 0)
> +
> +/* PWM Register offset */
> +#define KMB_PWM_LEADIN0_OFFSET		0x00
> +#define KMB_PWM_LEADIN1_OFFSET		0x04
> +#define KMB_PWM_LEADIN2_OFFSET		0x08
> +#define KMB_PWM_LEADIN3_OFFSET		0x0c
> +#define KMB_PWM_LEADIN4_OFFSET		0x10
> +#define KMB_PWM_LEADIN5_OFFSET		0x14

All but ..LEADIN0.. are unused. Is this maybe more useful to write as:

	#define KMB_PWM_LEADIN_OFFSET(ch)	(0x00 + 4 * (ch))

?

> +#define KMB_PWM_HIGHLOW0_OFFSET		0x20
> +#define KMB_PWM_HIGHLOW1_OFFSET		0x24
> +#define KMB_PWM_HIGHLOW2_OFFSET		0x28
> +#define KMB_PWM_HIGHLOW3_OFFSET		0x2c
> +#define KMB_PWM_HIGHLOW4_OFFSET		0x30
> +#define KMB_PWM_HIGHLOW5_OFFSET		0x34

ditto.

> +struct keembay_pwm {
> +	struct pwm_chip chip;
> +	struct device *dev;
> +	struct clk *clk;
> +	void __iomem *base;
> +};
> +
> +static inline struct keembay_pwm *to_keembay_pwm_dev(struct pwm_chip *ch=
ip)
> +{
> +	return container_of(chip, struct keembay_pwm, chip);
> +}
> +
> +static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u32=
 mask,
> +					   u32 val, u32 reg, int ch)
> +{
> +	u32 buff, offset, tmp;
> +	void __iomem *address;
> +
> +	offset =3D reg + ch * 4;
> +	address =3D priv->base + offset;
> +	buff =3D readl(address);
> +	tmp =3D buff & ~mask;
> +	tmp |=3D FIELD_PREP(mask, val);
> +	writel(tmp, address);
> +}
> +
> +static void keembay_pwm_enable(struct keembay_pwm *priv, int ch)
> +{
> +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 1,
> +				KMB_PWM_LEADIN0_OFFSET, ch);
> +}
> +
> +static void keembay_pwm_disable(struct keembay_pwm *priv, int ch)
> +{
> +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 0,
> +				KMB_PWM_LEADIN0_OFFSET, ch);
> +}
> +
> +static void keembay_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> +	unsigned long long pwm_h_count, pwm_l_count;
> +	unsigned long clk_rate;
> +	u32 buff;
> +
> +	clk_rate =3D clk_get_rate(priv->clk);
> +
> +	/* Read channel enabled status */
> +	buff =3D readl(priv->base + KMB_PWM_LEADIN0_OFFSET + pwm->hwpwm * 4);
> +	if (buff & KMB_PWM_EN_BIT)
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +
> +	/* Read period and duty cycle*/

Missing ' ' before closing */

> +	buff =3D readl(priv->base + KMB_PWM_HIGHLOW0_OFFSET + pwm->hwpwm * 4);
> +	pwm_l_count =3D (buff & KMB_PWM_LOW_MASK) * NSEC_PER_SEC;
> +	pwm_h_count =3D ((buff & KMB_PWM_HIGH_MASK) >> 16) * NSEC_PER_SEC;

pwm_h_count =3D FIELD_GET(KMB_PWM_HIGH_MASK, buff) * NSEC_PER_SEC

> +	state->duty_cycle =3D pwm_h_count / clk_rate;
> +	state->period =3D (pwm_h_count + pwm_l_count) / clk_rate;

Please round up both values.

> +}
> +
> +static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> +	struct pwm_state current_state;
> +	u16 pwm_h_count, pwm_l_count;
> +	unsigned long long div;
> +	unsigned long clk_rate;
> +	u32 pwm_count =3D 0;
> +
> +	pwm_get_state(pwm, &current_state);

Please check the hardware state, not the value cached in the PWM
framework.

> +	if (!state->enabled && current_state.enabled) {
> +		keembay_pwm_disable(priv, pwm->hwpwm);
> +		return 0;
> +	}
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -ENOSYS;

This must be checked before .enabled. That's because the expectation on

	.enabled =3D false
	.polarity =3D PWM_POLARITY_INVERSED

is that the output gets constant high.

> +	/*
> +	 * The upper 16 bits of the KMB_PWM_HIGHLOWx_OFFSET register contain
> +	 * the high time of the waveform, while the last 16 bits contain
> +	 * the low time of the waveform, in terms of clock cycles.

Just to be sure: Each period starts with the high time, right?

> +	 * high time =3D clock rate * duty cycle / NSEC_PER_SEC
> +	 * low time =3D  clock rate * (period - duty cycle) / NSEC_PER_SEC
> +	 *
> +	 * e.g. For period 50000ns, duty cycle 30000ns, and clock rate 500MHz:
> +	 * high time =3D (500000000 * 30000) / 1000000000 =3D 0x3A98
> +	 * low time =3D (500000000 * 20000) / 1000000000 =3D 0x2710
> +	 * Value written to KMB_PWM_HIGHLOWx_OFFSET =3D 0x3A982710

For period =3D 50000ns, duty_cycle =3D 30000ns and clock rate 266666666 Hz =
you
have to configure:

	high =3D 7999
	low =3D 5334

> +	 */
> +
> +	clk_rate =3D clk_get_rate(priv->clk);
> +
> +	/* Configure waveform high time */
> +	div =3D clk_rate * state->duty_cycle;
> +	do_div(div, NSEC_PER_SEC);

Can this overflow?

> +	if (div > KMB_PWM_COUNT_MAX)
> +		return -ERANGE;
> +
> +	pwm_h_count =3D (u16)div;

No need for this cast.

> +	/* Configure waveform low time */
> +	div =3D clk_rate * (state->period - state->duty_cycle);
> +	do_div(div, NSEC_PER_SEC);

Here the rounding is wrong. (See above example, currently you use
low =3D 5333 here)

> +	if (div > KMB_PWM_COUNT_MAX)
> +		return -ERANGE;
> +
> +	pwm_l_count =3D (u16)div;
> +
> +	pwm_count |=3D pwm_h_count << 16;
> +	pwm_count |=3D pwm_l_count;

pwm_count =3D FIELD_PREP(KMB_PWM_HIGH_MASK, pwm_h_count) | FIELD_PREP(KMB_P=
WM_LOW_MASK, pwm_l_count);

> +
> +	keembay_pwm_update_bits(priv, KMB_PWM_COUNT_MASK,
> +				pwm_count, KMB_PWM_HIGHLOW0_OFFSET, pwm->hwpwm);

here the rwm-procedure is not necessary as all 32 bits are written
anyhow.

> +	if (state->enabled && !current_state.enabled)
> +		keembay_pwm_enable(priv, pwm->hwpwm);
> +
> +	return 0;
> +}
> [...]
> +MODULE_ALIAS("platform:keembay");

This has to match your driver's name, so use:

	MODULE_ALIAS("platform:pwm-keembay");
=09
> +MODULE_DESCRIPTION("Intel Keem Bay PWM driver");
> +MODULE_LICENSE("GPL v2");

In v1 you told that on reconfiguration the hardware completes the
currently running period. Please document this in the driver, similar to
e.g. pwm-sifive.c.

You only ever write the enable bit in the leadin register. If there is
something !=3D 0 at boot this influences the correct behaviour of the
driver, right?

Further things to note there:

 - What is the behaviour on disable (usual candidates: freezes at
   current value, completes period and emits low, changes to High-Z)?

 - Can it do 0% and 100% duty ratio?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--n2tquz4ug3774r33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8WscUACgkQwfwUeK3K
7Ak4ygf/YqRbBmAufohPKRkRj0nh8H/9JALK13fYvDdTIr5iof+5Md7t5732w5h2
SQu8TPgSYhUl9VhdvneDXbueBb6K9CQ80/SENBP2vgMNe1BEO8Bp1VUVK54aYTAK
Mw26NJKMeV6jfHDJ4a39VcicTLWT/i50t2EiFMJaaSdsCBuHz0u3evjWRkYZPtws
CSpDPcEOkAKK//+nosIqjlvDiUr8CKfeHhd1Km1dT1mwFpAT+Z7g1/fVxNLq63E2
tyjbuNAsBOCoq5YgDlbUTqg4piwlBkUqJRlektxF0fa8Lb9qaf/C5Pol5v9TyyqF
/bNP4Uvf6Tdz3+Fn86aiLeqCmXYZ4A==
=X2vE
-----END PGP SIGNATURE-----

--n2tquz4ug3774r33--
