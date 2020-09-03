Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9125C4EA
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Sep 2020 17:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgICPUa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Sep 2020 11:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgICL1B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Sep 2020 07:27:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B794C061249
        for <linux-pwm@vger.kernel.org>; Thu,  3 Sep 2020 04:18:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so2746929wrl.12
        for <linux-pwm@vger.kernel.org>; Thu, 03 Sep 2020 04:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CQ15tirZpKA58Rq11JF7jkdfBFgYHMCtFMxo14MKJgM=;
        b=yAdaap5PB+hSEk2DOwQJho56yttfPUEvELhdmmRyS1aWA6/G07iA1d7B1Aiag5yyRb
         HBGOzpOR+7eQ1duXllObstGDJ2QrVCfgjTKWh/B5vovtTRM8OkuIkQUL9AhBTOrjZa+k
         pHHXVEAAZgVR65CNlQhE3F4r74LGaJi72lU8XEOKQ+t+i/pI85BoWmmvEPFkjWMSoLYw
         Y0zToNSt3UUvWnoGvHkaTgDQDdqPmMhmbOWHsrcJMzCrxqwLEpy6tjCD/6Qvz2ccy9K2
         zUijigOpVuxEOqKwN7rrTA89Q0657lSLVrciP+dal70DXma2u0aUNkHoQd9jyF+xtZjs
         bM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CQ15tirZpKA58Rq11JF7jkdfBFgYHMCtFMxo14MKJgM=;
        b=guVcW+dxtYVa+r7KYOPguLbzszfaumNQw4jvOyiozwXl/9pMrZZb7rbE2+8SPx4u4U
         aHgwqlZjCd0RKF8qSsyCU52rWkGyQ+kr3w7+Eh3w/MOTBIsXmWF/1LMcFAmORpm/GFCG
         v39CKAVzSuvwyaUIkHVajgYoHRkU807ip833f0NUXwO6OCbpxvph5/5PJFutAarkGtg6
         poW5zM08vvqVPKVebq4OXajUa1suUee82QJ6810x7N3qqjk9QN59BEqV887wYQvycK57
         RQqyx1o8SCTW9O+qzuWsHhAUucVB7RKWJwe3QNP5jCVTCnlR+eaTZxm5CBqNi/h8hi2n
         s2Ww==
X-Gm-Message-State: AOAM531HJfTTgAO85o5E18MQXB2cGdZL8iLOK7Qat2KQ/gR1fs/rfvKz
        MD8QJUIyaHL6iKIvcVrtgJ8M4Q==
X-Google-Smtp-Source: ABdhPJzuiRVyOaDLzC9V5jdoMTdPgH3/zYN54my371UhAdkbgzHKgI9i0auo3zIk0dt7BttnIX+osg==
X-Received: by 2002:adf:e7ca:: with SMTP id e10mr1860353wrn.236.1599131923615;
        Thu, 03 Sep 2020 04:18:43 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z14sm3706113wrh.14.2020.09.03.04.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 04:18:42 -0700 (PDT)
Date:   Thu, 3 Sep 2020 12:18:40 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     Andrey Lebedev <andrey@lebedev.lt>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Emil Lenngren <emil.lenngren@gmail.com>
Subject: Re: pwm-sun4i: PWM backlight is not turned off on shutdown
Message-ID: <20200903111840.vkjevwmwarx2txhe@holly.lan>
References: <ae58976c-a8d7-0d00-fe72-d21579b37240@lebedev.lt>
 <20200902095402.pombrirqqjdew34b@holly.lan>
 <913a5324-a7d2-f1d5-701e-1c28359286f2@lebedev.lt>
 <5302741318a28e39239db08a1f05ecb7@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5302741318a28e39239db08a1f05ecb7@pascalroeleven.nl>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 02, 2020 at 09:42:49PM +0200, Pascal Roeleven wrote:
