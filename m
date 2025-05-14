Return-Path: <linux-pwm+bounces-5978-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73925AB65EC
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 10:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A393D3A67C8
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 08:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78347221547;
	Wed, 14 May 2025 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="pMGlMrFN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F821B9C8;
	Wed, 14 May 2025 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747211218; cv=none; b=KT/RK1ayLMwwKr5EOhkp6pfxRa7lX/1eelXqnE9keNVA5p+vFWU4gwuR5cJOL/VGsPyH4zAGjsCiWwfT7bAyxVEQkbR56xzfMz+J3Om4HmtLpyIp1VeZqhvSlVV2vEwUJM6tc9vG6AbhknEkcrVEw5x1fHztEiKzY58UQuaIoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747211218; c=relaxed/simple;
	bh=pazwyUs7Ot0cc4KDotDE+lY96H0cEXZeAVpbnhs/JgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rYOKDUfZIa8ts7xm9ya/hsnS2XI4ypX9tvMynBphnnsFR3LBNSMed+KgB76LUwF39/ZMU41BFqgzk4hgZp3KTHWAh+fZ2J+8zpEXNK8r3WF7pjR901YaZX5NY0SuVUuX8CzIodYBIPZKqy2VpIG2qtwb2N/di9ddRh7LkGmRiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=pMGlMrFN; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E7vtKW023076;
	Wed, 14 May 2025 10:26:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ds5+8iM4sRf0Jo4IyqmV53NfBcmFz2cJwNiJZ/wCrmk=; b=pMGlMrFN7CKCc5l+
	/xUdEV5gxnTpRkg4FOuwGXS51BtuZ1kYDbW2LqiQMA2nhQSxwBFpjwLYCC2AhmDk
	msfLU+TozS7alcR8HZhZhXZb623TTILmwa7sKOnjfrj5H6LqzSSBzRZvyWS96QXC
	IWewdZXh737I31ekESxstCKDAXVXyOg1jGM5JpXfULiVEi+6tUDx4AHPQbn9ke2c
	LGDbfmqBSsPHm40wvkDE9bbbYeAJlHl5fGiH4T7HQpRId+2j7ux8/eK9Vy/8e4s8
	2DWJq5H67SsCDvyIICQi6YLh8xDI53BVvYN7sh5Yup55vf0X5feVmbg0IB1O8w3z
	+IM2dA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46mbdxtj5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 10:26:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C8B5240044;
	Wed, 14 May 2025 10:25:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1C3FDB3A736;
	Wed, 14 May 2025 10:24:03 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 10:24:02 +0200
Message-ID: <7f79af9a-2b42-48c0-98c5-6bf2afc61206@foss.st.com>
Date: Wed, 14 May 2025 10:24:02 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset)[PATCH v6 0/7] Add STM32MP25 LPTIM support: MFD, PWM,
 IIO, counter, clocksource
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, <daniel.lezcano@linaro.org>,
        <lee@kernel.org>, <tglx@linutronix.de>
CC: <ukleinek@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jic23@kernel.org>, <robh@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <devicetree@vger.kernel.org>, <wbg@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
References: <20250429125133.1574167-1-fabrice.gasnier@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250429125133.1574167-1-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01

Hi Fabrice

On 4/29/25 14:51, Fabrice Gasnier wrote:
> This series adds support for STM32MP25 to MFD PWM, IIO, counter and
> clocksource low-power timer (LPTIM) drivers.
> This new variant is managed by using a new DT compatible string, hardware
> configuration and version registers.
> It comes with a slightly updated register set, some new features and new
> interconnect signals inside the SoC.
> Same feature list as on STM32MP1x is supported currently.
> The device tree files add all instances in stm32mp251 dtsi file.
> 

Following patches are applied on stm32-next:

[PATCH v6 5/7] arm64: defconfig: enable STM32 LP timer clockevent driver
[PATCH v6 6/7] arm64: dts: st: add low-power timer nodes on stm32mp251
[PATCH v6 7/7] arm64: dts: st: use lptimer3 as tick broadcast source on 
stm32mp257f-ev1


Thanks
Alex

