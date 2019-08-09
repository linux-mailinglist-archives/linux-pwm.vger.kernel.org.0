Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7964D874E6
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 11:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406018AbfHIJKV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 05:10:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57137 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfHIJKV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 05:10:21 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hw0ud-0001Km-LU; Fri, 09 Aug 2019 11:10:15 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hw0ub-0005cn-Uf; Fri, 09 Aug 2019 11:10:13 +0200
Date:   Fri, 9 Aug 2019 11:10:13 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/2] pwm: sprd: Add Spreadtrum PWM support
Message-ID: <20190809091013.vguj4wty7qiab64t@pengutronix.de>
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
 <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Aug 08, 2019 at 04:59:39PM +0800, Baolin Wang wrote:
> From: Neo Hou <neo.hou@unisoc.com>
> 
> This patch adds the Spreadtrum PWM support, which provides maximum 4
> channels.
> 
> Signed-off-by: Neo Hou <neo.hou@unisoc.com>
> Co-developed-by: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/pwm/Kconfig    |   10 ++
>  drivers/pwm/Makefile   |    1 +
>  drivers/pwm/pwm-sprd.c |  311 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 322 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sprd.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a7e5751..4963b4d 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -423,6 +423,16 @@ config PWM_SPEAR
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-spear.
>  
> +config PWM_SPRD
> +	tristate "Spreadtrum PWM support"
> +	depends on ARCH_SPRD || COMPILE_TEST

I think you need

	depends on HAS_IOMEM

> +	help
> +	  Generic PWM framework driver for the PWM controller on
> +	  Spreadtrum SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sprd.
> +
>  config PWM_STI
>  	tristate "STiH4xx PWM support"
>  	depends on ARCH_STI
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 76b555b..26326ad 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
> +obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
>  obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
> diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> new file mode 100644
> index 0000000..f6fc793
> --- /dev/null
> +++ b/drivers/pwm/pwm-sprd.c
> @@ -0,0 +1,311 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Spreadtrum Communications Inc.

If there is a publicly available reference manual available, please add
a link to it here.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#define SPRD_PWM_PRESCALE	0x0
> +#define SPRD_PWM_MOD		0x4
> +#define SPRD_PWM_DUTY		0x8
> +#define SPRD_PWM_DIV		0xc
> +#define SPRD_PWM_PAT_LOW	0x10
> +#define SPRD_PWM_PAT_HIGH	0x14
> +#define SPRD_PWM_ENABLE		0x18
> +
> +#define SPRD_PWM_MOD_MAX	GENMASK(7, 0)
> +#define SPRD_PWM_REG_MSK	GENMASK(15, 0)
> +#define SPRD_PWM_ENABLE_BIT	BIT(0)
> +
> +#define SPRD_PWM_NUM		4
> +#define SPRD_PWM_REGS_SHIFT	5
> +#define SPRD_PWM_NUM_CLKS	2
> +#define SPRD_PWM_DEFAULT_CLK	26000000UL
> +
> +struct sprd_pwm_chn {
> +	struct clk_bulk_data clks[SPRD_PWM_NUM_CLKS];
> +	unsigned long clk_rate;
> +	bool clk_enabled;
> +};
> +
> +struct sprd_pwm_chip {
> +	void __iomem *base;
> +	struct device *dev;
> +	struct pwm_chip chip;
> +	int num_pwms;
> +	struct sprd_pwm_chn chn[SPRD_PWM_NUM];
> +};
> +
> +/* list of clocks required by PWM channels */
> +static const char * const sprd_pwm_clks[] = {
> +	"enable0", "pwm0",
> +	"enable1", "pwm1",
> +	"enable2", "pwm2",
> +	"enable3", "pwm3",
> +};
> +
> +static u32 sprd_pwm_read(struct sprd_pwm_chip *chip, u32 num, u32 reg)

num is the channel id here? Then maybe "hwid" or "chanid" would be a
better name. Or pass struct pwm_chip only?

Please (if you keep sprd_pwm_chip) rename chip to spc which is the name
used in other places for structures of this type. "chip" is for struct
pwm_chip.

> +{
> +	u32 offset = reg + (num << SPRD_PWM_REGS_SHIFT);
> +
> +	return readl_relaxed(chip->base + offset);
> +}
> +
> +static void sprd_pwm_write(struct sprd_pwm_chip *chip, u32 num,
> +			   u32 reg, u32 val)
> +{
> +	u32 offset = reg + (num << SPRD_PWM_REGS_SHIFT);
> +
> +	writel_relaxed(val, chip->base + offset);
> +}
> +
> +static int sprd_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   int duty_ns, int period_ns)

