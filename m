Return-Path: <linux-pwm+bounces-4565-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6F5A07D8E
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 17:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE97188C40B
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F59220688;
	Thu,  9 Jan 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="G1UBMas6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBC5153800;
	Thu,  9 Jan 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440300; cv=none; b=VUM2gqrvNNEbYfXXJsi2CKGE5r7gD3JOtG30YBJxKqmO7MpZnSNmF63ASx6fw3TvD6VhY6dTuXC4zJ8hwf1XjvlUQRSFF280mLdpWqmfveh9ZWiat9FUGvpgxSl3ujlmzUD6kkmXOhi/x8vFRDrcesnCn/AKXO/qDr4NjbAATHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440300; c=relaxed/simple;
	bh=6yNc/VvEqqd9EKFpxm3xmS2DW26GXhLersCSXGYIJPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hPHWistwk/eH7mCZmkFhaXAhnF0vw4aWVYE1e07EaWwxXKnuxV2EwF1oLIIssu1jnDWGIcd3qP4e87WhcsFZZb8LBob5doSUUrgPiI95Tkw1BeInlhkVeGhOwULeBmJr+Wr/YgdhU7sGSGyBPMvQASwYr/NnU+4mH1DngEqJ5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=G1UBMas6; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509ERp9A001039;
	Thu, 9 Jan 2025 17:31:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	tOCIMbi4zzKnCjTJpT+vOfF34I4MpmzXJcdcVQ+i7co=; b=G1UBMas6V61HEaGk
	JVOy7evlrOf6GWE5Dq8Ui6lMA+VTOcngVpsNPFctJQbfbfqINfr4tQwd3/ahfIOL
	hL+7NxMoYH9JjknuGvVka8hjb1StFrGf5f5THQ9pIBMteUMk8q1KvWIljYQmdPu9
	Z6a9ng+3yX3DDW3AbM0J3J+lZfrWYVjkVhidHkdfHNJrB8Sqqpl0UNcBkUPKy8qG
	2EUYq1KR0/kJxT8WqWs2EjSicv1+ZeyU355xsNP2hevm4Bwbca4Y+UKnVlA8Fgko
	CMrsiRumyHCGUpuQTUmGmVlKlfX2+9g7qB7jq0SwI/8xH2bafTM1bH6MnfpkKtZ5
	9MUN5w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4424hpbusr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 17:31:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5FFC340047;
	Thu,  9 Jan 2025 17:30:12 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 55061248764;
	Thu,  9 Jan 2025 17:29:10 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 9 Jan
 2025 17:29:10 +0100
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 9 Jan
 2025 17:29:09 +0100
Message-ID: <47dd8588-5c51-44f4-8f9f-e984ae24d57b@foss.st.com>
Date: Thu, 9 Jan 2025 17:29:08 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] mfd: stm32-timers: add support for stm32mp25
To: Lee Jones <lee@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <alexandre.torgue@foss.st.com>, <wbg@kernel.org>, <jic23@kernel.org>,
        <ukleinek@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
References: <20241218090153.742869-1-fabrice.gasnier@foss.st.com>
 <20241218090153.742869-3-fabrice.gasnier@foss.st.com>
 <20250109104956.GD6763@google.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250109104956.GD6763@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 1/9/25 11:49, Lee Jones wrote:
