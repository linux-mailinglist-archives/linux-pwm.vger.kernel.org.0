Return-Path: <linux-pwm+bounces-3174-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEECA972392
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 22:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3EAB234F1
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 20:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC76F18A939;
	Mon,  9 Sep 2024 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Nz8dI+OC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD684152790;
	Mon,  9 Sep 2024 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913381; cv=none; b=cG9yA958qk5Is77kq+61m8qM2bD8/qNkf/7cypkhVLKmZIUco0zEMgOv6BQecqTCTg4OudyEdb1E2w75VyX571xJTftwaocw3OQF1ghpjYzF4PPQczs9vwhH/27W3ZEcRRGt8MhmRcm3MtH9z0TYe/UlBVMTxJv2t9bHiKb9lvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913381; c=relaxed/simple;
	bh=kP1RxRCpVBkNjPJuEwmnA3Znn9iq8LsCl0ysMpyU+74=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SePPUbBMZgzEKyRnDam2oeNwf06qUpvn4T3SQpJFhRX7R2nHnPHl2556GhIldjy9VNzbIR27jCV9mQHW0YRB9n5Ya/4ZJ3SC/OM2Y8B9w9ebamuCVjELYOMckNRXw/I6dTfTHsM3ER1uOdWVdvbDc8P8y/+Phs3C+j6Ep7wuh1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Nz8dI+OC; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 26B1588CBD;
	Mon,  9 Sep 2024 22:22:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725913378;
	bh=i035IsvXnAr4KcZY5gBsui1I4dE7b0AVJXXJ57OnnzM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=Nz8dI+OCkHitBAe4pQJeKa7bJJk4r7mAVviURmL3+YyZ1mphz8Tj+w7xr20DzJMP1
	 f8lzjLbBHEI1O1qOBV5uyxjEg4YeUV2flVMMGXu3sPAbB3rZwN5yjazLWJr74FZj40
	 E4nPKz8yX7I6fqPspI5lwNTkvZqzXOyVRZeuTb0hPzAVJUjDDHIP9Nnb7QNO5WDkBV
	 oVijvkMiiXMx9GTAHepolSkmvZzEUcPRjQptM87KjQ8w9Ih/PAkWZxZGOSXfPc8+xg
	 Jgqu8MokBhKRSWLW0ym6vg46XAbO3LMNVD/ktyL06oH1wVOY91es+z9zD9R/t8wxvr
	 37hjcPORj0dzA==
Message-ID: <2d17752c-8a78-4b6d-9767-f4de884ec795@denx.de>
Date: Mon, 9 Sep 2024 22:16:58 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 3/3] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
To: Frank Li <Frank.li@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 pratikmanvar09@gmail.com, francesco@dolcini.it,
 Clark Wang <xiaoning.wang@nxp.com>, Jun Li <jun.li@nxp.com>
References: <20240715-pwm-v2-0-ff3eece83cbb@nxp.com>
 <20240715-pwm-v2-3-ff3eece83cbb@nxp.com>
 <CAOMZO5DNmHfHWbLoPj9P=_+JiLLQ4tiDd_90+UX+_psN2o+Knw@mail.gmail.com>
 <ac922fd5-9438-4f73-9a3d-08cceb1d7409@denx.de>
 <Ztn+SiBUp0BC5lzy@lizhi-Precision-Tower-5810>
 <1a5114c5-92d1-4f5a-9ad6-616475f3ba56@denx.de>
 <ZtoWowx1Vja3yjXc@lizhi-Precision-Tower-5810>
 <e14fba9a-87e9-42a3-9be8-b2b48ed08cd0@denx.de>
 <Zt9PcsUg4CdMbpov@lizhi-Precision-Tower-5810>
Content-Language: en-US
In-Reply-To: <Zt9PcsUg4CdMbpov@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/9/24 9:41 PM, Frank Li wrote:

Hi,

[...]

>>> I will add it at next version. But I found a problem of your method,
>>> especially when period is quite long, for example 2s. Assume  FIFO is empty.
>>> [old, old, new] will be written to FIFO, new value will takes 2s-6s to make
>>> new value effect.
>>
>> You're right, for long PWM periods, the application of changes will take
>> longer.
>>
>> As far as I can tell, the method implemented in this patch may still suffer
>> from the problem in case of short PWM periods, is that correct ? I think the
>> writesl() might help cover some of that.
> 
> No way can fix very short periods problem because period was shorter then
> register write speed.

What kind of period are we talking about here ? Since the FIFO has 4 
slots, I would expect way 4-8 MHz to be fixable still ?

> The register write go through ips bus, which is
> quit slow. writesl is equal to writel_relaxed and avoid a dmb(). This will
> be over1M hz and user generally use pwm around hz to khz.

I just had a look at the implementation of writel_relaxed() and yes, 
this is basically a 'str', good point.

>> Maybe for longer PWM periods (like 500ms and longer?) where we can be sure
>> the FIFO won't quickly consume the written data and underflow, we can do
>> writesl() with only two longwords {old_sar, new_sar}, first longword to make
>> sure the FIFO is not empty, second word with the new PWMSAR value ? That
>> could speed the update up ?
> 
> We should use this patch's method to read MX3_PWMCNR, if close enough,
> write two data into fifo instead of wait for new peroid start.

Can we guarantee that there would never be any scheduling or other delay 
between the readout of PWMCNR and write of the FIFO, one which would 
trigger an underflow ?

>>> The currect method, most time, the new value will effect at next period.
>> Yes, right, I think we may have to handle the longer PWM periods somehow
>> differently.
>>
>> I would like to avoid local_irq_save()/readl_poll_timeout_atomic() if
>> possible and let the hardware help avoid this, which I think is possible
>> with creative loading of the FIFO with data, hence the writesl() idea.
> 
> I think it hard to avoid local_irq_save() even use writesl(), writesl is
> not atomic,  if irq happen after first raw_write,  FIFO may be empty at
> next write.
> 
> actually, here have problem
> 
> 	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> 	^^^ if irq happen here, schedule happen, when schedule back,
> 
> 	FIFOAV value in hardware may less than MX3_PWMSR_FIFOAV_2WORDS, but
> 	previous read it bigger than MX3_PWMSR_FIFOAV_2WORDS, the below check
> 	will be false and skip workaround.
> 
> 	if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
> 
> 
> See patch v4
> https://lore.kernel.org/imx/20240909193855.2394830-1-Frank.Li@nxp.com/T/#u
> It should be little bit better.

I think the v4 is indeed better, thanks.

