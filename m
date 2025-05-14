Return-Path: <linux-pwm+bounces-5983-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C0AB6796
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 11:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B147AF4C4
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF8522A1E4;
	Wed, 14 May 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="yov7gtOg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C321518F;
	Wed, 14 May 2025 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215177; cv=none; b=NN1Xt83ltGnGwTo6wAKMCVWcIdKsFFzweqOHwYn737a8lUOdGPMulfuLCn5DLUoP2DDHNW5tV3/5+t1pY9ppwJ+42P9LqfTqZOVk0WbilhZsO0BJTdMo+JcEOBKUAbSXp/M5PCUQuTDQQtNHhor8iKm2SyYfo8gBMt85B2RF49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215177; c=relaxed/simple;
	bh=yoH0wqf8NQizEGdbPCU1LSKztQZYM6ZBokkY0cFNRVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hMAM5gxWJVkQliCR/EgJFQV9jPqbxLDf4YDk3Rh+OJ2sgs88qVYwVZZYLIoZZUwnvHmSI1DxHmpi46r0JjnZMtgUN4tLPj1n6xFzkVM6jafDCwEPOpxFwgTh0465Z4hSu+2ISoRkK9RMCULJrCbkQFp3F8MjgM3UMDAmOl5W20E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=yov7gtOg; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E7vvBU024075;
	Wed, 14 May 2025 11:32:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	TNCvFcvWwltndRrRe0jUv88V8Pga/agvOTssJvAUPj0=; b=yov7gtOgC6HysJ3s
	NeUP3A11E0TVcJ1EkNxohtbr9VRJYKNWEhGF/kI+Z46TQ+hqDJkk05OybEZzrvOK
	WMEcNzjJu/07dZmnQGhjPkX5egGPMCWkgWc3rPk8WA8CehMptQw3nDUoCiI4vB/7
	/JaJ2mZCXm0Ne4GvkLHvCBfVJAjivs5aonSaOO0G5uTwKH7NbeV5FbbrCKRu+P57
	AOsMMiAKEHjtR1GVcNesoJSzj2dvifAM7nWNcfgO2IChTrmzpV0BmLCfof0/kj77
	lkGesp4pPC6bWevkZZcIcXNY7+gaKo0iZtfStAwoF/nf17phWUzViLffTC9XA970
	lhW0Cw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46mbdx2u2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:32:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A909F40055;
	Wed, 14 May 2025 11:31:44 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9006DB4E912;
	Wed, 14 May 2025 11:30:28 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 11:30:28 +0200
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 11:30:27 +0200
Message-ID: <4b641513-ff2e-43ab-8074-ba6b521875e2@foss.st.com>
Date: Wed, 14 May 2025 11:30:26 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] pwm: stm32: add support for stm32mp25
To: <ukleinek@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <wbg@kernel.org>, <jic23@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <lee@kernel.org>,
        <alexandre.torgue@foss.st.com>
References: <20250110091922.980627-1-fabrice.gasnier@foss.st.com>
 <20250110091922.980627-5-fabrice.gasnier@foss.st.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250110091922.980627-5-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01

On 1/10/25 10:19, Fabrice Gasnier wrote:
> Add support for STM32MP25 SoC. Use newly introduced compatible to handle
> new features along with registers and bits diversity.
> The MFD part of the driver fills in ipidr, so it is used to check the
> hardware configuration register, when available to gather the number
> of PWM channels and complementary outputs.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v2:
> Address Uwe review comments:
> - Make MAX_PWM_OUTPUT definition less generic: STM32_PWM_MAX_OUTPUT
> - No need to initialize 'npwm'
> - refactor code, for *num_enabled to use same code path
> ---
>  drivers/pwm/pwm-stm32.c | 42 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)

Hi Uwe,

I think this patch still miss some reviews.
The first patches of this series have been merged.

Is it ok for you to merge, or shall I resend separately ?

Please advise,
BR,
Fabrice

> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 17e591f61efb..b9aadc473280 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -19,6 +19,7 @@
>  #define CCMR_CHANNEL_SHIFT 8
>  #define CCMR_CHANNEL_MASK  0xFF
>  #define MAX_BREAKINPUT 2
> +#define STM32_MAX_PWM_OUTPUT 4
>  
>  struct stm32_breakinput {
>  	u32 index;
> @@ -775,10 +776,19 @@ static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
>  	return stm32_pwm_apply_breakinputs(priv);
>  }
>  
> -static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
> +static void stm32_pwm_detect_complementary(struct stm32_pwm *priv, struct stm32_timers *ddata)
>  {
>  	u32 ccer;
>  
> +	if (ddata->ipidr) {
> +		u32 val;
> +
> +		/* Simply read from HWCFGR the number of complementary outputs (MP25). */
> +		regmap_read(priv->regmap, TIM_HWCFGR1, &val);
> +		priv->have_complementary_output = !!FIELD_GET(TIM_HWCFGR1_NB_OF_DT, val);
> +		return;
> +	}
> +
>  	/*
>  	 * If complementary bit doesn't exist writing 1 will have no
>  	 * effect so we can detect it.
> @@ -790,22 +800,39 @@ static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
>  	priv->have_complementary_output = (ccer != 0);
>  }
>  
> -static unsigned int stm32_pwm_detect_channels(struct regmap *regmap,
> +static unsigned int stm32_pwm_detect_channels(struct stm32_timers *ddata,
>  					      unsigned int *num_enabled)
>  {
> +	struct regmap *regmap = ddata->regmap;
>  	u32 ccer, ccer_backup;
>  
> +	regmap_read(regmap, TIM_CCER, &ccer_backup);
> +	*num_enabled = hweight32(ccer_backup & TIM_CCER_CCXE);
> +
> +	if (ddata->ipidr) {
> +		u32 hwcfgr;
> +		unsigned int npwm;
> +
> +		/* Deduce from HWCFGR the number of outputs (MP25). */
> +		regmap_read(regmap, TIM_HWCFGR1, &hwcfgr);
> +
> +		/*
> +		 * Timers may have more capture/compare channels than the
> +		 * actual number of PWM channel outputs (e.g. TIM_CH[1..4]).
> +		 */
> +		npwm = FIELD_GET(TIM_HWCFGR1_NB_OF_CC, hwcfgr);
> +
> +		return npwm < STM32_MAX_PWM_OUTPUT ? npwm : STM32_MAX_PWM_OUTPUT;
> +	}
> +
>  	/*
>  	 * If channels enable bits don't exist writing 1 will have no
>  	 * effect so we can detect and count them.
>  	 */
> -	regmap_read(regmap, TIM_CCER, &ccer_backup);
>  	regmap_set_bits(regmap, TIM_CCER, TIM_CCER_CCXE);
>  	regmap_read(regmap, TIM_CCER, &ccer);
>  	regmap_write(regmap, TIM_CCER, ccer_backup);
>  
> -	*num_enabled = hweight32(ccer_backup & TIM_CCER_CCXE);
> -
>  	return hweight32(ccer & TIM_CCER_CCXE);
>  }
>  
> @@ -820,7 +847,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
>  	unsigned int i;
>  	int ret;
>  
> -	npwm = stm32_pwm_detect_channels(ddata->regmap, &num_enabled);
> +	npwm = stm32_pwm_detect_channels(ddata, &num_enabled);
>  
>  	chip = devm_pwmchip_alloc(dev, npwm, sizeof(*priv));
>  	if (IS_ERR(chip))
> @@ -841,7 +868,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to configure breakinputs\n");
>  
> -	stm32_pwm_detect_complementary(priv);
> +	stm32_pwm_detect_complementary(priv, ddata);
>  
>  	ret = devm_clk_rate_exclusive_get(dev, priv->clk);
>  	if (ret)
> @@ -911,6 +938,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_r
>  
>  static const struct of_device_id stm32_pwm_of_match[] = {
>  	{ .compatible = "st,stm32-pwm",	},
> +	{ .compatible = "st,stm32mp25-pwm", },
>  	{ /* end node */ },
>  };
>  MODULE_DEVICE_TABLE(of, stm32_pwm_of_match);

