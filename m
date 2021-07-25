Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DE43D4F86
	for <lists+linux-pwm@lfdr.de>; Sun, 25 Jul 2021 20:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhGYRzH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 25 Jul 2021 13:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhGYRzG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 25 Jul 2021 13:55:06 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87502C061764
        for <linux-pwm@vger.kernel.org>; Sun, 25 Jul 2021 11:35:36 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so7704959oth.7
        for <linux-pwm@vger.kernel.org>; Sun, 25 Jul 2021 11:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bvXJHii8X2g7w9i76j1zx6tmbHcj57aoNAtTPLjIYEc=;
        b=shedze0gXF8HgZsQQxYlQwYVz4xH0x7pe6fvUnRL0UxfkwZbjgSBwfwZ1+B/d1KRqY
         1Jfr1nIS6AznBJYGQHiIrZxo3JYEqgaSql807t2XOtSecZhC+t1HmmzZznP9YN7s1Zxo
         ux6hKorV9BfWEj9IOLI/YJcGdBcDrfDg3K3wAgxwUpY/Y3we6MQl/pXwMQWle4ybfdSJ
         XIxd+wu3+9/vUZ6OPSqbORM8JdmrW/nRIgfokm5N79bbfPXp4AIgp/XjLKTVFKdG9N1T
         tK39zuy56p/mE2KUsXzvhVsqm/RSLaKd+awt+tP5WdZPhZe+aSfTtpCcsLGg+9hXsltb
         8ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bvXJHii8X2g7w9i76j1zx6tmbHcj57aoNAtTPLjIYEc=;
        b=c1WgF5Kp/TIjv9h2/VmIvHeGmSFupa3FaXBPC06YHVwtCnYZP6dVIBp+qbc7rk4466
         AT/TKlbNmARhqODP6OKFdi7t54K76zVkdQfO1pmigsawY+9YIdlj6Y5/DFwCYFTcbD2j
         ephHzsuC+A+hU5EaxZmAHn4PLVQ4H0W9qLobS4SWQNMqJKnE2JM5pLMvkpmqP8hO3CnN
         xf4kPfZDlxtxPz9DEOecVSWIHlO9mNL9K9WHLdJk51H9E9j+Jok6fBmoIiu9Vw9nlR5d
         K89WOKB2aCSHD5E/E6a9whjf1Oz0Nrah+IGinGTYRSjmeRB51+/SDE6vWigvTGjh29Kl
         pYcQ==
X-Gm-Message-State: AOAM53150Q/iJrHNaqQbk56SWSd5Nr7P1ogAP6lWpGuhOK95VfGGIRS+
        VVcPEwZp3mA7/yGnoygWw+R0Vw==
X-Google-Smtp-Source: ABdhPJxo/hwxDuTkFR+4/3V47u3XqE6+n65MNV65dHms7vrT3BSwAquZFHaIzgx9mG092tEY8MjeWw==
X-Received: by 2002:a9d:483:: with SMTP id 3mr10044234otm.231.1627238134869;
        Sun, 25 Jul 2021 11:35:34 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q20sm1157799otv.50.2021.07.25.11.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 11:35:34 -0700 (PDT)
Date:   Sun, 25 Jul 2021 13:35:32 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/4] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <YP2u9Hz2/+av6JLG@yoga>
References: <889aae1b88f120cb6281919d27164a959fbe69d0.1626948070.git.baruch@tkos.co.il>
 <2c4df635c57085fc33150d1b9a97845694e63e03.1626948070.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c4df635c57085fc33150d1b9a97845694e63e03.1626948070.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu 22 Jul 05:01 CDT 2021, Baruch Siach wrote:

> Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
> driver from downstream Codeaurora kernel tree. Removed support for older
> (V1) variants because I have no access to that hardware.
> 
> Tested on IPQ6010 based hardware.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v6:
> 
> Address Uwe Kleine-König review comments:
> 
>   Drop IPQ_PWM_MAX_DEVICES
> 
>   Rely on assigned-clock-rates; drop IPQ_PWM_CLK_SRC_FREQ
> 
>   Simplify register offset calculation
> 
>   Calculate duty cycle more precisely
> 
>   Refuse to set inverted polarity
> 
>   Drop redundant IPQ_PWM_REG1_ENABLE bit clear
> 
>   Remove x1000 factor in pwm_div calculation, use rate directly, and round up
> 
>   Choose initial pre_div such that pwm_div < IPQ_PWM_MAX_DIV
> 
>   Ensure pre_div <= pwm_div
> 
>   Rename close_ to best_
> 
>   Explain in comment why effective_div doesn't overflow
> 
>   Limit pwm_div to IPQ_PWM_MAX_DIV - 1 to allow 100% duty cycle
> 
>   Disable clock only after pwmchip_remove()
> 
>   const pwm_ops
> 
> Other changes:
> 
>   Add missing linux/bitfield.h header include (kernel test robot)
> 
>   Adjust code for PWM device node under TCSR (Rob Herring)
> 
> v5:
> 
> Use &tcsr_q6 syscon to access registers (Bjorn Andersson)
> 
> Address Uwe Kleine-König review comments:
> 
>   Implement .get_state()
> 
>   Add IPQ_PWM_ prefix to local macros
> 
>   Use GENMASK/BIT/FIELD_PREP for register fields access
> 
>   Make type of config_div_and_duty() parameters consistent
> 
>   Derive IPQ_PWM_MIN_PERIOD_NS from IPQ_PWM_CLK_SRC_FREQ
> 
>   Integrate enable/disable into config_div_and_duty() to save register read,
>   and reduce frequency glitch on update
> 
>   Use min() instead of min_t()
> 
>   Fix comment format
> 
>   Use dev_err_probe() to indicate probe step failure
> 
>   Add missing clk_disable_unprepare() in .remove
> 
>   Don't set .owner
> 
> v4:
> 
>   Use div64_u64() to fix link for 32-bit targets ((kernel test robot
>   <lkp@intel.com>, Uwe Kleine-König)
> 
> v3:
> 
>   s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> 
>   Fix integer overflow on 32-bit targets (kernel test robot <lkp@intel.com>)
> 
> v2:
> 
> Address Uwe Kleine-König review comments:
> 
>   Fix period calculation when out of range
> 
>   Don't set period larger than requested
> 
>   Remove PWM disable on configuration change
> 
>   Implement .apply instead of non-atomic .config/.enable/.disable
> 
>   Don't modify PWM on .request/.free
> 
>   Check pwm_div underflow
> 
>   Fix various code and comment formatting issues
> 
> Other changes:
> 
>   Use u64 divisor safe division
> 
>   Remove now empty .request/.free
> ---
>  drivers/pwm/Kconfig   |  12 ++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-ipq.c | 276 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 289 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ipq.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c76adedd58c9..08add845596f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -260,6 +260,18 @@ config PWM_INTEL_LGM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-intel-lgm.
>  
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
> @@ -22,6 +22,7 @@ obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
>  obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
>  obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_INTEL_LGM)	+= pwm-intel-lgm.o
> +obj-$(CONFIG_PWM_IPQ)		+= pwm-ipq.o
>  obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
>  obj-$(CONFIG_PWM_KEEMBAY)	+= pwm-keembay.o
> diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
> new file mode 100644
> index 000000000000..19f7ed93dc81
> --- /dev/null
> +++ b/drivers/pwm/pwm-ipq.c
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserved.
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
> +
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
> +{
> +	return container_of(chip, struct ipq_pwm_chip, chip);
> +}
> +
> +static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned reg)
> +{
> +	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(pwm->chip);
> +	unsigned int off = ipq_chip->regmap_off + 8 * pwm->hwpwm + reg;
> +	unsigned int val;
> +
> +	regmap_read(ipq_chip->regmap, off, &val);
> +
> +	return val;
> +}
> +
> +static void ipq_pwm_reg_write(struct pwm_device *pwm, unsigned reg,
> +		unsigned val)
> +{
> +	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(pwm->chip);
> +	unsigned int off = ipq_chip->regmap_off + 8 * pwm->hwpwm + reg;
> +
> +	regmap_write(ipq_chip->regmap, off, val);
> +}
> +
> +static void config_div_and_duty(struct pwm_device *pwm, unsigned int pre_div,
> +			unsigned int pwm_div, unsigned long rate, u64 duty_ns,
> +			bool enable)
> +{
> +	unsigned long hi_dur;
> +	unsigned long val = 0;
> +
> +	/*
> +	 * high duration = pwm duty * (pwm div + 1)
> +	 * pwm duty = duty_ns / period_ns
> +	 */
> +	hi_dur = div64_u64(duty_ns * rate, (pre_div + 1) * NSEC_PER_SEC);
> +
> +	val = FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
> +		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG0, val);
> +
> +	val = FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG1, val);
> +
> +	/* Enable needs a separate write to REG1 */
> +	val |= IPQ_PWM_REG1_UPDATE;
> +	if (enable)
> +		val |= IPQ_PWM_REG1_ENABLE;
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG1, val);
> +}
> +
> +static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(chip);
> +	unsigned long freq;
> +	unsigned int pre_div, pwm_div, best_pre_div, best_pwm_div;
> +	long long diff;
> +	unsigned long rate = clk_get_rate(ipq_chip->clk);
> +	unsigned long min_diff = rate;
> +	u64 period_ns, duty_ns;
> +
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (state->period < div64_u64(NSEC_PER_SEC, rate))
> +		return -ERANGE;
> +
> +	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
> +	duty_ns = min(state->duty_cycle, period_ns);
> +
> +	/* freq in Hz for period in nano second */
> +	freq = div64_u64(NSEC_PER_SEC, period_ns);
> +	best_pre_div = IPQ_PWM_MAX_DIV;
> +	best_pwm_div = IPQ_PWM_MAX_DIV;
> +	/* Initial pre_div value such that pwm_div < IPQ_PWM_MAX_DIV */
> +	pre_div = DIV64_U64_ROUND_UP(period_ns * rate,
> +			(u64)NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1));
> +
> +	for (; pre_div <= IPQ_PWM_MAX_DIV; pre_div++) {
> +		pwm_div = DIV64_U64_ROUND_UP(period_ns * rate,
> +				(u64)NSEC_PER_SEC * (pre_div + 1));
> +		pwm_div--;
> +
> +		if (pre_div > pwm_div)
> +			break;
> +
> +		/*
> +		 * Make sure we can do 100% duty cycle where
> +		 * hi_dur == pwm_div + 1
> +		 */
> +		if (pwm_div > IPQ_PWM_MAX_DIV - 1)
> +			continue;
> +
> +		diff = ((uint64_t)freq * (pre_div + 1) * (pwm_div + 1))
> +			- (uint64_t)rate;
> +
> +		if (diff < 0) /* period larger than requested */
> +			continue;
> +		if (diff == 0) { /* bingo */
> +			best_pre_div = pre_div;
> +			best_pwm_div = pwm_div;
> +			break;
> +		}
> +		if (diff < min_diff) {
> +			min_diff = diff;
> +			best_pre_div = pre_div;
> +			best_pwm_div = pwm_div;
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
> +static void ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      struct pwm_state *state)
> +{
> +	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(chip);
> +	unsigned long rate = clk_get_rate(ipq_chip->clk);
> +	unsigned int pre_div, pwm_div, hi_dur;
> +	u64 effective_div, hi_div;
> +	u32 reg0, reg1;
> +
> +	reg0 = ipq_pwm_reg_read(pwm, IPQ_PWM_CFG_REG0);
> +	reg1 = ipq_pwm_reg_read(pwm, IPQ_PWM_CFG_REG1);
> +
> +	state->polarity = PWM_POLARITY_NORMAL;
> +	state->enabled = reg1 & IPQ_PWM_REG1_ENABLE;
> +
> +	pwm_div = FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
> +	hi_dur = FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
> +	pre_div = FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
> +
> +	/* No overflow here, both pre_div and pwm_div <= 0xffff */
> +	effective_div = (u64)(pre_div + 1) * (pwm_div + 1);
> +	state->period = div64_u64(effective_div * NSEC_PER_SEC, rate);
> +
> +	hi_div = hi_dur * (pre_div + 1);
> +	state->duty_cycle = div64_u64(hi_div * NSEC_PER_SEC, rate);
> +}
> +
> +static const struct pwm_ops ipq_pwm_ops = {
> +	.apply = ipq_pwm_apply,
> +	.get_state = ipq_pwm_get_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int ipq_pwm_probe(struct platform_device *pdev)
> +{
> +	struct ipq_pwm_chip *pwm;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	pwm->regmap = syscon_node_to_regmap(dev->parent->of_node);
> +	if (IS_ERR(pwm->regmap))
> +		return dev_err_probe(dev, PTR_ERR(pwm->regmap),
> +				"regs map failed");
> +
> +	ret = of_property_read_u32(dev->of_node, "offset", &pwm->regmap_off);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "error reading 'offset'");
> +
> +	pwm->clk = devm_clk_get(dev, "core");

You only have a single clock, so passing NULL for the identifier would
do the trick...

> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
> +				"failed to get core clock");
> +
> +	ret = clk_prepare_enable(pwm->clk);

Not sure if Uwe asked you this already, but do you need to clock the
supply even when the PWM isn't enabled?

> +	if (ret)
> +		return dev_err_probe(dev, ret, "clock enable failed");
> +
> +	pwm->chip.dev = dev;
> +	pwm->chip.ops = &ipq_pwm_ops;
> +	pwm->chip.npwm = 4;
> +
> +	ret = pwmchip_add(&pwm->chip);

Depending on above answer you may or may not have the need to ensure the
ordering of clk_disable_unprepare() in the remove function.

Otherwise devm_pwmchip_add() would be nice here.

> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "pwmchip_add() failed\n");
> +		clk_disable_unprepare(pwm->clk);
> +		return ret;

pwmchip_add() returns 0 or -errno, so you could skip this and do return
ret; below.

> +	}
> +
> +	return 0;
> +}
> +
> +static int ipq_pwm_remove(struct platform_device *pdev)
> +{
> +	struct ipq_pwm_chip *pwm = platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&pwm->chip);
> +	clk_disable_unprepare(pwm->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id pwm_ipq_dt_match[] = {
> +	{ .compatible = "qcom,ipq6018-pwm", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, pwm_ipq_dt_match);
> +
> +static struct platform_driver ipq_pwm_driver = {
> +	.driver = {
> +		.name = "ipq-pwm",
> +		.of_match_table = pwm_ipq_dt_match,
> +	},
> +	.probe = ipq_pwm_probe,
> +	.remove = ipq_pwm_remove,
> +};
> +
> +module_platform_driver(ipq_pwm_driver);
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> -- 
> 2.30.2
> 
