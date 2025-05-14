Return-Path: <linux-pwm+bounces-5982-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F90AB6790
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 11:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09DB1895617
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BA62253FB;
	Wed, 14 May 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="REUcSlsD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DA41FF60E;
	Wed, 14 May 2025 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215177; cv=none; b=B/AzAwtyvEzo2WlFwhS1fTTzbSA2FPbV4sZ3la2LkWXPIlOMO/iGAxBsnzEfS8Y9v/YWugkzWbTkwoQuivhjGJZfzGjBuWyO9DDTiLL1HcBSGeVZTzzylJTksj4n2xLUHEVodFdqaInccD7geGZ9cw9NtzFvKvOpHC1ch7Lnz/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215177; c=relaxed/simple;
	bh=wgcDSzjE3z4wvyTjp53d7JEM1bigTEH6sNQEmXZAFnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PTrbzeO50wlqRmTXimeqTBpo+lQ5B9ayho5l9+2f8AU5qhLfhLkgNGN5/Tvvveoe6TeFJiVHXHnIOlz3oza0CVrOWJjcYOI3SCLRYY7dvFEnqYAwPYHgtaNDpePfR/OMD1o5XH/ea0IBqoONnwRqs8AjvP5/8gIUPC7jX3ble4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=REUcSlsD; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E7vt3p023085;
	Wed, 14 May 2025 11:32:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	apPuGix0U1l8NbuF2RfEV7srsEyy+YpkXLnEoKgNuME=; b=REUcSlsDCyI8Hyf1
	Dx5Y5boK9tw1Of6eJxcNtODLpy/xFNDPh/YLxIBUnW7KGAKOruHD7IUgQSjI4S7i
	CBVc0zCDej1aWz31I9mo/NeQ3/eVjsNJnJ1iIdKHCnSfvbxIOxrPrvIzfrYt/P2e
	nrrwse+lwg2bwLxhLn4qU7Z0sWttRjd/lJ671EWcDAWey286hEKr27RTU384YVMo
	UIt+RNh+MkahVlKYt0jc4HsIZo+pHIJ/JalIXzCu1wfGqvKSgPFFsaGTFY6qpuyU
	Fd3/Ro2LO3nrED4ScbRf0eonPqPp5JZH4xxm0YkeMbEH5nS9yulK0pv3kI7MDrJs
	WrLA3w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46mbdxtwvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:32:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A901540054;
	Wed, 14 May 2025 11:31:44 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EC64DB4C73F;
	Wed, 14 May 2025 11:30:15 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 11:30:15 +0200
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 11:30:14 +0200
Message-ID: <5268ec60-ae2e-425e-a4af-a55cb0c3a1f9@foss.st.com>
Date: Wed, 14 May 2025 11:30:14 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] counter: stm32-timer-cnt: add support for
 stm32mp25
To: <jic23@kernel.org>, <wbg@kernel.org>
CC: <alexandre.torgue@foss.st.com>, <lee@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <ukleinek@kernel.org>
References: <20250110091922.980627-1-fabrice.gasnier@foss.st.com>
 <20250110091922.980627-4-fabrice.gasnier@foss.st.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250110091922.980627-4-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01

On 1/10/25 10:19, Fabrice Gasnier wrote:
> Add support for STM32MP25 SoC. There are new counter modes that may be
> implemented in later. Still, use newly introduced compatible to handle
> this new HW variant and avoid being blocked with existing compatible
> in SoC dtsi file. Modes supported currently still remains compatible.
> New timer 20 has encoder capability, add it to the list.
> 
> Acked-by: William Breathitt Gray <wbg@kernel.org>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  drivers/counter/stm32-timer-cnt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Hi,

The first patches of this series have been merged.

I'm not sure who shall pick this one ? (I think there's no dependency).
Or do I need to resend it separately ?

Please advise,
BR,
Fabrice

> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index e75b69476a00..3d3384cbea87 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -669,12 +669,14 @@ static void stm32_timer_cnt_detect_channels(struct device *dev,
>  	dev_dbg(dev, "has %d cc channels\n", priv->nchannels);
>  }
>  
> -/* encoder supported on TIM1 TIM2 TIM3 TIM4 TIM5 TIM8 */
> -#define STM32_TIM_ENCODER_SUPPORTED	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(7))
> +/* encoder supported on TIM1 TIM2 TIM3 TIM4 TIM5 TIM8 TIM20 */
> +#define STM32_TIM_ENCODER_SUPPORTED	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(7) | \
> +					 BIT(19))
>  
>  static const char * const stm32_timer_trigger_compat[] = {
>  	"st,stm32-timer-trigger",
>  	"st,stm32h7-timer-trigger",
> +	"st,stm32mp25-timer-trigger",
>  };
>  
>  static int stm32_timer_cnt_probe_encoder(struct device *dev,
> @@ -846,6 +848,7 @@ static SIMPLE_DEV_PM_OPS(stm32_timer_cnt_pm_ops, stm32_timer_cnt_suspend,
>  
>  static const struct of_device_id stm32_timer_cnt_of_match[] = {
>  	{ .compatible = "st,stm32-timer-counter", },
> +	{ .compatible = "st,stm32mp25-timer-counter", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, stm32_timer_cnt_of_match);

