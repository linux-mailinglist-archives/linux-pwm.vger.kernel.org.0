Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A2621E793
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2020 07:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgGNFfW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Jul 2020 01:35:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:41449 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgGNFfW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 14 Jul 2020 01:35:22 -0400
IronPort-SDR: /CucBaDmgBHjwUg7SFnzewKOzbR6QWyzkI1iYXUbzV9t7Yw0W3DDSMkO4aDQj4S/yGbekFcf5R
 n/zWFWJpT5PA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="136276390"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="136276390"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 22:35:19 -0700
IronPort-SDR: CHqTJs+sdut8Yd81dfYiHMkm8lUVNd1CXAG+YweH9OVUR7KGHWew/7xGMcb0vwxoDeoRn8xRkV
 lFqZ+GayKd1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="324445883"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2020 22:35:19 -0700
Received: from [10.215.165.139] (rtanwar-MOBL.gar.corp.intel.com [10.215.165.139])
        by linux.intel.com (Postfix) with ESMTP id 7A60D58080E;
        Mon, 13 Jul 2020 22:35:15 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] Add PWM fan controller driver for LGM SoC
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
References: <cover.1593503228.git.rahul.tanwar@linux.intel.com>
 <a74b18b68f26bf902c30a017050cc4ea070da887.1593503228.git.rahul.tanwar@linux.intel.com>
 <20200713191059.zsokzvv3k2hyaxcl@pengutronix.de>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <3e0623c7-45cd-ea60-bae3-a03d991e98bf@linux.intel.com>
Date:   Tue, 14 Jul 2020 13:35:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713191059.zsokzvv3k2hyaxcl@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Uwe,

