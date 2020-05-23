Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4801DFB3F
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2020 23:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbgEWVkg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 23 May 2020 17:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388082AbgEWVkf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 May 2020 17:40:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2FCC061A0E
        for <linux-pwm@vger.kernel.org>; Sat, 23 May 2020 14:40:35 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcbsf-0006Tq-D9; Sat, 23 May 2020 23:40:33 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcbsd-0005J9-5g; Sat, 23 May 2020 23:40:31 +0200
Date:   Sat, 23 May 2020 23:40:31 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     vineetha.g.jaya.kumaran@intel.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH 2/3] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20200523214031.xpbenusp2i44w237@pengutronix.de>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-3-git-send-email-vineetha.g.jaya.kumaran@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1589723560-5734-3-git-send-email-vineetha.g.jaya.kumaran@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Sun, May 17, 2020 at 09:52:39PM +0800, vineetha.g.jaya.kumaran@intel.com wrote:
> From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> 
> Enable PWM support for the Intel Keem Bay SoC.
> 
> Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> ---
>  drivers/pwm/Kconfig       |   9 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-keembay.c | 308 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 318 insertions(+)
>  create mode 100644 drivers/pwm/pwm-keembay.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c13d146..5311975 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -569,4 +569,13 @@ config PWM_ZX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-zx.
>  
> +config PWM_KEEMBAY
> +	tristate "Intel Keem Bay PWM driver"
> +	depends on ARM64

Support for COMPILE_TEST would be nice here.

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
> @@ -55,3 +55,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
>  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
>  obj-$(CONFIG_PWM_ZX)		+= pwm-zx.o
> +obj-$(CONFIG_PWM_KEEMBAY)	+= pwm-keembay.o
> diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
> new file mode 100644
> index 0000000..39c7310
> --- /dev/null
> +++ b/drivers/pwm/pwm-keembay.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Keem Bay PWM driver
> + *
> + * Copyright (C) 2020 Intel Corporation
> + * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
> + *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>

Is there publically available documentation? If so, please add a link
here.

> + */
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
> +#define TOTAL_PWM_CHANNELS		6
> +#define LEAD_IN_DEFAULT			0
> +#define PWM_COUNT_MAX			65535

please use a unique prefix for all defines in your driver. The names as
they are are too generic.

> +
> +#define KEEMBAY_PWM_EN_BIT		31
> +
> +/* Mask */
> +#define KEEMBAY_PWM_RPT_CNT_MASK	GENMASK(15, 0)
> +#define KEEMBAY_PWM_LEAD_IN_MASK	GENMASK(30, 16)
> +#define KEEMBAY_PWM_HIGH_MASK		GENMASK(31, 16)
> +#define KEEMBAY_PWM_LOW_MASK		GENMASK(15, 0)
> +
> +/* PWM Register offset */
> +#define PWM_LEADIN0_OFFSET		0x00
> +#define PWM_LEADIN1_OFFSET		0x04
> +#define PWM_LEADIN2_OFFSET		0x08
> +#define PWM_LEADIN3_OFFSET		0x0c
> +#define PWM_LEADIN4_OFFSET		0x10
> +#define PWM_LEADIN5_OFFSET		0x14
> +
> +#define PWM_HIGHLOW0_OFFSET		0x20
> +#define PWM_HIGHLOW1_OFFSET		0x24
> +#define PWM_HIGHLOW2_OFFSET		0x28
> +#define PWM_HIGHLOW3_OFFSET		0x2c
> +#define PWM_HIGHLOW4_OFFSET		0x30
> +#define PWM_HIGHLOW5_OFFSET		0x34
> +
> +struct keembay_pwm {
> +	struct pwm_chip chip;
> +	struct device *dev;
> +	struct clk *clk;
> +	void __iomem *regmap;

I'd call this member "base" instead of "regmap" as the latter has a
different meaning in the kernel.

> +};
> +
> +static inline struct keembay_pwm *to_keembay_pwm_dev(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct keembay_pwm, chip);
> +}
> +
> +static inline void keembay_pwm_enable_channel(struct keembay_pwm *priv, int ch)
> +{
> +	u32 buff, offset;
> +	void __iomem *address;
> +
> +	offset = PWM_LEADIN0_OFFSET + ch * 4;
> +	address = priv->regmap + offset;
> +	buff = readl(address);
> +	buff |= BIT(KEEMBAY_PWM_EN_BIT);
> +	writel(buff, address);
> +}
> +
> +static inline void keembay_pwm_disable_channel(struct keembay_pwm *priv, int ch)
> +{
> +	u32 buff, offset;
> +	void __iomem *address;
> +
> +	offset = PWM_LEADIN0_OFFSET + ch * 4;
> +	address = priv->regmap + offset;
> +	buff = readl(address);
> +	buff &= ~BIT(KEEMBAY_PWM_EN_BIT);
> +	writel(buff, address);
> +}

