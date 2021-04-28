Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A34636D792
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Apr 2021 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbhD1Mnv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Apr 2021 08:43:51 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:11452 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239362AbhD1Mnv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Apr 2021 08:43:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619613786; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=5ow7mzLbNS/5oD8Mg+VT007huYKAfGyvY5OcgPRzKnQ=;
 b=H/CgxVO4L2wxx9YPqfgzIcEOTFGc9AVZf9nwfasTiuDRUBStg8dk12YO6LkFglE2EPbOKsU7
 HUDAgZXaz3fANOVPRPkjf+5KTIGC0vjLSNWEhRzWJoLO7vndJbRAxPpWSnLg93Pjzjl6tSW/
 qZiZgwzgnVkJYb9lSKP3eyHVJNc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJkZWM1ZCIsICJsaW51eC1wd21Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60895856e0e9c9a6b6e9cb03 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Apr 2021 12:43:02
 GMT
Sender: fenglinw=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 56B1FC433F1; Wed, 28 Apr 2021 12:43:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: fenglinw)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 664F3C433D3;
        Wed, 28 Apr 2021 12:42:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 28 Apr 2021 20:42:58 +0800
From:   fenglinw@codeaurora.org
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        subbaram@codeaurora.org, collinsd@codeaurora.org,
        aghayal@codeaurora.org
Subject: Re: [PATCH 2/2] pwm: pwm-qcom: add driver for PWM modules in QCOM
 PMICs
In-Reply-To: <20210427170748.wglupc6zwrndalxs@pengutronix.de>
References: <20210427102247.822-1-fenglinw@codeaurora.org>
 <20210427102247.822-3-fenglinw@codeaurora.org>
 <20210427170748.wglupc6zwrndalxs@pengutronix.de>
Message-ID: <6eccf4583cb1eb36775e50cdf069cdbc@codeaurora.org>
X-Sender: fenglinw@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2021-04-28 01:07, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Apr 27, 2021 at 06:22:10PM +0800, Fenglin Wu wrote:
>> PWM modules present in QCOM PMICs are controlled through SPMI bus.
>> Normally, it would have several PWM modules together with adjacent
>> register space and each PWM module can be controlled independently.
>> 
>> Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
>> ---
>>  drivers/pwm/Kconfig    |   9 +
>>  drivers/pwm/Makefile   |   1 +
>>  drivers/pwm/pwm-qcom.c | 585 
>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 595 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-qcom.c
>> 
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 8ae68d6..324ab5d 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -423,6 +423,15 @@ config PWM_PXA
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-pxa.
>> 
>> +config PWM_QCOM
>> +	tristate "Qcom PMIC PWM support"
>> +	depends on MFD_SPMI_PMIC && OF
>> +	help
>> +	  Generic PWM framework driver for PWM module in QCOM PMIC chips
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-qcom.
>> +
>>  config PWM_RCAR
>>  	tristate "Renesas R-Car PWM support"
>>  	depends on ARCH_RENESAS || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index d43b1e1..78316e9 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -38,6 +38,7 @@ obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
>>  obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
>>  obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
>>  obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
>> +obj-$(CONFIG_PWM_QCOM)		+= pwm-qcom.o
>>  obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
>>  obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
>>  obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
>> diff --git a/drivers/pwm/pwm-qcom.c b/drivers/pwm/pwm-qcom.c
>> new file mode 100644
>> index 0000000..48bd823
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-qcom.c
>> @@ -0,0 +1,585 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> 
> If there is a publicly available reference manual describing this
> hardware, please add a link here.
> 
Thanks for reviewing the patch. Unfortunately, I just checked 
internally,
the datasheet was not shared outside so I couldn't give a link here.

> Also please add a section (like in the pwm-sifive driver for example)
> describing the relevant properties. Interesting are answers to the
> questions:
Sure, I will add a section to describe the HW properties.
> 
>  - Does the hardware complete the currently running period on
>    reconfiguration? (If that's configurable, please enable this
>    behaviour)

Yes, this is configurable, PWM_EN_GLITCH_REMOVAL bit is for this purpose
and it's enabled by default.
> 
>  - Does the hardware complete the currently running period when the PWM
>    is disabled?
> 

No, the output stops immediately as soon as the PWM channel is disabled

>  - Does the output pin pull to the inactive level when the PWM is
>    disabled?

