Return-Path: <linux-pwm+bounces-5715-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8E8A9C98F
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 14:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960B43AE0C2
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B338253926;
	Fri, 25 Apr 2025 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="13kMQh3I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D919AD48;
	Fri, 25 Apr 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585605; cv=none; b=pmuyMBxMsIPPGmtnmP5Suir+spMXMFrct7KRcpBO71Iz9PA15/n3I2Fqx+1p/31ouFx21LGO49VXK4/el1b0HhpFGMS5u3z/KJ3NbphKsJJ4LY/JyEMR/DzvnYpEZ6VcJov8wwTZCpp3GMX0jSA3IPlUCQlvrVvQkSBG/0DWMM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585605; c=relaxed/simple;
	bh=zKwxpE0nQgrl5ku11YFdu+sIcrI+jdK+kOVP8m8d2hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qkxVEQyZqNp/p+zwokkYwvmY4vDa4iIdYMQYgfp0SYJ0N7ntgvm1cRnFcwzIWQPuN/3OD9p3hHzfKxPkOcRbpxCIxnYLitn1ERcPUUubmJfoT1NKmLHriXxAwVJXb84sIcqY4emBiJiF3kXNe97grGQWp66jCVrTGITfU7hsMz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=13kMQh3I; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P7b9Ov005857;
	Fri, 25 Apr 2025 14:53:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	yuP2hz4+AAmK0hgkk1ltz/sdzsPjbchhks48Sx2DD3M=; b=13kMQh3IKs5Bgb1s
	JKteJKieilegE2C1DugoLk1YyWfEDKw7R1oPQ+7oMP2wHmEj6Q7Jau2a9GIkSIUe
	+R3oO0hieOgT6eC8n63Ctx/zYYuIPA//LxRDRPZHa7O6hMcaWgES3NWy8ChhcvD4
	/Ns/6t9thac6hfd/EYYdZacVr5grSLwT6cl46Z+Hg7iXPMalBpY/j0fd2o2VoC+N
	osNiD60Qs5rvzSpzlpxALTZJkMxCnXNNVKj8DlwaLCSxysHDVRXDajFcye0+Eefm
	jN0faqt2jDTLdyj5/cTywRh5b15CGARz01oYw1Agloj2Caf4L/VbkoWbwUrYjGGR
	Wk6Z8A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jk3mkec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 14:53:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5872B40055;
	Fri, 25 Apr 2025 14:51:56 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 344329F78E9;
	Fri, 25 Apr 2025 14:50:08 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 14:50:07 +0200
Received: from [10.252.15.6] (10.252.15.6) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 14:50:06 +0200
Message-ID: <c78c1c19-cf11-4146-acda-fd435add6808@foss.st.com>
Date: Fri, 25 Apr 2025 14:50:06 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] mfd: stm32-lptimer: add support for stm32mp25
To: Lee Jones <lee@kernel.org>
CC: <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jic23@kernel.org>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>, <robh@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>, <wbg@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
References: <20250314171451.3497789-1-fabrice.gasnier@foss.st.com>
 <20250314171451.3497789-3-fabrice.gasnier@foss.st.com>
 <20250404144006.GB372032@google.com> <20250424130112.GD8734@google.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250424130112.GD8734@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01

On 4/24/25 15:01, Lee Jones wrote:
> On Fri, 04 Apr 2025, Lee Jones wrote:
> 
>> On Fri, 14 Mar 2025, Fabrice Gasnier wrote:
>>
>>> Add support for STM32MP25 SoC.
>>> A new hardware configuration register (HWCFGR2) has been added, to gather
>>> number of capture/compare channels, autonomous mode and input capture
>>> capability. The full feature set is implemented in LPTIM1/2/3/4. LPTIM5
>>> supports a smaller set of features. This can now be read from HWCFGR
>>> registers.
>>>
>>> Add new registers to the stm32-lptimer.h: CCMR1, CCR2, HWCFGR1/2 and VERR.
>>> Update the stm32_lptimer data struct so signal the number of
>>> capture/compare channels to the child devices.
>>> Also Remove some unused bit masks (CMPOK_ARROK / CMPOKCF_ARROKCF).
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>> ---
>>> Changes in V4:
>>> - Add DIEROK, ARROK status flags, and their clear flags.
>>> Changes in V2:
>>> - rely on fallback compatible as no specific .data is associated to the
>>>   driver. Compatibility is added by reading hardware configuration
>>>   registers.
>>> - read version register, to be used by clockevent child driver
>>> - rename register/bits definitions
>>> ---
>>>  drivers/mfd/stm32-lptimer.c       | 33 ++++++++++++++++++++++++++-
>>>  include/linux/mfd/stm32-lptimer.h | 37 ++++++++++++++++++++++++++++---
>>
>> At least the Clocksource driver depends on this.
>>
>> I need Acks from the other Maintainers before I can merge this.
> 
> Suggest you resubmit the set as a [RESEND] to re-gain traction.
> 

Hi Lee,

Thanks for suggesting.
I recently found I needed to add a small delay in clocksource driver. So
I just have sent a V5.

Best Regards,
Fabrice

