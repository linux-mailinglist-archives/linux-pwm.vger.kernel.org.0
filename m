Return-Path: <linux-pwm+bounces-5388-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14299A80EFE
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 16:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C79A424A3E
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 14:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A2022333A;
	Tue,  8 Apr 2025 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oO1x1MwF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD72221DB0;
	Tue,  8 Apr 2025 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123899; cv=none; b=qEuxBHwPUWlK3FZJsObiAgAThCbLS6e3oeOZTnJihpC1uIsdOAwqJY/aaShvHazvMYD1197G1kDVIWPUlrtS8b/ZDFOyhVMoN/1sHUAk3+SXvmMwF+oniPIyA416VVVNEugXF7cIenW4stkMhreFb25aAI8iB9HdYYZUb+DV3t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123899; c=relaxed/simple;
	bh=qHKVhMeNu+6uyMJqrkcJu9sxTEx1ISyc3gVts+BKlVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CQPJARpVaUes1d8N8lSk+3NhAfFCB8ELhGl3wozFaj4t9S4uYLuoyszZbBvT6+Ye//FMeZi3glVmoEWSHSbGAWBE9JqcsDASdJ+f3SOQfAyuXkRCwgq6XPK8FEJn2KY+oxapgkV76VqXtf6jh+a3/QM+HmpcGslC8NBwezX2K2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oO1x1MwF; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538AxRGf008721;
	Tue, 8 Apr 2025 16:51:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	3RQmySbuo/UCyRNQmzbHNRcOJc6ylALW0myadTLuAJI=; b=oO1x1MwF4IqH7lel
	i7TxuO7cgSSQ2R1sZZWjEkr09m7XArQeSZ3GF5TRsACoc0jhtT9lnauTQRF0qSrR
	zxvQ8MUe+KMXhpetm4bw+9cJ4hjautcsdL6MWFc8L1M5etZUhZW9hOgV40hA9/xC
	7HewaMMiBZpYYE5CQ9BTbg+O5+/CnTc0UJLfg9nBeoZ/0PwUoXzFAWktktQPQsk1
	5nA/ovi6Rkd9Ualzuk0+s7EzZqeSxJt+J3QOaXxd+9iCs6YnsX+6VBFklsP5R/9F
	nXUtFZ9J4lHj1mQq3BUxFgmHk28f7sOIH2nnaY1ib7CywwEy91aCU3POrtXM0DSy
	3fm8cw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45tw2gwmpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 16:51:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A351040045;
	Tue,  8 Apr 2025 16:50:02 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 196509245C5;
	Tue,  8 Apr 2025 16:48:52 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 16:48:51 +0200
Received: from [10.252.0.136] (10.252.0.136) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 16:48:50 +0200
Message-ID: <d66bd978-820a-4700-92c2-ba52d7db4efb@foss.st.com>
Date: Tue, 8 Apr 2025 16:48:50 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] clocksource: stm32-lptimer: add support for
 stm32mp25
To: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <conor+dt@kernel.org>,
        <ukleinek@kernel.org>, <robh@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <devicetree@vger.kernel.org>, <wbg@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
References: <20250314171451.3497789-1-fabrice.gasnier@foss.st.com>
 <20250314171451.3497789-5-fabrice.gasnier@foss.st.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250314171451.3497789-5-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01

On 3/14/25 18:14, Fabrice Gasnier wrote:
> On stm32mp25, DIER (former IER) must only be modified when the lptimer
> is enabled. On earlier SoCs, it must be only be modified when it is
> disabled. There's also a new DIEROK flag, to ensure register access
> has completed.
> Add a new "set_evt" routine to be used on stm32mp25, called depending
> on the version register, read by the MFD core (LPTIM_VERR).
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in V4:
> - Daniel suggests to encapsulate IER write into a separate function
>   that manages the enabling/disabling of the LP timer. In addition,
>   DIEROK and ARROK flags checks have been added. So adopt a new routine
>   to set the event into ARR register and enable the interrupt.

Hi all, Daniel,

Does anybody else have additional remarks on this driver ?