Actually, the QCOM PMIC PWM module doesn't have physical pin out. Its 
output
is normally connected to other hardware module in the same PMIC as 
internal
signals, such as: control signal for LED module for scaling LED 
brightness,
input signal for vibrator module for vibration strength control. It's 
output
can also be routed through PMIC GPIO or other pin using internal DTEST
lines, and that depends on HW connection, and it will also need addition
configuration in the GPIO module or the DTEST and that's outside of the
PWM module scope.

For the output signal itself, it's always inactive when the PWM module
is disabled.
> 
>  - Does the hardware support both polarities?
> 
No, it's only support normal polarity.

> Please stick to the format used in pwm-sifive to be easily greppable.
sure, I will.
> 
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/slab.h>
>> +#include <linux/types.h>
>> +
>> +/* PWM module registers */
>> +#define REG_PERPH_SUBTYPE		0x05
>> +#define REG_PWM_SIZE_CLK		0x41
>> +#define REG_PWM_FREQ_PREDIV_CLK		0x42
>> +#define REG_PWM_TYPE_CONFIG		0x43
>> +#define REG_PWM_VALUE_LSB		0x44
>> +#define REG_PWM_VALUE_MSB		0x45
>> +#define REG_ENABLE_CONTROL		0x46
>> +#define REG_PWM_SYNC			0x47
>> +
>> +/* REG_PERPH_SUBTYPE */
>> +#define SUBTYPE_PWM			0x0b
>> +#define SUBTYPE_PWM_LITE		0x11
>> +
>> +/* REG_PWM_SIZE_CLK */
>> +#define PWM_LITE_PWM_SIZE_MASK		BIT(4)
>> +#define PWM_LITE_PWM_SIZE_SHIFT		4
>> +#define PWM_SIZE_MASK			BIT(2)
>> +#define PWM_SIZE_SHIFT			2
>> +#define PWM_CLK_FREQ_SEL_MASK		GENMASK(1, 0)
>> +
>> +/* REG_PWM_FREQ_PREDIV_CLK */
>> +#define PWM_FREQ_PREDIV_MASK		GENMASK(6, 5)
>> +#define PWM_FREQ_PREDIV_SHIFT		5
> 
> It should be possible to not need the _SHIFT define as it can be
> deferred from the mask value. In turn you can also drop the _MASK 
> suffix
> shortening the define names.
Thanks for the suggestion. I will update them all to use
FIELD_PREP(mask, val) for masking and shifting values.
> 
>> +#define PWM_FREQ_EXPONENT_MASK		GENMASK(2, 0)
>> +
>> +/* REG_PWM_TYPE_CONFIG */
>> +#define PWM_EN_GLITCH_REMOVAL_MASK	BIT(5)
>> +
>> +/* REG_PWM_VALUE */
>> +#define PWM_VALUE_LSB_MASK		GENMASK(7, 0)
>> +#define PWM_VALUE_MSB_MASK		BIT(0)
>> +
>> +/* REG_ENABLE_CONTROL */
>> +#define EN_MODULE_BIT			BIT(7)
>> +
>> +/* REG_PWM_SYNC */
>> +#define PWM_VALUE_SYNC			BIT(0)
> 
> I would like to see the register definition to use a common prefix 
> (like
> QCOM_PWM_) and that the names of bit fields include the register name.
> So something like:
> 
> 	#define QCOM_PWM_PWM_SIZE_CLK		0x41
> 	#define QCOM_PWM_PWM_SIZE_CLK_FREQ_SEL 		GENMASK(1, 0)
> 
> even if the names are quite long, its usage is less error prone. Maybe
> it makes sense to drop the duplicated PWM (but only if all or no
> register contains PWM in its name according to the reference manual).
> Also maybe QCOM_PWM_PWMSIZECLK_FREQSEL might be a good choice. I let 
> you
> judge about the details.

sure, I will think about a better way to define the register and bit 
fields
and make sure QCOM_PWM_ prefix is present.
> 
>> +
>> +/* constant definitions */
>> +#define REG_SIZE_PER_CHANN		0x100
>> +#define NUM_PWM_SIZE			2
>> +#define NUM_PWM_CLK			3
>> +#define NUM_CLK_PREDIV			4
>> +#define NUM_PWM_EXP			8
>> +
>> +static const int pwm_size[NUM_PWM_SIZE] = {6, 9};
>> +static const int clk_freq_hz[NUM_PWM_CLK] = {1024, 32768, 19200000};
>> +static const int clk_prediv[NUM_CLK_PREDIV] = {1, 3, 5, 6};
>> +static const int pwm_exponent[NUM_PWM_EXP] = {0, 1, 2, 3, 4, 5, 6, 
>> 7};
> 
> Please also use a driver specific prefix for variables and function
> names.