> Thank you for adding me. Emil (also added now) and I spent a while on trying
> to figure out how to solve this. The Allwinner PWM controller has some
> quirks.
> 
> Unfortunately I never got around to perform some more tests and fix it
> indefinitely. It's still on my todo list..
> 
> > On 9/2/20 12:54 PM, Daniel Thompson wrote:
> > > There's some rather odd logic in sun4i_pwm_apply() that results in the
> > > PWM being disabled twice... once when it applies the initial config
> > > and again after waiting for a duty_cycle.
> 
> That's true. To properly turn off the controller you have to turn the
> controller off first and keep the gate on for at least two full clock
> cycles. Then the gate must be turned off. Otherwise it might get stuck.
> That's probably what is trying to be done here.
> 
> On 2020-09-02 21:05, Andrey Lebedev wrote:
> > Indeed, this fixes the issue for me. The display goes dark reliably on
> > writing 4 to "/sys/.../bl_power" as well as when system is halted. I did
> > not notice any negative side effects so far.
> 
> Problems start to arise when combining bl_power and brightness setting in a
> particular order or at the same time (with for example a backlight driver
> which sets both bl_power and brightness). I can't recall exactly what caused
> problems and when, but one thing I was sure of is that timing was of the
> essence. Once I added some delays here and there it started to work.
> 
> If this patch works for you then that's great, but unfortunately it isn't a
> complete solution.

Forgive my poking but it does look to me like Andrey may have a point
about d3817a647059 ("pwm: sun4i: Remove redundant needs_delay").

I've not got this hardware so I can't comment on whether the current
code is correct or not. However, after reviewing d3817a647059, it is
certainly looks like the patch does not actually implement what the
patch description says it does. In fact, by activating previously
unreachable code, it appears to introduces exactly the regression
described by Andrey.


> From d3817a647059a3e5f8791e9b7225d194985aa75f Mon Sep 17 00:00:00 2001
> From: Pascal Roeleven <dev@pascalroeleven.nl>
> Date: Tue, 17 Mar 2020 16:59:03 +0100
> Subject: [PATCH] pwm: sun4i: Remove redundant needs_delay
> 
> 'needs_delay' does now always evaluate to true, so remove all
> occurrences.

In other words, all paths that test !needs_delay[pwm->hwpwm] are
unreachable...


> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 3e3efa6c768f..5c677c563349 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -90,7 +90,6 @@ struct sun4i_pwm_chip {
>  	spinlock_t ctrl_lock;
>  	const struct sun4i_pwm_data *data;
>  	unsigned long next_period[2];
> -	bool needs_delay[2];
>  };
>  
>  static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
> @@ -287,7 +286,6 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
>  	sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
>  		usecs_to_jiffies(cstate.period / 1000 + 1);
> -	sun4i_pwm->needs_delay[pwm->hwpwm] = true;
>  
>  	if (state->polarity != PWM_POLARITY_NORMAL)
>  		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
> @@ -298,7 +296,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	if (state->enabled) {
>  		ctrl |= BIT_CH(PWM_EN, pwm->hwpwm);
> -	} else if (!sun4i_pwm->needs_delay[pwm->hwpwm]) {
> +	} else {

... but this previously unreachable path will now be executed
if state->enabled is false.

>  		ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
>  		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
>  	}
> @@ -310,15 +308,9 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	if (state->enabled)
>  		return 0;
>  
> -	if (!sun4i_pwm->needs_delay[pwm->hwpwm]) {
> -		clk_disable_unprepare(sun4i_pwm->clk);
> -		return 0;
> -	}
> -

This unreachable path is correctly removed.

>  	/* We need a full period to elapse before disabling the channel. */
>  	now = jiffies;
> -	if (sun4i_pwm->needs_delay[pwm->hwpwm] &&

This unconditionally true expression is also correctly removed.

In short this patch changes behaviour in a manner that could not be
predicted from the patch description.


Daniel.


> -	    time_before(now, sun4i_pwm->next_period[pwm->hwpwm])) {
> +	if (time_before(now, sun4i_pwm->next_period[pwm->hwpwm])) {

>  		delay_us = jiffies_to_usecs(sun4i_pwm->next_period[pwm->hwpwm] -
>  					   now);
>  		if ((delay_us / 500) > MAX_UDELAY_MS)
> @@ -326,7 +318,6 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		else
>  			usleep_range(delay_us, delay_us * 2);
>  	}
> -	sun4i_pwm->needs_delay[pwm->hwpwm] = false;
>  
>  	spin_lock(&sun4i_pwm->ctrl_lock);
>  	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);

