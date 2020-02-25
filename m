Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E7216B8A6
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2020 06:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgBYFCo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Feb 2020 00:02:44 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58312 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgBYFCo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2020 00:02:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P52ac2053449;
        Mon, 24 Feb 2020 23:02:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582606956;
        bh=uoXSKgnByoSIyANgjh0TvRzjJ2JfaEonET/CBdrACKI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZrUIO8oxRPhHQ/UrsnlZ9j+lv1oRrqFmukdQaROTMl+ucdy7VCFNZa/sAFZWg0gye
         /xBBaLV9vBf6n8ODqzxkBYxPijE2i4MNakLGssbon4Mizs1x1TgWImlKlkFguEDVQY
         H7jmhBwEQ5U6BrSI+SrSsaSwX5q63Z6Z8BZrPw34=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P52alq022879;
        Mon, 24 Feb 2020 23:02:36 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 23:02:36 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 23:02:36 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P52XGf093103;
        Mon, 24 Feb 2020 23:02:34 -0600
Subject: Re: [PATCH 4/4] pwm: omap-dmtimer: Implement .apply callback
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-5-lokeshvutla@ti.com>
 <20200224090706.xsujpc3yiqlmmrmm@pengutronix.de>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <cee31e10-17b4-1cfb-5c77-a58a142c338d@ti.com>
Date:   Tue, 25 Feb 2020 10:31:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200224090706.xsujpc3yiqlmmrmm@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 24/02/20 2:37 PM, Uwe Kleine-König wrote:
> On Mon, Feb 24, 2020 at 10:51:35AM +0530, Lokesh Vutla wrote:
>> Implement .apply callback and drop the legacy callbacks(enable, disable,
>> config, set_polarity).
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  drivers/pwm/pwm-omap-dmtimer.c | 141 +++++++++++++++++++--------------
>>  1 file changed, 80 insertions(+), 61 deletions(-)
>>

[..snip..]

>> -static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
>> -					 struct pwm_device *pwm,
>> -					 enum pwm_polarity polarity)
>> +/**
>> + * pwm_omap_dmtimer_apply() - Changes the state of the pwm omap dm timer.
>> + * @chip:	Pointer to PWM controller
>> + * @pwm:	Pointer to PWM channel
>> + * @state:	New sate to apply
>> + *
>> + * Return 0 if successfully changed the state else appropriate error.
>> + */
>> +static int pwm_omap_dmtimer_apply(struct pwm_chip *chip,
>> +				  struct pwm_device *pwm,
>> +				  const struct pwm_state *state)
>>  {
>>  	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
>> +	int ret = 0;
>>  
>> -	/*
>> -	 * PWM core will not call set_polarity while PWM is enabled so it's
>> -	 * safe to reconfigure the timer here without stopping it first.
>> -	 */
>>  	mutex_lock(&omap->mutex);
>> -	omap->pdata->set_pwm(omap->dm_timer,
>> -			     polarity == PWM_POLARITY_INVERSED,
>> -			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
>> +
>> +	if (pwm_is_enabled(pwm) && !state->enabled) {
> 
> In my book calling PWM API functions (designed for PWM consumers) is not
> so nice. I would prefer you checking the hardware registers or cache the
> state locally instead of relying on the core here.

.start and .stop apis does read the hardware registers and check the state
before making any changes. Do you want to drop off the pwm_is_enabled(pwm) check
here?

> 
> It would be great to have a general description at the top of the driver
> (like for example drivers/pwm/pwm-sifive.c) that answers things like:
> 
>  - Does calling .stop completes the currently running period (it
>    should)?

Existing driver implementation abruptly stops the cycle. I can make changes such
that it completes the currently running period.

>  - Does changing polarity, duty_cycle and period complete the running
>    period?

- Polarity can be changed only when the pwm is not running. Ill add extra guards
to reflect this behavior.
- Changing duty_cycle and period does complete the running period and new values
gets reflected in next cycle.

>  - How does the hardware behave on disable? (i.e. does it output the
>    state the pin is at in that moment? Does it go High-Z?)

Now that I am making changes to complete the current period on disable, the pin
goes to Low after disabling(completing the cycle).

Ill add all these points as you mentioned in v2.

Thanks and regards,
Lokesh
