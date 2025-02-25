Return-Path: <linux-pwm+bounces-4987-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E35A445F5
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 17:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A2C16CD97
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793D41917C2;
	Tue, 25 Feb 2025 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OgoS/t3L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C318DB2C;
	Tue, 25 Feb 2025 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500613; cv=none; b=ETZ0tJj4IYCM1tARj0sSq0rVya4MV69BnUTXpXjNZGUoswYcUVG42lh3PRsQlyYQM0Xp8HZY60VkuAwB+KobHO7Vel3N1oJtLUGhsrHz86+r58IacRb4KxblhwOvkK7mvcepo53H8Nbd0lHlYfG+33fHaNgVZz0T6HlGKIXr9o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500613; c=relaxed/simple;
	bh=cnPoMKGqFJxRlkYXHJlYiIRk5oJDrfshV0R/SyXnwBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GaeCbkPFpDvSJ4lCDximyvbC8yzG1UpOHVMabXNCpfwPW8Ku7TfSyJjllKezjdnNHokphAFTMkO/WrbeNUFalenYM+pfQA8TDDHn/jLuIHvRBpj8oFC6YdkJV5GInSR8VKEqoe+mrSG95DeQp4f9RnXfXj2EV4zjG+gxGMkKrIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OgoS/t3L; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PEsxG7025684;
	Tue, 25 Feb 2025 17:23:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	wqgFWeoQivzhLETwW+Q6wbE8s0MXA+Zaes1DQ9N8L94=; b=OgoS/t3Lbxp32NRq
	naIljPbKwZjr091WEhth+xRTbwEvzSk/tLAsR8GGUbCX4EJcw45zSGkWEMsSAPA+
	0jtddvtuWP5j4x+EM/+zRbQ5H3tuh2T0m2tBFY5/xzcINPAj6K98NzjPP5CLF8Iz
	hjkTAM9heRqObmD4CLkTJUjb742v4ghuIoHFn5Dzl4p/lwrYH+dSK75Z4Jmd8rK6
	nSezAbmEvZT0YC6zTRBimbtDnvxlkax1p6AYWGCvDJhptSoGf+dsmLpHUrml1+Ca
	/K9GKj0gTA/WfKroXfTL3MjXE3YVlagShG2IX+/6axek79yU12tzinLvjxW6W80b
	zJImDA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4512spvjyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 17:23:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2819E4006C;
	Tue, 25 Feb 2025 17:21:53 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3142E52CB63;
	Tue, 25 Feb 2025 15:58:26 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 15:58:26 +0100
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 15:58:25 +0100
Message-ID: <e309c016-4dcb-49e3-945e-54ddadfbddb8@foss.st.com>
Date: Tue, 25 Feb 2025 15:58:24 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] pwm: stm32-lp: add support for stm32mp25
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
 <20250224180150.3689638-6-fabrice.gasnier@foss.st.com>
 <20250225-psychedelic-iguana-of-education-d5fff7@krzk-bin>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250225-psychedelic-iguana-of-education-d5fff7@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01



On 2/25/25 13:04, Krzysztof Kozlowski wrote:
> On Mon, Feb 24, 2025 at 07:01:47PM +0100, Fabrice Gasnier wrote:
>>  	}
>>  
>>  	return pinctrl_pm_select_sleep_state(dev);
>> @@ -246,6 +413,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
>>  
>>  static const struct of_device_id stm32_pwm_lp_of_match[] = {
>>  	{ .compatible = "st,stm32-pwm-lp", },
>> +	{ .compatible = "st,stm32mp25-pwm-lp", },
> 
> No driver data suggests device is backwards compatible. Commit msg
> suggests not, so that's confusing.


The LPTimer PWM driver takes benefit of the MFD parent driver to feed in
data, e.g. 'num_cc_chans'. Number of channels is now variable, on
STM32MP25 (e.g. not a single channel). But it can't be hard-coded as
compatible data. (there's only 1 channel on earlier LP Timer hardware
revision).

The hardware controller is a bit different, hence the new compatible.

Best regards,
Fabrice

> 
> Best regards,
> Krzysztof
> 

