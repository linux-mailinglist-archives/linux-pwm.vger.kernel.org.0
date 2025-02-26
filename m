Return-Path: <linux-pwm+bounces-5008-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83422A46CAF
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 21:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121C0188CAF4
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBD22512E2;
	Wed, 26 Feb 2025 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="HvzUZHc+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A723BCED;
	Wed, 26 Feb 2025 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602700; cv=none; b=Pei1bfWekxo4Kj15XeG8aTAbXE0NSvszImMUMAEg1D/IPfs763CWNXD9y/1BprVSY1i3fSDzAajLDftIKKN2ETi6Rj9wJju3BtPo+2/9gNT3dnjLGDCUyZiMaBSbb8Ay1A0b8THhVdPRdyH52PRcMkHVsVGmzrQw7UnZcYL6+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602700; c=relaxed/simple;
	bh=/5JXGHRq+/oMmdCbsCZ+alNq8hGcm3qjMnYrPCN8pK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cNCt9e5Tm2lQdRl8erk2P6dxA7pHhb/I/F+fO3TR9MO20w2DwBVSkFIOLnq+ZQBM6SujG7NKoqocdtAQRJMm/4ArKxP3319DksJuwiLOKe9dpI1J3gJZUGVLI4SgAzxTDmGstcGG3/X5/oil0Mc2jHQhiHfUz38+4Yux1skMi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=HvzUZHc+; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QJoKW6012382;
	Wed, 26 Feb 2025 21:44:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	2GOBEorWmIgUcdOOD80gRp7n39T+YL9MZl8LKJghq44=; b=HvzUZHc+jDn1+88j
	dTdruYUDZMwl95iRYAKyZNOEDVvPQ9LNZ2fIQBN3OpBJGp4aOLb6OEpH1iUwwl0m
	dwY+bHpFNtFE6KfXsUJGydmJZ/Kjk3hpXfFQiNS4VSthFtAshWJDsLW+nJm7jksf
	pCDe/Mf1YR9jmnxJLJF/ZRttsHDzBlbmaD2ceN2ejEJUv2dVDkiwQtjy+22RMcMM
	64hn0eTZVTcG85hu87F44bXN/N1Xxe9s20pGB8Z6JKlJe+O1JpwJp5Ya6yVV0/L1
	MIYQfow3CtLSgRelnJTyL3dq+XS9QTMSX3h3h8aRJPo8o96aooGAi4TrkOP/YjTB
	rWOaTQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 451psv6usm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 21:44:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 14F404007D;
	Wed, 26 Feb 2025 21:43:33 +0100 (CET)
Received: by euls16034.sgp.st.com (STMicroelectronics, from userid 89)
	id 6DE2F4EFC7A; Wed, 26 Feb 2025 19:16:19 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF75A4F3E66;
	Wed, 26 Feb 2025 19:16:19 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 19:16:19 +0100
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 19:16:18 +0100
Message-ID: <4876e1a4-93b7-4bd8-be03-4a2895567f2b@foss.st.com>
Date: Wed, 26 Feb 2025 19:16:17 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] counter: stm32-lptimer-cnt: add support for stm32mp25
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <wbg@kernel.org>, <jic23@kernel.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
References: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
 <20250224180150.3689638-7-fabrice.gasnier@foss.st.com>
 <20250225-pelican-of-pleasurable-might-e9a7e8@krzk-bin>
 <4ffc3fe3-78ab-43b2-b0d5-8f9cb545f9c5@foss.st.com>
 <b9b3844e-bdd5-4f50-aa10-8bf97751c566@kernel.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <b9b3844e-bdd5-4f50-aa10-8bf97751c566@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_06,2025-02-26_01,2024-11-22_01

On 2/26/25 08:49, Krzysztof Kozlowski wrote:
> On 25/02/2025 15:58, Fabrice Gasnier wrote:
>> On 2/25/25 13:02, Krzysztof Kozlowski wrote:
>>> On Mon, Feb 24, 2025 at 07:01:48PM +0100, Fabrice Gasnier wrote:
>>>> Add support for STM32MP25 SoC. Use newly introduced compatible to handle
>>>> this new HW variant, even if no major change is expected on the counter
>>>> driver.
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>>> ---
>>>>  drivers/counter/stm32-lptimer-cnt.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
>>>> index b249c8647639..a5dce017c37b 100644
>>>> --- a/drivers/counter/stm32-lptimer-cnt.c
>>>> +++ b/drivers/counter/stm32-lptimer-cnt.c
>>>> @@ -508,6 +508,7 @@ static SIMPLE_DEV_PM_OPS(stm32_lptim_cnt_pm_ops, stm32_lptim_cnt_suspend,
>>>>  
>>>>  static const struct of_device_id stm32_lptim_cnt_of_match[] = {
>>>>  	{ .compatible = "st,stm32-lptimer-counter", },
>>>> +	{ .compatible = "st,stm32mp25-lptimer-counter", },
>>>
>>> So fully compatible? Why this change then?
>>
>> Hi Krzysztof,
>>
>> I should have mentioned it in the commit message:
>>
>> Currently, same feature list as on STM32MP1x is supported.
>> New capture input stage is now available in the hardware. It's not added
>> yet to the driver.
> 
> Which is the exact meaning of compatible. Express it properly in
> bindings and driver.

Could you please just clarify here, do you suggest to better explain it
in the commit message, both in bindings and driver ?
Or do you mean something else ?

There's one more thing here, I haven't mentioned earlier, which is
specific to the STM32MP25 SoC family (not only to the LPTimer revision).

The LPTimer has interconnect signals throughout all the SoC. It's listed
in the "Peripheral interconnects" section of the Reference Manual (RM0457).
Here, simply reading the LPTimer revision/identification register
wouldn't be enough, as it specific to the SoC. Upcoming STM32MP21 SoC
family will have a different list of inputs/outpus internally in the SoC
(but same controller revision).

So here I intend to keep the specific compatible
"st,stm32mp25-lptimer-counter", to be used even if not yet implemented
by the driver.

I'll try to explain it better in next revision.

Thanks for reviewing,
Best Regards,
Fabrice

> 
>>
>> The Low Power Timer (LPTIM) hardware isn't fully backward compatible,
> 
> How so? How can it work then with above ID table?
> 
> 
> Best regards,
> Krzysztof

