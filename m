Return-Path: <linux-pwm+bounces-5007-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7B8A46CAC
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 21:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 312637A324C
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 20:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3832238142;
	Wed, 26 Feb 2025 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6jTbVLko"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB42248B4;
	Wed, 26 Feb 2025 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602697; cv=none; b=F/K33yNc2/Yrryghf+TamcDAZt4pJcXiiAOJq34ANXRZOAqdFLjd4OA2EajMEcmCrzRpgizYy9vkmUHtYMmG5vFJeU8TVd/IEoHwtJRo9vamKtlP9D5wj1HtDQ0bHiyct96NMoxOV2XlGucz1jejXSshA+5YkpZHf1Oe1Lco828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602697; c=relaxed/simple;
	bh=4Bd/ysuMv3oiTg+/PUT+0ertYPOrzIu4H0CiC2mZ1MI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=CaTh+HkBF1xr64UKZEkwPJJqcVqpmAeY9SViJQOra6+cxJMflQR2Kd+bMgazLYZMbeBHvXXbV3BhfvWxfAdqjWn1zvG+S/90cAi4PrrUmn7KFKNhOHV9Fof8dV8eWiu7xZXcNBV67wNCwgpJj+n602NAztlO21jmulbXiiWCAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6jTbVLko; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QG2v7O015427;
	Wed, 26 Feb 2025 21:43:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	soQ5BkZDufwYMdgMJdG7Zd6+UrF3nw3Qs6ixs6vY/CM=; b=6jTbVLkocKgNzD6j
	Y/2AYcivvlHsnAgchC1i19FlTLWjy2/Dl/Dyx+v5WaESHovbd3tpxosNSRjjv6FC
	zbcDphxZ+h0rc5bJoAAXPFgjoA9PpK7823zFRc/4/jKZ9nknFWX8rEYmmdHexX/7
	bmUN9BmFoVtFIpAAPMKmY0q+CVneVa7zsksQfphYbUf/KppXC0YQ2hx/My1Buby6
	HPsOOmfkMvhpAPGEBhyju4qcL1aPWoROj07o6guNinEP2MPtp8dB+8MbWuZTMXWQ
	KDVrdwQ4+xgiyWoNCccx7fxkUXKKMe7HeCev2w/MBb2eNy3JeGzOHxBJuuO+COPN
	sppSaw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 451psuekdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 21:43:39 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 04D6E4008B;
	Wed, 26 Feb 2025 21:42:20 +0100 (CET)
Received: by euls16034.sgp.st.com (STMicroelectronics, from userid 89)
	id 744C145206A; Wed, 26 Feb 2025 19:14:03 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E4EC05332BB;
	Wed, 26 Feb 2025 19:14:03 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 19:14:03 +0100
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 19:14:02 +0100
Message-ID: <157348a3-9b22-4196-b4b1-ee8fcc46a84d@foss.st.com>
Date: Wed, 26 Feb 2025 19:14:02 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] clocksource: stm32-lptimer: add stm32mp25 support
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
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
 <20250224180150.3689638-5-fabrice.gasnier@foss.st.com>
 <20250225-purring-herring-of-reputation-1aed2f@krzk-bin>
 <2df7bdd9-5072-4a9a-b142-1e1e3f20130c@foss.st.com>
Content-Language: en-US
In-Reply-To: <2df7bdd9-5072-4a9a-b142-1e1e3f20130c@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_06,2025-02-26_01,2024-11-22_01

On 2/25/25 15:57, Fabrice Gasnier wrote:
> On 2/25/25 13:02, Krzysztof Kozlowski wrote:
>> On Mon, Feb 24, 2025 at 07:01:46PM +0100, Fabrice Gasnier wrote:
>>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>
>>> Add the support of the new compatible for STM32MP25 SoC in driver, as
>>> described in Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
>>> and used in arch/arm64/boot/dts/st/stm32mp251.dtsi.
>>>
>>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>> ---
>>>  drivers/clocksource/timer-stm32-lp.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
>>> index a4c95161cb22..db055348e2cc 100644
>>> --- a/drivers/clocksource/timer-stm32-lp.c
>>> +++ b/drivers/clocksource/timer-stm32-lp.c
>>> @@ -197,6 +197,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
>>>  
>>>  static const struct of_device_id stm32_clkevent_lp_of_match[] = {
>>>  	{ .compatible = "st,stm32-lptimer-timer", },
>>> +	{ .compatible = "st,stm32mp25-lptimer-timer", },
>>>  	{},
>>
>> Same question.
> 
> Oops, I just figured out I have missed a change to this driver, to
> enable interrupts, in order to comply with the LPTimer spec, starting
> with STM32MP25.
> 
> E.g. with earlier STM32MP13, STM32MP15 or even STM32H7:
> * The LPTIM_IER register must only be modified when the LPTIM is
> disabled (ENABLE bit reset to ‘0’)
> 
> On STM32MP25:
> * The LPTIMx_DIER register must only be modified when the LPTIM is
> enabled (ENABLE bit set to 1)
> 
> I'll add this as compatible data in next revision.

This is specific behavior, to the new revision of the LPTimer hardware.
It can be read from revision/identification registers. So this new
compatible can be dropped.

I'll remove "st,stm32mp25-lptimer-timer" compatible string in next revision.

Thanks for reviewing,
BR,
Fabrice

> 
> Best regards,
> Fabrice
> 
>>
>> Best regards,
>> Krzysztof
>>

