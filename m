Return-Path: <linux-pwm+bounces-3109-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FEB96E1FF
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 20:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84585B25132
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 18:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE4B17C9B9;
	Thu,  5 Sep 2024 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Bf6L3a3f"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB516C84B;
	Thu,  5 Sep 2024 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560944; cv=none; b=fyB8y/7YBq9JEtxIMgXFle4aUOeH52a8IKlx1doZQ84lGBaJVWe6fGMmHyTQLWNn0LEygGlE1qNdBKDTAQF2CbD868jAkJF2FHfsqhXLX/EgJ+dajpo338H72/5kehsibwozf8DdVQ4uEJyWzmiLWbHYH07J3RxZxBepNDxyGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560944; c=relaxed/simple;
	bh=RzH7YeQcOe3cwiGwu/SoGWjxyZNxZtjC5k/biggfzXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyxqaIJGaV7kcPqmKxVGUSgZJXJ2sxIZq9AEbLZBCbXam/GCjEfA4ewTEYUeiiK3QqI9E20bgn19gRb9yFYb8ArpOt3Sw7YQQHob8xo9WM/VPIBdNxqNhHUiq4n7ZJ3nwJ3NfL7zLigjhLaLs+EIHxu9U5r1USdC8PV01u+uYmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Bf6L3a3f; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 143EB88CC1;
	Thu,  5 Sep 2024 20:28:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725560934;
	bh=mnlOn+20C49szsiIT5w0NLtAJkZUlNBplzPPTN3aoqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bf6L3a3fxGvrFbeBlQVDD22e37MRnlF57PgHKTw++RlIWFVbUCPjOxI2XrCYjhwoZ
	 aZLInovRZc3+5yj+OTid82sNwCuFlCzMF2Rizvg7PSj54C/c6QfGKS+vHNVFgusyJI
	 PBjZlU81KAPhyRZtBW688tJ2mRhyNOsXx1MpGao8FRLLgq+JoOMZJrcvl5j/bXW7mB
	 iY5scM0OWpc0pM2qX3nFqFMber/T7i+5b3SEUyXal9E+h8zoqlmAL72W9wqScYPSrn
	 A1YZs5glMXfF2ozlz0AG8IlONkyLO9bn9AtBvprNiVlfJRpbpwfOcYC+ohL/MgcNe2
	 bbbwz514h8l0w==
