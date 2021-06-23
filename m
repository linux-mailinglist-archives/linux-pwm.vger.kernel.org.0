Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9803B23DF
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jun 2021 01:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFWXKy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Jun 2021 19:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFWXKx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Jun 2021 19:10:53 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C722AC061574
        for <linux-pwm@vger.kernel.org>; Wed, 23 Jun 2021 16:08:35 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id m6-20020a9d1d060000b029044e2d8e855eso1684861otm.8
        for <linux-pwm@vger.kernel.org>; Wed, 23 Jun 2021 16:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=spxLzNl1WczKhSgIfE+tUewWWbh43cgGhLoKHWyLKZ0=;
        b=iuozrOOoCE/N/EoJiaTPeujMmDMEO1+OsjhIi0qUZZtUSOBL7bCAMytTOQwII3kxtj
         EocmDDErMJsf+SF4L32YeKn+NWmkF9eWX7Ik47iQf+DhEM6Mv3W/T2qyDdSiyIiZ+YLo
         R98kViqyWxUYIxUG6A49rYiWMJOWCH/S2gwK+3tMmqmGNV64JQ4LueQjP4NCtdNxA6m9
         p67P2oBCMe35qyiMLMU6GGIQScqSEiGHguf1ZwaYCWyJe37lkg0yZoe59dJKQvA+eKxH
         6xIe7+vmxRPqsVoIoNKQlLazUi8JgpHRnSBCX/tnrV9qQnu+8xLldO9rERJuRJbTG9zT
         IjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=spxLzNl1WczKhSgIfE+tUewWWbh43cgGhLoKHWyLKZ0=;
        b=Vt6hsKftzPspU50hcvL666VPzlM77rlUYc1QBV0DnJmS37Y3RqfH4YXDLODSZAEmsi
         27sbjaJQ7T/1JihQQHkD5eD/PcgE31P7+x5diIH3AWnoG0oGCuotLdVkLYLAAQZYU9IK
         ZjbYBwzuz7A3wvxBfpvMv41iecFKhtcWAd8KgCdqnj2DEpJ9F7ZnTLWzRLBJaTG5m8jM
         ss46bAd0icylWsEd7zN4D/UK0j/tq4jwB4yn3adwSWprVd31+6TSuZOGbBN5N8HEb3WT
         AhngQt6s6cEaZ+prNKKR4gpaoxcCPvPQhX6yu21OUyZJH8IUPU8O83e0f3esZHMHMXXS
         Xbdg==
X-Gm-Message-State: AOAM5305Ch35sHPPVcbfc9TiBnDVQKGelnOar+QzgKr+kd4oLaoMhkAw
        LLpsu0tq4f3n1BoU/z17tRFqvQ==
X-Google-Smtp-Source: ABdhPJzlupqIzZNLgzUsHCrQc+Hev5LzkJzbQ4wOxzz2WYqXSipiFwuA79uRGLXjx7X070vwOwSNWw==
X-Received: by 2002:a9d:589:: with SMTP id 9mr1972661otd.65.1624489715030;
        Wed, 23 Jun 2021 16:08:35 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v203sm286256oib.37.2021.06.23.16.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 16:08:34 -0700 (PDT)
Date:   Wed, 23 Jun 2021 18:08:32 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 2/2] drm/bridge: ti-sn65dsi86: Implement the pwm_chip
Message-ID: <YNO+8O679/BVNR9K@yoga>
References: <20210622030948.966748-1-bjorn.andersson@linaro.org>
 <20210622030948.966748-2-bjorn.andersson@linaro.org>
 <20210622202935.lbghwelbiwgufycd@pengutronix.de>
 <YNKKkEMD4sVhfcNr@yoga>
 <20210623082915.tj7pid46wm3dl5jf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210623082915.tj7pid46wm3dl5jf@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed 23 Jun 03:29 CDT 2021, Uwe Kleine-K?nig wrote:

