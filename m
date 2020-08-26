Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD9A252BBD
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Aug 2020 12:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgHZKwb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Aug 2020 06:52:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:36626 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgHZKwa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Aug 2020 06:52:30 -0400
IronPort-SDR: 1jg7dZSNKEhveqownOIC4TWNFtAMMu+vrzmiJ6MMY/4whh0KT2CbTc4c70HAUOXcqxBy66+Jx4
 CfgphOR0mslA==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="135820145"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="135820145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 03:52:29 -0700
IronPort-SDR: j6nRy5CDKVKsZzlUfQn49BHbLyG8M9Q8oSgsNngy6Htht3OzbS1/ZWpu+vmt6bPEn2CthOR6jd
 aa9cyd3Vnd1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="329181901"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2020 03:52:27 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAt2X-00BXsr-5b; Wed, 26 Aug 2020 13:52:25 +0300
Date:   Wed, 26 Aug 2020 13:52:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     vineetha.g.jaya.kumaran@intel.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v5 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20200826105225.GI1891694@smile.fi.intel.com>
References: <1598437559-25828-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1598437559-25828-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598437559-25828-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Aug 26, 2020 at 06:25:58PM +0800, vineetha.g.jaya.kumaran@intel.com wrote:
> From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> 
> Enable PWM support for the Intel Keem Bay SoC.

LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Co-developed-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> ---
>  drivers/pwm/Kconfig       |   9 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-keembay.c | 228 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 238 insertions(+)
>  create mode 100644 drivers/pwm/pwm-keembay.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 7dbcf69..0a68a167 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -560,4 +560,13 @@ config PWM_ZX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-zx.
>  
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
> index 2c2ba0a..293e48f 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -54,3 +54,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
>  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
>  obj-$(CONFIG_PWM_ZX)		+= pwm-zx.o
> +obj-$(CONFIG_PWM_KEEMBAY)	+= pwm-keembay.o
> diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
> new file mode 100644
> index 00000000..3c7481f
> --- /dev/null
> +++ b/drivers/pwm/pwm-keembay.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Keem Bay PWM driver
> + *
> + * Copyright (C) 2020 Intel Corporation
> + * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
> + *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> + *
> + * Limitation:
> + * - Upon disabling a channel, the currently running
> + *   period will not be completed. However, upon
> + *   reconfiguration of the duty cycle/period, the
> + *   currently running period will be completed first.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +#define KMB_TOTAL_PWM_CHANNELS		6
> +#define KMB_PWM_COUNT_MAX		0xffff
> +#define KMB_PWM_EN_BIT			BIT(31)
> +
> +/* Mask */
> +#define KMB_PWM_HIGH_MASK		GENMASK(31, 16)
> +#define KMB_PWM_LOW_MASK		GENMASK(15, 0)
> +#define KMB_PWM_COUNT_MASK		GENMASK(31, 0)
> +
> +/* PWM Register offset */
> +#define KMB_PWM_LEADIN_OFFSET(ch)	(0x00 + 4 * (ch))
> +#define KMB_PWM_HIGHLOW_OFFSET(ch)	(0x20 + 4 * (ch))
> +
> +struct keembay_pwm {
> +	struct pwm_chip chip;
> +	struct device *dev;
> +	struct clk *clk;
> +	void __iomem *base;
> +};
> +
> +static inline struct keembay_pwm *to_keembay_pwm_dev(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct keembay_pwm, chip);
> +}
> +
> +static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u32 mask,
> +					   u32 val, u32 offset)
> +{
> +	u32 buff = readl(priv->base + offset);
> +
> +	buff = u32_replace_bits(buff, val, mask);
> +	writel(buff, priv->base + offset);
> +}
> +
> +static void keembay_pwm_enable(struct keembay_pwm *priv, int ch)
> +{
> +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 1,
> +				KMB_PWM_LEADIN_OFFSET(ch));
> +}
> +
> +static void keembay_pwm_disable(struct keembay_pwm *priv, int ch)
> +{
> +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 0,
> +				KMB_PWM_LEADIN_OFFSET(ch));
> +}
> +
> +static void keembay_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct keembay_pwm *priv = to_keembay_pwm_dev(chip);
> +	unsigned long long pwm_h_count, pwm_l_count;
> +	unsigned long clk_rate;
> +	u32 buff;
> +
> +	clk_rate = clk_get_rate(priv->clk);
> +
> +	/* Read channel enabled status */
> +	buff = readl(priv->base + KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
> +	if (buff & KMB_PWM_EN_BIT)
> +		state->enabled = true;
> +	else
> +		state->enabled = false;
> +
> +	/* Read period and duty cycle */
> +	buff = readl(priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
> +	pwm_l_count = FIELD_GET(KMB_PWM_LOW_MASK, buff) * NSEC_PER_SEC;
> +	pwm_h_count = FIELD_GET(KMB_PWM_HIGH_MASK, buff) * NSEC_PER_SEC;
> +	state->duty_cycle = DIV_ROUND_UP_ULL(pwm_h_count, clk_rate);
> +	state->period = DIV_ROUND_UP_ULL(pwm_h_count + pwm_l_count, clk_rate);
> +}
> +
> +static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			     const struct pwm_state *state)
> +{
> +	struct keembay_pwm *priv = to_keembay_pwm_dev(chip);
> +	struct pwm_state current_state;
> +	u16 pwm_h_count, pwm_l_count;
> +	unsigned long long div;
> +	unsigned long clk_rate;
> +	u32 pwm_count = 0;
> +
> +	keembay_pwm_get_state(chip, pwm, &current_state);
> +
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -ENOSYS;
> +
> +	if (!state->enabled && current_state.enabled) {
> +		keembay_pwm_disable(priv, pwm->hwpwm);
> +		return 0;
> +	}
> +
> +	/*
> +	 * The upper 16 bits of the KMB_PWM_HIGHLOW_OFFSET register contain
> +	 * the high time of the waveform, while the last 16 bits contain
> +	 * the low time of the waveform, in terms of clock cycles.
> +	 *
> +	 * high time = clock rate * duty cycle
> +	 * low time =  clock rate * (period - duty cycle)
> +	 *
> +	 * e.g. For period 50us, duty cycle 30us, and clock rate 500MHz:
> +	 * high time = 500MHz * 30us = 0x3A98
> +	 * low time = 500MHz * 20us = 0x2710
> +	 * Value written to KMB_PWM_HIGHLOW_OFFSET = 0x3A982710
> +	 */
> +
> +	clk_rate = clk_get_rate(priv->clk);
> +
> +	/* Configure waveform high time */
> +	div = clk_rate * state->duty_cycle;
> +	div = DIV_ROUND_CLOSEST_ULL(div, NSEC_PER_SEC);
> +	if (div > KMB_PWM_COUNT_MAX)
> +		return -ERANGE;
> +
> +	pwm_h_count = div;
> +
> +	/* Configure waveform low time */
> +	div = clk_rate * (state->period - state->duty_cycle);
> +	div = DIV_ROUND_CLOSEST_ULL(div, NSEC_PER_SEC);
> +	if (div > KMB_PWM_COUNT_MAX)
> +		return -ERANGE;
> +
> +	pwm_l_count = div;
> +
> +	pwm_count = FIELD_PREP(KMB_PWM_HIGH_MASK, pwm_h_count) |
> +		    FIELD_PREP(KMB_PWM_LOW_MASK, pwm_l_count);
> +
> +	writel(pwm_count, priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
> +
> +	if (state->enabled && !current_state.enabled)
> +		keembay_pwm_enable(priv, pwm->hwpwm);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops keembay_pwm_ops = {
> +	.owner = THIS_MODULE,
> +	.apply = keembay_pwm_apply,
> +	.get_state = keembay_pwm_get_state,
> +};
> +
> +static int keembay_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct keembay_pwm *priv;
> +	int ret, ch;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get clock\n");
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->chip.base = -1;
> +	priv->chip.dev = dev;
> +	priv->chip.ops = &keembay_pwm_ops;
> +	priv->chip.npwm = KMB_TOTAL_PWM_CHANNELS;
> +
> +	ret = pwmchip_add(&priv->chip);
> +	if (ret) {
> +		dev_err(dev, "Failed to add PWM chip: %pe\n", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	/* Ensure enable bit for each channel is cleared at boot */
> +	for (ch = 0; ch < KMB_TOTAL_PWM_CHANNELS; ch++)
> +		keembay_pwm_disable(priv, ch);
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static int keembay_pwm_remove(struct platform_device *pdev)
> +{
> +	struct keembay_pwm *priv = platform_get_drvdata(pdev);
> +
> +	return pwmchip_remove(&priv->chip);
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
> +MODULE_ALIAS("platform:pwm-keembay");
> +MODULE_DESCRIPTION("Intel Keem Bay PWM driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.9.1
> 

-- 
With Best Regards,
Andy Shevchenko


