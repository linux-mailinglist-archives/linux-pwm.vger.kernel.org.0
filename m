Return-Path: <linux-pwm+bounces-4986-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B6BA44601
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 17:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3483B5520
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 16:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B56618DB3F;
	Tue, 25 Feb 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OxOtEUAE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7D18C93C;
	Tue, 25 Feb 2025 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500579; cv=none; b=ZqIPCFa9/0fBl7L4h/QuUsIqHmk/uVwj21TsmAnTmNl1L1d5j9Ga5jTCInetNqffNwvHp7DdT2euE/i33t0rCZp+ggdhbaz12j4g81Zep+Qg5Oi2xyu9Ycuflu/A8/olh1yUcOUp9dgze75qfKgwcqNtnRmF+Rpkbd5tCba8D/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500579; c=relaxed/simple;
	bh=r4o5TBDQfp7XBMg94pkTeFm2ojET8kuPPGCZu0LaV14=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kukfv+ZDrFRkoUsKBOP/UZrc1TvZGw9OGhhDwVEOoN/bEVbsc+WhV3lLEY/rsYo4YIt53lZoJJy81BNa5kmSJp9h/1AS1Pra0CaodLdsH2LwLsXHXEaiRFqmgf/O2OxT1nuJ3idukEFdMXsMDobebHpZAc8gMCsNyQMlk5IPkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OxOtEUAE; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFCrWC016958;
	Tue, 25 Feb 2025 17:22:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	5gxQFyJw5oEPlJrNAKF6ERcGuSNk0FxInJ0AAbQCAlg=; b=OxOtEUAEemJ7xmT+
	SswcTnH0XnACl/+5vGnoJ91/aKrxA90SM9ZdHJqoMEaEudZ6bsOJwu3/FOree1r0
	u1sILtXwawuzUyOXgy6Jc9aDmZ6KlMF99ul6mlrxWrDoN70HPnZgGdpmLaTDtyUT
	Be5TL9/MWjIHuQwsgg36J5fqS1JNCfg55zZRsRzTEhA/o4B8OE9IauTObLlzdED/
	0abBmAfOzmyTgTLs0wV0WbBMFaaWYlHD2p/BGylTlISso2/VYqTLrALQ0iBLKg/H
	sNfysYZ7fk0TpBRr87LV27Iuy2hijSOzD07iIvkSIgSKxp3Ewg0n4p9dd3NKjTdB
	lNE8Og==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4512sqvfhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 17:22:30 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 88F5240046;
	Tue, 25 Feb 2025 17:21:13 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2597C5C0CD7;
	Tue, 25 Feb 2025 15:57:51 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 15:57:50 +0100
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 15:57:50 +0100
Message-ID: <2df7bdd9-5072-4a9a-b142-1e1e3f20130c@foss.st.com>
Date: Tue, 25 Feb 2025 15:57:49 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] clocksource: stm32-lptimer: add stm32mp25 support
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
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250225-purring-herring-of-reputation-1aed2f@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01

On 2/25/25 13:02, Krzysztof Kozlowski wrote:
> On Mon, Feb 24, 2025 at 07:01:46PM +0100, Fabrice Gasnier wrote:
>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>
>> Add the support of the new compatible for STM32MP25 SoC in driver, as
>> described in Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
>> and used in arch/arm64/boot/dts/st/stm32mp251.dtsi.
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>>  drivers/clocksource/timer-stm32-lp.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
>> index a4c95161cb22..db055348e2cc 100644
>> --- a/drivers/clocksource/timer-stm32-lp.c
>> +++ b/drivers/clocksource/timer-stm32-lp.c
>> @@ -197,6 +197,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
>>  
>>  static const struct of_device_id stm32_clkevent_lp_of_match[] = {
>>  	{ .compatible = "st,stm32-lptimer-timer", },
>> +	{ .compatible = "st,stm32mp25-lptimer-timer", },
>>  	{},
> 
> Same question.

Oops, I just figured out I have missed a change to this driver, to
enable interrupts, in order to comply with the LPTimer spec, starting
with STM32MP25.

E.g. with earlier STM32MP13, STM32MP15 or even STM32H7:
* The LPTIM_IER register must only be modified when the LPTIM is
disabled (ENABLE bit reset to ‘0’)

On STM32MP25:
* The LPTIMx_DIER register must only be modified when the LPTIM is
enabled (ENABLE bit set to 1)

I'll add this as compatible data in next revision.

Best regards,
Fabrice

> 
> Best regards,
> Krzysztof
> 

