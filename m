Return-Path: <linux-pwm+bounces-6719-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20746AF8E40
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 11:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDA617A212
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 09:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9982DCF52;
	Fri,  4 Jul 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="aqQqbzM7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF032DA769;
	Fri,  4 Jul 2025 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620379; cv=none; b=QkF5hEG6UxJ3RhMRw9yh8wJurLmwPfmwIfTiImi/wo39x9h8AoaR0WR54DMXNPakzkzl8y+ZnhJ3i/p9ja50+pYdz5xSXJXV/iKgE4QU0c0NNTJ/sAXSf4FOIePGbjuq4NGqM7agNpSolNPi9nVm6OsRkeY7h5tH0fQo6iv9eUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620379; c=relaxed/simple;
	bh=N7QKC+pm+qrvZDqnMTZSHH6sdhRJNNtWgFXKK8pjTd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mRu+51Cj8+TgqlzkJSymvNzpQRN20YCe4aMrW+9wisrMKqhrk2jVoKlVtq4nPVDvHpm5WYpAv443JBVdknPIYA4pupx2cEkLO296Lsk9U4f+7lY/beAMjbZ7Wj+5TphQhSqItjMdHGjFhEaVJY1IG2/kCL5PekbL5S/2apXojr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=aqQqbzM7; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5647Zsmm012108;
	Fri, 4 Jul 2025 11:12:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	o9vFHnH+10VgpguGO7CSDoz8TQTajPJNBGdmVoWn0WM=; b=aqQqbzM7yRmB9AiA
	xExSCXj2ZJY+0YRGwxXqL63PYmeEjiuE34qNGrmr0Ap9IQEZ+G47upZdb9+EiqNg
	eAhrP6gvxoretMVSCukaQqM8KXoGSTMbyI6NEEoWNjGqxmHxq7rIsMliK6TrOoD3
	P4CQhgxMaRmb15mh60ZSlAd/itqy9R/gWKIG4+KKM2IHMT8JR95FoLbTE1cRc/gs
	LCAh9ZDFUIgW0nI7Y+QLnZba/vR3dQL8ptwozFYIVqfnpmJopoWxwuH5cBCIiXAb
	EqoOwORtYh6Yx1+q0beeKVfLjMQ9+jlEuMhRd0j3cW/ierm+CuAaabIM20Ol2C01
	5QrfEA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47jubp9329-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 11:12:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 87A7A4004F;
	Fri,  4 Jul 2025 11:11:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C28BA4D113;
	Fri,  4 Jul 2025 11:10:50 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 11:10:49 +0200
Message-ID: <7a56c778-0c46-49a4-8a83-ed7ec8355ef7@foss.st.com>
Date: Fri, 4 Jul 2025 11:10:49 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Add STM32MP25 timers support: MFD, PWM, IIO and
 counter drivers
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, <lee@kernel.org>,
        <ukleinek@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <wbg@kernel.org>, <jic23@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
References: <20250110091922.980627-1-fabrice.gasnier@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250110091922.980627-1-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_03,2025-07-02_04,2025-03-28_01

Hi Fabrie

On 1/10/25 10:19, Fabrice Gasnier wrote:
> This series adds STM32MP25 support on MFD PWM, IIO, counter timer drivers.
> This new timer variant is managed by using a new DT compatible string.
> It comes with a slightly updated register set, some new features and new
> interconnect signals inside the SoC. There is also a new instance (TIM20).
> Same feature list as on STM32MP1x is supported currently, except for PWM
> capture (not enabled, by DT).
> The device tree files add all instances in stm32mp251 dtsi. PWM, counter
> and trigger examples are provided for stm32mp257f-ev1 board.
> 
> Changes in V3
> ---
> - MFD updated since Lee's coments
> - IIO patch dropped since applied by Jonathan
> 
> Changes in V2
> ---
> - PMW driver updated to address Uwe's review comments
> - Collected Acked-by
> 
> Fabrice Gasnier (8):
>    dt-bindings: mfd: stm32-timers: add support for stm32mp25
>    mfd: stm32-timers: add support for stm32mp25
>    counter: stm32-timer-cnt: add support for stm32mp25
>    pwm: stm32: add support for stm32mp25
>    arm64: defconfig: enable STM32 timers drivers
>    arm64: dts: st: add timer nodes on stm32mp251
>    arm64: dts: st: add timer pins for stm32mp257f-ev1
>    arm64: dts: st: add timer nodes on stm32mp257f-ev1
> 
>   .../bindings/mfd/st,stm32-timers.yaml         |  18 +-
>   arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |  61 ++
>   arch/arm64/boot/dts/st/stm32mp251.dtsi        | 524 ++++++++++++++++++
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  58 ++
>   arch/arm64/configs/defconfig                  |   4 +
>   drivers/counter/stm32-timer-cnt.c             |   7 +-
>   drivers/mfd/stm32-timers.c                    |  31 +-
>   drivers/pwm/pwm-stm32.c                       |  42 +-
>   include/linux/mfd/stm32-timers.h              |   9 +
>   9 files changed, 740 insertions(+), 14 deletions(-)
> 

Patches 5 to 8 applied on stm32-next.

Thanks
Alex

