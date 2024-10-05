Return-Path: <linux-pwm+bounces-3486-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B28991391
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 02:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82381F21F55
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 00:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC864C7C;
	Sat,  5 Oct 2024 00:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Yl4sbFGH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04797182;
	Sat,  5 Oct 2024 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728088964; cv=none; b=kwiQsr4XfnDGXDFEpLtfTIyuxypq+xRvphNhNtR7+Hl+KtN7n4q6rBvKyxEHLH0cBIGaMY2k+Hni/HJIQ+rOPefhYI2hgXz+1abevXu0Lt6djcGzZN9UVSeJnKDxx66xf9s8iWqbPa/f3eh7gqGwjwJ6RaSEJRsWfuvlzQcBEHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728088964; c=relaxed/simple;
	bh=Ie/XQKbbsSR4D1iycCkYUWZ0G1cgjLVrrylLn+TcNoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT5rPKDfJKBG7ysAlbUl054onvBOwf4aJT+tFTYQnf7MXyjbATlv6zU5fH30KfD1d8rF94LnZcsaoDZDig7UYB/+I51kT7kplOsKN0+9hsjSs1fSThIQhYRWLH1UAxC49P2KP0BoCWYilXVGIQ+8gxj1oNftzsH2mIDoMxT4r/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Yl4sbFGH; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E99AB886DF;
	Sat,  5 Oct 2024 02:42:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728088960;
	bh=WAlganDHVley7ZzJIIV/eYDB7QCfZKEuedzG4few7pU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yl4sbFGHy7P6Uvuq8TsiS5SQZx4pBiuGMXIy/ORX5r1NG6KFbr6cMfUJPvV0DpViX
	 k8SGyAZkhLRKIhg5DcalNvj2PvTQt+X0dwcTbMJdYpjK9U8Px3V8UuYtFzoJ2Lm8Kl
	 YlQw7mWKdAKFaLqovVZD/yEG4BntIR92Bh3WzZhuKBze6Hvwcw0jKPDCXkNInHmX56
	 Rdc0EpmMnTt30ZcHbKyzVMNZsIFmfZzbR/IjEUy748cUakqgAhwhc1PyaziWq8aQ3l
	 BRQODyEfukPWa/fHotGUdMRO69N5jSbSZsOF5wtspYc4yxkI5aHyc3NU3EE90q31sg
	 wY1Iqo6sVDJ4w==
Message-ID: <4166d68c-5eca-406a-936f-412dd2ae72fc@denx.de>
Date: Sat, 5 Oct 2024 02:41:29 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
 francesco@dolcini.it, imx@lists.linux.dev, jun.li@nxp.com,
 kernel@pengutronix.de, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, p.zabel@pengutronix.de, pratikmanvar09@gmail.com,
 robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
 xiaoning.wang@nxp.com
References: <20241004193531.673488-1-Frank.Li@nxp.com>
 <5cvzarqkldstuziokdbxxne75i35odexkcykzikyq2gm6ytdyd@5wkm7mhotgej>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <5cvzarqkldstuziokdbxxne75i35odexkcykzikyq2gm6ytdyd@5wkm7mhotgej>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/4/24 10:58 PM, Uwe Kleine-König wrote:

[...]

