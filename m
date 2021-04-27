Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4425536CA10
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Apr 2021 19:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhD0RIm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Apr 2021 13:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbhD0RIl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Apr 2021 13:08:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3CBC061574
        for <linux-pwm@vger.kernel.org>; Tue, 27 Apr 2021 10:07:57 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lbRBg-00048s-CR; Tue, 27 Apr 2021 19:07:52 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lbRBf-0005ag-Qa; Tue, 27 Apr 2021 19:07:51 +0200
Date:   Tue, 27 Apr 2021 19:07:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fenglin Wu <fenglinw@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        subbaram@codeaurora.org, collinsd@codeaurora.org,
        aghayal@codeaurora.org
Subject: Re: [PATCH 2/2] pwm: pwm-qcom: add driver for PWM modules in QCOM
 PMICs
Message-ID: <20210427170748.wglupc6zwrndalxs@pengutronix.de>
References: <20210427102247.822-1-fenglinw@codeaurora.org>
 <20210427102247.822-3-fenglinw@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hpvhpzizshayaciu"
Content-Disposition: inline
In-Reply-To: <20210427102247.822-3-fenglinw@codeaurora.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--hpvhpzizshayaciu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 27, 2021 at 06:22:10PM +0800, Fenglin Wu wrote:
> PWM modules present in QCOM PMICs are controlled through SPMI bus.
> Normally, it would have several PWM modules together with adjacent
> register space and each PWM module can be controlled independently.
>=20
> Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
> ---
>  drivers/pwm/Kconfig    |   9 +
>  drivers/pwm/Makefile   |   1 +
>  drivers/pwm/pwm-qcom.c | 585 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 595 insertions(+)
>  create mode 100644 drivers/pwm/pwm-qcom.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 8ae68d6..324ab5d 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -423,6 +423,15 @@ config PWM_PXA
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-pxa.
> =20
> +config PWM_QCOM
> +	tristate "Qcom PMIC PWM support"
> +	depends on MFD_SPMI_PMIC && OF
> +	help
> +	  Generic PWM framework driver for PWM module in QCOM PMIC chips
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-qcom.
> +
>  config PWM_RCAR
>  	tristate "Renesas R-Car PWM support"
>  	depends on ARCH_RENESAS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index d43b1e1..78316e9 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
>  obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.o
>  obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
> +obj-$(CONFIG_PWM_QCOM)		+=3D pwm-qcom.o
>  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> diff --git a/drivers/pwm/pwm-qcom.c b/drivers/pwm/pwm-qcom.c
> new file mode 100644
> index 0000000..48bd823
> --- /dev/null
> +++ b/drivers/pwm/pwm-qcom.c
> @@ -0,0 +1,585 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.

If there is a publicly available reference manual describing this
hardware, please add a link here.

Also please add a section (like in the pwm-sifive driver for example)
describing the relevant properties. Interesting are answers to the
questions:

 - Does the hardware complete the currently running period on
   reconfiguration? (If that's configurable, please enable this
   behaviour)

 - Does the hardware complete the currently running period when the PWM
   is disabled?

 - Does the output pin pull to the inactive level when the PWM is
   disabled?

 - Does the hardware support both polarities?

Please stick to the format used in pwm-sifive to be easily greppable.

> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +/* PWM module registers */
> +#define REG_PERPH_SUBTYPE		0x05
> +#define REG_PWM_SIZE_CLK		0x41
> +#define REG_PWM_FREQ_PREDIV_CLK		0x42
> +#define REG_PWM_TYPE_CONFIG		0x43
> +#define REG_PWM_VALUE_LSB		0x44
> +#define REG_PWM_VALUE_MSB		0x45
> +#define REG_ENABLE_CONTROL		0x46
> +#define REG_PWM_SYNC			0x47
> +
> +/* REG_PERPH_SUBTYPE */
> +#define SUBTYPE_PWM			0x0b
> +#define SUBTYPE_PWM_LITE		0x11
> +
> +/* REG_PWM_SIZE_CLK */
> +#define PWM_LITE_PWM_SIZE_MASK		BIT(4)
> +#define PWM_LITE_PWM_SIZE_SHIFT		4
> +#define PWM_SIZE_MASK			BIT(2)
> +#define PWM_SIZE_SHIFT			2
> +#define PWM_CLK_FREQ_SEL_MASK		GENMASK(1, 0)
> +
> +/* REG_PWM_FREQ_PREDIV_CLK */
> +#define PWM_FREQ_PREDIV_MASK		GENMASK(6, 5)
> +#define PWM_FREQ_PREDIV_SHIFT		5

