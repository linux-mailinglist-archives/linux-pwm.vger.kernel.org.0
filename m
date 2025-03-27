Return-Path: <linux-pwm+bounces-5296-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D72A73712
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Mar 2025 17:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4938B3BE7C3
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Mar 2025 16:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A19C1C8634;
	Thu, 27 Mar 2025 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0J6ljeyg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC21A8F63;
	Thu, 27 Mar 2025 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093592; cv=none; b=GaCDoas+N163fLpGlIiLvLGl7b+wPMCN2tXP9k7cLhadKk+Z9NAIBgJs5MetxfdjVS7x9Xo2u3RGdzK1jOYm59rk5iSqxiWDk9OZNTkcWFxnx2nJE7BMXCaUdWritaQ8NuyNpjSo8D2nDOIAURuZc07ZxiAf/xnINXHSByiJ49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093592; c=relaxed/simple;
	bh=3+yFQl9MsrLmluPFUbyma5Bg/7hcDryJ/eM8UMUsSso=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g5mpbsuYwy/aBEovry6oTVBmbPJwtvVDhfH6aWWvgGyTSYxb8s1tqbpkCM+tTCADH0Es35YRbhhkwgrbtUa0jwvSGAicDHVWHBKxjWdG5wZvJTj1aHkTmjmjmijQPfproWbv8QKR4ZTHzQKb6MSLVfw7s99pa12uLQ57aD9gCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0J6ljeyg; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RDilnT022015;
	Thu, 27 Mar 2025 17:39:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	az0YCnmeyySHfJgjCSLhzolXq61fHw4p+GQsMO6NSxk=; b=0J6ljeygU3qcaI8y
	8bWZLLYh00LdEbVFMd0OSckS8S7TmA+OfQCtQHY4HQRDzlMiisrqZG3YiV8KrS2f
	cYKnrklharMXLL8knqJ2FQLppd50N9/I2D/kyUmOMcuKUHBMnacOvVNC+tEzjZxt
	8N730tIwORhnQcYHGb3xlQ3k+ofQjCVXXOd/t49N8khu0laJ6WRFeZf4lAGFTkKF
	HIJliiEMGa+BsNBhlD+iOAoXGiXoD0jV6Mt+2KLdYze/Z+bihwY/Mp+9H5NQ+2gO
	UOa+FbHYUwhdX3senU1hGgScRih6j/CiikhlL2UU9H/lnlaIQeUCyKv3ehNzCRUf
	35vwVA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45j91sucg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 17:39:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9C88E40045;
	Thu, 27 Mar 2025 17:38:01 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 55A6890429F;
	Thu, 27 Mar 2025 17:36:02 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 17:36:02 +0100
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 17:36:00 +0100
Message-ID: <30d13179-66fc-4856-ac70-af051ec5fe8f@foss.st.com>
Date: Thu, 27 Mar 2025 17:36:00 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] iio: trigger: stm32-lptimer: add support for
 stm32mp25
To: Jonathan Cameron <jic23@kernel.org>, <lee@kernel.org>
CC: <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>, <robh@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>, <wbg@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
References: <20250314171451.3497789-1-fabrice.gasnier@foss.st.com>
 <20250314171451.3497789-4-fabrice.gasnier@foss.st.com>
 <20250315125615.065a2e74@jic23-huawei>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250315125615.065a2e74@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_02,2025-03-26_02,2024-11-22_01

On 3/15/25 13:56, Jonathan Cameron wrote:
> On Fri, 14 Mar 2025 18:14:46 +0100
> Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:
> 
>> From: Olivier Moysan <olivier.moysan@foss.st.com>
>>
>> Add support for STM32MP25 SoC. Use newly introduced compatible to handle
>> this new HW variant. Add new trigger definitions that can be used by the
>> stm32 analog-to-digital converter. Use compatible data to identify them.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 
> How do you want this to merge?   If it's going through mfd because
> of dependencies, then
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I haven't checked if there are any dependencies so shout if I should
> pick this up directly for next cycle.

Hi Jonathan, Lee,

There's no build dependency, but the dt-bindings that adds the
compatible string.

Perhaps Lee can pick it up along with the mfd bindings and driver ?

I'm not sure what the most suitable option is.