ACKed!
> 
>> +struct qcom_pwm_config {
>> +	u32	pwm_size;
>> +	u32	pwm_clk;
>> +	u32	prediv;
>> +	u32	clk_exp;
>> +	u16	pwm_value;
>> +	u64	best_period_ns;
>> +};
>> +
>> +struct qcom_pwm_channel {
>> +	struct qcom_pwm_chip	*chip;
>> +	struct qcom_pwm_config	pwm_config;
>> +	u32			chan_idx;
>> +	u32			reg_base;
>> +	u8			subtype;
>> +	u64			current_period_ns;
>> +	u64			current_duty_ns;
>> +};
>> +
>> +struct qcom_pwm_chip {
>> +	struct pwm_chip		pwm_chip;
>> +	struct regmap		*regmap;
>> +	struct device		*dev;
>> +	struct qcom_pwm_channel	*pwms;
>> +	struct mutex		rw_lock;
>> +	u32			num_channels;
>> +};
>> +
>> +static int qcom_pwm_channel_read(struct qcom_pwm_channel *pwm,
>> +					u16 addr, u8 *val)
>> +{
>> +	int rc;
>> +	unsigned int tmp;
>> +
>> +	mutex_lock(&pwm->chip->rw_lock);
>> +	rc = regmap_read(pwm->chip->regmap, pwm->reg_base + addr, &tmp);
>> +	if (rc < 0)
>> +		dev_err(pwm->chip->dev, "Read addr %#x failed, rc=%d\n",
>> +				pwm->reg_base + addr, rc);
> 
> Do you know that you can emit the symbolic error code using %pe? This
> yields better readable error messages. That would be something like:
> 
> 		dev_err(pwm->chip->dev, "Read addr %#x failed, rc=%pe\n",
> 				pwm->reg_base + addr, ERR_PTR(rc));
> 
Thanks for the suggestion, will check it this way.

>> +	else
>> +		*val = (u8)tmp;
>> +	mutex_unlock(&pwm->chip->rw_lock);
>> +
>> +	return rc;
>> +}
>> +
>> +static int qcom_pwm_channel_write(struct qcom_pwm_channel *pwm, u16 
>> addr, u8 val)
>> +{
>> +	int rc;
>> +
>> +	mutex_lock(&pwm->chip->rw_lock);
>> +	rc = regmap_write(pwm->chip->regmap, pwm->reg_base + addr, val);
>> +	if (rc < 0)
>> +		dev_err(pwm->chip->dev, "Write addr %#x with value %#x failed, 
>> rc=%d\n",
>> +				pwm->reg_base + addr, val, rc);
>> +	mutex_unlock(&pwm->chip->rw_lock);
>> +
>> +	return rc;
>> +}
>> +
>> +static int qcom_pwm_channel_masked_write(struct qcom_pwm_channel 
>> *pwm,
>> +				u16 addr, u8 mask, u8 val)
>> +{
>> +	int rc;
>> +
>> +	mutex_lock(&pwm->chip->rw_lock);
>> +	rc = regmap_update_bits(pwm->chip->regmap, pwm->reg_base + addr,
>> +							mask, val);
>> +	if (rc < 0)
>> +		dev_err(pwm->chip->dev, "Update addr %#x to val %#x with mask %#x 
>> failed, rc=%d\n",
>> +				pwm->reg_base + addr, val, mask, rc);
>> +	mutex_unlock(&pwm->chip->rw_lock);
>> +
>> +	return rc;
>> +}
>> +
>> +static struct qcom_pwm_channel *pwm_dev_to_pwm_channel(struct 
>> pwm_chip *pwm_chip,
>> +				struct pwm_device *pwm_dev)
> 
> Please use "chip" as name for the first parameter which is the usual
> choice in the PWM core and also the drivers.
> 
ACKed!

