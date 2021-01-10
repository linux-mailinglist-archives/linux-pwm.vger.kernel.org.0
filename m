Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269472F0894
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Jan 2021 18:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbhAJRPC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Sun, 10 Jan 2021 12:15:02 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:42430 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbhAJRPB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 10 Jan 2021 12:15:01 -0500
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id DD3584400C5;
        Sun, 10 Jan 2021 19:14:17 +0200 (IST)
References: <cover.1609917364.git.baruch@tkos.co.il>
 <22d1fe7b2137e3a2660ab2e6f1f127d41493fb16.1609917364.git.baruch@tkos.co.il>
 <20210107142953.ifg5yuy3dsblgsju@pengutronix.de>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/4] gpio: mvebu: fix pwm get_state period calculation
In-reply-to: <20210107142953.ifg5yuy3dsblgsju@pengutronix.de>
Date:   Sun, 10 Jan 2021 19:14:17 +0200
Message-ID: <87wnwkyas6.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for your review comments.

On Thu, Jan 07 2021, Uwe Kleine-König wrote:
> On Wed, Jan 06, 2021 at 09:37:37AM +0200, Baruch Siach wrote:
>> The period is the sum of on and off values.
>> 
>> Reported-by: Russell King <linux@armlinux.org.uk>
>> Fixes: 757642f9a584e ("gpio: mvebu: Add limited PWM support")
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>> v6: divide (on + off) sum to reduce rounding error (RMK)
>> ---
>>  drivers/gpio/gpio-mvebu.c | 19 ++++++++-----------
>>  1 file changed, 8 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
>> index 672681a976f5..a912a8fed197 100644
>> --- a/drivers/gpio/gpio-mvebu.c
>> +++ b/drivers/gpio/gpio-mvebu.c
>> @@ -676,20 +676,17 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
>>  	else
>>  		state->duty_cycle = 1;
>>  
>> +	val = (unsigned long long) u; /* on duration */
>>  	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
>> -	val = (unsigned long long) u * NSEC_PER_SEC;
>> +	val += (unsigned long long) u; /* period = on + off duration */
>> +	val *= NSEC_PER_SEC;
>>  	do_div(val, mvpwm->clk_rate);
>> -	if (val < state->duty_cycle) {
>> +	if (val > UINT_MAX)
>> +		state->period = UINT_MAX;
>
> state->period is an u64, so there is no reason to not use values greater
> than UINT_MAX.

I'll post a patch for that.

>> +	else if (val)
>> +		state->period = val;
>> +	else
>>  		state->period = 1;
>
> This case assigning 1 looks strange. An explanation in a comment would
> be great. I wonder if this is a hardware property or if it is only used
> to not report 0 in case that mvpwm->clk_rate is high.

I guess that this is because 0 period does not make sense for pwm. It is
like a zero divisor. What is the common behavior?

> I found a few further shortcommings in the mvebu_pwm implementation while
> looking through it:
>
>  a) The rounding problem that RMK found is also present in .apply
>
>     There we have:
>
>     	val = clk_rate * (period - duty_cycle) / NSEC_PER_SEC
>
>     while
>
>     	val = clk_rate * period / NSEC_PER_SEC - on
>
>     would be more exact.

I'll post a patch for that.

>  b) To make
>
>  	pwm_get_state(pwm, &state);
> 	pwm_apply_state(pwm, &state);
>
>     idempotent .get_state should round up the division results.

I'll post a patch for that as well.

>  c) .apply also has a check for val being zero and configures at least 1
>     cycle for the on and off intervals. Is this a hardware imposed
>     limitation? 

Not sure what was the original intention. Maybe Andrew can explain.

On my hardware (Armada 8040), zero 'on' value does not work as
expected. There is a blink once in a long while. Maybe this is the
reason?

As I understand, all these issues should not block this patch, right?

BTW, the key you used to sign your message is expired since 2020-01-10
on the key server I use (keys.gnupg.net). Where can I find your updated
key?

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