> Hello Bjorn,
> 
> On Tue, Jun 22, 2021 at 08:12:48PM -0500, Bjorn Andersson wrote:
> > On Tue 22 Jun 15:29 CDT 2021, Uwe Kleine-K?nig wrote:
> > > On Mon, Jun 21, 2021 at 10:09:48PM -0500, Bjorn Andersson wrote:
> > > > +		/*
> > > > +		 * PWM duty cycle is given as:
> > > > +		 *
> > > > +		 *   duty = BACKLIGHT / (BACKLIGHT_SCALE + 1)
> > > > +		 *
> > > > +		 * The documentation is however inconsistent in its examples,
> > > > +		 * so the interpretation used here is that the duty cycle is
> > > > +		 * the period of BACKLIGHT * PRE_DIV / REFCLK_FREQ.
> > > 
> > > I don't understand this.
> > > 
> > > > +		 *
> > > > +		 * The ratio PRE_DIV / REFCLK_FREQ is rounded up to whole
> > > > +		 * nanoseconds in order to ensure that the calculations are
> > > > +		 * idempotent and gives results that are smaller than the
> > > > +		 * requested value.
> > > > +		 */
> > > > +		tick = DIV_ROUND_UP(NSEC_PER_SEC * pre_div, pdata->pwm_refclk_freq);
> > > > +		backlight = state->duty_cycle / tick;
> > > 
> > > You're loosing precision here by dividing by the result of a division.
> > 
> > The actual period is also a result of a division and after spending too
> > many hours scratching my head I reached to conclusion that this was the
> > reason why I wasn't able to get the duty cycle calculation idempotent
> > over the ranges I tested.
> 
> How did you test? Using the sysfs interface?
>  

I primarily tested this by transplanting this into a user space thing
where I could sweep over various values for refclk, duty cycle and
period.

Then after that I tested it setting up pwm-backlight on top (as I don't
have access to the signal anyways) and try a few different periods and
for those test all possible brightness levels for those periods... (With
CONFIG_PWM_DEBUG enabled)

> > But in my effort to describe this to you here, I finally spotted the
> > error and will follow up with a new version that does:
> > 
> >                 actual = NSEC_PER_SEC * (pre_div * scale + 1) / pdata->pwm_refclk_freq);
> >                 backlight = state->duty_cycle * (scale + 1) / actual;
> 
> So the first term ("actual") is the period that you get for a given
> pre_div, scale and pwm_refclk_freq, right? And the 2nd ("backlight")
> defines the register value to configure the duty_cycle, right?
> 

Right, pre_div and pwm_refclk_freq defines the rate at which the PWM
ticks. "actual" is our estimate of the actual period that results in and
"backlight" is then the number of ticks (each prediv / refclk seconds
long) the signal should be high.

> I wonder: Is it possible to configure a 100% relative duty cycle? Then
> backlight would be scale + 1 which (at least if scale is 0xffff) would
> overflow the 16 bit register width?!
> 

The documentation gives two examples:
* backlight = 0x40, scale = 0xff results in 25% duty cycle, i.e. the
  duty is 0x40 / (0xff + 1).
* backlight = 0xff, scale = 0xff results in 100% duty cycle, i.e. the
  duty is 0xff / 0xff.

As you can see these are in  conflict and I think the latter is the one
that doesn't match the rest of what's described.

So I don't think it's possible to go beyond 99.6% - 99.998% duty cycle,
depending on BACKLIGHT_SCALE.