The two functions above could make use of keembay_pwm_update_bits().

> +
> +static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u32 mask,
> +					   u32 val, u32 reg, int ch)
> +{
> +	u32 buff, offset, tmp;
> +	void __iomem *address;
> +
> +	offset = reg + ch * 4;
> +	address = priv->regmap + offset;
> +	buff = readl(address);
> +	tmp = buff & ~mask;
> +	tmp |= FIELD_PREP(mask, val);
> +	writel(tmp, address);
> +}
> +
> +static inline u32 keembay_pwm_config_min(struct keembay_pwm *priv)
> +{
> +	unsigned long long divd, divs;
> +
> +	divd = NSEC_PER_SEC;
> +	divs = clk_get_rate(priv->clk);
> +	do_div(divd, divs);

Given that both NSEC_PER_SEC and the return value of clk_get_rate fit
into an unsigned long, this seems too much.

> +	return (u32)divd;
> +}
> +
> +static inline u16 keembay_pwm_config_duty_cycle(struct keembay_pwm *priv,
> +						int duty_ns, u32 ns_min)
> +{
> +	unsigned long long divd;
> +
> +	divd = duty_ns;
> +	do_div(divd, ns_min);
> +	if ((u16)divd == 0)
> +		return 0;
> +
> +	return (u16)divd - 1;

missing range checking.

> +}
> +
> +static inline u16 keembay_pwm_config_period(struct keembay_pwm *priv,
> +					    int period_ns,
> +					    int duty_ns,
> +					    u32 ns_min)
> +{
> +	unsigned long long divd;
> +
> +	divd = period_ns - duty_ns;
> +	do_div(divd, ns_min);
> +	if ((u16)divd == 0)
> +		return 0;
> +
> +	return (u16)divd - 1;

I wonder if both keembay_pwm_config_duty_cycle() and
keembay_pwm_config_period() would be easier to understand if they were not
separate functions but unrolled into their only user.

As above there is no range checking.

> +}
> +
> +/*
> + *	For calculating "high time" register value:
> + *	High time (quotient only) = duty_cycle / ns_min
> + *
> + *	For calculating "low time" register value:
> + *	Low time (quotient only) = (period - duty_cycle) / ns_min
> + *
> + *	All values used are in nanoseconds for calculation.
> + */
> +static int keembay_pwm_config(struct keembay_pwm *priv, int ch,
> +			      int duty_ns, int period_ns, int count)

this function is only called once, I wonder if it can better be folded
into its only user.