>> @@ -263,7 +266,77 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   		pwm_imx27_sw_reset(chip);
>>   	}
>>   
>> -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>> +	/*
>> +	 * This is a limited workaround. When the SAR FIFO is empty, the new
>> +	 * write value will be directly applied to SAR even the current period
>> +	 * is not over.
>> +	 *
>> +	 *           ─────────────────────┐
>> +	 * PWM OUTPUT                     │
>> +	 *                                └─────────────────────────
>> +	 *
>> +	 *           ┌──────────────────────────────────────────────┐
>> +	 * Counter   │       XXXXXXXXXXXXXX                         │
>> +	 *           └──────────────────────────────────────────────┘
>> +	 *                   ▲            ▲
>> +	 *                   │            │
>> +	 *                 New SAR      Old SAR
>> +	 *
>> +	 *           XXXX  Errata happen window
> 
> Hmm, ok, so SAR is the register value that implements the duty cycle
> setting. And if a new SAR is written, it is directly applied to the
> hardware and this way it can happen (if SAR_new < counter < SAR_old)
> that no falling edge happens in the current period. Right?

Yes

> If so, I think the depicted PWM output is misleading. I'd describe and
> picture it as follows:

Why not simply duplicate the ERRATA description for iMX8M Nano 
MX8MN_0N14Y errata sheet ?

"
ERR051198:
PWM: PWM output may not function correctly if the FIFO is empty when a 
new SAR value is programmed

Description:
When the PWM FIFO is empty, a new value programmed to the PWM Sample 
register (PWM_PWMSAR) will be directly applied even if the current timer 
period has not expired.

If the new SAMPLE value programmed in the PWM_PWMSAR register is less 
than the previous value, and the PWM counter register (PWM_PWMCNR) that 
contains the current COUNT value is greater than the new programmed 
SAMPLE value, the current period will not flip the level. This may 
result in an output pulse with a duty cycle of 100%.
"

That is very clear to me.

> 	/*
> 	 * At each clock tick the hardware compares the SAR value with
> 	 * the current counter. If they are equal the output is changed
> 	 * to the inactive level.

I would skip this ^ part unless you can surely say the IP works exactly 
that way because you checked the RTL.

> As a new SAR value is applied
> 	 * immediately to the currently running period, it can happen
> 	 * that no falling edge happens in a period and so the output is
> 	 * active for a whole period. Consider a change from
>           *     ________
> 	 *    /        \______/
>           *    ^      *        ^
> 	 * to
>           *     ____
> 	 *    /    \__________/
>           *    ^               ^
> 	 *
> 	 * where SAR is written at the time marked by *. The counter
> 	 * didn't reach the old (bigger) value because it was changed
> 	 * before the counter reached that value and when the new value
> 	 * becomes active it is already lower than the current counter
> 	 * and so doesn't trigger either while the counter continues to
> 	 * grow. So the resulting waveform looks as follows:
> 	 *
>           *     ________        ____________________
> 	 *    /        \______/                    \__________/
>           *    ^               ^      *        ^               ^
> 	 *    |<-- old SAR -->|               |<-- new SAR -->|
> 	 *
> 	 * that is the output is active for a whole period.

The ascii/infographics is nice and would be good to keep, but regarding 
the description, frankly, the NXP errata description says the same thing 
in fewer words :)

> 	 */
> 
>> +	 *
>> +	 * If the new SAR value is less than the old one, and the counter is
>> +	 * greater than the new SAR value (see above diagram XXXX), the current
>> +	 * period will not flip the level. This will result in a pulse with a
>> +	 * duty cycle of 100%.
>> +	 *
>> +	 * Check new SAR less than old SAR and current counter is in errata
>> +	 * windows, write extra old SAR into FIFO and new SAR will effect at
>> +	 * next period.
>> +	 *
>> +	 * Sometime period is quite long, such as over 1 second. If add old SAR
>> +	 * into FIFO unconditional, new SAR have to wait for next period. It
>> +	 * may be too long.
>> +	 *
>> +	 * Turn off the interrupt to ensure that not IRQ and schedule happen
>> +	 * during above operations. If any irq and schedule happen, counter
>> +	 * in PWM will be out of data and take wrong action.
>> +	 *
>> +	 * Add a safety margin 1.5us because it needs some time to complete
>> +	 * IO write.
>> +	 *
>> +	 * Use __raw_writel() to minimize the interval between two writes to
>> +	 * the SAR register to increase the fastest PWM frequency supported.
>> +	 *
>> +	 * When the PWM period is longer than 2us(or <500kHz), this workaround
>> +	 * can solve this problem. No software workaround is available if PWM
>> +	 * period is shorter than IO write.
>> +	 */
>> +	c = clkrate * 1500;
>> +	do_div(c, NSEC_PER_SEC);
>> +
>> +	local_irq_save(flags);
>> +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
>> +
>> +	if (duty_cycles < imx->duty_cycle) {
>> +		if (state->period < 2000) { /* 2000ns = 500 kHz */
>> +			/* Best effort attempt to fix up >500 kHz case */
>> +			udelay(6); /* 2us per FIFO entry, 3 FIFO entries written => 6 us */
> 
> I don't understand the motivation to wait here. Wouldn't it be better to
> write the old value 3 - val times and not sleep?

No, because you would overflow the FIFO, see:

137fd45ffec1 ("pwm: imx: Avoid sample FIFO overflow for i.MX PWM version2")

> Or busy loop until
> MX3_PWMSR_FIFOAV becomes 0?

Do we really want a busy wait here if we can avoid it ?

We can do udelay(3 * state->period / 1000); so faster PWMs would wait 
shorter.

The delay is here to basically wait until the FIFO is surely empty and 
has space for 3 consecutive writes (see the commit above wrt. FIFO 
overflow).

[...]

