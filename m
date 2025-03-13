Return-Path: <linux-pwm+bounces-5176-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AFAA5FD12
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 18:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F067D3A8BA2
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9015268FDB;
	Thu, 13 Mar 2025 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2+g7dDtP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91FE2676FD;
	Thu, 13 Mar 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885668; cv=none; b=Sadt25cpiJUO2cjtRQDDNMw2DWGKK27musVXgrkCQqreUEDRTqSv+bgYkCQdX9SrmywcJt8pRFEzgCPtkwjEuJJbi82rH9a3hsYGJtYeLOR4++P2VmLaC6cM41xEZ22aa2OUloS32/e3F1nOuugBlC27XGJSPWSIwlElMYSWEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885668; c=relaxed/simple;
	bh=O0CjwpdSioQx0uW6sJKWWy+Y5McB13rM6R0h3UzHO2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cQZpTtAE7NCWeWxT7GSkapW/zk+vJVr0XFKKUG4l21TnOrg0PviBa+JGK4QCmsmiTk3PRocMhxWM6RWEveIMP5YmjQZu0+krseX3zEIhvEIBCVIEc+iG3faXln6mlIkR7ZVX91UQkCdpGsdGWH5ilLCZH5flrBVefrTxDluAjJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2+g7dDtP; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGD84J004017;
	Thu, 13 Mar 2025 18:07:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	m/R+k38EavnnLqI4ME3aQthwcfO1+fuRzyD+GV3fSk4=; b=2+g7dDtPyxMq1Shu
	QHC7J6eyC/YvBdFdAZwurWUHHOA6LbrJL32RrgKtq6u5ob9qxTvRk5bJnUVgh8Bh
	fuL7OIC6gBf4neJDK0XG6x0vLfIzJOPucsEIuA+AefRNN1/Tuc5P5s+cnZ1BhBtI
	q5WeCk4l+oVW8Gj7CMC2somyp35Ih/UhvZkznVvVOmoxkw/vAKm4LW+OWDwHN8pC
	WLkSntmDkbrr9nk82zbtKDLviuYVMp2hghusryDe1xQFlabxomansar33G0yJIzX
	HwdVxqOZpfB1NNjLgHBkwR/1Z3jQkjXWn0WqW4/vjeQYpH+q7pcfT+BUaXVFZ9sD
	5eitpA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45c2pf07ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 18:07:09 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9EAC94002D;
	Thu, 13 Mar 2025 18:05:58 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C1DE757D4E3;
	Thu, 13 Mar 2025 18:04:27 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 18:04:27 +0100
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 18:04:26 +0100
Message-ID: <c0aec002-7889-4ec5-a438-e7e90d8da13f@foss.st.com>
Date: Thu, 13 Mar 2025 18:04:25 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] clocksource: stm32-lptimer: add support for
 stm32mp25
To: Daniel Lezcano <daniel.lezcano@linaro.org>, <lee@kernel.org>,
        <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jic23@kernel.org>, <tglx@linutronix.de>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <wbg@kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
References: <20250305094935.595667-1-fabrice.gasnier@foss.st.com>
 <20250305094935.595667-5-fabrice.gasnier@foss.st.com>
 <83283a94-6833-4d7d-8d89-6ba42b43b96c@linaro.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <83283a94-6833-4d7d-8d89-6ba42b43b96c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01