It should be possible to not need the _SHIFT define as it can be
deferred from the mask value. In turn you can also drop the _MASK suffix
shortening the define names.

> +#define PWM_FREQ_EXPONENT_MASK		GENMASK(2, 0)
> +
> +/* REG_PWM_TYPE_CONFIG */
> +#define PWM_EN_GLITCH_REMOVAL_MASK	BIT(5)
> +
> +/* REG_PWM_VALUE */
> +#define PWM_VALUE_LSB_MASK		GENMASK(7, 0)
> +#define PWM_VALUE_MSB_MASK		BIT(0)
> +
> +/* REG_ENABLE_CONTROL */
> +#define EN_MODULE_BIT			BIT(7)
> +
> +/* REG_PWM_SYNC */
> +#define PWM_VALUE_SYNC			BIT(0)

I would like to see the register definition to use a common prefix (like
QCOM_PWM_) and that the names of bit fields include the register name.
So something like:

	#define QCOM_PWM_PWM_SIZE_CLK		0x41
	#define QCOM_PWM_PWM_SIZE_CLK_FREQ_SEL 		GENMASK(1, 0)

even if the names are quite long, its usage is less error prone. Maybe
it makes sense to drop the duplicated PWM (but only if all or no
register contains PWM in its name according to the reference manual).
Also maybe QCOM_PWM_PWMSIZECLK_FREQSEL might be a good choice. I let you
judge about the details.

> +
> +/* constant definitions */
> +#define REG_SIZE_PER_CHANN		0x100
> +#define NUM_PWM_SIZE			2
> +#define NUM_PWM_CLK			3
> +#define NUM_CLK_PREDIV			4
> +#define NUM_PWM_EXP			8
> +
> +static const int pwm_size[NUM_PWM_SIZE] =3D {6, 9};
> +static const int clk_freq_hz[NUM_PWM_CLK] =3D {1024, 32768, 19200000};
> +static const int clk_prediv[NUM_CLK_PREDIV] =3D {1, 3, 5, 6};
> +static const int pwm_exponent[NUM_PWM_EXP] =3D {0, 1, 2, 3, 4, 5, 6, 7};

Please also use a driver specific prefix for variables and function
names.

