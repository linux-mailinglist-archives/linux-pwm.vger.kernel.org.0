Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B9440AE2B
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Sep 2021 14:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhINMvc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Sep 2021 08:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhINMvb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Sep 2021 08:51:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6822AC061760
        for <linux-pwm@vger.kernel.org>; Tue, 14 Sep 2021 05:50:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQ7sy-0003Pn-CH; Tue, 14 Sep 2021 14:50:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQ7sv-0006MQ-Gg; Tue, 14 Sep 2021 14:50:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQ7sv-0006x5-F8; Tue, 14 Sep 2021 14:50:01 +0200
Date:   Tue, 14 Sep 2021 14:49:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v8 2/4] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <20210914124959.spwjiifvysposhls@pengutronix.de>
References: <5c95bcf62a9d08208a7da19f0b1cec0689502b9a.1630323987.git.baruch@tkos.co.il>
 <bdc61569e4068490f53f347dcf29ee9539a8bc0b.1630323987.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kqyldxkbyhgsihnp"
Content-Disposition: inline
In-Reply-To: <bdc61569e4068490f53f347dcf29ee9539a8bc0b.1630323987.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--kqyldxkbyhgsihnp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Baruch,

On Mon, Aug 30, 2021 at 02:46:25PM +0300, Baruch Siach wrote:
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c76adedd58c9..08add845596f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -260,6 +260,18 @@ config PWM_INTEL_LGM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-intel-lgm.
> =20
> +config PWM_IPQ
> +	tristate "IPQ PWM support"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on HAVE_CLK && HAS_IOMEM
> +	help
> +	  Generic PWM framework driver for IPQ PWM block which supports
> +	  4 pwm channels. Each of the these channels can be configured
> +	  independent of each other.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-ipq.
> +
>  config PWM_IQS620A
>  	tristate "Azoteq IQS620A PWM support"
>  	depends on MFD_IQS62X || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 708840b7fba8..7402feae4b36 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
>  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
>  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_INTEL_LGM)	+=3D pwm-intel-lgm.o
> +obj-$(CONFIG_PWM_IPQ)		+=3D pwm-ipq.o
>  obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
>  obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
> diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
> new file mode 100644
> index 000000000000..8405d0554951
> --- /dev/null
> +++ b/drivers/pwm/pwm-ipq.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserv=
ed.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/math64.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>
> +
> +/* The frequency range supported is 1 Hz to clock rate */
> +#define IPQ_PWM_MAX_PERIOD_NS	((u64)NSEC_PER_SEC)
> +
> +/*
> + * The max value specified for each field is based on the number of bits
> + * in the pwm control register for that field
> + */
> +#define IPQ_PWM_MAX_DIV		0xFFFF
> +
> +/*
> + * Two 32-bit registers for each PWM: REG0, and REG1.
> + * Base offset for PWM #i is at 8 * #i.
> + */
> +#define IPQ_PWM_CFG_REG0 0 /*PWM_DIV PWM_HI*/
> +#define IPQ_PWM_REG0_PWM_DIV		GENMASK(15, 0)
> +#define IPQ_PWM_REG0_HI_DURATION	GENMASK(31, 16)

Assuming that IPQ_PWM_REG0_PWM_DIV is a field in IPQ_PWM_CFG_REG0: I
wonder why the former has not "CFG" in it's name?! Ditto below.

> +#define IPQ_PWM_CFG_REG1 4 /*ENABLE UPDATE PWM_PRE_DIV*/
> +#define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)
> +/*
> + * Enable bit is set to enable output toggling in pwm device.
> + * Update bit is set to reflect the changed divider and high duration
> + * values in register.
> + */
> +#define IPQ_PWM_REG1_UPDATE		BIT(30)
> +#define IPQ_PWM_REG1_ENABLE		BIT(31)
> +
> +
> +struct ipq_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct regmap *regmap;
> +	u32 regmap_off;
> +};
> +
> +static struct ipq_pwm_chip *to_ipq_pwm_chip(struct pwm_chip *chip)

I would have called this ipq_pwm_from_chip() to have this function's
name use the common prefix, too. (But note that Thierry might not agree
here.)

> +{
> +	return container_of(chip, struct ipq_pwm_chip, chip);
> +}
> +
> +static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned re=
g)

checkpatch warns about this line

> +{
> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(pwm->chip);
> +	unsigned int off =3D ipq_chip->regmap_off + 8 * pwm->hwpwm + reg;
> +	unsigned int val;
> +
> +	regmap_read(ipq_chip->regmap, off, &val);

You don't expect regmap_read returning an error? Maybe note that in a
comment to prevent someone preparing patches checking the error. Or
alternatively add a WARN_ONCE when this fails?

> +	return val;
> +}
> +
> +static void ipq_pwm_reg_write(struct pwm_device *pwm, unsigned reg,
> +		unsigned val)

I expected that checkpatch warns here, too, and advises to align follow
up lines to the opening ( in the previous line. So it's me who has to
criticize that.

> +{
> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(pwm->chip);
> +	unsigned int off =3D ipq_chip->regmap_off + 8 * pwm->hwpwm + reg;
> +
> +	regmap_write(ipq_chip->regmap, off, val);
> +}
> +
> +static void config_div_and_duty(struct pwm_device *pwm, unsigned int pre=
_div,
> +			unsigned int pwm_div, unsigned long rate, u64 duty_ns,
> +			bool enable)
> +{
> +	unsigned long hi_dur;
> +	unsigned long val =3D 0;
> +
> +	/*
> +	 * high duration =3D pwm duty * (pwm div + 1)
> +	 * pwm duty =3D duty_ns / period_ns
> +	 */
> +	hi_dur =3D div64_u64(duty_ns * rate, (pre_div + 1) * NSEC_PER_SEC);
> +
> +	val =3D FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
> +		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG0, val);
> +
> +	val =3D FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG1, val);
> +
> +	/* Enable needs a separate write to REG1 */