> +{
> +	u32 ns_min;
> +	u16 pwm_h_count, pwm_l_count;
> +
> +	/* Write to lead in */
> +	keembay_pwm_update_bits(priv, KEEMBAY_PWM_LEAD_IN_MASK,
> +				LEAD_IN_DEFAULT,
> +				PWM_LEADIN0_OFFSET, ch);

What is the effect of this "lead in"?

> +	/* Write the number of PWM pulse repetition */
> +	keembay_pwm_update_bits(priv, KEEMBAY_PWM_RPT_CNT_MASK, count,
> +				PWM_LEADIN0_OFFSET, ch);

Is this racy? E.g. if the PWM is already running and just after you
update the repetition count completes a period?

This writes to the same register as the lead in above. Can this be done
in a single register access?

> +	/* Calculate min */
> +	ns_min = keembay_pwm_config_min(priv);

What is "min"?

> +	/* For duty cycle */
> +	pwm_h_count = keembay_pwm_config_duty_cycle(priv, duty_ns, ns_min);

this is ineffective and less exact as possible. ns_min is the result of
a division and in keembay_pwm_config_duty_cycle you divide by it.

> +	/* Write to high registers */
> +	keembay_pwm_update_bits(priv, KEEMBAY_PWM_HIGH_MASK, pwm_h_count,
> +				PWM_HIGHLOW0_OFFSET, ch);
> +
> +	/* For period */
> +	pwm_l_count = keembay_pwm_config_period(priv, period_ns, duty_ns,
> +						ns_min);
> +
> +	/* Write to low registers */
> +	keembay_pwm_update_bits(priv, KEEMBAY_PWM_LOW_MASK, pwm_l_count,
> +				PWM_HIGHLOW0_OFFSET, ch);

Can you please explain in a comment what's the resulting wave form for a
given value of this register?

Can writing h_count and l_count be combined in a single register access?
(And if not, what happens if a period completes between the two
updates?)

How does the hardware behave on a change here? Is the currently running
period completed before the new values take effect?

> +
> +	return 0;
> +}
> +
> +static int keembay_pwm_enable(struct keembay_pwm *priv, int ch)
> +{
> +	int ret;
> +
> +	ret = clk_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable channel */
> +	keembay_pwm_enable_channel(priv, ch);
> +
> +	return 0;
> +}
> +
> +static void keembay_pwm_disable(struct keembay_pwm *priv, int ch)
> +{
> +	/* Disable channel */
> +	keembay_pwm_disable_channel(priv, ch);
> +
> +	clk_disable(priv->clk);
> +}
> +
> +static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			     const struct pwm_state *state)
> +{
> +	struct keembay_pwm *priv = to_keembay_pwm_dev(chip);
> +
> +	if (!state->enabled && pwm_is_enabled(pwm)) {

Please don't call API functions in the driver.

> +		keembay_pwm_disable(priv, pwm->hwpwm);

Is a currently running period completed here? How does the output behave
on disable? (i.e. does it go in its inactive state?)

> +		return 0;
> +	}
> +
> +	if (state->count > PWM_COUNT_MAX)
> +		return -EINVAL;
> +
> +	if (state->polarity != pwm_get_polarity(pwm))

Using:

	if (state->polarity != PWM_POLARITY_NORMAL)

seems both more robust and easier to understand.

> +		return -ENOSYS;
> +
> +	keembay_pwm_config(priv, pwm->hwpwm, state->duty_cycle,
> +			   state->period, state->count);
> +
> +	if (state->enabled && !pwm_is_enabled(pwm))
> +		return keembay_pwm_enable(priv, pwm->hwpwm);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops keembay_pwm_ops = {
> +	.owner = THIS_MODULE,
> +	.apply = keembay_pwm_apply,

Please implement .get_state().

> +};
> +
> +static int keembay_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct keembay_pwm *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))

Error message please. (Something like:

		int ret = PTR_ERR(ret);

		if (ret != -EPROBE_DEFER)
			dev_err(pdev->dev, "Failed to get clk: %pE\n", priv->clk);

		return ret;
)

> +		return PTR_ERR(priv->clk);
> +
> +	/*
> +	 * Prepare clock here, and carry out clock enabling/disabling
> +	 * during channel enablement/disablement.
> +	 * The clock will not be unprepared due to shared usage with GPIO.

What has this clock to do with GPIO? If the GPIO drivers gets and
enables this clock itself there should be no problem.

> +	 */
> +	ret = clk_prepare(priv->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to prepare PWM clock\n");

Please include the error code in the message (preferably using %pE as
above).

> +		return ret;
> +	}
> +
> +	priv->regmap = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	priv->chip.base = -1;
> +	priv->chip.dev = dev;
> +	priv->chip.ops = &keembay_pwm_ops;
> +	priv->chip.npwm = TOTAL_PWM_CHANNELS;
> +
> +	ret = pwmchip_add(&priv->chip);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to add PWM chip: %d\n", ret);

%pE please.

> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static int keembay_pwm_remove(struct platform_device *pdev)
> +{
> +	struct keembay_pwm *priv = platform_get_drvdata(pdev);
> +	unsigned int i;
> +
> +	for (i = 0; i < priv->chip.npwm; i++)
> +		pwm_disable(&priv->chip.pwms[i]);

That's wrong. It's the responsibility of the consumer to disable the
clock.

> +
> +	pwmchip_remove(&priv->chip);

clk_unprepare missing here.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id keembay_pwm_of_match[] = {
> +	{ .compatible = "intel,keembay-pwm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, keembay_pwm_of_match);
> +
> +static struct platform_driver keembay_pwm_driver = {
> +	.probe	= keembay_pwm_probe,
> +	.remove	= keembay_pwm_remove,
> +	.driver	= {
> +		.name = "pwm-keembay",
> +		.of_match_table = keembay_pwm_of_match,
> +	},
> +};
> +module_platform_driver(keembay_pwm_driver);
> +
> +MODULE_ALIAS("platform:keembay");
> +MODULE_DESCRIPTION("Intel Keem Bay PWM driver");
> +MODULE_LICENSE("GPL v2");

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
