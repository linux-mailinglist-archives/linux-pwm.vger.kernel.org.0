Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA42F4497
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 07:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbhAMGg5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 13 Jan 2021 01:36:57 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:45552 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbhAMGg5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 13 Jan 2021 01:36:57 -0500
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id B346E440045;
        Wed, 13 Jan 2021 08:36:12 +0200 (IST)
References: <cover.1610362661.git.baruch@tkos.co.il>
 <e3afc6e297e495322971c26a79c6f841d5952fd1.1610362661.git.baruch@tkos.co.il>
 <20210111201711.ym46w7dy62ux66zb@pengutronix.de>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     g@pengutronix.de, Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] gpio: mvebu: fix pwm get_state period calculation
In-reply-to: <20210111201711.ym46w7dy62ux66zb@pengutronix.de>
Date:   Wed, 13 Jan 2021 08:36:12 +0200
Message-ID: <87ft35xs0z.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Jan 11 2021, Uwe Kleine-König wrote:
> $Subject ~= s/get_state/.get_state/ ?

Ack.

> On Mon, Jan 11, 2021 at 01:17:02PM +0200, Baruch Siach wrote:
>> The period is the sum of on and off values.
>> 
>> Reported-by: Russell King <linux@armlinux.org.uk>
>> Fixes: 757642f9a584e ("gpio: mvebu: Add limited PWM support")
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
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
>> +	else if (val)
>> +		state->period = val;
>> +	else
>>  		state->period = 1;
>> -	} else {
>> -		val -= state->duty_cycle;
>> -		if (val > UINT_MAX)
>> -			state->period = UINT_MAX;
>> -		else if (val)
>> -			state->period = val;
>> -		else
>> -			state->period = 1;
>> -	}
>
> The patch looks good, the patch description could be a bit more verbose.
> Something like:
>
> 	Calculate the period as
>
> 		($on + $off) / clkrate
>
> 	instead of
>
> 		$off / clkrate - $on / clkrate
>
> 	.

I take this to refer to the next patch (2/5). This patch changes from
buggy

  $on / clkrate

to

  ($on + $off) / clkrate

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