s/Enable/Updating REG1/ ?

> +	val |=3D IPQ_PWM_REG1_UPDATE;
> +	if (enable)
> +		val |=3D IPQ_PWM_REG1_ENABLE;
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG1, val);
> +}
> +
> +static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(chip);
> +	unsigned long freq;
> +	unsigned int pre_div, pwm_div, best_pre_div, best_pwm_div;
> +	long long diff;
> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
> +	unsigned long min_diff =3D rate;
> +	u64 period_ns, duty_ns;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (state->period < div64_u64(NSEC_PER_SEC, rate))
> +		return -ERANGE;
> +
> +	period_ns =3D min(state->period, IPQ_PWM_MAX_PERIOD_NS);
> +	duty_ns =3D min(state->duty_cycle, period_ns);
> +
> +	/* freq in Hz for period in nano second */
> +	freq =3D div64_u64(NSEC_PER_SEC, period_ns);

You're loosing quite some precision here. Consider a clock rate of
266666667 Hz and period =3D 500000001 ns.

Then we end up with freq =3D 1 (while the exact result is nearly 2) which
results in diff below being too small.

> +	best_pre_div =3D IPQ_PWM_MAX_DIV;
> +	best_pwm_div =3D IPQ_PWM_MAX_DIV;
> +	/* Initial pre_div value such that pwm_div < IPQ_PWM_MAX_DIV */
> +	pre_div =3D DIV64_U64_ROUND_UP(period_ns * rate,
> +			(u64)NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1));

This is wrong, you need to round down here. (Consider cases where you
need pre_div =3D 0.)

> +
> +	for (; pre_div <=3D IPQ_PWM_MAX_DIV; pre_div++) {
> +		pwm_div =3D DIV64_U64_ROUND_UP(period_ns * rate,
> +				(u64)NSEC_PER_SEC * (pre_div + 1));
> +		pwm_div--;

Can it happen that pwm_div is zero before it is decreased by one? Also
you need to round down here; with rounding up the resulting period is
bigger than the requested period (unless the division yields an exact
integer).

> +		if (pre_div > pwm_div)
> +			break;

A comment here why we can end the search would be good.

> +		/*
> +		 * Make sure we can do 100% duty cycle where
> +		 * hi_dur =3D=3D pwm_div + 1
> +		 */
> +		if (pwm_div > IPQ_PWM_MAX_DIV - 1)
> +			continue;
> +
> +		diff =3D ((uint64_t)freq * (pre_div + 1) * (pwm_div + 1))
> +			- (uint64_t)rate;
> +
> +		if (diff < 0) /* period larger than requested */
> +			continue;
> +		if (diff =3D=3D 0) { /* bingo */
> +			best_pre_div =3D pre_div;
> +			best_pwm_div =3D pwm_div;
> +			break;
> +		}
> +		if (diff < min_diff) {
> +			min_diff =3D diff;
> +			best_pre_div =3D pre_div;
> +			best_pwm_div =3D pwm_div;
> +		}
> +	}
> +
> +	/* config divider values for the closest possible frequency */
> +	config_div_and_duty(pwm, best_pre_div, best_pwm_div,
> +			    rate, duty_ns, state->enabled);
> +
> +	return 0;
> +}
> +
> +static void ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      struct pwm_state *state)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(chip);
> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
> +	unsigned int pre_div, pwm_div, hi_dur;
> +	u64 effective_div, hi_div;
> +	u32 reg0, reg1;
> +
> +	reg0 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_CFG_REG0);
> +	reg1 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_CFG_REG1);
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->enabled =3D reg1 & IPQ_PWM_REG1_ENABLE;
> +
> +	pwm_div =3D FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
> +	hi_dur =3D FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
> +	pre_div =3D FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
> +
> +	/* No overflow here, both pre_div and pwm_div <=3D 0xffff */
> +	effective_div =3D (u64)(pre_div + 1) * (pwm_div + 1);
> +	state->period =3D div64_u64(effective_div * NSEC_PER_SEC, rate);

You have to round up here to make apply . get_state idempotent.

> +	hi_div =3D hi_dur * (pre_div + 1);
> +	state->duty_cycle =3D div64_u64(hi_div * NSEC_PER_SEC, rate);
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kqyldxkbyhgsihnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFAmnQACgkQwfwUeK3K
7AkuAQf/aW5lxy/sZhu1FYXjhXt8bEX0ZZtODsMFvdw3WJWJmJVlRvS4BvzUGvRg
Vevu6jpj64N4ryR1vzP22wmJUt3XnT4ibR2lc/SxtuGNAwhSY6+zJ2lr3os1WTyA
qZYU5v2JTkJTbUrm83nPCE2oOuEpg2/aFRHMSt27wlNMi4d3GM8Inm7Ot+aQ6hbf
tP4OcHWVrx71EPDy7Kzy3WiRld4pJacqxtpDVa3pU2+BypqcS+EUaRVMjrV8Fip3
DaAjZrTz98i7DGeAs7t8BH4j9naAVT65iiSmxQNfiAL6dMyUVXAuGkP/OBBu3V9v
GntX09gS2MVul36UCu3wCi78SPKq0g==
=xk9H
-----END PGP SIGNATURE-----

--kqyldxkbyhgsihnp--