> On Wed, 18 Dec 2024, Fabrice Gasnier wrote:
> 
>> Add support for STM32MP25 SoC. Use newly introduced compatible, to handle
>> new features.
>> Identification and hardware configuration registers allow to read the
>> timer version and capabilities (counter width, number of channels...).
>> So, rework the probe to avoid touching ARR register by simply read the
>> counter width when available. This may avoid messing with a possibly
>> running timer.
>> Also add useful bit fields to stm32-timers header file.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>>  drivers/mfd/stm32-timers.c       | 32 +++++++++++++++++++++++++++++++-
>>  include/linux/mfd/stm32-timers.h |  9 +++++++++
>>  2 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
>> index 650724e19b88..6f217c32482c 100644
>> --- a/drivers/mfd/stm32-timers.c
>> +++ b/drivers/mfd/stm32-timers.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/module.h>
>>  #include <linux/of_platform.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/property.h>
>>  #include <linux/reset.h>
>>  
>>  #define STM32_TIMERS_MAX_REGISTERS	0x3fc
>> @@ -173,6 +174,32 @@ static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
>>  	regmap_write(ddata->regmap, TIM_ARR, arr);
>>  }
>>  
>> +static int stm32_timers_probe_hwcfgr(struct device *dev, struct stm32_timers *ddata)
>> +{
>> +	u32 val;
>> +
>> +	ddata->ipidr = (uintptr_t)device_get_match_data(dev);
> 
> Are you sure this cast is needed?

Hi Lee,

Yes, I can see a warning pops-up without it:

drivers/mfd/stm32-timers.c:181:22: warning: assignment to ‘u32’ {aka
‘unsigned int’} from ‘const void *’ makes integer from pointer without a
cast [-Wint-conversion]
  181 |         ddata->ipidr = device_get_match_data(dev);
      |                      ^


> 
>> +	if (!ddata->ipidr) {
>> +		/* fallback to legacy method for probing counter width */
> 
> Sentences start with uppercase chars.

Ack

> 
>> +		stm32_timers_get_arr_size(ddata);
>> +		return 0;
>> +	}
>> +
>> +	regmap_read(ddata->regmap, TIM_IPIDR, &val);
>> +	/* Sanity check on IP identification register */
> 
> This seems obvious, thus superfluous.

Ack

> 
>> +	if (val != ddata->ipidr) {
>> +		dev_err(dev, "Unexpected identification: %u\n", val);
> 
> "Unexpected model number"?
> "Unsupported device detected"?

Ack

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	regmap_read(ddata->regmap, TIM_HWCFGR2, &val);
> 
> '/n' here.

Ack

> 
>> +	/* Counter width in bits, max reload value is BIT(width) - 1 */
>> +	ddata->max_arr = BIT(FIELD_GET(TIM_HWCFGR2_CNT_WIDTH, val)) - 1;
>> +	dev_dbg(dev, "TIM width: %ld\n", FIELD_GET(TIM_HWCFGR2_CNT_WIDTH, val));
> 
> How useful is this now the driver has been developed?

Well... that's just debug. I'll remove it and send a V3.

Thanks for reviewing,
BR,
Fabrice

> 
>> +	return 0;
>> +}
>> +
>>  static int stm32_timers_dma_probe(struct device *dev,
>>  				   struct stm32_timers *ddata)
>>  {
>> @@ -285,7 +312,9 @@ static int stm32_timers_probe(struct platform_device *pdev)
>>  	if (IS_ERR(ddata->clk))
>>  		return PTR_ERR(ddata->clk);
>>  
>> -	stm32_timers_get_arr_size(ddata);
>> +	ret = stm32_timers_probe_hwcfgr(dev, ddata);
>> +	if (ret)
>> +		return ret;
>>  
>>  	ret = stm32_timers_irq_probe(pdev, ddata);
>>  	if (ret)
>> @@ -320,6 +349,7 @@ static void stm32_timers_remove(struct platform_device *pdev)
>>  
>>  static const struct of_device_id stm32_timers_of_match[] = {
>>  	{ .compatible = "st,stm32-timers", },
>> +	{ .compatible = "st,stm32mp25-timers", .data = (void *)STM32MP25_TIM_IPIDR },
>>  	{ /* end node */ },
>>  };
>>  MODULE_DEVICE_TABLE(of, stm32_timers_of_match);
>> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
>> index f09ba598c97a..23b0cae4a9f8 100644
>> --- a/include/linux/mfd/stm32-timers.h
>> +++ b/include/linux/mfd/stm32-timers.h
>> @@ -33,6 +33,9 @@
>>  #define TIM_DCR		0x48			/* DMA control register			*/
>>  #define TIM_DMAR	0x4C			/* DMA register for transfer		*/
>>  #define TIM_TISEL	0x68			/* Input Selection			*/
>> +#define TIM_HWCFGR2	0x3EC			/* hardware configuration 2 Reg (MP25)	*/
>> +#define TIM_HWCFGR1	0x3F0			/* hardware configuration 1 Reg (MP25)	*/
>> +#define TIM_IPIDR	0x3F8			/* IP identification Reg (MP25)		*/
>>  
>>  #define TIM_CR1_CEN		BIT(0)					/* Counter Enable				*/
>>  #define TIM_CR1_DIR		BIT(4)					/* Counter Direction				*/
>> @@ -100,6 +103,9 @@
>>  #define TIM_BDTR_BKF(x)		(0xf << (16 + (x) * 4))
>>  #define TIM_DCR_DBA		GENMASK(4, 0)				/* DMA base addr				*/
>>  #define TIM_DCR_DBL		GENMASK(12, 8)				/* DMA burst len				*/
>> +#define TIM_HWCFGR1_NB_OF_CC	GENMASK(3, 0)				/* Capture/compare channels			*/
>> +#define TIM_HWCFGR1_NB_OF_DT	GENMASK(7, 4)				/* Complementary outputs & dead-time generators */
>> +#define TIM_HWCFGR2_CNT_WIDTH	GENMASK(15, 8)				/* Counter width				*/
>>  
>>  #define MAX_TIM_PSC				0xFFFF
>>  #define MAX_TIM_ICPSC				0x3
>> @@ -113,6 +119,8 @@
>>  #define TIM_BDTR_BKF_MASK			0xF
>>  #define TIM_BDTR_BKF_SHIFT(x)			(16 + (x) * 4)
>>  
>> +#define STM32MP25_TIM_IPIDR	0x00120002
>> +
>>  enum stm32_timers_dmas {
>>  	STM32_TIMERS_DMA_CH1,
>>  	STM32_TIMERS_DMA_CH2,
>> @@ -151,6 +159,7 @@ struct stm32_timers_dma {
>>  
>>  struct stm32_timers {
>>  	struct clk *clk;
>> +	u32 ipidr;
>>  	struct regmap *regmap;
>>  	u32 max_arr;
>>  	struct stm32_timers_dma dma; /* Only to be used by the parent */
>> -- 
>> 2.25.1
>>
> 

