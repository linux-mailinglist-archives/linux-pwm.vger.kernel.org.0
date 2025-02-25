Return-Path: <linux-pwm+bounces-4979-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C0EA43807
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 09:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DC3189A37D
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2451F25D537;
	Tue, 25 Feb 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CodEsv4e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454813A88A;
	Tue, 25 Feb 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473265; cv=none; b=NBuvON05QEdyxFKKcBqYP58e3rRNFmLCXspRokXI9ilstWT2np+9fzF9bWEY1lFVdEl51uF6NF5kFlmlrq+ews0y8xOQMIghKt6r9yKaZgL65PyMYhwzzd4ts4/14YVtSwNq6mhWd61iBpxr4Z0z1m0t06Nkc76nYeJmRX5sC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473265; c=relaxed/simple;
	bh=IvrsNh1PoziXp5gsBXRLYUYz8EOp7rsmJMbgVpDub9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cjOOe4bI4Bro4X9e91ahGp+WuHRQP5CG8iJ2mohMFRfmrdZMVj+UtypXgJNGlDkkbjrjpu2uYXazBanC8kcyfLGTML2YcVHq3Sm8nxTnBuOfZ3rdLm4kZVYhxTKOCaUXvmdQw66h1Z1SWeG+Y1Adjy03qRyTzyHWKv0ExM852p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CodEsv4e; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7LgQ0003966;
	Tue, 25 Feb 2025 09:47:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	yHiS+n00ibzlP5REtMR+ddXLiK9OUJ+uzaby4EVh4iM=; b=CodEsv4eyIfFhzYg
	ppgKu4xEWudziYqyzc6o4+V04zZ9hb2GoY5E3k8+YGSgW1XJh4FYciD1d8ZTfiB1
	HWrAGQMacZjm+JsMIxqVuGatBAr2dcKZh+XQD16NZ3RPJRG6Qin5KHOOZaqZc1y7
	cd0zu6WUaGwEWMk+odatGnvR8FpWKwz6Oj2/vqJeDGwNBnkVGW9MKjSIFwqfzxt/
	Uo9uXsTDYMxnokHSXiSJiJC2NAaTWEejQ80wuuH9aNdb+RA+1+BXe7qyATYn9TnU
	Wa/4Eyy8BsE0EaqNfsPMErBymX6znxmfg1a7MonpedGO+L73X9L0y5RHG5cQLVo3
	Z6P34A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4512sphr2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 09:47:26 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 380F040044;
	Tue, 25 Feb 2025 09:46:16 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8B9C9430105;
	Tue, 25 Feb 2025 09:44:00 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 09:44:00 +0100
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 09:43:59 +0100
Message-ID: <696ac9eb-f223-4993-b288-b6c3e07f4ed7@foss.st.com>
Date: Tue, 25 Feb 2025 09:43:58 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] arm64: defconfig: enable STM32 LP timers drivers
To: Krzysztof Kozlowski <krzk@kernel.org>, <lee@kernel.org>,
        <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <wbg@kernel.org>, <jic23@kernel.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
References: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
 <20250224180150.3689638-8-fabrice.gasnier@foss.st.com>
 <f76a3a6c-795e-4fc8-905f-4655115ea99d@kernel.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <f76a3a6c-795e-4fc8-905f-4655115ea99d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01

On 2/25/25 08:48, Krzysztof Kozlowski wrote:
> On 24/02/2025 19:01, Fabrice Gasnier wrote:
>> Enable the STM32 timer drivers: MFD, counter, PWM and trigger as modules.
>> Clocksource is a bool, hence set to y. These drivers can be used on
>> STM32MP25.
> 
> 
> Which upstream board? If you do not have upstream board, the defconfig
> is pointless for us. It's not defconfig for your downstream forks.

Hi Krzysztof,

It's going to be used on stm32mp257f-dk and stm32mp257f-ev1 boards.
I can add the relevant DT for the(se) board(s) in next revision.

Best regards,
Fabrice

> 
> 
> Best regards,
> Krzysztof