On 14/7/2020 3:10 am, Uwe Kleine-König wrote:
> Hello,
>
> On Tue, Jun 30, 2020 at 03:55:32PM +0800, Rahul Tanwar wrote:
>> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
>> This PWM controller does not have any other consumer, it is a
>> dedicated PWM controller for fan attached to the system. Add
>> driver for this PWM fan controller.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> ---
>>  drivers/pwm/Kconfig         |  11 ++
>>  drivers/pwm/Makefile        |   1 +
>>  drivers/pwm/pwm-intel-lgm.c | 266 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 278 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-intel-lgm.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index cb8d739067d2..3486edab09c4 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -232,6 +232,17 @@ config PWM_IMX_TPM
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-imx-tpm.
>>  
>> +config PWM_INTEL_LGM
>> +	tristate "Intel LGM PWM support"
>> +	depends on OF && HAS_IOMEM
>> +	depends on X86 || COMPILE_TEST
>> +	select REGMAP_MMIO
>> +	help
>> +	  Generic PWM fan controller driver for LGM SoC.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-intel-lgm.
>> +
>>  config PWM_IQS620A
>>  	tristate "Azoteq IQS620A PWM support"
>>  	depends on MFD_IQS62X || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index a59c710e98c7..db154a6b4f51 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
>>  obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
>>  obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
>>  obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
>> +obj-$(CONFIG_PWM_INTEL_LGM)	+= pwm-intel-lgm.o
>>  obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
>>  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
>>  obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
>> diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
>> new file mode 100644
>> index 000000000000..fddfedd56fc3
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-intel-lgm.c
>> @@ -0,0 +1,266 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2020 Intel Corporation.
>> + *
>> + * Notes & Limitations:
> I'd like to have this "Limitations:" only to make it easily greppable.
>
>> + * - The hardware supports fixed period which is dependent on 2/3 or 4
>> + *   wire fan mode.
>> + * - Supports normal polarity. Does not support changing polarity.
>> + * - When PWM is disabled, output of PWM will become 0(inactive). It doesn't
>> + *   keep track of running period.
>> + * - When duty cycle is changed, PWM output may be a mix of previous setting
>> + *   and new setting for the first period. From second period, the output is
>> + *   based on new setting.
>> + * - It is a dedicated PWM fan controller. There are no other consumers for
>> + *   this PWM controller.
>> + */
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +
>> +#define LGM_PWM_FAN_CON0		0x0
>> +#define LGM_PWM_FAN_EN_EN		BIT(0)
>> +#define LGM_PWM_FAN_EN_DIS		0x0
>> +#define LGM_PWM_FAN_EN_MSK		BIT(0)
>> +#define LGM_PWM_FAN_MODE_2WIRE		0x0
>> +#define LGM_PWM_FAN_MODE_4WIRE		0x1
>> +#define LGM_PWM_FAN_MODE_MSK		BIT(1)
>> +#define LGM_PWM_FAN_DC_MSK		GENMASK(23, 16)
>> +
>> +#define LGM_PWM_FAN_CON1		0x4
>> +#define LGM_PWM_FAN_MAX_RPM_MSK		GENMASK(15, 0)
>> +
>> +#define LGM_PWM_MAX_RPM			(BIT(16) - 1)
>> +#define LGM_PWM_DEFAULT_RPM		4000
>> +#define LGM_PWM_MAX_DUTY_CYCLE		(BIT(8) - 1)
>> +
>> +#define LGM_PWM_DC_BITS			8
>> +
>> +#define LGM_PWM_PERIOD_2WIRE_NSECS	40000000
>> +#define LGM_PWM_PERIOD_4WIRE_NSECS	40000
>> +
>> +struct lgm_pwm_chip {
>> +	struct pwm_chip chip;
>> +	struct regmap *regmap;
>> +	struct clk *clk;
>> +	struct reset_control *rst;
>> +	u32 period;
>> +};
>> +
>> +static inline struct lgm_pwm_chip *to_lgm_pwm_chip(struct pwm_chip *chip)
>> +{
>> +	return container_of(chip, struct lgm_pwm_chip, chip);
>> +}
>> +
>> +static int lgm_pwm_enable(struct pwm_chip *chip, bool enable)
>> +{
>> +	struct lgm_pwm_chip *pc = to_lgm_pwm_chip(chip);
>> +	struct regmap *regmap = pc->regmap;
>> +
>> +	regmap_update_bits(regmap, LGM_PWM_FAN_CON0, LGM_PWM_FAN_EN_MSK,
>> +			   enable ? LGM_PWM_FAN_EN_EN : LGM_PWM_FAN_EN_DIS);
> regmap_update_bits has a return value. I think it is supposed to be
> checked.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int lgm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>> +{
>> +	struct lgm_pwm_chip *pc = to_lgm_pwm_chip(chip);
>> +	u32 duty_cycle, val;
>> +	unsigned int period;
>> +
>> +	if (!state->enabled) {
>> +		lgm_pwm_enable(chip, 0);
>> +		return 0;
>> +	}
>> +
>> +	period = min_t(u64, state->period, pc->period);
>> +
>> +	if (state->polarity != PWM_POLARITY_NORMAL ||
>> +	    period < pc->period)
>> +		return -EINVAL;
> This check looks wrong. If you refuse period < pc->period there isn't
> much configuration possible.
>
>> +	duty_cycle = min_t(u32, state->duty_cycle, period);
> This is wrong. Consider state->duty_cycle = 0x100000001 (once it is an
> u64).
>
>> +	/* reg_value = duty_ns * LGM_PWM_MAX_DUTY_CYCLE(0xff) / period_ns */
>> +	val = duty_cycle * LGM_PWM_MAX_DUTY_CYCLE / period;
> The comment is little helpful.
>
>> +	regmap_update_bits(pc->regmap, LGM_PWM_FAN_CON0, LGM_PWM_FAN_DC_MSK,
>> +			   FIELD_PREP(LGM_PWM_FAN_DC_MSK, val));
>> +
>> +	if (state->enabled)
>> +		lgm_pwm_enable(chip, 1);
>> +
>> +	return 0;
>> +}
>> +
>> +static void lgm_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			      struct pwm_state *state)
>> +{
>> +	struct lgm_pwm_chip *pc = to_lgm_pwm_chip(chip);
>> +	u32 duty, val;
>> +
>> +	state->enabled = regmap_test_bits(pc->regmap, LGM_PWM_FAN_CON0,
>> +					  LGM_PWM_FAN_EN_EN);
>> +	state->polarity = PWM_POLARITY_NORMAL;
>> +	state->period = pc->period; /* fixed period */
>> +
>> +	regmap_read(pc->regmap, LGM_PWM_FAN_CON0, &val);
>> +	duty = FIELD_GET(LGM_PWM_FAN_DC_MSK, val);
>> +	state->duty_cycle = DIV_ROUND_UP(duty * pc->period,
>> +					 LGM_PWM_MAX_DUTY_CYCLE);
>> +}
>> +
>> +static const struct pwm_ops lgm_pwm_ops = {
>> +	.get_state = lgm_pwm_get_state,
>> +	.apply = lgm_pwm_apply,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> +static void lgm_pwm_init(struct lgm_pwm_chip *pc)
>> +{
>> +	struct device *dev = pc->chip.dev;
>> +	struct regmap *regmap = pc->regmap;
>> +	u32 max_rpm, fan_wire, con0_val, con0_mask;
>> +
>> +	if (device_property_read_u32(dev, "intel,fan-wire", &fan_wire))
>> +		fan_wire = 2; /* default is 2 wire mode */
>> +
>> +	con0_mask = LGM_PWM_FAN_MODE_MSK;
>> +
>> +	switch (fan_wire) {
>> +	case 4:
>> +		con0_val = FIELD_PREP(LGM_PWM_FAN_MODE_MSK, LGM_PWM_FAN_MODE_4WIRE);
>> +		pc->period = LGM_PWM_PERIOD_4WIRE_NSECS;
>> +		break;
>> +	default:
>> +		/* default is 2wire mode */
>> +		con0_val = FIELD_PREP(LGM_PWM_FAN_MODE_MSK, LGM_PWM_FAN_MODE_2WIRE);
>> +		pc->period = LGM_PWM_PERIOD_2WIRE_NSECS;
>> +		break;
>> +	}
>> +
>> +	if (device_property_read_u32(dev, "intel,max-rpm", &max_rpm))
>> +		max_rpm = LGM_PWM_DEFAULT_RPM;
>> +
>> +	max_rpm = min_t(u32, max_rpm, LGM_PWM_MAX_RPM);
>> +	if (max_rpm == 0)
>> +		max_rpm = LGM_PWM_DEFAULT_RPM;
>> +
>> +	regmap_update_bits(regmap, LGM_PWM_FAN_CON1, LGM_PWM_FAN_MAX_RPM_MSK, max_rpm);
>> +	regmap_update_bits(regmap, LGM_PWM_FAN_CON0, con0_mask, con0_val);
>> +}
>> +
>> +static const struct regmap_config lgm_pwm_regmap_config = {
>> +	.reg_bits = 32,
>> +	.reg_stride = 4,
>> +	.val_bits = 32,
>> +};
>> +
>> +static int lgm_pwm_probe(struct platform_device *pdev)
>> +{
>> +	struct lgm_pwm_chip *pc;
>> +	struct device *dev = &pdev->dev;
>> +	void __iomem *io_base;
>> +	int ret;
>> +
>> +	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
>> +	if (!pc)
>> +		return -ENOMEM;
>> +
>> +	io_base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(io_base))
>> +		return PTR_ERR(io_base);
>> +
>> +	pc->regmap = devm_regmap_init_mmio(dev, io_base, &lgm_pwm_regmap_config);
>> +	if (IS_ERR(pc->regmap)) {
>> +		ret = PTR_ERR(pc->regmap);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to init register map: %pe\n",
>> +				pc->regmap);
>> +		return ret;
>> +	}
>> +
>> +	pc->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(pc->clk)) {
>> +		ret = PTR_ERR(pc->clk);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to get clock: %pe\n", pc->clk);
>> +		return ret;
>> +	}
>> +
>> +	pc->rst = devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(pc->rst)) {
>> +		ret = PTR_ERR(pc->rst);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to get reset control: %pe\n",
>> +				pc->rst);
>> +		return ret;
>> +	}
>> +
>> +	ret = reset_control_deassert(pc->rst);
>> +	if (ret) {
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "cannot deassert reset control: %pe\n",
>> +				ERR_PTR(ret));
>> +		return ret;
>> +	}
>> +
>> +	ret = clk_prepare_enable(pc->clk);
>> +	if (ret) {
>> +		dev_err(dev, "failed to enable clock\n");
> reset_control_assert missing here.
>
>> +		return ret;
>> +	}
>> +
>> +	pc->chip.dev = dev;
>> +	pc->chip.ops = &lgm_pwm_ops;
>> +	pc->chip.npwm = 1;
>> +
>> +	lgm_pwm_init(pc);
>> +
>> +	ret = pwmchip_add(&pc->chip);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to add PWM chip: %pe\n", ERR_PTR(ret));
>> +		clk_disable_unprepare(pc->clk);
>> +		reset_control_assert(pc->rst);
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, pc);
>> +	return 0;
>> +}
>> +
>> +static int lgm_pwm_remove(struct platform_device *pdev)
>> +{
>> +	struct lgm_pwm_chip *pc = platform_get_drvdata(pdev);
>> +	int ret;
>> +
>> +	ret = pwmchip_remove(&pc->chip);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	clk_disable_unprepare(pc->clk);
>> +	reset_control_assert(pc->rst);
> Please swap the two previous lines to match the error patch of .probe.
>
>> +
>> +	return 0;
>> +}
>

Given the fact that this is a dedicated PWM fan controller with no other
PWM consumer, do you think that this driver belongs to drivers/hwmon
instead of drivers/pwm? Thanks.

Regards,
Rahul