I think Lee is waiting for review, before merging the MFD part (at least).

Best Regards,
Thanks,
Fabrice

> Changes in V2:
> - rely on fallback compatible as no specific .data is associated to the
>   driver. Use version data from MFD core.
> - Added interrupt enable register access update in (missed in V1)
> ---
>  drivers/clocksource/timer-stm32-lp.c | 51 +++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
> index 928da2f6de69..e58932300fb4 100644
> --- a/drivers/clocksource/timer-stm32-lp.c
> +++ b/drivers/clocksource/timer-stm32-lp.c
> @@ -27,6 +27,7 @@ struct stm32_lp_private {
>  	u32 psc;
>  	struct device *dev;
>  	struct clk *clk;
> +	u32 version;
>  };
>  
>  static struct stm32_lp_private*
> @@ -47,12 +48,37 @@ static int stm32_clkevent_lp_shutdown(struct clock_event_device *clkevt)
>  	return 0;
>  }
>  
> -static int stm32_clkevent_lp_set_timer(unsigned long evt,
> -				       struct clock_event_device *clkevt,
> -				       int is_periodic)
> +static int stm32mp25_clkevent_lp_set_evt(struct stm32_lp_private *priv, unsigned long evt)
>  {
> -	struct stm32_lp_private *priv = to_priv(clkevt);
> +	int ret;
> +	u32 val;
> +
> +	/* Enable LPTIMER to be able to write into IER and ARR registers */
> +	regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
> +	/* set next event counter */
> +	regmap_write(priv->reg, STM32_LPTIM_ARR, evt);
> +	/* enable ARR interrupt */
> +	regmap_write(priv->reg, STM32_LPTIM_IER, STM32_LPTIM_ARRMIE);
> +
> +	/* Poll DIEROK and ARROK to ensure register access has completed */
> +	ret = regmap_read_poll_timeout_atomic(priv->reg, STM32_LPTIM_ISR, val,
> +					      (val & STM32_LPTIM_DIEROK_ARROK) ==
> +					      STM32_LPTIM_DIEROK_ARROK,
> +					      10, 500);
> +	if (ret) {
> +		dev_err(priv->dev, "access to LPTIM timed out\n");
> +		/* Disable LPTIMER */
> +		regmap_write(priv->reg, STM32_LPTIM_CR, 0);
> +		return ret;
> +	}
> +	/* Clear DIEROK and ARROK flags */
> +	regmap_write(priv->reg, STM32_LPTIM_ICR, STM32_LPTIM_DIEROKCF_ARROKCF);
> +
> +	return 0;
> +}
>  
> +static void stm32_clkevent_lp_set_evt(struct stm32_lp_private *priv, unsigned long evt)
> +{
>  	/* disable LPTIMER to be able to write into IER register*/
>  	regmap_write(priv->reg, STM32_LPTIM_CR, 0);
>  	/* enable ARR interrupt */
> @@ -61,6 +87,22 @@ static int stm32_clkevent_lp_set_timer(unsigned long evt,
>  	regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
>  	/* set next event counter */
>  	regmap_write(priv->reg, STM32_LPTIM_ARR, evt);
> +}
> +
> +static int stm32_clkevent_lp_set_timer(unsigned long evt,
> +				       struct clock_event_device *clkevt,
> +				       int is_periodic)
> +{
> +	struct stm32_lp_private *priv = to_priv(clkevt);
> +	int ret;
> +
> +	if (priv->version == STM32_LPTIM_VERR_23) {
> +		ret = stm32mp25_clkevent_lp_set_evt(priv, evt);
> +		if (ret)
> +			return ret;
> +	} else {
> +		stm32_clkevent_lp_set_evt(priv, evt);
> +	}
>  
>  	/* start counter */
>  	if (is_periodic)
> @@ -176,6 +218,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	priv->reg = ddata->regmap;
> +	priv->version = ddata->version;
>  	priv->clk = ddata->clk;
>  	ret = clk_prepare_enable(priv->clk);
>  	if (ret)

