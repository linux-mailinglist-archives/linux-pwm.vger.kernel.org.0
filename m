Return-Path: <linux-pwm+bounces-5177-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA4AA5FD18
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 18:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24295170D60
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDAA26988E;
	Thu, 13 Mar 2025 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="B4CqnQjr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90AB13AA2F;
	Thu, 13 Mar 2025 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885789; cv=none; b=u1cbId0h0F+NOBX2TxcB8vQGwouTz+ACJYRb+EyP6e4sEm2XDO1bvoEIoINIUG0Vz94Fj7ZH2KNrwCBEL5dx3XsfN1TlR3cgh/x5AjdTyLn7IuoagnrPn/gomQNFNj5x5lvbgm/EEMeRvdTSDAQSRbxm7GqSSWPw8lARLM/hR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885789; c=relaxed/simple;
	bh=tu+hrOb5T8ZjFtDOYK4B51yn76Cxq1wcFPtSB9zCbHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TIQ7z06o/fxs5Fdnmadt+ornXe1ClF53G4V/tCk13z+M+d5+JD5zuEV3eM/jVkryvhiQwyxWKc5LwC/IvRow2ydovjDMyu17t0cDjHTL4IeCxTxiW2leZ9qUeFdWgHDf1lyfQw99bBXOvW2HIrMIE3oFdlzwoul/jb82Ss459Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=B4CqnQjr; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGD7D6003932;
	Thu, 13 Mar 2025 18:09:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	/UACylWACYq+MaYXZcL2+yGVsndWAy/wz/DmvGJrXiA=; b=B4CqnQjrifjsld/Y
	DaUYXKtWR6i45Ame6DKDoXrNii3EePe8ZddE1Ysiu37Upj0VTc+sEY+4E38WsO4X
	KJz/PxvRy8AKzWj+egbTF8nZjfWRfcrPS7Kk3O5iJOkgk7x4EPp72BGZ+I+G7A4d
	HQrZqxTbLhFKQY/GZBfqYYo0uF3VksBpXuALvM5SzIEsXsKaOGi/yoZkKTZsrUmq
	7nBaB+hbMpnAn2LPUpupn+V3qwG505VaUB/cHqRsmuW/jnjOnbpkM2nOk/vDv8QJ
	WOXT8xErxt7gNcXWCT1P+ia3f3yUzaAQw4TwcRWv+koTDEBsp4NFZu4BUghZPADQ
	ggjDsg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45c2pf07mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 18:09:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1780B4004D;
	Thu, 13 Mar 2025 18:08:27 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B3E4E589337;
	Thu, 13 Mar 2025 18:07:18 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 18:07:18 +0100
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 18:07:17 +0100
Message-ID: <c1cb926f-33b0-4433-b54d-954451ed32a8@foss.st.com>
Date: Thu, 13 Mar 2025 18:07:16 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] mfd: stm32-lptimer: add support for stm32mp25
To: Lee Jones <lee@kernel.org>
CC: <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jic23@kernel.org>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>, <wbg@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
References: <20250305094935.595667-1-fabrice.gasnier@foss.st.com>
 <20250305094935.595667-3-fabrice.gasnier@foss.st.com>
 <20250313164008.GC3645863@google.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250313164008.GC3645863@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01



On 3/13/25 17:40, Lee Jones wrote:
> On Wed, 05 Mar 2025, Fabrice Gasnier wrote:
> 
>> Add support for STM32MP25 SoC.
>> A new hardware configuration register (HWCFGR2) has been added, to gather
>> number of capture/compare channels, autonomous mode and input capture
>> capability. The full feature set is implemented in LPTIM1/2/3/4. LPTIM5
>> supports a smaller set of features. This can now be read from HWCFGR
>> registers.
>>
>> Add new registers to the stm32-lptimer.h: CCMR1, CCR2, HWCFGR1/2 and VERR.
>> Update the stm32_lptimer data struct so signal the number of
>> capture/compare channels to the child devices.
>> Also Remove some unused bit masks (CMPOK_ARROK / CMPOKCF_ARROKCF).
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>> Changes in V2:
>> - rely on fallback compatible as no specific .data is associated to the
>>   driver. Compatibility is added by reading hardware configuration
>>   registers.
>> - read version register, to be used by clockevent child driver
>> - rename register/bits definitions
>> ---
>>  drivers/mfd/stm32-lptimer.c       | 33 ++++++++++++++++++++++++++++-
> 
> Looks okay.

Hi Lee,

Thanks for reviewing,

> 
>>  include/linux/mfd/stm32-lptimer.h | 35 ++++++++++++++++++++++++++++---
> 
> Assumingly this patch is not independent of the others?

Please hold on, I'll submit a V4, with some additional bit definition
for the clocksource driver (see my last reply to Daniel).

Best Regards,
Fabrice

> 