Best Regards,
Fabrice
> 
> Thanks,
> 
> Jonathan
> 
> 
>> ---
>> Changes in v4:
>> - Jonathan's comment: simplify infrastructure by keeping
>>   devm_iio_trigger_register. Don't need to cast compatible data.
>> ---
>>  drivers/iio/trigger/stm32-lptimer-trigger.c   | 75 ++++++++++++++-----
>>  include/linux/iio/timer/stm32-lptim-trigger.h |  9 +++
>>  2 files changed, 67 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
>> index f1e18913236a..3dcc8d2fe093 100644
>> --- a/drivers/iio/trigger/stm32-lptimer-trigger.c
>> +++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
>> @@ -16,16 +16,43 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/property.h>
>>  
>> -/* List Low-Power Timer triggers */
>> -static const char * const stm32_lptim_triggers[] = {
>> -	LPTIM1_OUT,
>> -	LPTIM2_OUT,
>> -	LPTIM3_OUT,
>> +/* Maximum triggers + one trailing null entry to indicate the end of array */
>> +#define MAX_TRIGGERS 3
>> +
>> +struct stm32_lptim_cfg {
>> +	const char * const (*triggers)[MAX_TRIGGERS];
>> +	unsigned int nb_triggers;
>> +};
>> +
>> +/* List Low-Power Timer triggers for H7, MP13, MP15 */
>> +static const char * const stm32_lptim_triggers[][MAX_TRIGGERS] = {
>> +	{ LPTIM1_OUT,},
>> +	{ LPTIM2_OUT,},
>> +	{ LPTIM3_OUT,},
>> +};
>> +
>> +/* List Low-Power Timer triggers for STM32MP25 */
>> +static const char * const stm32mp25_lptim_triggers[][MAX_TRIGGERS] = {
>> +	{ LPTIM1_CH1, LPTIM1_CH2, },
>> +	{ LPTIM2_CH1, LPTIM2_CH2, },
>> +	{ LPTIM3_CH1,},
>> +	{ LPTIM4_CH1,},
>> +	{ LPTIM5_OUT,},
>> +};
>> +
>> +static const struct stm32_lptim_cfg stm32mp15_lptim_cfg = {
>> +	.triggers = stm32_lptim_triggers,
>> +	.nb_triggers = ARRAY_SIZE(stm32_lptim_triggers),
>> +};
>> +
>> +static const struct stm32_lptim_cfg stm32mp25_lptim_cfg = {
>> +	.triggers = stm32mp25_lptim_triggers,
>> +	.nb_triggers = ARRAY_SIZE(stm32mp25_lptim_triggers),
>>  };
>>  
>>  struct stm32_lptim_trigger {
>>  	struct device *dev;
>> -	const char *trg;
>> +	const char * const *triggers;
>>  };
>>  
>>  static int stm32_lptim_validate_device(struct iio_trigger *trig,
>> @@ -56,22 +83,33 @@ EXPORT_SYMBOL(is_stm32_lptim_trigger);
>>  
>>  static int stm32_lptim_setup_trig(struct stm32_lptim_trigger *priv)
>>  {
>> -	struct iio_trigger *trig;
>> +	const char * const *cur = priv->triggers;
>> +	int ret;
>>  
>> -	trig = devm_iio_trigger_alloc(priv->dev, "%s", priv->trg);
>> -	if  (!trig)
>> -		return -ENOMEM;
>> +	while (cur && *cur) {
>> +		struct iio_trigger *trig;
>>  
>> -	trig->dev.parent = priv->dev->parent;
>> -	trig->ops = &stm32_lptim_trigger_ops;
>> -	iio_trigger_set_drvdata(trig, priv);
>> +		trig = devm_iio_trigger_alloc(priv->dev, "%s", *cur);
>> +		if  (!trig)
>> +			return -ENOMEM;
>>  
>> -	return devm_iio_trigger_register(priv->dev, trig);
>> +		trig->dev.parent = priv->dev->parent;
>> +		trig->ops = &stm32_lptim_trigger_ops;
>> +		iio_trigger_set_drvdata(trig, priv);
>> +
>> +		ret = devm_iio_trigger_register(priv->dev, trig);
>> +		if (ret)
>> +			return ret;
>> +		cur++;
>> +	}
>> +
>> +	return 0;
>>  }
>>  
>>  static int stm32_lptim_trigger_probe(struct platform_device *pdev)
>>  {
>>  	struct stm32_lptim_trigger *priv;
>> +	struct stm32_lptim_cfg const *lptim_cfg;
>>  	u32 index;
>>  
>>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> @@ -81,17 +119,20 @@ static int stm32_lptim_trigger_probe(struct platform_device *pdev)
>>  	if (device_property_read_u32(&pdev->dev, "reg", &index))
>>  		return -EINVAL;
>>  
>> -	if (index >= ARRAY_SIZE(stm32_lptim_triggers))
>> +	lptim_cfg = device_get_match_data(&pdev->dev);
>> +
>> +	if (index >= lptim_cfg->nb_triggers)
>>  		return -EINVAL;
>>  
>>  	priv->dev = &pdev->dev;
>> -	priv->trg = stm32_lptim_triggers[index];
>> +	priv->triggers = lptim_cfg->triggers[index];
>>  
>>  	return stm32_lptim_setup_trig(priv);
>>  }
>>  
>>  static const struct of_device_id stm32_lptim_trig_of_match[] = {
>> -	{ .compatible = "st,stm32-lptimer-trigger", },
>> +	{ .compatible = "st,stm32-lptimer-trigger", .data = &stm32mp15_lptim_cfg },
>> +	{ .compatible = "st,stm32mp25-lptimer-trigger", .data = &stm32mp25_lptim_cfg},
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, stm32_lptim_trig_of_match);
>> diff --git a/include/linux/iio/timer/stm32-lptim-trigger.h b/include/linux/iio/timer/stm32-lptim-trigger.h
>> index a34dcf6a6001..ce3cf0addb2e 100644
>> --- a/include/linux/iio/timer/stm32-lptim-trigger.h
>> +++ b/include/linux/iio/timer/stm32-lptim-trigger.h
>> @@ -14,6 +14,15 @@
>>  #define LPTIM1_OUT	"lptim1_out"
>>  #define LPTIM2_OUT	"lptim2_out"
>>  #define LPTIM3_OUT	"lptim3_out"
>> +#define LPTIM4_OUT	"lptim4_out"
>> +#define LPTIM5_OUT	"lptim5_out"
>> +
>> +#define LPTIM1_CH1	"lptim1_ch1"
>> +#define LPTIM1_CH2	"lptim1_ch2"
>> +#define LPTIM2_CH1	"lptim2_ch1"
>> +#define LPTIM2_CH2	"lptim2_ch2"
>> +#define LPTIM3_CH1	"lptim3_ch1"
>> +#define LPTIM4_CH1	"lptim4_ch1"
>>  
>>  #if IS_REACHABLE(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
>>  bool is_stm32_lptim_trigger(struct iio_trigger *trig);
> 

