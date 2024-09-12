Return-Path: <linux-pwm+bounces-3219-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F71975E1D
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 02:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF62285B13
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 00:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA171A288;
	Thu, 12 Sep 2024 00:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="mUVLP5gc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C93209;
	Thu, 12 Sep 2024 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102083; cv=none; b=tuAuRCVCj+Q+lrFpgbhXx6dJhZR6xLAs1mTfhYjKK/2/8xul9fFfjQNtAHMoxcXmlFOKiXOJ8niKa/MK31fCK+w1miwAqUYiyXGbfVmPFJMC7U03unJT22K8hQSniQVwikAbk/xyERyxZxKqvzTeplpTbeo++XT5L8DXpI0YEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102083; c=relaxed/simple;
	bh=0eysDtgRRa65JkJQOs3PKV4EUwS47bDFQDXpBNYg4Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/BaQbDtdqPAfvuNwvGPI40KrRagcjDsls3u2LQc9piBIwRF7CTrjAnXAZVJAuIgITJflXq3g31JdfXV+1Rm7X+2swA0JVsMw/5NqHDjb+a840roqgqJMWibymIRoSEDWqJBWtfj6klPvsC6HbTIxzxs19Q2ccZbKYMUQKh2Odw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=mUVLP5gc; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E65F788CEB;
	Thu, 12 Sep 2024 02:47:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726102080;
	bh=sc503OWPpPYu83ILRstAasVNUOftYWoZvWdM7aKBsdY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mUVLP5gcJk4q+oo5qPmwe6keLWLN7aA1RO/qVVZHwoUPcwuyq8YzhmHxr+5DvR/C5
	 j6W4MRX3JC5JzkHrWf6m3zXxhxmwNpRCSgOFq20AoVg58np5OBOU2B2t6r2xOWcmFP
	 1LtXyMdIJ85doT/PXT6oSX7GSBNoKGTahQiTvh/iRazNHsTlOeLPmg/NFieWo5uNr0
	 LiH6zJXbKj5lO9iCQoj1falZkb82Fdm+R62L3zz1zeWIdd/yi184am+Tf+UbM6oLB4
	 FaiZcHUiE4ox2HIqFS4GFozib3cnnmxoMd3bI99ciUzPWAsPgASTt1JxU0m5Gba5aU
	 C+Y5KeDhqPmng==
Message-ID: <0c69242f-7ce6-463a-b704-a5c0b94389cf@denx.de>
Date: Thu, 12 Sep 2024 02:22:15 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
To: Frank Li <Frank.li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
 francesco@dolcini.it, imx@lists.linux.dev, jun.li@nxp.com,
 kernel@pengutronix.de, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, p.zabel@pengutronix.de, pratikmanvar09@gmail.com,
 robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
 ukleinek@kernel.org, xiaoning.wang@nxp.com
References: <20240910152455.2425152-1-Frank.Li@nxp.com>
 <f42fefb6-2815-4f74-b403-fecd2aa79688@denx.de>
 <ZuIR04pr59mepdBB@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZuIR04pr59mepdBB@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/11/24 11:55 PM, Frank Li wrote:

Hi,

>>> This only resolves the issue when the PWM period is longer than 2us
>>> (or <500KHz) because write register is not quick enough when PWM period is
>>> very short.
>>
>> You did mention the IPS bus is slow. Do I understand it correctly that the
>> IPS bus write takes about 1us ? Because of the PWM consumes a sample every
>> 2us and we need to write 2 samples to avoid FIFO underrun, then to safely
>> write those 2 samples, we need to be able to write 1 sample per 1 us into
>> the FIFO ?
> 
> The above time is just estimated, which variance at difference platform and
> impact by other IPs. If there are pending write/read from GPIO, PWM write
> have to wait for GPIO's write finish. It actually depend on IPS bus's
> loading.
> 
> <500Khz is very less possiblity that write slower than PWM's consumes.
> 
>>
>> Also, would writing more samples help with such "fast" use cases ?
>> Something like this:
>>
>> if (clkrate > 500000) {
>>    // This usleep() could use some further improvement, e.g. calculate
>>    // precise delay for the FIFO to get empty based on PWM clkrate
>>    usleep(2 * 5); // wait 2us for each of the 4 samples in FIFO and a bit
>>    // Now the FIFO is surely empty, write all four FIFO slots
>>    writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
>>    writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
>>    writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
>>    writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
> 
> It can help at some possiblity, but still have problem if > 1Mhz, write
> will always less than consume.
> 
> If errata happen, only 1 cycle is full high. I think it is quite less
> impact at such high frequency.
> 
> We found this problem by observe a screen backlight flick when change
> ducty_cycle. I think we try fix it after a real user visible impact happen.

Indeed, I observed similar problem.

> Put code here can reduce some possiblity at certain freq range, but may
> miss-leading user the problem fixed when > 500k.

You already have good code comments, maybe expanding one would help 
clarify this issue cannot really be fully fixed with current hardware.

I think the multi-write for > 500 kHz could further improve the patch, 
but let's wait for input from others, let's see what they think.

