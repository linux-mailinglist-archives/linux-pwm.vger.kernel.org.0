Return-Path: <linux-pwm+bounces-4985-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BF9A445FD
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4293B4F3D
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 16:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9290318DB15;
	Tue, 25 Feb 2025 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="t076cPPW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A485C15383D;
	Tue, 25 Feb 2025 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500578; cv=none; b=He9hhX5A890/1G4yqCAbi/QyeHgUEQ1wNt8Z1OR4K4yi3B7o0H/Tf0klA1BJph1jcxP2AUkp3sEvdy36ykdmDOKgJlgMyD8YmhI1EPnoPSYtGylT4BwEhTgsv/jprW259g8Igk415UOdGVDG8U3MPN8Ap/+uyuGttDNl8Bb28bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500578; c=relaxed/simple;
	bh=4UZQt6CS0MHkBs/i4rSdDNtr9IYHVh5vB9xkgBgwouI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GtBufvbm0yglYhDRS0QJsF+gyM0tl/3hXUEU3BW0HY4hewtmubPZ8ueV5C/zo+GmBCE/zzBDAgiofYpkd2Q0Nur2kKJtHUNvRUj1/A9R8Wsoj6yql7uVshuYt3zdTBNs3kF9skon0FK1F9nuk7q3MjBN5P8Tp1TJQEHYYWVDsiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=t076cPPW; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PF4maO002601;
	Tue, 25 Feb 2025 17:22:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Xhh3gcbiFK/6Ez/lxF9CuTHjea+5VkiT+cvC5t9kB1c=; b=t076cPPWkl37c0C9
	0Sf4NkVTYac4WOW0OzH5SB/N9VcaPdVH06HEtXlDggksW8DgtAexmUqShnUXuSjH
	2i0Wt9AcuBY0vU+thJKq5Kpe9laqG2GfAjpKTNoUdXfbmpSfUh2QrcWeAmslaE0Z
	TfDOXE2vQQzVSAew0yRWO9WZsrKH20AlSyeeGy/jEKixUNn1LtGujjMC3xLUaKPO
	d8puCY+ckneEhuWWdeovePidHjiMJMEViaM254XZ2mhfQCOjt3BFahXO0EJFDd4r
	3yU2QvhnR83nRbxGDufnMs6JhcvefOepMo2QpyK7CPAaYz+cSPwdizVcZeACqTMS
	WVhbuA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4512spmfjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 17:22:30 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F2403400A0;
	Tue, 25 Feb 2025 17:21:09 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D10F54DD22B;
	Tue, 25 Feb 2025 15:57:05 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 15:57:05 +0100
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 15:57:04 +0100
Message-ID: <acabacb8-8ea1-4b16-a562-8ffba64fdd36@foss.st.com>
Date: Tue, 25 Feb 2025 15:57:04 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: mfd: stm32-lptimer: add support for
 stm32mp25
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
 <20250224180150.3689638-2-fabrice.gasnier@foss.st.com>
 <20250225-outgoing-scorpion-of-music-be0bea@krzk-bin>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250225-outgoing-scorpion-of-music-be0bea@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01

On 2/25/25 13:02, Krzysztof Kozlowski wrote:
> On Mon, Feb 24, 2025 at 07:01:43PM +0100, Fabrice Gasnier wrote:
>>    pwm:
>>      type: object
>>      additionalProperties: false
>>  
>>      properties:
>>        compatible:
>> -        const: st,stm32-pwm-lp
>> +        enum:
>> +          - st,stm32-pwm-lp
>> +          - st,stm32mp25-pwm-lp
>>  
>>        "#pwm-cells":
>>          const: 3
>> @@ -69,7 +76,9 @@ properties:
>>  
>>      properties:
>>        compatible:
>> -        const: st,stm32-lptimer-counter
>> +        enum:
>> +          - st,stm32-lptimer-counter
>> +          - st,stm32mp25-lptimer-counter
> 
> Driver changes suggest many of these are compatible. Why isn't this expressed?

Hi Krzysztof,

The Low Power Timer (LPTIM) hardware isn't fully backward compatible.

At driver level, as indicated in the cover-letter, same feature list as
on STM32MP1x is supported currently. This is probably what makes it look
like it's compatible, but it's not fully compatible.

The hardware controller is a bit different. Some registers/bits has been
revisited among other things. This is the purpose for these new compatibles.

Please find driver-related answers each driver part.

Best regards,
Fabrice

> 
> Best regards,
> Krzysztof
> 

