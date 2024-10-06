Return-Path: <linux-pwm+bounces-3505-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E89920A9
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Oct 2024 21:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72121F217B0
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Oct 2024 19:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8DA18A6BF;
	Sun,  6 Oct 2024 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="cvFDF1C/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF447189B9C;
	Sun,  6 Oct 2024 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728242531; cv=none; b=VHB+IUdEKhMRM/HoKJ3vvPhOWEdgcplezQRYjdd1a06orMaiLtD1UyVt0zO0YdVbv8WdcSsPpsBjvXlBZ1tRkPw9OdSdiKnmT3MmyQcQuy4nmyAxcWrTyXh8YsRGjpEi1N1CQHyzimEp4UzSRs5SkIh/YoaEojCXp1CUILjrrIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728242531; c=relaxed/simple;
	bh=5Ej/roX0hBsFAsuY5HOV6xxMHJnnvuBYZnHZd7USqw8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pRDnBKDYKcedOtcZciv09nMb5Pv1gPAw80wS5oz/IKyRVjToEFPmkevKW3sbdXPE3hrB5T0GwFgclUAT0qk3QxeSt7ETlcaXaN2Eg6ulO4xCZ8ln+okwZO2WeP5VOFjVRfAEjbdp/Ebd7fVybIKnuelBig6FcnnaDWne0Q78WjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=cvFDF1C/; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7D66188896;
	Sun,  6 Oct 2024 21:13:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728241983;
	bh=k1vovXXkKC3Gh/6LzZZyo6822HUQ4nfaTQ3gBfRXD2Y=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=cvFDF1C/K/pRBgSKo3l20U3tN3baBrziLPXPbhNgvzGJQn91kg6xdJ8w3mUVg+EAd
	 BohABlcLOjzu9ZByMIc++xw4of1YNo7gC9k9adAEldbb4MeVqSJsvqoBgdIIbpXwAk
	 z3C07mq+LQPJ4SFhE+ack7nU/df25t9UXKoQkq3JyzKrPxJq14fHhuFboTpyYrXbvg
	 r4vDgB9zl3C9dfWXtL9mSwGyNv28359ao1tCtEb2dEVtFTBIMT2PMl7aH0ayKlXofn
	 mXGuECDKQosJgn9nu8MYwrefXg8T+cTxr+FGcOdnt3z3jB8H3GFzd5T82FawKXj7h3
	 GFsJPZiSrDhSA==
Message-ID: <1e6600a8-0b1a-472b-9f84-9b3c646a931a@denx.de>
Date: Sun, 6 Oct 2024 21:12:25 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v7 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Frank Li <Frank.Li@nxp.com>, conor+dt@kernel.org,
 devicetree@vger.kernel.org, festevam@gmail.com, francesco@dolcini.it,
 imx@lists.linux.dev, jun.li@nxp.com, kernel@pengutronix.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 p.zabel@pengutronix.de, pratikmanvar09@gmail.com, robh@kernel.org,
 s.hauer@pengutronix.de, shawnguo@kernel.org, xiaoning.wang@nxp.com
References: <20241004193531.673488-1-Frank.Li@nxp.com>
 <5cvzarqkldstuziokdbxxne75i35odexkcykzikyq2gm6ytdyd@5wkm7mhotgej>
 <4166d68c-5eca-406a-936f-412dd2ae72fc@denx.de>
 <gnlm4u7dc2aktycxzn4nqw3anzeit6tbtgcq7kv3pzbrorwg6o@h35yxit5y2a3>
Content-Language: en-US
In-Reply-To: <gnlm4u7dc2aktycxzn4nqw3anzeit6tbtgcq7kv3pzbrorwg6o@h35yxit5y2a3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/5/24 5:57 PM, Uwe Kleine-König wrote:
> On Sat, Oct 05, 2024 at 02:41:29AM +0200, Marek Vasut wrote:
>> On 10/4/24 10:58 PM, Uwe Kleine-König wrote:
>>
>> [...]
>>
>> Why not simply duplicate the ERRATA description for iMX8M Nano MX8MN_0N14Y
>> errata sheet ?
>>
>> "
>> [...]
>> "
>>
>> That is very clear to me.
> 
> Fine for me. Frank, do you want to try creating the right mix of the NXP
> text, your and my description?
> 
>>> 	/*
>>> 	 * At each clock tick the hardware compares the SAR value with
>>> 	 * the current counter. If they are equal the output is changed
>>> 	 * to the inactive level.
>>
>> I would skip this ^ part unless you can surely say the IP works exactly that
>> way because you checked the RTL.
> 
> That it works that way is clear from the errata text IMHO.

The errata description does not say anything about comparing SAR value 
on each clock tick. Better stick to exactly what the errata does say.

[...]

>>>> +	c = clkrate * 1500;
>>>> +	do_div(c, NSEC_PER_SEC);
>>>> +
>>>> +	local_irq_save(flags);
>>>> +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
>>>> +
>>>> +	if (duty_cycles < imx->duty_cycle) {
>>>> +		if (state->period < 2000) { /* 2000ns = 500 kHz */
>>>> +			/* Best effort attempt to fix up >500 kHz case */
>>>> +			udelay(6); /* 2us per FIFO entry, 3 FIFO entries written => 6 us */
>>>
>>> I don't understand the motivation to wait here. Wouldn't it be better to
>>> write the old value 3 - val times and not sleep?
>>
>> No, because you would overflow the FIFO, see:
>>
>> 137fd45ffec1 ("pwm: imx: Avoid sample FIFO overflow for i.MX PWM version2")
> 
> val holds the number of uses FIFO entries, so writing (3 - val) new
> items should be fine?!

Not necessarily, consider the case where:
- The PWM is very fast
- There are currently 3 entries in the FIFO according to driver state
- The driver determines 3-val is 1 and performs 1 single write to FIFO
=> If the PWM consumed the FIFO (FIFO is empty) before the 1 single
    write arrives, then the aforementioned errata still occurs

I believe the better option is to wait until the FIFO is surely depleted 
and then write three entries in short sequence -- OLD-OLD-NEW -- this 
way the FIFO would get updated with old value first and then switched to 
new value, hopefully mitigating the issue as best as possible even for 
fast PWM settings.

btw. the two writes here should be writing the old value twice, now 
there are three new value writes in this patch version.

>>> Or busy loop until
>>> MX3_PWMSR_FIFOAV becomes 0?
>>
>> Do we really want a busy wait here if we can avoid it ?
> 
> udelay(6) is a busy loop, so we're already there.
> 
>> We can do udelay(3 * state->period / 1000); so faster PWMs would wait
>> shorter.
> 
> state->period is the new value (and you want the old, right?), but
> otherwise I agree
Right