>> +{
>> +
>> +	struct qcom_pwm_chip *chip = container_of(pwm_chip,
>> +			struct qcom_pwm_chip, pwm_chip);
> 
> You will have to pick a different name here accordingly. I'd suggest
> ddata or qc.
> 
ACKed!

>> +	u32 chan_idx = pwm_dev->hwpwm;
> 
> hwpwm is an unsigned int, I suggest making chan_idx an unsigned int,
> too.
> 
ACKed!

>> +	if (chan_idx >= chip->num_channels) {
>> +		dev_err(chip->dev, "hw index %u out of range [0-%u]\n",
>> +				chan_idx, chip->num_channels - 1);
>> +		return NULL;
>> +	}
>> +
>> +	return &chip->pwms[chan_idx];
>> +}
>> +
>> +static int __find_index_in_array(int data, const int array[], int 
>> length)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < length; i++) {
>> +		if (data == array[i])
>> +			return i;
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>> +
>> +static int qcom_pwm_channel_set_glitch_removal(
>> +		struct qcom_pwm_channel *pwm, bool en)
>> +{
>> +	u8 mask, val;
>> +
>> +	val = en ? PWM_EN_GLITCH_REMOVAL_MASK : 0;
>> +	mask = PWM_EN_GLITCH_REMOVAL_MASK;
>> +	return qcom_pwm_channel_masked_write(pwm,
>> +			REG_PWM_TYPE_CONFIG, mask, val);
> 
> What is the effect of this setting?
> 
As I explained at the beginning, enable this setting would garantee the 
PWM
module complete current period before swtiching to the new settings.

>> +}
>> +
>> +static int qcom_pwm_channel_config(struct qcom_pwm_channel *pwm)
>> +{
>> +	int rc;
>> +	u8 val, mask, shift;
>> +	int pwm_size_idx, pwm_clk_idx, prediv_idx, clk_exp_idx;
>> +
>> +	pwm_size_idx = __find_index_in_array(pwm->pwm_config.pwm_size,
>> +			pwm_size, ARRAY_SIZE(pwm_size));
>> +	pwm_clk_idx = __find_index_in_array(pwm->pwm_config.pwm_clk,
>> +			clk_freq_hz, ARRAY_SIZE(clk_freq_hz));
>> +	prediv_idx = __find_index_in_array(pwm->pwm_config.prediv,
>> +			clk_prediv, ARRAY_SIZE(clk_prediv));
>> +	clk_exp_idx = __find_index_in_array(pwm->pwm_config.clk_exp,
>> +			pwm_exponent, ARRAY_SIZE(pwm_exponent));
>> +
>> +	if (pwm_size_idx < 0 || pwm_clk_idx < 0
>> +			|| prediv_idx < 0 || clk_exp_idx < 0)
>> +		return -EINVAL;
>> +
>> +	/* pwm_clk_idx is 1 bit lower than the register value */
>> +	pwm_clk_idx += 1;
>> +	shift = PWM_SIZE_SHIFT;
>> +	mask = PWM_SIZE_MASK;
>> +	if (pwm->subtype == SUBTYPE_PWM_LITE) {
>> +		shift = PWM_LITE_PWM_SIZE_SHIFT;
>> +		mask = PWM_LITE_PWM_SIZE_MASK;
>> +	}
>> +
>> +	val = pwm_size_idx << shift | pwm_clk_idx;
> 
> If you use
> 
> 	val = FIELD_PREP(pwm_size_idx, mask) | pwm_clk_idx;
> 
> you don't need the shift variable.
> 
ACKed!

>> +	mask |= PWM_CLK_FREQ_SEL_MASK;
>> +	rc = qcom_pwm_channel_masked_write(pwm, REG_PWM_SIZE_CLK, mask, 
>> val);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	val = prediv_idx << PWM_FREQ_PREDIV_SHIFT | clk_exp_idx;
>> +	mask = PWM_FREQ_PREDIV_MASK | PWM_FREQ_EXPONENT_MASK;
>> +	rc = qcom_pwm_channel_masked_write(pwm, REG_PWM_FREQ_PREDIV_CLK, 
>> mask, val);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	val = pwm->pwm_config.pwm_value >> 8;
>> +	mask = PWM_VALUE_MSB_MASK;
>> +	rc = qcom_pwm_channel_masked_write(pwm, REG_PWM_VALUE_MSB, mask, 
>> val);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	val = pwm->pwm_config.pwm_value & PWM_VALUE_LSB_MASK;
>> +	rc = qcom_pwm_channel_write(pwm, REG_PWM_VALUE_LSB, val);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	val = PWM_VALUE_SYNC;
>> +	return qcom_pwm_channel_write(pwm, REG_PWM_SYNC, val);
>> +}
>> +
>> +static int qcom_pwm_channel_enable(struct qcom_pwm_channel *pwm, bool 
>> en)
>> +{
>> +	u8 mask, val;
>> +
>> +	mask = EN_MODULE_BIT;
>> +	val = en ? EN_MODULE_BIT : 0;
>> +	return qcom_pwm_channel_masked_write(pwm,
>> +			REG_ENABLE_CONTROL, mask, val);
>> +}
>> +
>> +static void __qcom_pwm_calc_pwm_period(u64 period_ns,
>> +			struct qcom_pwm_config *pwm_config)
>> +{
>> +	struct qcom_pwm_config configs[NUM_PWM_SIZE];
>> +	int i, j, m, n;
>> +	u64 tmp1, tmp2;
>> +	u64 clk_period_ns = 0, pwm_clk_period_ns;
>> +	u64 clk_delta_ns = U64_MAX, min_clk_delta_ns = U64_MAX;
>> +	u64 pwm_period_delta = U64_MAX, min_pwm_period_delta = U64_MAX;
>> +	int pwm_size_step;
>> +
>> +	/*
>> +	 *              (2^pwm_size) * (2^pwm_exp) * prediv * NSEC_PER_SEC
>> +	 * pwm_period = ---------------------------------------------------
>> +	 *                               clk_freq_hz
>> +	 *
>> +	 * Searching the closest settings for the requested PWM period.
> 
> Please don't pick the nearest setting, but the next smallest one.
> 
I am not quite sure here. You can see from the equation above, there are 
4
settings can impact PWM period calculation and each setting has an array 
of
values. We can't easily sort out the sequence of settings to achieve an 
ascending
or descending PWM periods and choose the closest one or the next 
smallest one,
instead, the logic below is to walk through all of the settings and find 
the
closest one.
I am also confused about not choosing the nearest settings but the
next smallest one, let's say if we are trying to achieve 1ms PWM period, 
and
there are three settings can get 0.90ms, 0.99ms, 1.05ms respectively
should we choose 0.99ms which is the closest one, or 1.05ms which is the 
next
smallest one?

>> +	 */
>> +
>> +	for (n = 0; n < ARRAY_SIZE(pwm_size); n++) {
>> +		pwm_clk_period_ns = period_ns >> pwm_size[n];
>> +		for (i = ARRAY_SIZE(clk_freq_hz) - 1; i >= 0; i--) {
>> +			for (j = 0; j < ARRAY_SIZE(clk_prediv); j++) {
>> +				for (m = 0; m < ARRAY_SIZE(pwm_exponent); m++) {
>> +					tmp1 = 1 << pwm_exponent[m];
>> +					tmp1 *= clk_prediv[j];
>> +					tmp2 = NSEC_PER_SEC;
>> +					do_div(tmp2, clk_freq_hz[i]);
>> +
>> +					clk_period_ns = tmp1 * tmp2;
>> +
>> +					clk_delta_ns = abs(pwm_clk_period_ns
>> +						- clk_period_ns);
>> +					/*
>> +					 * Find the closest setting for
>> +					 * PWM frequency predivide value
>> +					 */
>> +					if (clk_delta_ns < min_clk_delta_ns) {
>> +						min_clk_delta_ns
>> +							= clk_delta_ns;
>> +						configs[n].pwm_clk
>> +							= clk_freq_hz[i];
>> +						configs[n].prediv
>> +							= clk_prediv[j];
>> +						configs[n].clk_exp
>> +							= pwm_exponent[m];
>> +						configs[n].pwm_size
>> +							= pwm_size[n];
>> +						configs[n].best_period_ns
>> +							= clk_period_ns;
>> +					}
>> +				}
>> +			}
>> +		}
>> +
>> +		configs[n].best_period_ns *= 1 << pwm_size[n];
>> +		/* Find the closest setting for PWM period */
>> +		pwm_period_delta = min_clk_delta_ns << pwm_size[n];
>> +		if (pwm_period_delta < min_pwm_period_delta) {
>> +			min_pwm_period_delta = pwm_period_delta;
>> +			memcpy(pwm_config, &configs[n],
>> +					sizeof(struct qcom_pwm_config));
>> +		}
>> +	}
> 
> Huh, this is complicated. It would be great if this could be 
> simplified.
> If you provide a reference manual or at least a .get_state function, I
> can try to advise.
> 
Hmm, I am not sure how to describe the HW implementation here, but as I
explained, there are four parameters impacting the PWM period 
calculation
with different way, so the code logic here is trying to walk through all
of the the settings and find the one which can achieve the closest PWM
period.

>> +	/* Larger PWM size can achieve better resolution for PWM duty */
>> +	for (n = ARRAY_SIZE(pwm_size) - 1; n > 0; n--) {
>> +		if (pwm_config->pwm_size >= pwm_size[n])
>> +			break;
>> +		pwm_size_step = pwm_size[n] - pwm_config->pwm_size;
>> +		if (pwm_config->clk_exp >= pwm_size_step) {
>> +			pwm_config->pwm_size = pwm_size[n];
> 
> If you store n instead of pwm_size[n] finding n in
> qcom_pwm_channel_config becomes easier and you can drop
> __find_index_in_array.

I agree with you, but I thought it might be more meaningful to store the
physical values in "struct qcom_pwm_config" instead of the array index .

> 
>> +			pwm_config->clk_exp -= pwm_size_step;
>> +		}
>> +	}
>> +
>> +	pr_debug("PWM setting for period_ns %llu: pwm_clk = %dHZ, prediv = 
>> %d, exponent = %d, pwm_size = %d\n",
>> +			period_ns, pwm_config->pwm_clk, pwm_config->prediv,
>> +			pwm_config->clk_exp, pwm_config->pwm_size);
>> +	pr_debug("Actual period: %lluns\n", pwm_config->best_period_ns);
>> +}
>> +
>> +static void __qcom_pwm_calc_pwm_duty(u64 period_ns, u64 duty_ns,
>> +			struct qcom_pwm_config *pwm_config)
>> +{
>> +	u16 pwm_value, max_pwm_value;
>> +	u64 tmp;
>> +
>> +	tmp = (u64)duty_ns << pwm_config->pwm_size;
>> +	pwm_value = (u16)div64_u64(tmp, period_ns);
>> +
>> +	max_pwm_value = (1 << pwm_config->pwm_size) - 1;
>> +	if (pwm_value > max_pwm_value)
>> +		pwm_value = max_pwm_value;
>> +
>> +	pwm_config->pwm_value = pwm_value;
>> +}
>> +
>> +static int qcom_pwm_config(struct pwm_chip *pwm_chip,
>> +		struct pwm_device *pwm_dev, u64 duty_ns, u64 period_ns)
>> +{
>> +	struct qcom_pwm_channel *pwm;
>> +	int rc;
>> +
>> +	pwm = pwm_dev_to_pwm_channel(pwm_chip, pwm_dev);
>> +	if (pwm == NULL) {
>> +		dev_err(pwm_chip->dev, "PWM channel not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (duty_ns > period_ns) {
>> +		dev_err(pwm_chip->dev, "Duty %llu ns is larger than period %llu 
>> ns\n",
>> +						duty_ns, period_ns);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (period_ns != pwm->current_period_ns)
>> +		__qcom_pwm_calc_pwm_period(period_ns, &pwm->pwm_config);
>> +
>> +	if (period_ns != pwm->current_period_ns ||
>> +			duty_ns != pwm->current_duty_ns)
>> +		__qcom_pwm_calc_pwm_duty(period_ns, duty_ns, &pwm->pwm_config);
> 
> You're losing precision here by using the requested period length
> (instead of the time that is implemented in hardware).

ACKed, will use (pwm_config->best_period_ns) to calculate the duty.

> 
>> +	rc = qcom_pwm_channel_config(pwm);
>> +	if (rc < 0) {
>> +		dev_err(pwm_chip->dev, "Config PWM channel %u failed, rc=%d\n",
>> +						pwm->chan_idx, rc);
>> +		return rc;
>> +	}
>> +
>> +	pwm->current_period_ns = period_ns;
>> +	pwm->current_duty_ns = duty_ns;
>> +	return 0;
>> +}
>> +
>> +static int qcom_pwm_enable(struct pwm_chip *pwm_chip,
>> +				struct pwm_device *pwm_dev)
>> +{
>> +	struct qcom_pwm_channel *pwm;
>> +	int rc = 0;
>> +
>> +	pwm = pwm_dev_to_pwm_channel(pwm_chip, pwm_dev);
>> +	if (pwm == NULL) {
>> +		dev_err(pwm_chip->dev, "PWM channel not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	rc = qcom_pwm_channel_write(pwm, REG_PWM_SYNC, PWM_VALUE_SYNC);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	rc = qcom_pwm_channel_set_glitch_removal(pwm, true);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	return qcom_pwm_channel_enable(pwm, true);
>> +}
>> +
>> +static int qcom_pwm_disable(struct pwm_chip *pwm_chip,
>> +				struct pwm_device *pwm_dev)
>> +{
>> +	struct qcom_pwm_channel *pwm;
>> +	int rc;
>> +
>> +	pwm = pwm_dev_to_pwm_channel(pwm_chip, pwm_dev);
>> +	if (pwm == NULL) {
>> +		dev_err(pwm_chip->dev, "PWM channel not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	rc = qcom_pwm_channel_enable(pwm, false);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	return qcom_pwm_channel_set_glitch_removal(pwm, false);
>> +}
>> +
>> +static int qcom_pwm_apply(struct pwm_chip *pwm_chip,
>> +		struct pwm_device *pwm_dev, const struct pwm_state *state)
> 
> s/pwm_chip/chip/; s/pwm_dev/pwm/;

ACKed!
> 
>> +{
>> +	int rc;
>> +
> 
> You have to check for polarity here.
> 
The PWM module can only support normal polarity, should I just ignore it
or return an error code if PWM_POLARITY_INVERSED is requested?

>> +	if (state->period != pwm_dev->state.period ||
>> +			state->duty_cycle != pwm_dev->state.duty_cycle) {
>> +		rc = qcom_pwm_config(pwm_chip, pwm_dev,
>> +				state->duty_cycle, state->period);
>> +		if (rc < 0)
>> +			return rc;
>> +
>> +		pwm_dev->state.duty_cycle = state->duty_cycle;
>> +		pwm_dev->state.period = state->period;
> 
> The core takes care for this, please drop these two assignments.
> 
ACKed!

>> +	}
>> +
>> +	if (state->enabled != pwm_dev->state.enabled) {
>> +		if (state->enabled)
>> +			rc = qcom_pwm_enable(pwm_chip, pwm_dev);
>> +		else
>> +			rc = qcom_pwm_disable(pwm_chip, pwm_dev);
> 
> Please handle state->enabled = false before configuring duty/period to
> prevent a glitch.
> 
ACKed!

>> +		if (rc < 0)
>> +			return rc;
>> +
>> +		pwm_dev->state.enabled = state->enabled;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct pwm_ops qcom_pwm_ops = {
>> +	.apply = qcom_pwm_apply,
>> +	.owner = THIS_MODULE,
> 
> Please implement .get_status and test your driver with
> CONFIG_PWM_ENABLED.
> 
ACKed, I will add this in next patchset.

>> +};
>> +
>> +static int qcom_pwm_parse_dt(struct qcom_pwm_chip *chip)
>> +{
>> +	int rc = 0, i;
>> +	const __be32 *addr;
>> +	u32 base;
>> +
>> +	addr = of_get_address(chip->dev->of_node, 0, NULL, NULL);
>> +	if (!addr) {
>> +		dev_err(chip->dev, "Get PWM device address failed, rc=%d\n",
>> +				rc);
>> +		return -EINVAL;
>> +	}
>> +
>> +	base = be32_to_cpu(*addr);
>> +	rc = of_property_read_u32(chip->dev->of_node, "qcom,num-channels",
>> +			&chip->num_channels);
>> +	if (rc < 0) {
>> +		dev_err(chip->dev, "Failed to get qcom,num-channels, rc=%d\n",
>> +				rc);
>> +		return rc;
>> +	}
>> +
>> +	if (chip->num_channels == 0) {
>> +		dev_err(chip->dev, "No PWM channel specified\n");
>> +		return rc;
>> +	}
>> +
>> +	chip->pwms = devm_kcalloc(chip->dev, chip->num_channels,
>> +			sizeof(*chip->pwms), GFP_KERNEL);
>> +	if (!chip->pwms)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < chip->num_channels; i++) {
>> +		chip->pwms[i].chip = chip;
>> +		chip->pwms[i].chan_idx = i;
>> +		chip->pwms[i].reg_base = base + i * REG_SIZE_PER_CHANN;
>> +		rc = qcom_pwm_channel_read(&chip->pwms[i], REG_PERPH_SUBTYPE,
>> +				&chip->pwms[i].subtype);
> 
> Can a single device have channels with different sub-types?

Hmm, it has the possibility. Normally, in one PMIC, all PWM modules 
should
have the same sub-type of PWM modules. But since each PWM module is 
accessed
independantly, so we will need to check the sub-type here for each PWM 
module.

> 
>> +		if (rc < 0) {
>> +			dev_err(chip->dev, "Read PWM channel %d subtype failed, rc=%d\n",
>> +					i, rc);
>> +			return rc;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_pwm_probe(struct platform_device *pdev)
>> +{
>> +	int rc;
>> +	struct qcom_pwm_chip *chip;
>> +
>> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>> +	if (!chip)
>> +		return -ENOMEM;
> 
> If you parse qcom,num-channels already before allocating driver data 
> you
> can allocate driver and per channel data in a single chunk, making some
> operations simpler and maybe even save some memory.
> 
In a single chunk do you mean by calling devm_zalloc() once?
Can you let me know how to do that? The per channel data is anothe 
pointer
which is different from the driver data, how can we make sure two 
different
pointers can be allocated in the same chunk of memory?

>> +	chip->dev = &pdev->dev;
>> +	chip->regmap = dev_get_regmap(chip->dev->parent, NULL);
>> +	if (!chip->regmap) {
>> +		dev_err(chip->dev, "Getting regmap failed\n");
>> +		return -EINVAL;
> 
> ENODEV instead of EINVAL is more usual I think. Please use
> 
> 	return dev_err_probe(chip->dev, -ENODEV, "....");
> 
> and also use dev_err_probe in the other error paths.

Acked!

> 
>> +	}
>> +
>> +	rc = qcom_pwm_parse_dt(chip);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	mutex_init(&chip->rw_lock);
>> +	dev_set_drvdata(chip->dev, chip);
>> +	chip->pwm_chip.dev = chip->dev;
>> +	chip->pwm_chip.base = -1;
> 
> This shouldn't be done any more since commit f9a8ee8c8bcd ("pwm: Always
> allocate PWM chip base ID dynamically") (which currently sits in next).

ACKed!
> 
>> +	chip->pwm_chip.npwm = chip->num_channels;
>> +	chip->pwm_chip.ops = &qcom_pwm_ops;
>> +
>> +	rc = pwmchip_add(&chip->pwm_chip);
>> +	if (rc < 0) {
>> +		dev_err(chip->dev, "Add pwmchip failed, rc=%d\n", rc);
>> +		goto err_out;
> 
> The cleanups done after this goto are not necessary. Just use
> 
> 	return dev_err_probe(chip->dev, rc, "Add pwmchip failed\n");
> 
> 
ACKed!

>> +	}
>> +
>> +	return 0;
>> +err_out:
>> +	mutex_destroy(&chip->rw_lock);
>> +	dev_set_drvdata(chip->dev, NULL);
>> +	return rc;
>> +}
>> +
>> +static int qcom_pwm_remove(struct platform_device *pdev)
>> +{
>> +	struct qcom_pwm_chip *chip = dev_get_drvdata(&pdev->dev);
>> +	int rc = 0;
>> +
>> +	rc = pwmchip_remove(&chip->pwm_chip);
>> +	if (rc < 0)
>> +		dev_err(chip->dev, "Remove pwmchip failed, rc=%d\n", rc);
>> +
>> +	mutex_destroy(&chip->rw_lock);
>> +	dev_set_drvdata(chip->dev, NULL);
> 
> The driver core cares for
> 
> 	dev_set_drvdata(chip->dev, NULL);
> 
> Also destroying the mutes isn't usually done.
> 
ACKed!

>> +	return rc;
>> +}
>> +
>> +static const struct of_device_id qcom_pwm_of_match[] = {
>> +	{ .compatible = "qcom,pwm"},
>> +	{ },
>> +};
>> +
>> +static struct platform_driver qcom_pwm_driver = {
>> +	.driver		= {
>> +		.name		= "qcom,pwm",
>> +		.of_match_table	= qcom_pwm_of_match,
>> +	},
>> +	.probe		= qcom_pwm_probe,
>> +	.remove		= qcom_pwm_remove,
> 
> I'm not a big fan of aligning the =. It looks ugly with that big white
> space before = (and using a smaller space is bad if you later have to
> initialize a member with a longer name).
> 
> But no hard veto from my side here, if you want to stick to that 
> layout.
> 
>> +};
>> +module_platform_driver(qcom_pwm_driver);
>> +
>> +MODULE_DESCRIPTION("QCOM PWM driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project.
>> 
>> 