On 3/7/25 16:12, Daniel Lezcano wrote:
> On 05/03/2025 10:49, Fabrice Gasnier wrote:
>> On stm32mp25, DIER (former IER) must only be modified when the lptimer
>> is enabled. On earlier SoCs, it must be only be modified when it is
>> disabled. Read the LPTIM_VERR register to properly manage the enable
>> state, before accessing IER.
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>> Changes in V2:
>> - rely on fallback compatible as no specific .data is associated to the
>>    driver. Use version data from MFD core.
>> - Added interrupt enable register access update in (missed in V1)
>> ---
>>   drivers/clocksource/timer-stm32-lp.c | 26 ++++++++++++++++++++++----
>>   1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-stm32-lp.c
>> b/drivers/clocksource/timer-stm32-lp.c
>> index a4c95161cb22..96d975adf7a4 100644
>> --- a/drivers/clocksource/timer-stm32-lp.c
>> +++ b/drivers/clocksource/timer-stm32-lp.c
>> @@ -25,6 +25,7 @@ struct stm32_lp_private {
>>       struct clock_event_device clkevt;
>>       unsigned long period;
>>       struct device *dev;
>> +    bool ier_wr_enabled;    /* Enables LPTIMER before writing into
>> IER register */
>>   };
>>     static struct stm32_lp_private*
>> @@ -37,8 +38,15 @@ static int stm32_clkevent_lp_shutdown(struct
>> clock_event_device *clkevt)
>>   {
>>       struct stm32_lp_private *priv = to_priv(clkevt);
>>   -    regmap_write(priv->reg, STM32_LPTIM_CR, 0);
>> +    /* Disable LPTIMER either before or after writing IER register
>> (else, keep it enabled) */
>> +    if (!priv->ier_wr_enabled)
>> +        regmap_write(priv->reg, STM32_LPTIM_CR, 0);
>> +
>>       regmap_write(priv->reg, STM32_LPTIM_IER, 0);
>> +
> 
> Why not encapsulate the function ?
> 
>     regmap_write_ier(struct stm32_lp_private *priv, int value)
>     {
> 
>         /* A comment ... */
>         if (!priv->ier_wr_enabled)
>             regmap_write(priv->reg, STM32_LPTIM_CR, 0);
> 
>         regmap_write(priv->reg, STM32_LPTIM_IER, value);
> 
>         if (!priv->ier_wr_enabled)
>             regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
>     }

Hi Daniel,

Thanks for your suggestion.

I've tried various factorization but can't really find something pretty
and easy to read.

I think I'll rather implement some dedicated ops in V4, for stm32mp25,
based on compatible data.
This would allow straight forward sequence, without dangling with enable
bit / flags. I also need to add some checks on new status flags. So this
will avoid to add complexity on existing routines.

Best Regards,
Fabrice

> 
> 
>> +    if (priv->ier_wr_enabled)
>> +        regmap_write(priv->reg, STM32_LPTIM_CR, 0);
>> +
> 
>>       /* clear pending flags */
>>       regmap_write(priv->reg, STM32_LPTIM_ICR, STM32_LPTIM_ARRMCF);
>>   @@ -51,12 +59,21 @@ static int stm32_clkevent_lp_set_timer(unsigned
>> long evt,
>>   {
>>       struct stm32_lp_private *priv = to_priv(clkevt);
>>   -    /* disable LPTIMER to be able to write into IER register*/
>> -    regmap_write(priv->reg, STM32_LPTIM_CR, 0);
>> +    if (!priv->ier_wr_enabled) {
>> +        /* Disable LPTIMER to be able to write into IER register */
>> +        regmap_write(priv->reg, STM32_LPTIM_CR, 0);
>> +    } else {
>> +        /* Enable LPTIMER to be able to write into IER register */
>> +        regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
>> +    }
>> +
>>       /* enable ARR interrupt */
>>       regmap_write(priv->reg, STM32_LPTIM_IER, STM32_LPTIM_ARRMIE);
>> +
>>       /* enable LPTIMER to be able to write into ARR register */
>> -    regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
>> +    if (!priv->ier_wr_enabled)
>> +        regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
>> +
>>       /* set next event counter */
>>       regmap_write(priv->reg, STM32_LPTIM_ARR, evt);
>>   @@ -151,6 +168,7 @@ static int stm32_clkevent_lp_probe(struct
>> platform_device *pdev)
>>           return -ENOMEM;
>>         priv->reg = ddata->regmap;
>> +    priv->ier_wr_enabled = ddata->version == STM32_LPTIM_VERR_23;
>>       ret = clk_prepare_enable(ddata->clk);
>>       if (ret)
>>           return -EINVAL;
> 
> 