> > > > +static void ti_sn_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > +				struct pwm_state *state)
> > > > +{
> > > > +	struct ti_sn65dsi86 *pdata = pwm_chip_to_ti_sn_bridge(chip);
> > > > +	unsigned int pwm_en_inv;
> > > > +	unsigned int pre_div;
> > > > +	u16 backlight;
> > > > +	u16 scale;
> > > > +	int ret;
> > > > +
> > > > +	ret = regmap_read(pdata->regmap, SN_PWM_EN_INV_REG, &pwm_en_inv);
> > > > +	if (ret)
> > > > +		return;
> > > > +
> > > > +	ret = ti_sn65dsi86_read_u16(pdata, SN_BACKLIGHT_SCALE_REG, &scale);
> > > > +	if (ret)
> > > > +		return;
> > > > +
> > > > +	ret = ti_sn65dsi86_read_u16(pdata, SN_BACKLIGHT_REG, &backlight);
> > > > +	if (ret)
> > > > +		return;
> > > > +
> > > > +	ret = regmap_read(pdata->regmap, SN_PWM_PRE_DIV_REG, &pre_div);
> > > > +	if (ret)
> > > > +		return;
> > > > +
> > > > +	state->enabled = FIELD_GET(SN_PWM_EN_MASK, pwm_en_inv);
> > > > +	if (FIELD_GET(SN_PWM_INV_MASK, pwm_en_inv))
> > > > +		state->polarity = PWM_POLARITY_INVERSED;
> > > > +	else
> > > > +		state->polarity = PWM_POLARITY_NORMAL;
> > > > +
> > > > +	state->period = DIV_ROUND_UP(NSEC_PER_SEC * (pre_div * scale + 1), pdata->pwm_refclk_freq);
> > > > +	state->duty_cycle = backlight * DIV_ROUND_UP(NSEC_PER_SEC * pre_div, pdata->pwm_refclk_freq);
> > > 
> > > If you use
> > > 
> > > 	state->duty_cycle = DIV_ROUND_UP(backlight * NSEC_PER_SEC * pre_div, pdata->pwm_refclk_freq);
> > > 
> > > instead (with a cast to u64 to not yield an overflow) the result is more
> > > exact.
> > > 
> > 
> > The problem with this is that it sometimes yields duty_cycles larger
> > than what was requested... But going back to describing this as a ratio
> > of the period this becomes:
> > 
> >         state->duty_cycle = DIV_ROUND_UP_ULL(state->period * backlight, scale + 1);
> 
> I saw your next iteration of this patch set, but didn't look into it
> yet. Note that if it uses this formula it sill looses precision.
> Consider:
> 
> 	pwm_refclk_freq = 1333333
> 	pre_div = 4
> 	scale = 60000
> 	backlight = 59999
> 
> then you calculate:
> 
> 	state->period = 180000796 (exact value: 180000795.00019875)
> 	state->duty_cycle = 179994797 (exact value: 179994795.0736975)
> 
> so duty_cycle should actually be reported as 179994796. That happens
> because state->period is already the result of a division, you get the
> right value when doing:
> 
> 	state->duty_cycle = round_up(NSEC_PER_SEC * (pre_div * scale + 2) * backlight, (scale + 1) * pdata->pwm_refclk_freq)
> 

The problem (in addition to that being hideous) with that added
precision is that if I plug in that duty_cycle and period with
pwm_refclk_freq = 19200000 (one of the valid ones) the function is no
longer idempotent.

With period given as 180000796 i get 179998542 back as actual period,
but the duty cycle becomes 3186264 and if I throw that in I get 3185473.

> > > I still find this surprising, I'd expect that SCALE also matters for the
> > > duty_cycle. With the assumption implemented here modifying SCALE only
> > > affects the period. This should be easy to verify?! I would expect that
> > > changing SCALE doesn't affect the relative duty_cycle, so the brightness
> > > of an LED is unaffected (unless the period gets too big of course).
> > > 
> > 
> > I think the hardware is two nested counters, one (A) ticking at REFCLK_FREQ
> > and as that hits PRE_DIV, it kicks the second counter (B) (and resets).
> > 
> > As counter A is reset the output signal goes high, when A hits BACKLIGHT the
> > signal goes low and when A hits BACKLIGHT_SCALE it resets.
> 
> then we would probably have:
> 
> 	period = (scale + 1) * pre_div / refclk
> 
> but not
> 
> 	period = (scale * pre_div + 1) / refclk
> 
> . The former would be nicer because then in the calculation for
> duty_cycle the factor (scale + 1) would cancel.
> 

Not only does scale + 1 cancel, there's something entity that actually
divides the (BACKLIGHT_SCALE + 1) in the denominator of the duty cycle
ratio.

> > Per this implementation the actual length of the duty cycle would indeed
> > be independent of the BACKLIGHT_SCALE,
> 
> In your formula for duty_cycle scale actually does matter. So I think
> we're not there yet?
> 

Right, the relationship between pre_div, backlight and duty_cycle should
be independent of period. I think is misinterpreted what you said
yesterday, and thought you where looking for there to be a relationship.


So, if we decide that we have a typo in the datasheet and make the
formula:

          NSEC_PER_SEC * PRE_DIV * (BACKLIGHT_SCALE + 1)
period = -----------------------------------------------
                        REFCLK_FREQ

then given the formula for the duty ratio:

  duty           BACKLIGHT
-------- = ---------------------
 period     BACKLIGHT_SCALE + 1

with NSEC_PER_SEC * PRE_DIV / REFCLK_FREQ cancelled out, this fits
better together and we can deduce that:

              NSEC_PER_SEC * PRE_DIV * BACKLIGHT
duty_cycle = ------------------------------------
                        REFCLK_FREQ

So after adjusting the calculations for pre_div and scale I can
calculate backlight, without first calculating the actual period using:

             duty_cycle * REFCLK_FREQ
BACKLIGHT = --------------------------
              NSEC_PER_SEC * PRE_DIV

Which I now assume is what you where trying to say but I misunderstood
the other day?


PS. With refclk 19200000 and period 180000796 this satisfies the
PWM_DEBUG requirements for all possible duty_cycles.

Regards,
Bjorn

> > but the length of the low signal (and hence the ratio, which results
> > in the actual brightness) does depend on BACKLIGHT_SCALE.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


