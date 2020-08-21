Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F7824CDB4
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Aug 2020 08:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgHUGHz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Aug 2020 02:07:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:28726 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgHUGHy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 21 Aug 2020 02:07:54 -0400
IronPort-SDR: 01wy1fbkMkqI3AWfmxowQztTkZPf7EqAP6DupBgS/+42rYAb0BN6j4Zu+89gqzlPzHvRilD2Sq
 iAeSo6BJU3Tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="240292014"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="240292014"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 23:07:53 -0700
IronPort-SDR: zS3Q+hWnsEQSYSpZK5bV44jbsl8hcdicGfMIFVWItfHEDnDnloLkqbEVDEYMiTiPxuKugdxVF0
 N2Ex83FLmAsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="335231840"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2020 23:07:54 -0700
Received: from [10.214.149.100] (rtanwar-MOBL.gar.corp.intel.com [10.214.149.100])
        by linux.intel.com (Postfix) with ESMTP id 7604E580279;
        Thu, 20 Aug 2020 23:07:50 -0700 (PDT)
Subject: Re: [PATCH v8 2/2] Add PWM fan controller driver for LGM SoC
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
References: <cover.1597898872.git.rahul.tanwar@linux.intel.com>
 <b6d0a65625a2bc231c649c970c0a1af1ff3a5dd5.1597898872.git.rahul.tanwar@linux.intel.com>
 <20200820105255.GB1891694@smile.fi.intel.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <ae472e72-8727-b62b-4fc7-f62aa41cafbc@linux.intel.com>
Date:   Fri, 21 Aug 2020 14:07:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820105255.GB1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Andy,

On 20/8/2020 6:52 pm, Andy Shevchenko wrote:
> On Thu, Aug 20, 2020 at 12:50:46PM +0800, Rahul Tanwar wrote:
>> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
>> This PWM controller does not have any other consumer, it is a
>> dedicated PWM controller for fan attached to the system. Add
>> driver for this PWM fan controller.
> ...
>
>> +config PWM_INTEL_LGM
>> +	tristate "Intel LGM PWM support"
>> +	depends on OF && HAS_IOMEM
>> +	depends on X86 || COMPILE_TEST
> For better test coverage you may rewrite this
>
> 	depends on HAS_IOMEM
> 	depends on (OF && X86) || COMPILE_TEST

Sure, will update.

>> +	select REGMAP_MMIO
>> +	help
>> +	  Generic PWM fan controller driver for LGM SoC.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-intel-lgm.
> ...
>
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
> This should be mod_devicetable.h.

Well noted.

>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
> ...
>
>> +#define LGM_PWM_PERIOD_2WIRE_NSECS	40000000
> NSECS -> NS
> 40000000 -> (40 * NSEC_PER_MSEC)

Well noted.

> ...
>
>> +	if (state->polarity != PWM_POLARITY_NORMAL ||
>> +	    state->period < pc->period)
> It can be one line.

Ok.

>> +		return -EINVAL;
> ...
>
>> +	if (!state->enabled) {
>> +		ret = lgm_pwm_enable(chip, 0);
>> +		return ret;
> What is the point?

I guess you mean to change it to return lgm_pwm_enable(chip, 0);
Will do, thanks.

>> +	}
> ...
>
>> +	ret = lgm_pwm_enable(chip, 1);
>> +
>> +	return ret;
> Ditto.
>
> ...
>
>> +	state->duty_cycle = DIV_ROUND_UP(duty * pc->period,
>> +					 LGM_PWM_MAX_DUTY_CYCLE);
> One line?

Ok.

> ...
>
>> +	struct lgm_pwm_chip *pc;
>> +	struct device *dev = &pdev->dev;
> Use reversed xmas tree order.

Sure, will update.

>> +	void __iomem *io_base;
>> +	int ret;
> ...
>
>> +	pc->regmap = devm_regmap_init_mmio(dev, io_base, &lgm_pwm_regmap_config);
>> +	if (IS_ERR(pc->regmap)) {
>> +		ret = PTR_ERR(pc->regmap);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to init register map: %pe\n",
>> +				pc->regmap);
>> +		return ret;
> dev_err_probe()

Will update. Thanks.

>> +	}
> ...
>
>> +	pc->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(pc->clk)) {
>> +		ret = PTR_ERR(pc->clk);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to get clock: %pe\n", pc->clk);
>> +		return ret;
> Ditto.
>
>> +	}
>> +
>> +	pc->rst = devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(pc->rst)) {
>> +		ret = PTR_ERR(pc->rst);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to get reset control: %pe\n",
>> +				pc->rst);
>> +		return ret;
> Ditto.
>
>> +	}
>> +
>> +	ret = reset_control_deassert(pc->rst);
>> +	if (ret) {
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "cannot deassert reset control: %pe\n",
>> +				ERR_PTR(ret));
>> +		return ret;
> Ditto.
>
>> +	}
> ...
>
>> +	ret = clk_prepare_enable(pc->clk);
> Wrap it with devm_add_action_or_reset(). Same for reset_control_deassert().
> You probably can even put them under one function.

I did some study and research for using devm_add_action_or_reset(). But
still i have some doubts. Below steps is what i intend to do in order to
switch to using this API. Please do review and let me know it is ok and
i am not missing anything else. Thanks.

1. Call reset_control_assert()
2. Call clk_prepare_enable()
3. Call pwmchip_add()
4. Call devm_add_action_or_reset(dev, my_action, pc)
5. Remove explicit calls to unprepare/reset_control_assert from probe in
failure cases.
6. static void my_action(void *pc)
   {
      pwmchip_remove(&pc->chip);
      clk_disable_upprepare(pc->clk);
      reset_control_assert(pc->rst);
   }
7. Remove platform_driver.remove() entirely.

>> +	if (ret) {
>> +		dev_err(dev, "failed to enable clock\n");
>> +		reset_control_assert(pc->rst);
>> +		return ret;
>> +	}
> ...
>
>> +	ret = pwmchip_add(&pc->chip);
>> +	if (ret < 0) {
> Does ' < 0' have any meaning?

I use < 0 because this API's return code is mentioned as below:
Returns: 0 on success or a negative error code on failure.
Also, all other PWM drivers check for <0 for this call.

>> +		dev_err(dev, "failed to add PWM chip: %pe\n", ERR_PTR(ret));
>> +		clk_disable_unprepare(pc->clk);
>> +		reset_control_assert(pc->rst);
>> +		return ret;
>> +	}
> ...
>
>> +	ret = pwmchip_remove(&pc->chip);
>> +	if (ret < 0)
> Ditto.

Same as above.

>> +		return ret;
Thanks.

Regards,
Rahul

