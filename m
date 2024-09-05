Return-Path: <linux-pwm+bounces-3112-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB0396E2C2
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 21:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE121C219DB
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 19:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E27A18D627;
	Thu,  5 Sep 2024 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="uQYq59Y/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C33158DC8;
	Thu,  5 Sep 2024 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563395; cv=none; b=lYnnKLD2NCwTSQw0X961dJh6FDOEuRcYEx1fQOWx6ffOasIogOZtMtaOlFOg6xgbHOJ+wmfwofsvh4hOktZIc/phsrfuvK9gnt8HZNEJeSSGuPtFn3AUNZnHTdma3A+4BHvSo6FTFw6TWZ1jtU47iQvvV4dp1h0ZC24KXuQY7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563395; c=relaxed/simple;
	bh=GrkSvGc83gmOa+ZfzM3uLj86ulug8IfnV8jKz9sInjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEpBcaFmyyeWa4TJ1D72gn0fcTpVOI5WgeP+L7Bov7vDAT5NT36M0U0bnvleRhOApCm5Zl9+Kt17bguyhEblMu9U8YThA1U0hWvrVIFNb2WMARqwXXZcGwoV8VgU+kk71Xt7EhK4xgCXyK67eu+mGH1z4WxqzQ9D//TWcdLxgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=uQYq59Y/; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2EE4C88BD6;
	Thu,  5 Sep 2024 21:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725563391;
	bh=edm4F86Hk2qklkmhJHHSmSvMydQmT4S2HIAG+u+hZ1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uQYq59Y/ONuJJUHV1/P7Mc42bMIsefHvm8V+NrdSYjgwJWVo0UabBeixP/G+jRKGZ
	 jugMbbFBeE8rNqnflqv5UyOMVkbB7SShhhfoSJCgsMb9hQJpICAn8t379Gkd9xM/TG
	 H84ct/bz/lV7Y/xPA8qoOa67FRLLR1Fj5ZXLRlevCcYBMbshmdVQoY3iX8a5kzE3OG
	 xIPFmMDBudiKoOrM6sDUqJyPOfWuuyoxEAPkH1THz5TmJm83L4UrCMLfwZodsixPBA
	 qZBq1dJDFt4Fqzrlr5ZjXVJ2oraPjH2adULbz8VXGOwGTwQeSF5qh4Q+qTVgQqrkT9
	 78qUQt7AoePYQ==
