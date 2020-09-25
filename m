Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E2B278324
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Sep 2020 10:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgIYItq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 04:49:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:52159 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbgIYItn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 25 Sep 2020 04:49:43 -0400
IronPort-SDR: BR4YvuB2mwU8zmAs1xtN7hqH7wwdXTFb7stmxayQHaZzcRX5DOhBozwvEMgUYxXt3aDxONsjIQ
 ULRYWNYZ1Vsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="158861197"
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="158861197"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 01:49:43 -0700
IronPort-SDR: SOCX4YkFqpFtyVmVKqxBwiim2OMbh+XB7z5F4jcvoJaGEpZe0qkVtK3e8SNoKbIPKosVLsmhDe
 jId6rzeTma0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="413726937"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 25 Sep 2020 01:49:42 -0700
Received: from [10.215.249.131] (rtanwar-MOBL.gar.corp.intel.com [10.215.249.131])
        by linux.intel.com (Postfix) with ESMTP id DB2B858043C;
        Fri, 25 Sep 2020 01:49:38 -0700 (PDT)
Subject: Re: [PATCH v13 2/2] Add PWM fan controller driver for LGM SoC
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, lee.jones@linaro.org,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
References: <cover.1600158087.git.rahul.tanwar@linux.intel.com>
 <befa655d8beb326fc8aa405a25a8b3e62b7e6a4a.1600158087.git.rahul.tanwar@linux.intel.com>
 <20200924065534.e2anwghhtysv63e7@pengutronix.de>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <7c424d83-f96b-4b0c-1fbb-b3ec7ef6f07d@linux.intel.com>
Date:   Fri, 25 Sep 2020 16:49:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924065534.e2anwghhtysv63e7@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Uwe,

Thanks for review & feedback.

On 24/9/2020 2:55 pm, Uwe Kleine-König wrote:
> Hello,
>
> (hhm Thierry already announced to have taken this patch, so my review is
> late.)
>
> On Tue, Sep 15, 2020 at 04:23:37PM +0800, Rahul Tanwar wrote:
>> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
>> This PWM controller does not have any other consumer, it is a
>> dedicated PWM controller for fan attached to the system. Add
>> driver for this PWM fan controller.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> ---
>>  drivers/pwm/Kconfig         |  11 ++
>>  drivers/pwm/Makefile        |   1 +
>>  drivers/pwm/pwm-intel-lgm.c | 246 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 258 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-intel-lgm.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 7dbcf6973d33..4949c51fe90b 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -232,6 +232,17 @@ config PWM_IMX_TPM
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-imx-tpm.
>>  
>> +config PWM_INTEL_LGM
>> +	tristate "Intel LGM PWM support"
>> +	depends on HAS_IOMEM
>> +	depends on (OF && X86) || COMPILE_TEST
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
>> index 2c2ba0a03557..e9431b151694 100644
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
>> index 000000000000..ea3df75a5971
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-intel-lgm.c
>> @@ -0,0 +1,246 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2020 Intel Corporation.
>> + *
>> + * Limitations:
>> + * - The hardware supports fixed period which is dependent on 2/3 or 4
>> + *   wire fan mode.
> The driver now hardcodes 2-wire mode. IMHO that is worth mentioning.

Will update.

>> +static void lgm_clk_disable(void *data)
>> +{
>> +	struct lgm_pwm_chip *pc = data;
>> +
>> +	clk_disable_unprepare(pc->clk);
>> +}
>> +
>> +static int lgm_clk_enable(struct device *dev, struct lgm_pwm_chip *pc)
>> +{
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(pc->clk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_add_action_or_reset(dev, lgm_clk_disable, pc);
>> +}
> My first reflex here was to point out that lgm_clk_disable() isn't the
> counter part to lgm_clk_enable() and so lgm_clk_disable() needs
> adaption. On a second look this is correct and so I think the function
> names are wrong. The usual naming would be to use _release instead of
> _disable. Having said that the enable function could be named
> devm_clk_enable and live in drivers/clk/clk-devres.c. (Or
> devm_clk_get_enabled()?)


Will change function name from _disable to _release. But i think addition
of a generic devm_clk_enable in drivers/clk/clk-devres.c can be taken as
a separate task in a future patch (not clubbed with this driver)..


>> +static void lgm_reset_control_assert(void *data)
>> +{
>> +	struct lgm_pwm_chip *pc = data;
>> +
>> +	reset_control_assert(pc->rst);
>> +}
>> +
>> +static int lgm_reset_control_deassert(struct device *dev, struct lgm_pwm_chip *pc)
>> +{
>> +	int ret;
>> +
>> +	ret = reset_control_deassert(pc->rst);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_add_action_or_reset(dev, lgm_reset_control_assert, pc);
>> +}
> A similar comment applies here.
>
>> +static int lgm_pwm_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct lgm_pwm_chip *pc;
>> +	void __iomem *io_base;
>> +	int ret;
>> +
>> +	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
>> +	if (!pc)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, pc);
>> +
>> +	io_base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(io_base))
>> +		return PTR_ERR(io_base);
>> +
>> +	pc->regmap = devm_regmap_init_mmio(dev, io_base, &lgm_pwm_regmap_config);
>> +	if (IS_ERR(pc->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(pc->regmap),
>> +				     "failed to init register map\n");
>> +
>> +	pc->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(pc->clk))
>> +		return dev_err_probe(dev, PTR_ERR(pc->clk), "failed to get clock\n");
>> +
>> +	ret = lgm_clk_enable(dev, pc);
>> +	if (ret) {
>> +		dev_err(dev, "failed to enable clock\n");
> You used dev_err_probe four times for six error paths. I wonder why you
> didn't use it here (and below for a failing pwmchip_add()).

Well noted, will update.

>> +		return ret;
>> +	}
>> +
>> +	pc->rst = devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(pc->rst))
>> +		return dev_err_probe(dev, PTR_ERR(pc->rst),
>> +				     "failed to get reset control\n");
>> +
>> +	ret = lgm_reset_control_deassert(dev, pc);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
> After lgm_reset_control_deassert is called pc->rst is unused. So there
> is no need to have this member in struct lgm_pwm_chip. The same applies
> to ->clk. (You have to pass rst (or clk) to devm_add_action_or_reset for
> that to work. Looks like a nice idea anyhow.)

Agreed, will update.

>> +	pc->chip.dev = dev;
>> +	pc->chip.ops = &lgm_pwm_ops;
>> +	pc->chip.npwm = 1;
> pc->chip.base should probably be set to -1.

Got it, will update. Thanks.

Regards,
Rahul

> Best regards
> Uwe
>