Message-ID: <ac922fd5-9438-4f73-9a3d-08cceb1d7409@denx.de>
Date: Thu, 5 Sep 2024 20:26:34 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
To: Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5DNmHfHWbLoPj9P=_+JiLLQ4tiDd_90+UX+_psN2o+Knw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/5/24 7:12 PM, Fabio Estevam wrote:
> Adding Marek.
> 
> On Mon, Jul 15, 2024 at 5:30 PM Frank Li <Frank.Li@nxp.com> wrote:
>>
>> From: Clark Wang <xiaoning.wang@nxp.com>
>>
>> Implement workaround for ERR051198
>> (https://www.nxp.com/docs/en/errata/IMX8MN_0N14Y.pdf)
>>
>> PWM output may not function correctly if the FIFO is empty when a new SAR
>> value is programmed
>>
>> Description:
>>    When the PWM FIFO is empty, a new value programmed to the PWM Sample
>>    register (PWM_PWMSAR) will be directly applied even if the current timer
>>    period has not expired. If the new SAMPLE value programmed in the
>>    PWM_PWMSAR register is less than the previous value, and the PWM counter
>>    register (PWM_PWMCNR) that contains the current COUNT value is greater
>>    than the new programmed SAMPLE value, the current period will not flip
>>    the level. This may result in an output pulse with a duty cycle of 100%.
>>
>> Workaround:
>>    Program the current SAMPLE value in the PWM_PWMSAR register before
>>    updating the new duty cycle to the SAMPLE value in the PWM_PWMSAR
>>    register. This will ensure that the new SAMPLE value is modified during
>>    a non-empty FIFO, and can be successfully updated after the period
>>    expires.

Frank, could you submit this patch separately ? The 1/3 and 2/3 are 
unrelated as far as I can tell ?

>> ---
>> Change from v1 to v2
>> - address comments in https://lore.kernel.org/linux-pwm/20211221095053.uz4qbnhdqziftymw@pengutronix.de/
>>    About disable/enable pwm instead of disable/enable irq:
>>    Some pmw periphal may sensitive to period. Disable/enable pwm will
>> increase period, althouhg it is okay for most case, such as LED backlight
>> or FAN speed. But some device such servo may require strict period.
>>
>> - address comments in https://lore.kernel.org/linux-pwm/d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net/
>>    Using official errata number
>>    fix typo 'filp'
>>    add {} for else
>>
>> I supposed fixed all previous issues, let me know if I missed one.
>> ---
>>   drivers/pwm/pwm-imx27.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
>> index 253afe94c4776..e12eaaebe3499 100644
>> --- a/drivers/pwm/pwm-imx27.c
>> +++ b/drivers/pwm/pwm-imx27.c
>> @@ -27,6 +27,7 @@
>>   #define MX3_PWMSR                      0x04    /* PWM Status Register */
>>   #define MX3_PWMSAR                     0x0C    /* PWM Sample Register */
>>   #define MX3_PWMPR                      0x10    /* PWM Period Register */
>> +#define MX3_PWMCNR                     0x14    /* PWM Counter Register */
>>
>>   #define MX3_PWMCR_FWM                  GENMASK(27, 26)
>>   #define MX3_PWMCR_STOPEN               BIT(25)
>> @@ -232,8 +233,11 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   {
>>          unsigned long period_cycles, duty_cycles, prescale;
>>          struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
>> +       void __iomem *reg_sar = imx->mmio_base + MX3_PWMSAR;
>>          unsigned long long c;
>>          unsigned long long clkrate;
>> +       unsigned long flags;
>> +       int val;
>>          int ret;
>>          u32 cr;
>>
>> @@ -274,7 +278,53 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>                  pwm_imx27_sw_reset(chip);
>>          }
>>
>> -       writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>> +       /*
>> +        * This is a limited workaround. When the SAR FIFO is empty, the new
>> +        * write value will be directly applied to SAR even the current period
>> +        * is not over.
>> +        *
>> +        * If the new SAR value is less than the old one, and the counter is
>> +        * greater than the new SAR value, the current period will not filp
>> +        * the level. This will result in a pulse with a duty cycle of 100%.
>> +        * So, writing the current value of the SAR to SAR here before updating
>> +        * the new SAR value can avoid this issue.
>> +        *
>> +        * Add a spin lock and turn off the interrupt to ensure that the
>> +        * real-time performance can be guaranteed as much as possible when
>> +        * operating the following operations.
>> +        *
>> +        * 1. Add a threshold of 1.5us. If the time T between the read current
>> +        * count value CNR and the end of the cycle is less than 1.5us, wait
>> +        * for T to be longer than 1.5us before updating the SAR register.
>> +        * This is to avoid the situation that when the first SAR is written,
>> +        * the current cycle just ends and the SAR FIFO that just be written
>> +        * is emptied again.
>> +        *
>> +        * 2. Use __raw_writel() to minimize the interval between two writes to
>> +        * the SAR register to increase the fastest pwm frequency supported.
>> +        *
>> +        * When the PWM period is longer than 2us(or <500KHz), this workaround
>> +        * can solve this problem.
>> +        */
>> +       val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
>> +       if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
>> +               c = clkrate * 1500;
>> +               do_div(c, NSEC_PER_SEC);
>> +
>> +               local_irq_save(flags);
>> +               if (state->period >= 2000)
>> +                       readl_poll_timeout_atomic(imx->mmio_base + MX3_PWMCNR, val,
>> +                                                 period_cycles - val >= c, 0, 10);
>> +
>> +               val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
>> +               if (!val)
>> +                       writel_relaxed(imx->duty_cycle, reg_sar);
>> +               writel_relaxed(duty_cycles, reg_sar);
>> +               local_irq_restore(flags);
>> +       } else {
>> +               writel_relaxed(duty_cycles, reg_sar);
>> +       }

Why so complicated ? Can't this be simplified to this ?

const u32 sar[3] = { old_sar, old_sar, new_sar };

val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + 
MX3_PWMSR));

switch (val) {
case MX3_PWMSR_FIFOAV_EMPTY:
case MX3_PWMSR_FIFOAV_1WORD:
   writesl(duty_cycles, sar, 3);
   break;
case MX3_PWMSR_FIFOAV_2WORDS:
   writesl(duty_cycles, sar + 1, 2);
   break;
default: // 3 words in FIFO
   writel(new_sar, duty_cycles);
}

The MX3_PWMSR_FIFOAV_EMPTY/MX3_PWMSR_FIFOAV_1WORD case will effectively 
trigger three consecutive 'str' instructions:

1: str PWMSAR, old_sar
2: str PWMSAR, old_sar
3: str PWMSAR, new_sar

If the PWM cycle ends before 1:, then PWM will reload old value, then 
pick old value from 1:, 2: and then new value from 3: -- the FIFO will 
never be empty.

If the PWM cycle ends after 1:, then PWM will pick up old value from 1: 
which is now in FIFO, 2: and then new value from 3: -- the FIFO will 
never be empty.

The MX3_PWMSR_FIFOAV_2WORDS and default: case is there to prevent FIFO 
overflow which may lock up the PWM. In case of MX3_PWMSR_FIFOAV_2WORDS 
there are two words in the FIFO, write two more, old SAR value and new 
SAR value. In case of default, there must be at least one free slot in 
the PWM FIFO because pwm_imx27_wait_fifo_slot() which polled the FIFO 
for free slot above, so there is no danger of FIFO being empty or FIFO 
overflow.

Maybe this can still be isolated to "if (duty_cycles < imx->duty_cycle)" .

What do you think ?

>>          writel(period_cycles, imx->mmio_base + MX3_PWMPR);