Please implement .apply() instead of .config(), .enable() and
.disable().

> +{
> +	struct sprd_pwm_chip *spc =
> +		container_of(chip, struct sprd_pwm_chip, chip);
> +	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
> +	u64 div, tmp;
> +	u32 prescale, duty;
> +	int ret;
> +
> +	/*
> +	 * NOTE: the clocks to PWM channel has to be enabled first before
> +	 * writing to the registers.
> +	 */
> +	if (!chn->clk_enabled) {
> +		ret = clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->clks);

Do you really need to enable all 8 clocks to configure a single channel?

> +		if (ret) {
> +			dev_err(spc->dev, "failed to enable pwm%u clock\n",
> +				pwm->hwpwm);
> +			return ret;
> +		}
> +
> +		chn->clk_enabled = true;
> +	}
> +
> +	duty = duty_ns * SPRD_PWM_MOD_MAX / period_ns;

@Baolin: until we're there that there are framework requirements how to
round, please document at least how you do it here. Also describing the
underlying concepts would be good for the driver reader.

Something like:

/*
 * The hardware provides a counter that is feed by the source clock.
 * The period length is (PRESCALE + 1) * MOD counter steps.
 * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
 *
 * To keep the maths simple we're always using MOD = MOD_MAX.
 * The value for PRESCALE is selected such that the resulting period
 * gets the maximal length not bigger than the requested one with the
 * given settings (MOD = MOD_MAX and input clock).
 */

@Thierry: having a framework guideline here would be good. Or still
better a guideline and a debug setting that notices drivers stepping out
of line.

I assume using MOD = 0 is forbidden?

> +	/*
> +	 * According to the datasheet, the period_ns calculation formula
> +	 * should be:
> +	 * period_ns = 10^9 * (prescale + 1) * mod / clk_rate
> +	 *
> +	 * Then we can get the prescale formula:
> +	 * prescale = (period_ns * clk_rate) / (10^9 * mod) -1
> +	 */
> +	tmp = chn->clk_rate * period_ns;
> +	div = 1000000000ULL * SPRD_PWM_MOD_MAX;

Please use NSEC_PER_SEC instead of 1000000000ULL.

> +	prescale = div64_u64(tmp, div) - 1;

If tmp is smaller than div you end up with prescale = 0xffffffff which
should be catched. What if prescale > 0xffff?

> +	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
> +	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);

You're losing precision here as you always use SPRD_PWM_MOD_MAX, right?
(Just for my understanding, if this simpler approach is good enough
here that's fine.)

> +	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PAT_LOW, SPRD_PWM_REG_MSK);
> +	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PAT_HIGH, SPRD_PWM_REG_MSK);

Please describe these two registers in a short comment.

> +	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);

Is the configuration here atomic in the sense that the write of DUTY
above only gets effective when PRESCALE is written? If not, please add
a describing paragraph at the top of the driver similar to what is
written in pwm-sifive.c. When the PWM is already running before, how
does a configuration change effects the output? Is the currently running
period completed?

> +static void sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +			       struct pwm_state *state)
> +{
> +	struct sprd_pwm_chip *spc =
> +		container_of(chip, struct sprd_pwm_chip, chip);
> +	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
> +	u32 enabled, duty, prescale;
> +	u64 tmp;
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->clks);
> +	if (ret) {
> +		dev_err(spc->dev, "failed to enable pwm%u clocks\n",
> +			pwm->hwpwm);
> +		return;
> +	}
> +
> +	chn->clk_enabled = true;
> +
> +	duty = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY) & SPRD_PWM_REG_MSK;
> +	prescale = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE) & SPRD_PWM_REG_MSK;
> +	enabled = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABLE) & SPRD_PWM_ENABLE_BIT;
> +
> +	/*
> +	 * According to the datasheet, the period_ns and duty_ns calculation
> +	 * formula should be:
> +	 * period_ns = 10^9 * (prescale + 1) * mod / clk_rate
> +	 * duty_ns = 10^9 * (prescale + 1) * duty / clk_rate
> +	 */
> +	tmp = (prescale + 1) * 1000000000ULL * SPRD_PWM_MOD_MAX;
> +	state->period = div64_u64(tmp, chn->clk_rate);

