Return-Path: <linux-pwm+bounces-3438-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD8098E3B2
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 21:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9216D28486A
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ACA215F77;
	Wed,  2 Oct 2024 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="fnE2QUes"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ACF212F11;
	Wed,  2 Oct 2024 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898500; cv=none; b=cnYiAajqJKwdZfjk/ugmLdIte+id9GM5RwodBjY06HjYSXpeX0yEeBw0koefFzUxp8x5OwYl6bUgMV+2+R5Mumh95iyarfECj2ed47E1kPE3TQ9sJ5rtZgjcq54hHtd12380+ulJa9MGU3w01H/RWvaytr/s2I2Qd+RZ4Bw/3xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898500; c=relaxed/simple;
	bh=9Q2D+WykA0eWJSHzqwSIfhSvzl73WtDeizE3VyiHEoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a027M5oLEZPPzJnnbTLBi2kTHx/0OnF91lVovp/Z+2B+tDseg1iXh2m4DkPzWdKNJK9SCDdS1xN3zZcgAHG6cPFkMLabd3C5gfy0eU5+cNfLmTLhqMNJC/dlYQf+tBcu0EPRY1l2hobFmp5CGpqO7ogt8nvSLickxLACRSkNwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=fnE2QUes; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3F73088DA3;
	Wed,  2 Oct 2024 21:48:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727898494;
	bh=Oa9dSkA2IL+LJwOZCnOOgKJ0gMnhf8sMx+NEA5HrmYc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fnE2QUesU0UzeveL1ddBbm1NL2842mZaHoexdDeaeEa6lbWSGoEF1mXWhwjMe6ewU
	 gYGMlLyXX+sUtttKovCQieGnaxSL/xQdFMXm2Bod9rQQBTWip8kTb+bVLze8SHE4n/
	 WGqr0j4K0DYPcbCpuITanvK5cAAreXWn23lx3L1VGUQ/467j4Ry3tyb9kOsDVOgpIt
	 yUiqHZXbcT3337Y6xkIgK1gdBem/TRo5snKYeSW1cIuRPdPy5IcHP38Sc3MXT7+Mch
	 pt9CiGveZTPNr7yGkpUvOYOGe5VWdVDZl0UiEipq03avZBB+DtKzULWD2gYAVXbC08
	 eVr6QI13/r8bA==
Message-ID: <ab75066d-31ae-4725-b524-9cf6720bc866@denx.de>
Date: Wed, 2 Oct 2024 21:48:12 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
To: Frank Li <Frank.li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
 francesco@dolcini.it, imx@lists.linux.dev, jun.li@nxp.com,
 kernel@pengutronix.de, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, p.zabel@pengutronix.de, pratikmanvar09@gmail.com,
 robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
 ukleinek@kernel.org, xiaoning.wang@nxp.com
References: <20240917192510.3031493-1-Frank.Li@nxp.com>
 <4bbee009-3985-4679-a85e-76f4259ff8d6@denx.de>
 <Zv2i73MvKASJA+2x@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <Zv2i73MvKASJA+2x@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/2/24 9:45 PM, Frank Li wrote:
> On Sun, Sep 22, 2024 at 10:28:02PM +0200, Marek Vasut wrote:
>> Hi,
>>
>> On 9/17/24 9:25 PM, Frank Li wrote:
>>
>> [...]
>>
>>> @@ -223,6 +224,8 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>    	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
>>>    	unsigned long long c;
>>>    	unsigned long long clkrate;
>>> +	unsigned long flags;
>>> +	int val;
>>>    	int ret;
>>>    	u32 cr;
>>> @@ -263,7 +266,69 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>
>> [...]
>>
>>> +	c = clkrate * 1500;
>>> +	do_div(c, NSEC_PER_SEC);
>>> +
>>> +	local_irq_save(flags);
>>> +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
>>
>> I think the multi-write I mentioned in v5 for > 500 kHz case could further
>> improve the patch, let's see what others think:
>>
>> if (state->period < 2000) { /* 2000ns = 500 kHz */
>>     /* Best effort attempt to fix up >500 kHz case */
>>     udelay(6); /* 2us per FIFO entry, 3 FIFO entries written => 6 us */
>>     writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>>     writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>>     /* Last write is outside, after this conditional */
>> } else if (duty_cycles ...

Can you have a look at this part ?

>>> +	if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
>>> +		val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);
>>> +		/*
>>> +		 * If counter is close to period, controller may roll over when
>>> +		 * next IO write.
>>> +		 */
>>
>> c is only used in this if (duty_cycles ...) { } conditional, the do_div()
>> above can be moved here:
> 
> It is in local_irq_save(flags) scope, it'd better as less as possible. So
> I prefer do_div() is outside local_irq_save()
Good point, either way is fine by me.

