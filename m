Return-Path: <linux-pwm+bounces-5111-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06459A54537
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Mar 2025 09:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B2C1895B63
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Mar 2025 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D6B207A3E;
	Thu,  6 Mar 2025 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xAzJdlwn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EBF207A23;
	Thu,  6 Mar 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250569; cv=none; b=Bh6+A5bO9yqFjjq1bfn/WxxPJDMaU3cYHatwWQe/bO7NwVrlOeVOx2ebsJzhO07on683xmCwpd7pvHnil0osw/LdL32ssbgEVg3LoDxdOu1cnttPt9OujhO8v4eGqO7Vef0Ro82Q039F/yZyP/v++u0/zWvy9/mEwsKU9RQ6w+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250569; c=relaxed/simple;
	bh=Qn0Y3wq34ma88v52Q0vjPttdvRfgoyqUtiMEV5R6AO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TaaGReAJWXqqdLK8vnSHipnu4YAQqCFs8GalnTKYuknBjxqx/5Q5FUO89dhgLsoCU4PLcWw1lzFsTn4tEL6adT26D5IlRPgdVSplf4GrNsbnEyQLlEJeZrwGSgY1OqePgNaYqjNgYU42SOBFLBPV2fWhzNxzGhxQ4VGZHOpcYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xAzJdlwn; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5267Sk7N015077;
	Thu, 6 Mar 2025 09:42:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	mcl6sGfOXxz2wVCK7AnSLNHITansIH0yOzXR+7u97no=; b=xAzJdlwnXlBNm1Wa
	7Ife+ee+VgwahclxL70yp7tvaLJa4H1ObaqD15ZCyqlBMH8sFnRdZUvn31Mp/SYY
	A6pIR/FJjc7B6PXCWpy9ykshds9Lejm8g+cCQeGONwjQjacbntQuag08ox4s2mY8
	ddSQ/IRWGPpgvpnKCy7O/ZJ9kLoESBL6G08fUFrN7asYyBbMFxOJt7yJNxjYNB+k
	iILuXTz1faI7GfE3vI91cHBsKtfVb54RKddtFw73nEowe2PMhzDlVNnwOq6/WEbb
	xLIadHIi8b/hnQpaRc5nb2vNJe8YRQrNEGYudS/Re0U0EgUNScrj9SFkBxGHFMvf
	Xt/NHA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 456krth50w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 09:42:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 54F7C40052;
	Thu,  6 Mar 2025 09:41:17 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 83009441E5C;
	Thu,  6 Mar 2025 09:40:12 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 09:40:12 +0100
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 09:40:11 +0100
Message-ID: <32aad66e-a9ae-493a-8bea-a06e096c88f2@foss.st.com>
Date: Thu, 6 Mar 2025 09:40:10 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] iio: trigger: stm32-lptimer: add support for
 stm32mp25
To: Jonathan Cameron <jic23@kernel.org>
CC: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>, <wbg@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
References: <20250305094935.595667-1-fabrice.gasnier@foss.st.com>
 <20250305094935.595667-4-fabrice.gasnier@foss.st.com>
 <20250305144539.54a75689@jic23-huawei>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250305144539.54a75689@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01

On 3/5/25 15:45, Jonathan Cameron wrote:
> On Wed, 5 Mar 2025 10:49:30 +0100
> Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:
> 
>> From: Olivier Moysan <olivier.moysan@foss.st.com>
>>
>> Add support for STM32MP25 SoC. Use newly introduced compatible to handle
>> this new HW variant. Add new trigger definitions that can be used by the
>> stm32 analog-to-digital converter. Use compatible data to identify them.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Hi. Oops I replied to v1 without looking for other versions.
> From a quick glance feedback still applies here.

Hi Jonathan,

Thanks for reviewing, I've noticed your review comments on V1, I'll take
care of these in next revision (v4).

Best Regards,
Fabrice

> 