> +struct qcom_pwm_config {
> +	u32	pwm_size;
> +	u32	pwm_clk;
> +	u32	prediv;
> +	u32	clk_exp;
> +	u16	pwm_value;
> +	u64	best_period_ns;
> +};
> +
> +struct qcom_pwm_channel {
> +	struct qcom_pwm_chip	*chip;
> +	struct qcom_pwm_config	pwm_config;
> +	u32			chan_idx;
> +	u32			reg_base;
> +	u8			subtype;
> +	u64			current_period_ns;
> +	u64			current_duty_ns;
> +};
> +
> +struct qcom_pwm_chip {
> +	struct pwm_chip		pwm_chip;
> +	struct regmap		*regmap;
> +	struct device		*dev;
> +	struct qcom_pwm_channel	*pwms;
> +	struct mutex		rw_lock;
> +	u32			num_channels;
> +};
> +
> +static int qcom_pwm_channel_read(struct qcom_pwm_channel *pwm,
> +					u16 addr, u8 *val)
> +{
> +	int rc;
> +	unsigned int tmp;
> +
> +	mutex_lock(&pwm->chip->rw_lock);
> +	rc =3D regmap_read(pwm->chip->regmap, pwm->reg_base + addr, &tmp);
> +	if (rc < 0)
> +		dev_err(pwm->chip->dev, "Read addr %#x failed, rc=3D%d\n",
> +				pwm->reg_base + addr, rc);

Do you know that you can emit the symbolic error code using %pe? This
yields better readable error messages. That would be something like:

		dev_err(pwm->chip->dev, "Read addr %#x failed, rc=3D%pe\n",
				pwm->reg_base + addr, ERR_PTR(rc));
=09
> +	else
> +		*val =3D (u8)tmp;
> +	mutex_unlock(&pwm->chip->rw_lock);
> +
> +	return rc;
> +}
> +
> +static int qcom_pwm_channel_write(struct qcom_pwm_channel *pwm, u16 addr=
, u8 val)
> +{
> +	int rc;
> +
> +	mutex_lock(&pwm->chip->rw_lock);
> +	rc =3D regmap_write(pwm->chip->regmap, pwm->reg_base + addr, val);
> +	if (rc < 0)
> +		dev_err(pwm->chip->dev, "Write addr %#x with value %#x failed, rc=3D%d=
\n",
> +				pwm->reg_base + addr, val, rc);
> +	mutex_unlock(&pwm->chip->rw_lock);
> +
> +	return rc;
> +}
> +
> +static int qcom_pwm_channel_masked_write(struct qcom_pwm_channel *pwm,
> +				u16 addr, u8 mask, u8 val)
> +{
> +	int rc;
> +
> +	mutex_lock(&pwm->chip->rw_lock);
> +	rc =3D regmap_update_bits(pwm->chip->regmap, pwm->reg_base + addr,
> +							mask, val);
> +	if (rc < 0)
> +		dev_err(pwm->chip->dev, "Update addr %#x to val %#x with mask %#x fail=
ed, rc=3D%d\n",
> +				pwm->reg_base + addr, val, mask, rc);
> +	mutex_unlock(&pwm->chip->rw_lock);
> +
> +	return rc;
> +}
> +
> +static struct qcom_pwm_channel *pwm_dev_to_pwm_channel(struct pwm_chip *=
pwm_chip,
> +				struct pwm_device *pwm_dev)

Please use "chip" as name for the first parameter which is the usual
choice in the PWM core and also the drivers.

