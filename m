Return-Path: <linux-pwm+bounces-6342-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE8AAD8DB7
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 15:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39AE18978BC
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA5318DB24;
	Fri, 13 Jun 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="e9zj3Qmw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A322F22;
	Fri, 13 Jun 2025 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822465; cv=none; b=F87LLpWNHlpW8h2PoRptRODsv8tWMERTcQDrhl7KtNxRCHOBmkNQ1o+lnQQwBX0Q5oHCp1CHJFamj4nVXpe5op20cIV3MDmrkzAthPWzVsRJx9dH28/eIhYlHxwTnVRaB4HjfzZewOjDZ5n9CkGXzMdNnGEKigMYWTrOeActSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822465; c=relaxed/simple;
	bh=EvV/AQFNGYn1BkbnZYKoWbAWoLrbH5/uURZIOWrOb9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GLAFs6+3D6htgA8U3d47fyx1DRigzH4xwdFhBbsnUlgYcteRqX6Hp17wrJUCukLAA+EKacL/x9sPHGCi9DNpL5VpTmzgOpKUsGCYO7c7OJmbmfqbXvqswZ45W7FUq/rxoUty1tvLVzYhzRqb8N0kLJH300QYdx6wlI9oEg43mbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=e9zj3Qmw; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DB7mUP030978;
	Fri, 13 Jun 2025 15:47:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Ei9n0mlSS+RGTUs8J62IILpUrlBM4z2gov+FvU4IE2M=; b=e9zj3QmwZlRjxEsa
	fHopqr4SFaF+DVyvbsh6ITrsy/VLyJfB/NPjT41IAjlqgnu4EyQqZ3Iqg4g1JUr1
	mu2E7lrj/oolb6LwgSgR/fHxGB95CYTStre9MZP4ae93ZjiaXLZw4zC2VkY/rRCr
	kW/nDiLYqdaEhu3vruKyVxvSvp1ppHtBs41ExJxJMvJRUIcnsGRaOpwJcltTaqIc
	cRSzwr2VR3hW2I+U4+qTUKqDIneClB8VVZOZw4VWsJbkwORPLXSw7P4HXtEOpCSP
	YCZlb1U3rJaJcBOHfLuFtcxCQWoOT5pgLRq9fBh5DEHRHRfvVGs/3IPPkwHJy6WI
	mhJttA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474cs364mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 15:47:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2B8B04005A;
	Fri, 13 Jun 2025 15:46:31 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F05F2AE5D11;
	Fri, 13 Jun 2025 15:44:59 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 15:44:59 +0200
Received: from [10.252.9.77] (10.252.9.77) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 15:44:58 +0200
Message-ID: <c3208fec-53ac-46eb-907f-cc5b7a18b188@foss.st.com>
Date: Fri, 13 Jun 2025 15:44:57 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] pwm: stm32: add support for stm32mp25
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
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
 <4b641513-ff2e-43ab-8074-ba6b521875e2@foss.st.com>
 <5ui74qlssllgn4h34by5jcpi5g6rknziclcsh4w27tjvznynsv@lcjtjxn6rovl>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <5ui74qlssllgn4h34by5jcpi5g6rknziclcsh4w27tjvznynsv@lcjtjxn6rovl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-12_02,2025-03-28_01

On 5/15/25 11:24, Uwe Kleine-König wrote:
> Hello Fabrice,
> 
> On Wed, May 14, 2025 at 11:30:26AM +0200, Fabrice Gasnier wrote:
>> On 1/10/25 10:19, Fabrice Gasnier wrote:
>>> Add support for STM32MP25 SoC. Use newly introduced compatible to handle
>>> new features along with registers and bits diversity.
>>> The MFD part of the driver fills in ipidr, so it is used to check the
>>> hardware configuration register, when available to gather the number
>>> of PWM channels and complementary outputs.
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>> ---
>>> Changes in v2:
>>> Address Uwe review comments:
>>> - Make MAX_PWM_OUTPUT definition less generic: STM32_PWM_MAX_OUTPUT
>>> - No need to initialize 'npwm'
>>> - refactor code, for *num_enabled to use same code path
>>> ---
>>>  drivers/pwm/pwm-stm32.c | 42 ++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 35 insertions(+), 7 deletions(-)
>>
>> Hi Uwe,
>>
>> I think this patch still miss some reviews.
>> The first patches of this series have been merged.
>>
>> Is it ok for you to merge, or shall I resend separately ?
> 
> I have it still on my radar, no need to resend. I just have to find the
> time to look into it in more detail.

Hello Uwe,

Gentle reminder, I hope you may find some time to review this patch ?

Best Regards,
Fabrice

> 
> Best regards
> Uwe