Message-ID: <1a5114c5-92d1-4f5a-9ad6-616475f3ba56@denx.de>
Date: Thu, 5 Sep 2024 21:01:06 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <Ztn+SiBUp0BC5lzy@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/5/24 8:54 PM, Frank Li wrote:
> On Thu, Sep 05, 2024 at 08:26:34PM +0200, Marek Vasut wrote:
>> On 9/5/24 7:12 PM, Fabio Estevam wrote:
>>> Adding Marek.
>>>
>>> On Mon, Jul 15, 2024 at 5:30 PM Frank Li <Frank.Li@nxp.com> wrote:
>>>>
>>>> From: Clark Wang <xiaoning.wang@nxp.com>
>>>>
>>>> Implement workaround for ERR051198
>>>> (https://www.nxp.com/docs/en/errata/IMX8MN_0N14Y.pdf)
>>>>
>>>> PWM output may not function correctly if the FIFO is empty when a new SAR
>>>> value is programmed
>>>>
>>>> Description:
>>>>     When the PWM FIFO is empty, a new value programmed to the PWM Sample
>>>>     register (PWM_PWMSAR) will be directly applied even if the current timer
>>>>     period has not expired. If the new SAMPLE value programmed in the
>>>>     PWM_PWMSAR register is less than the previous value, and the PWM counter
>>>>     register (PWM_PWMCNR) that contains the current COUNT value is greater
>>>>     than the new programmed SAMPLE value, the current period will not flip
>>>>     the level. This may result in an output pulse with a duty cycle of 100%.
>>>>
>>>> Workaround:
>>>>     Program the current SAMPLE value in the PWM_PWMSAR register before
>>>>     updating the new duty cycle to the SAMPLE value in the PWM_PWMSAR
>>>>     register. This will ensure that the new SAMPLE value is modified during
>>>>     a non-empty FIFO, and can be successfully updated after the period
>>>>     expires.
>>
>> Frank, could you submit this patch separately ? The 1/3 and 2/3 are
>> unrelated as far as I can tell ?
>>
>>>> ---
>>>> Change from v1 to v2
>>>> - address comments in https://lore.kernel.org/linux-pwm/20211221095053.uz4qbnhdqziftymw@pengutronix.de/
>>>>     About disable/enable pwm instead of disable/enable irq:
>>>>     Some pmw periphal may sensitive to period. Disable/enable pwm will
>>>> increase period, althouhg it is okay for most case, such as LED backlight
>>>> or FAN speed. But some device such servo may require strict period.
>>>>
>>>> - address comments in https://lore.kernel.org/linux-pwm/d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net/
>>>>     Using official errata number
>>>>     fix typo 'filp'
>>>>     add {} for else
>>>>
>>>> I supposed fixed all previous issues, let me know if I missed one.
>>>> ---
>>>>    drivers/pwm/pwm-imx27.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 51 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
>>>> index 253afe94c4776..e12eaaebe3499 100644
>>>> --- a/drivers/pwm/pwm-imx27.c
>>>> +++ b/drivers/pwm/pwm-imx27.c
>>>> @@ -27,6 +27,7 @@
>>>>    #define MX3_PWMSR                      0x04    /* PWM Status Register */
>>>>    #define MX3_PWMSAR                     0x0C    /* PWM Sample Register */
>>>>    #define MX3_PWMPR                      0x10    /* PWM Period Register */
>>>> +#define MX3_PWMCNR                     0x14    /* PWM Counter Register */
>>>>
>>>>    #define MX3_PWMCR_FWM                  GENMASK(27, 26)
>>>>    #define MX3_PWMCR_STOPEN               BIT(25)
>>>> @@ -232,8 +233,11 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>    {
>>>>           unsigned long period_cycles, duty_cycles, prescale;
>>>>           struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
>>>> +       void __iomem *reg_sar = imx->mmio_base + MX3_PWMSAR;
>>>>           unsigned long long c;
>>>>           unsigned long long clkrate;
>>>> +       unsigned long flags;
>>>> +       int val;
>>>>           int ret;
>>>>           u32 cr;
>>>>
>>>> @@ -274,7 +278,53 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>                   pwm_imx27_sw_reset(chip);
>>>>           }
>>>>
>>>> -       writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>>>> +       /*
>>>> +        * This is a limited workaround. When the SAR FIFO is empty, the new
>>>> +        * write value will be directly applied to SAR even the current period
>>>> +        * is not over.
>>>> +        *
>>>> +        * If the new SAR value is less than the old one, and the counter is
>>>> +        * greater than the new SAR value, the current period will not filp
>>>> +        * the level. This will result in a pulse with a duty cycle of 100%.
>>>> +        * So, writing the current value of the SAR to SAR here before updating
>>>> +        * the new SAR value can avoid this issue.
>>>> +        *
>>>> +        * Add a spin lock and turn off the interrupt to ensure that the
>>>> +        * real-time performance can be guaranteed as much as possible when
>>>> +        * operating the following operations.
>>>> +        *
>>>> +        * 1. Add a threshold of 1.5us. If the time T between the read current
>>>> +        * count value CNR and the end of the cycle is less than 1.5us, wait
>>>> +        * for T to be longer than 1.5us before updating the SAR register.
>>>> +        * This is to avoid the situation that when the first SAR is written,
>>>> +        * the current cycle just ends and the SAR FIFO that just be written
>>>> +        * is emptied again.
>>>> +        *
>>>> +        * 2. Use __raw_writel() to minimize the interval between two writes to
>>>> +        * the SAR register to increase the fastest pwm frequency supported.
>>>> +        *
>>>> +        * When the PWM period is longer than 2us(or <500KHz), this workaround
>>>> +        * can solve this problem.
>>>> +        */
>>>> +       val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
>>>> +       if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
>>>> +               c = clkrate * 1500;
>>>> +               do_div(c, NSEC_PER_SEC);
>>>> +
>>>> +               local_irq_save(flags);
>>>> +               if (state->period >= 2000)
>>>> +                       readl_poll_timeout_atomic(imx->mmio_base + MX3_PWMCNR, val,
>>>> +                                                 period_cycles - val >= c, 0, 10);
>>>> +
>>>> +               val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
>>>> +               if (!val)
>>>> +                       writel_relaxed(imx->duty_cycle, reg_sar);
>>>> +               writel_relaxed(duty_cycles, reg_sar);
>>>> +               local_irq_restore(flags);
>>>> +       } else {
>>>> +               writel_relaxed(duty_cycles, reg_sar);
>>>> +       }
>>
>> Why so complicated ? Can't this be simplified to this ?
>>
>> const u32 sar[3] = { old_sar, old_sar, new_sar };
>>
>> val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base +
>> MX3_PWMSR));
>>
>> switch (val) {
>> case MX3_PWMSR_FIFOAV_EMPTY:
>> case MX3_PWMSR_FIFOAV_1WORD:
>>    writesl(duty_cycles, sar, 3);
>>    break;
>> case MX3_PWMSR_FIFOAV_2WORDS:
>>    writesl(duty_cycles, sar + 1, 2);
>>    break;
>> default: // 3 words in FIFO
>>    writel(new_sar, duty_cycles);
>> }
>>
>> The MX3_PWMSR_FIFOAV_EMPTY/MX3_PWMSR_FIFOAV_1WORD case will effectively
>> trigger three consecutive 'str' instructions:
>>
>> 1: str PWMSAR, old_sar
>> 2: str PWMSAR, old_sar
>> 3: str PWMSAR, new_sar
>>
>> If the PWM cycle ends before 1:, then PWM will reload old value, then pick
>> old value from 1:, 2: and then new value from 3: -- the FIFO will never be
>> empty.
>>
>> If the PWM cycle ends after 1:, then PWM will pick up old value from 1:
>> which is now in FIFO, 2: and then new value from 3: -- the FIFO will never
>> be empty.
>>
>> The MX3_PWMSR_FIFOAV_2WORDS and default: case is there to prevent FIFO
>> overflow which may lock up the PWM. In case of MX3_PWMSR_FIFOAV_2WORDS there
>> are two words in the FIFO, write two more, old SAR value and new SAR value.
>> In case of default, there must be at least one free slot in the PWM FIFO
>> because pwm_imx27_wait_fifo_slot() which polled the FIFO for free slot
>> above, so there is no danger of FIFO being empty or FIFO overflow.
>>
>> Maybe this can still be isolated to "if (duty_cycles < imx->duty_cycle)" .
>>
>> What do you think ?
> 
> Reasonable. Let me test it.
Thank you.

I have MX8MN locally, so if you need RB/TB for V3, let me know.

Will I be able to reproduce it on another iMX too? Like MX8MP or MX8MM 
(they are a bit easier to work with for me) ?

Could you include "how to reproduce" in the commit message ? Something 
easy like:
- Write this and that sysfs attribute file with old value
- Write this and that sysfs attribute file with new value
- Observe this on a scope