> +{
> +
> +	struct qcom_pwm_chip *chip =3D container_of(pwm_chip,
> +			struct qcom_pwm_chip, pwm_chip);

You will have to pick a different name here accordingly. I'd suggest
ddata or qc.

> +	u32 chan_idx =3D pwm_dev->hwpwm;

hwpwm is an unsigned int, I suggest making chan_idx an unsigned int,
too.

> +	if (chan_idx >=3D chip->num_channels) {
> +		dev_err(chip->dev, "hw index %u out of range [0-%u]\n",
> +				chan_idx, chip->num_channels - 1);
> +		return NULL;
> +	}
> +
> +	return &chip->pwms[chan_idx];
> +}
> +
> +static int __find_index_in_array(int data, const int array[], int length)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < length; i++) {
> +		if (data =3D=3D array[i])
> +			return i;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +static int qcom_pwm_channel_set_glitch_removal(
> +		struct qcom_pwm_channel *pwm, bool en)
> +{
> +	u8 mask, val;
> +
> +	val =3D en ? PWM_EN_GLITCH_REMOVAL_MASK : 0;
> +	mask =3D PWM_EN_GLITCH_REMOVAL_MASK;
> +	return qcom_pwm_channel_masked_write(pwm,
> +			REG_PWM_TYPE_CONFIG, mask, val);

What is the effect of this setting?

> +}
> +
> +static int qcom_pwm_channel_config(struct qcom_pwm_channel *pwm)
> +{
> +	int rc;
> +	u8 val, mask, shift;
> +	int pwm_size_idx, pwm_clk_idx, prediv_idx, clk_exp_idx;
> +
> +	pwm_size_idx =3D __find_index_in_array(pwm->pwm_config.pwm_size,
> +			pwm_size, ARRAY_SIZE(pwm_size));
> +	pwm_clk_idx =3D __find_index_in_array(pwm->pwm_config.pwm_clk,
> +			clk_freq_hz, ARRAY_SIZE(clk_freq_hz));
> +	prediv_idx =3D __find_index_in_array(pwm->pwm_config.prediv,
> +			clk_prediv, ARRAY_SIZE(clk_prediv));
> +	clk_exp_idx =3D __find_index_in_array(pwm->pwm_config.clk_exp,
> +			pwm_exponent, ARRAY_SIZE(pwm_exponent));
> +
> +	if (pwm_size_idx < 0 || pwm_clk_idx < 0
> +			|| prediv_idx < 0 || clk_exp_idx < 0)
> +		return -EINVAL;
> +
> +	/* pwm_clk_idx is 1 bit lower than the register value */
> +	pwm_clk_idx +=3D 1;
> +	shift =3D PWM_SIZE_SHIFT;
> +	mask =3D PWM_SIZE_MASK;
> +	if (pwm->subtype =3D=3D SUBTYPE_PWM_LITE) {
> +		shift =3D PWM_LITE_PWM_SIZE_SHIFT;
> +		mask =3D PWM_LITE_PWM_SIZE_MASK;
> +	}
> +
> +	val =3D pwm_size_idx << shift | pwm_clk_idx;

If you use

	val =3D FIELD_PREP(pwm_size_idx, mask) | pwm_clk_idx;

you don't need the shift variable.

> +	mask |=3D PWM_CLK_FREQ_SEL_MASK;
> +	rc =3D qcom_pwm_channel_masked_write(pwm, REG_PWM_SIZE_CLK, mask, val);
> +	if (rc < 0)
> +		return rc;
> +
> +	val =3D prediv_idx << PWM_FREQ_PREDIV_SHIFT | clk_exp_idx;
> +	mask =3D PWM_FREQ_PREDIV_MASK | PWM_FREQ_EXPONENT_MASK;
> +	rc =3D qcom_pwm_channel_masked_write(pwm, REG_PWM_FREQ_PREDIV_CLK, mask=
, val);
> +	if (rc < 0)
> +		return rc;
> +
> +	val =3D pwm->pwm_config.pwm_value >> 8;
> +	mask =3D PWM_VALUE_MSB_MASK;
> +	rc =3D qcom_pwm_channel_masked_write(pwm, REG_PWM_VALUE_MSB, mask, val);
> +	if (rc < 0)
> +		return rc;
> +
> +	val =3D pwm->pwm_config.pwm_value & PWM_VALUE_LSB_MASK;
> +	rc =3D qcom_pwm_channel_write(pwm, REG_PWM_VALUE_LSB, val);
> +	if (rc < 0)
> +		return rc;
> +
> +	val =3D PWM_VALUE_SYNC;
> +	return qcom_pwm_channel_write(pwm, REG_PWM_SYNC, val);
> +}
> +
> +static int qcom_pwm_channel_enable(struct qcom_pwm_channel *pwm, bool en)
> +{
> +	u8 mask, val;
> +
> +	mask =3D EN_MODULE_BIT;
> +	val =3D en ? EN_MODULE_BIT : 0;
> +	return qcom_pwm_channel_masked_write(pwm,
> +			REG_ENABLE_CONTROL, mask, val);
> +}
> +
> +static void __qcom_pwm_calc_pwm_period(u64 period_ns,
> +			struct qcom_pwm_config *pwm_config)
> +{
> +	struct qcom_pwm_config configs[NUM_PWM_SIZE];
> +	int i, j, m, n;
> +	u64 tmp1, tmp2;
> +	u64 clk_period_ns =3D 0, pwm_clk_period_ns;
> +	u64 clk_delta_ns =3D U64_MAX, min_clk_delta_ns =3D U64_MAX;
> +	u64 pwm_period_delta =3D U64_MAX, min_pwm_period_delta =3D U64_MAX;
> +	int pwm_size_step;
> +
> +	/*
> +	 *              (2^pwm_size) * (2^pwm_exp) * prediv * NSEC_PER_SEC
> +	 * pwm_period =3D ---------------------------------------------------
> +	 *                               clk_freq_hz
> +	 *
> +	 * Searching the closest settings for the requested PWM period.

Please don't pick the nearest setting, but the next smallest one.

> +	 */
> +
> +	for (n =3D 0; n < ARRAY_SIZE(pwm_size); n++) {
> +		pwm_clk_period_ns =3D period_ns >> pwm_size[n];
> +		for (i =3D ARRAY_SIZE(clk_freq_hz) - 1; i >=3D 0; i--) {
> +			for (j =3D 0; j < ARRAY_SIZE(clk_prediv); j++) {
> +				for (m =3D 0; m < ARRAY_SIZE(pwm_exponent); m++) {
> +					tmp1 =3D 1 << pwm_exponent[m];
> +					tmp1 *=3D clk_prediv[j];
> +					tmp2 =3D NSEC_PER_SEC;
> +					do_div(tmp2, clk_freq_hz[i]);
> +
> +					clk_period_ns =3D tmp1 * tmp2;
> +
> +					clk_delta_ns =3D abs(pwm_clk_period_ns
> +						- clk_period_ns);
> +					/*
> +					 * Find the closest setting for
> +					 * PWM frequency predivide value
> +					 */
> +					if (clk_delta_ns < min_clk_delta_ns) {
> +						min_clk_delta_ns
> +							=3D clk_delta_ns;
> +						configs[n].pwm_clk
> +							=3D clk_freq_hz[i];
> +						configs[n].prediv
> +							=3D clk_prediv[j];
> +						configs[n].clk_exp
> +							=3D pwm_exponent[m];
> +						configs[n].pwm_size
> +							=3D pwm_size[n];
> +						configs[n].best_period_ns
> +							=3D clk_period_ns;
> +					}
> +				}
> +			}
> +		}
> +
> +		configs[n].best_period_ns *=3D 1 << pwm_size[n];
> +		/* Find the closest setting for PWM period */
> +		pwm_period_delta =3D min_clk_delta_ns << pwm_size[n];
> +		if (pwm_period_delta < min_pwm_period_delta) {
> +			min_pwm_period_delta =3D pwm_period_delta;
> +			memcpy(pwm_config, &configs[n],
> +					sizeof(struct qcom_pwm_config));
> +		}
> +	}

Huh, this is complicated. It would be great if this could be simplified.
If you provide a reference manual or at least a .get_state function, I
can try to advise.

> +	/* Larger PWM size can achieve better resolution for PWM duty */
> +	for (n =3D ARRAY_SIZE(pwm_size) - 1; n > 0; n--) {
> +		if (pwm_config->pwm_size >=3D pwm_size[n])
> +			break;
> +		pwm_size_step =3D pwm_size[n] - pwm_config->pwm_size;
> +		if (pwm_config->clk_exp >=3D pwm_size_step) {
> +			pwm_config->pwm_size =3D pwm_size[n];

If you store n instead of pwm_size[n] finding n in
qcom_pwm_channel_config becomes easier and you can drop
__find_index_in_array.

> +			pwm_config->clk_exp -=3D pwm_size_step;
> +		}
> +	}
> +
> +	pr_debug("PWM setting for period_ns %llu: pwm_clk =3D %dHZ, prediv =3D =
%d, exponent =3D %d, pwm_size =3D %d\n",
> +			period_ns, pwm_config->pwm_clk, pwm_config->prediv,
> +			pwm_config->clk_exp, pwm_config->pwm_size);
> +	pr_debug("Actual period: %lluns\n", pwm_config->best_period_ns);
> +}
> +
> +static void __qcom_pwm_calc_pwm_duty(u64 period_ns, u64 duty_ns,
> +			struct qcom_pwm_config *pwm_config)
> +{
> +	u16 pwm_value, max_pwm_value;
> +	u64 tmp;
> +
> +	tmp =3D (u64)duty_ns << pwm_config->pwm_size;
> +	pwm_value =3D (u16)div64_u64(tmp, period_ns);
> +
> +	max_pwm_value =3D (1 << pwm_config->pwm_size) - 1;
> +	if (pwm_value > max_pwm_value)
> +		pwm_value =3D max_pwm_value;
> +
> +	pwm_config->pwm_value =3D pwm_value;
> +}
> +
> +static int qcom_pwm_config(struct pwm_chip *pwm_chip,
> +		struct pwm_device *pwm_dev, u64 duty_ns, u64 period_ns)
> +{
> +	struct qcom_pwm_channel *pwm;
> +	int rc;
> +
> +	pwm =3D pwm_dev_to_pwm_channel(pwm_chip, pwm_dev);
> +	if (pwm =3D=3D NULL) {
> +		dev_err(pwm_chip->dev, "PWM channel not found\n");
> +		return -ENODEV;
> +	}
> +
> +	if (duty_ns > period_ns) {
> +		dev_err(pwm_chip->dev, "Duty %llu ns is larger than period %llu ns\n",
> +						duty_ns, period_ns);
> +		return -EINVAL;
> +	}
> +
> +	if (period_ns !=3D pwm->current_period_ns)
> +		__qcom_pwm_calc_pwm_period(period_ns, &pwm->pwm_config);
> +
> +	if (period_ns !=3D pwm->current_period_ns ||
> +			duty_ns !=3D pwm->current_duty_ns)
> +		__qcom_pwm_calc_pwm_duty(period_ns, duty_ns, &pwm->pwm_config);

You're losing precision here by using the requested period length
(instead of the time that is implemented in hardware).

> +	rc =3D qcom_pwm_channel_config(pwm);
> +	if (rc < 0) {
> +		dev_err(pwm_chip->dev, "Config PWM channel %u failed, rc=3D%d\n",
> +						pwm->chan_idx, rc);
> +		return rc;
> +	}
> +
> +	pwm->current_period_ns =3D period_ns;
> +	pwm->current_duty_ns =3D duty_ns;
> +	return 0;
> +}
> +
> +static int qcom_pwm_enable(struct pwm_chip *pwm_chip,
> +				struct pwm_device *pwm_dev)
> +{
> +	struct qcom_pwm_channel *pwm;
> +	int rc =3D 0;
> +
> +	pwm =3D pwm_dev_to_pwm_channel(pwm_chip, pwm_dev);
> +	if (pwm =3D=3D NULL) {
> +		dev_err(pwm_chip->dev, "PWM channel not found\n");
> +		return -ENODEV;
> +	}
> +
> +	rc =3D qcom_pwm_channel_write(pwm, REG_PWM_SYNC, PWM_VALUE_SYNC);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc =3D qcom_pwm_channel_set_glitch_removal(pwm, true);
> +	if (rc < 0)
> +		return rc;
> +
> +	return qcom_pwm_channel_enable(pwm, true);
> +}
> +
> +static int qcom_pwm_disable(struct pwm_chip *pwm_chip,
> +				struct pwm_device *pwm_dev)
> +{
> +	struct qcom_pwm_channel *pwm;
> +	int rc;
> +
> +	pwm =3D pwm_dev_to_pwm_channel(pwm_chip, pwm_dev);
> +	if (pwm =3D=3D NULL) {
> +		dev_err(pwm_chip->dev, "PWM channel not found\n");
> +		return -ENODEV;
> +	}
> +
> +	rc =3D qcom_pwm_channel_enable(pwm, false);
> +	if (rc < 0)
> +		return rc;
> +
> +	return qcom_pwm_channel_set_glitch_removal(pwm, false);
> +}
> +
> +static int qcom_pwm_apply(struct pwm_chip *pwm_chip,
> +		struct pwm_device *pwm_dev, const struct pwm_state *state)

s/pwm_chip/chip/; s/pwm_dev/pwm/;

> +{
> +	int rc;
> +

You have to check for polarity here.

> +	if (state->period !=3D pwm_dev->state.period ||
> +			state->duty_cycle !=3D pwm_dev->state.duty_cycle) {
> +		rc =3D qcom_pwm_config(pwm_chip, pwm_dev,
> +				state->duty_cycle, state->period);
> +		if (rc < 0)
> +			return rc;
> +
> +		pwm_dev->state.duty_cycle =3D state->duty_cycle;
> +		pwm_dev->state.period =3D state->period;

The core takes care for this, please drop these two assignments.

> +	}
> +
> +	if (state->enabled !=3D pwm_dev->state.enabled) {
> +		if (state->enabled)
> +			rc =3D qcom_pwm_enable(pwm_chip, pwm_dev);
> +		else
> +			rc =3D qcom_pwm_disable(pwm_chip, pwm_dev);

Please handle state->enabled =3D false before configuring duty/period to
prevent a glitch.

> +		if (rc < 0)
> +			return rc;
> +
> +		pwm_dev->state.enabled =3D state->enabled;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops qcom_pwm_ops =3D {
> +	.apply =3D qcom_pwm_apply,
> +	.owner =3D THIS_MODULE,

Please implement .get_status and test your driver with
CONFIG_PWM_ENABLED.

> +};
> +
> +static int qcom_pwm_parse_dt(struct qcom_pwm_chip *chip)
> +{
> +	int rc =3D 0, i;
> +	const __be32 *addr;
> +	u32 base;
> +
> +	addr =3D of_get_address(chip->dev->of_node, 0, NULL, NULL);
> +	if (!addr) {
> +		dev_err(chip->dev, "Get PWM device address failed, rc=3D%d\n",
> +				rc);
> +		return -EINVAL;
> +	}
> +
> +	base =3D be32_to_cpu(*addr);
> +	rc =3D of_property_read_u32(chip->dev->of_node, "qcom,num-channels",
> +			&chip->num_channels);
> +	if (rc < 0) {
> +		dev_err(chip->dev, "Failed to get qcom,num-channels, rc=3D%d\n",
> +				rc);
> +		return rc;
> +	}
> +
> +	if (chip->num_channels =3D=3D 0) {
> +		dev_err(chip->dev, "No PWM channel specified\n");
> +		return rc;
> +	}
> +
> +	chip->pwms =3D devm_kcalloc(chip->dev, chip->num_channels,
> +			sizeof(*chip->pwms), GFP_KERNEL);
> +	if (!chip->pwms)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < chip->num_channels; i++) {
> +		chip->pwms[i].chip =3D chip;
> +		chip->pwms[i].chan_idx =3D i;
> +		chip->pwms[i].reg_base =3D base + i * REG_SIZE_PER_CHANN;
> +		rc =3D qcom_pwm_channel_read(&chip->pwms[i], REG_PERPH_SUBTYPE,
> +				&chip->pwms[i].subtype);

Can a single device have channels with different sub-types?

> +		if (rc < 0) {
> +			dev_err(chip->dev, "Read PWM channel %d subtype failed, rc=3D%d\n",
> +					i, rc);
> +			return rc;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_pwm_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +	struct qcom_pwm_chip *chip;
> +
> +	chip =3D devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;

If you parse qcom,num-channels already before allocating driver data you
can allocate driver and per channel data in a single chunk, making some
operations simpler and maybe even save some memory.

> +	chip->dev =3D &pdev->dev;
> +	chip->regmap =3D dev_get_regmap(chip->dev->parent, NULL);
> +	if (!chip->regmap) {
> +		dev_err(chip->dev, "Getting regmap failed\n");
> +		return -EINVAL;

ENODEV instead of EINVAL is more usual I think. Please use

	return dev_err_probe(chip->dev, -ENODEV, "....");

and also use dev_err_probe in the other error paths.

> +	}
> +
> +	rc =3D qcom_pwm_parse_dt(chip);
> +	if (rc < 0)
> +		return rc;
> +
> +	mutex_init(&chip->rw_lock);
> +	dev_set_drvdata(chip->dev, chip);
> +	chip->pwm_chip.dev =3D chip->dev;
> +	chip->pwm_chip.base =3D -1;

This shouldn't be done any more since commit f9a8ee8c8bcd ("pwm: Always
allocate PWM chip base ID dynamically") (which currently sits in next).

> +	chip->pwm_chip.npwm =3D chip->num_channels;
> +	chip->pwm_chip.ops =3D &qcom_pwm_ops;
> +
> +	rc =3D pwmchip_add(&chip->pwm_chip);
> +	if (rc < 0) {
> +		dev_err(chip->dev, "Add pwmchip failed, rc=3D%d\n", rc);
> +		goto err_out;

The cleanups done after this goto are not necessary. Just use

	return dev_err_probe(chip->dev, rc, "Add pwmchip failed\n");


> +	}
> +
> +	return 0;
> +err_out:
> +	mutex_destroy(&chip->rw_lock);
> +	dev_set_drvdata(chip->dev, NULL);
> +	return rc;
> +}
> +
> +static int qcom_pwm_remove(struct platform_device *pdev)
> +{
> +	struct qcom_pwm_chip *chip =3D dev_get_drvdata(&pdev->dev);
> +	int rc =3D 0;
> +
> +	rc =3D pwmchip_remove(&chip->pwm_chip);
> +	if (rc < 0)
> +		dev_err(chip->dev, "Remove pwmchip failed, rc=3D%d\n", rc);
> +
> +	mutex_destroy(&chip->rw_lock);
> +	dev_set_drvdata(chip->dev, NULL);

The driver core cares for

	dev_set_drvdata(chip->dev, NULL);

Also destroying the mutes isn't usually done.

> +	return rc;
> +}
> +
> +static const struct of_device_id qcom_pwm_of_match[] =3D {
> +	{ .compatible =3D "qcom,pwm"},
> +	{ },
> +};
> +
> +static struct platform_driver qcom_pwm_driver =3D {
> +	.driver		=3D {
> +		.name		=3D "qcom,pwm",
> +		.of_match_table	=3D qcom_pwm_of_match,
> +	},
> +	.probe		=3D qcom_pwm_probe,
> +	.remove		=3D qcom_pwm_remove,

I'm not a big fan of aligning the =3D. It looks ugly with that big white
space before =3D (and using a smaller space is bad if you later have to
initialize a member with a longer name).

But no hard veto from my side here, if you want to stick to that layout.

> +};
> +module_platform_driver(qcom_pwm_driver);
> +
> +MODULE_DESCRIPTION("QCOM PWM driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hpvhpzizshayaciu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCIROEACgkQwfwUeK3K
7AlqVQf9F421lx6i491K8+EJ/UasG9ea9a6026w7pzAK5YIZks5woEyhzDDPavvY
J2QOa08m6A47UrFA+K+T0q6KnDH4U7+vSTDtQLtKoyCxZyZgG6LZ9iOYnI6k6UK0
hHhjWXs1t3mt2iJvmISkadj5QrEbgQKl5aQR/3l2ZzieNq12ppP+Z5tD383UPQlT
Dh6U3Wk65NI7CHoxV5hkhLp8hUiIFj0TxC9n1si2CkY9amj6W2/SVNpN9/3Tt4Hs
iUVI6lcAPaW0oCi+Snpsvtl2W9n91oXed2QxSksOXHw2Nj5HlJUL9xpmVxV+7Fvg
tzcrLP3tKHz+qGtL1HKOzHaRD26kQA==
=JGGn
-----END PGP SIGNATURE-----

--hpvhpzizshayaciu--