This is not idempotent. If you apply the configuration that is returned
here this shouldn't result in a reconfiguration.

> +	tmp = (prescale + 1) * 1000000000ULL * duty;
> +	state->duty_cycle = div64_u64(tmp, chn->clk_rate);
> +
> +	state->enabled = !!enabled;
> +
> +	/* Disable PWM clocks if the PWM channel is not in enable state. */
> +	if (!enabled) {
> +		clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);
> +		chn->clk_enabled = false;
> +	}
> +}
> +
> +static const struct pwm_ops sprd_pwm_ops = {
> +	.config = sprd_pwm_config,
> +	.enable = sprd_pwm_enable,
> +	.disable = sprd_pwm_disable,
> +	.get_state = sprd_pwm_get_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
> +{
> +	struct clk *clk_parent, *clk_pwm;
> +	int ret, i, clk_index = 0;
> +
> +	clk_parent = devm_clk_get(spc->dev, "source");
> +	if (IS_ERR(clk_parent)) {
> +		dev_err(spc->dev, "failed to get source clock\n");
> +		return PTR_ERR(clk_parent);
> +	}
> +
> +	for (i = 0; i < SPRD_PWM_NUM; i++) {
> +		struct sprd_pwm_chn *chn = &spc->chn[i];
> +		int j;
> +
> +		for (j = 0; j < SPRD_PWM_NUM_CLKS; ++j)
> +			chn->clks[j].id = sprd_pwm_clks[clk_index++];
> +
> +		ret = devm_clk_bulk_get(spc->dev, SPRD_PWM_NUM_CLKS, chn->clks);
> +		if (ret) {
> +			if (ret == -ENOENT)
> +				break;

devm_clk_bulk_get_optional ? I'm sure you don't want to get all 8 clocks
8 times.

> +
> +			dev_err(spc->dev, "failed to get channel clocks\n");
> +			return ret;
> +		}
> +
> +		clk_pwm = chn->clks[1].clk;

This 1 looks suspicious. Are you using all clocks provided in the dtb at
all? You're not using i in the loop at all, this doesn't look right.

> +		if (!clk_set_parent(clk_pwm, clk_parent))
> +			chn->clk_rate = clk_get_rate(clk_pwm);
> +		else
> +			chn->clk_rate = SPRD_PWM_DEFAULT_CLK;

I don't know all the clock framework details, but I think there are
better ways to ensure that a given clock is used as parent for another
given clock. Please read the chapter about "Assigned clock parents and
rates" in the clock bindings and check if this could be used for the
purpose here and so simplify the driver.

> +	}
> +
> +	if (!i) {
> +		dev_err(spc->dev, "no availbale PWM channels\n");

s/availbale/available/

> +		return -EINVAL;
> +	}
> +
> +	spc->num_pwms = i;
> +
> +	return 0;
> +}
> +
> +static int sprd_pwm_probe(struct platform_device *pdev)
> +{
> +	struct sprd_pwm_chip *spc;
> +	int ret;
> +
> +	spc = devm_kzalloc(&pdev->dev, sizeof(*spc), GFP_KERNEL);
> +	if (!spc)
> +		return -ENOMEM;
> +
> +	spc->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(spc->base))
> +		return PTR_ERR(spc->base);
> +
> +	spc->dev = &pdev->dev;
> +	ret = sprd_pwm_clk_init(spc);
> +	if (ret)
> +		return ret;
> +
> +	spc->chip.dev = &pdev->dev;
> +	spc->chip.ops = &sprd_pwm_ops;
> +	spc->chip.base = -1;
> +	spc->chip.npwm = spc->num_pwms;
> +
> +	ret = pwmchip_add(&spc->chip);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add PWM chip\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, spc);

If you do this earlier you can simplify the last part of the driver to:

	ret = pwmchip_add(&spc->chip);
	if (ret)
		dev_err(&pdev->dev, "failed to add PWM chip\n");

	return ret;

> +	return 0;
> +}
> +
> +static int sprd_pwm_remove(struct platform_device *pdev)
> +{
> +	struct sprd_pwm_chip *spc = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < spc->num_pwms; i++)
> +		pwm_disable(&spc->chip.pwms[i]);

This is wrong. You must not call pwm_disable here. It's the consumer's
responsibility to disable the hardware.

> +
> +	return pwmchip_remove(&spc->chip);
> +}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
