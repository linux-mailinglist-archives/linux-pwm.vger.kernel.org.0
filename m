Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0112098EC
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2020 06:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgFYEYA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 25 Jun 2020 00:24:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:27978 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgFYEYA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 25 Jun 2020 00:24:00 -0400
IronPort-SDR: /VyxqyaFq++yxyl9zoqCLyvC9ViSbNY+nXnOlBoE17mLlnL0bv1+8BRnfOyeBVKiKtcszyOdcE
 9+wyU/UmkFGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="146246035"
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="146246035"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 21:23:59 -0700
IronPort-SDR: wn6pbKZSjt6KA7vrnM6zVRfPvdg0paanvOI94eMoZWfE9hNk658QDFgcn6iJhvoKuEXgsErZak
 HRe+Idgq4U3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="311863765"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jun 2020 21:23:58 -0700
Received: from [10.213.33.121] (rtanwar-MOBL.gar.corp.intel.com [10.213.33.121])
        by linux.intel.com (Postfix) with ESMTP id 95689580298;
        Wed, 24 Jun 2020 21:23:55 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] Add PWM fan controller driver for LGM SoC
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
References: <cover.1592474693.git.rahul.tanwar@linux.intel.com>
 <79fefda4aad5ebeb368129375bf128b74ed12224.1592474693.git.rahul.tanwar@linux.intel.com>
 <41a3c509e8d72d1e1c45b6b87f52f0a75018e6b0.camel@pengutronix.de>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <25560ece-5d71-562d-359a-490d70cc5453@linux.intel.com>
Date:   Thu, 25 Jun 2020 12:23:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <41a3c509e8d72d1e1c45b6b87f52f0a75018e6b0.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Philipp,

On 18/6/2020 8:25 pm, Philipp Zabel wrote:
> Hi Rahul,
>
> On Thu, 2020-06-18 at 20:05 +0800, Rahul Tanwar wrote:
>> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
>> This PWM controller does not have any other consumer, it is a
>> dedicated PWM controller for fan attached to the system. Add
>> driver for this PWM fan controller.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> ---
>>  drivers/pwm/Kconfig         |   9 +
>>  drivers/pwm/Makefile        |   1 +
>>  drivers/pwm/pwm-intel-lgm.c | 400 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 410 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-intel-lgm.c
>>
> [...]
>> diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
>> new file mode 100644
>> index 000000000000..3c7077acb161
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-intel-lgm.c
>> @@ -0,0 +1,400 @@
> [...]
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
>> +	pc->regmap = devm_regmap_init_mmio(dev, io_base, &pwm_regmap_config);
>> +	if (IS_ERR(pc->regmap)) {
>> +		ret = PTR_ERR(pc->regmap);
>> +		dev_err(dev, "failed to init register map: %pe\n", pc->regmap);
>> +		return ret;
>> +	}
>> +
>> +	pc->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(pc->clk)) {
>> +		ret = PTR_ERR(pc->clk);
>> +		dev_err(dev, "failed to get clock: %pe\n", pc->clk);
>> +		return ret;
>> +	}
>> +
>> +	pc->rst = devm_reset_control_get(dev, NULL);
>> +	if (IS_ERR(pc->rst)) {
>> +		ret = PTR_ERR(pc->rst);
>> +		dev_err(dev, "failed to get reset control: %pe\n", pc->rst);
>> +		return ret;
>> +	}
> Please use devm_reset_control_get_exclusive() to make it explicit an
> that exclusive reset control is requested. Given how the reset control
> is used, I think this driver could also use
> devm_reset_control_get_shared() to potentially allow sharing a reset
> line with other devices.

devm_reset_control_get() is a wrapper for devm_reset_control_get_exclusive().
Code as below:
static inline struct reset_control *devm_reset_control_get(
                                struct device *dev, const char *id)
{
        return devm_reset_control_get_exclusive(dev, id);
}
Am i missing something else?

Regards,
Rahul
