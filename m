Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D103AB9D1
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Jun 2021 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhFQQkj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Jun 2021 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhFQQki (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Jun 2021 12:40:38 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0074C061574
        for <linux-pwm@vger.kernel.org>; Thu, 17 Jun 2021 09:38:29 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so6745805otk.5
        for <linux-pwm@vger.kernel.org>; Thu, 17 Jun 2021 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=m0MVvsZb1hr1a4TsaY4Ry0fJgtY0P//6ZgkDcV/EML0=;
        b=OsqstlLT8KtiNyRWrLQNtz8IWq8jH/tJb5Bb7eE3U1S8OpERF7i43RsrCB5HA/04kJ
         Axnsm6sUW+Udp7rEpvazZTPpjJxQni9nOSfzyLbrD/ZBKH/tGdGd05jn5s2h1CRUjxwM
         Q5KW9bRXkM++3VlOLfOZVFwt1D5rzoXpg1Xr9BRMDbvLjREo8rN9a4VuqRhQ8xBp/x8s
         dU0FYdCzMm1oTEOLD+YUg0552YG7vZ44f5MWfD0VcNS0ELy9RhqINRe/vQ2Mfhi58bma
         1jx1Pr9TjgwQdJri9eZZ8SAmH9iZngv5Hes3mHhgmBOoL8sz5FYK11vGz4+SagBfIdYM
         0Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m0MVvsZb1hr1a4TsaY4Ry0fJgtY0P//6ZgkDcV/EML0=;
        b=ZaiUmR6KRmnDvXjBn+cyNauUsJDoj2KFN/7yqYHX/8V5BPYcjODDdRDCV3CXhcNI3w
         iOZAiK0svBawC39GyU+1mBg9hf1ZyhNJB/E0gb+H54MO6YZA6HcmQIehOgubgQcwSxHQ
         Ex5pyggW+AKxIqErJgV0OB6YDpYYDcvYNV0frhXU8FWbm/XzCB89WK74C3m6StsAEOCH
         z4luDM/1IH7D9bmYopbgTzugpAYXS9/dMgF3bP8ClEAU63r41elbEGqGAZNxUaFBjLle
         B8n3ws34OUVVgPL5YJlb2W4Bqf8RuIOKNos0LUzr5E4X662C63fNgVGKrWI3t7cwWGHR
         DyzQ==
X-Gm-Message-State: AOAM53106ItRuYDVYEyJP6xHyCX1Q3NhGaVf/+emoWLFf3wZuBSTriIt
        GaHirHcAnnk+DBm4Vx4XxK92Dg==
X-Google-Smtp-Source: ABdhPJx+MUc+bMLm1uA7ND4jpKXvbyWaKmupBmC32xaDSHkqCCohvWqBDS+ZHh+9+EvfVZr+E3aAfQ==
X-Received: by 2002:a9d:6e03:: with SMTP id e3mr2640982otr.218.1623947909079;
        Thu, 17 Jun 2021 09:38:29 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p203sm1177819oib.40.2021.06.17.09.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 09:38:28 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:38:26 -0500
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
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/bridge: ti-sn65dsi86: Implement the pwm_chip
Message-ID: <YMt6gvXQKijtPOql@yoga>
References: <20210615231828.835164-1-bjorn.andersson@linaro.org>
 <20210615231828.835164-2-bjorn.andersson@linaro.org>
 <20210616075637.jtoa25uyhnqkctlu@pengutronix.de>
 <YMq/6VhXrYJoTVnj@yoga>
 <20210617062449.qwsjcpkyiwzdyfi3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210617062449.qwsjcpkyiwzdyfi3@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu 17 Jun 01:24 CDT 2021, Uwe Kleine-K?nig wrote:

> Hello Bjorn,
> 
> On Wed, Jun 16, 2021 at 10:22:17PM -0500, Bjorn Andersson wrote:
> > > > +static int ti_sn_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > +			   const struct pwm_state *state)
> > > > +{
> > > > +	struct ti_sn65dsi86 *pdata = pwm_chip_to_ti_sn_bridge(chip);
> > > > +	unsigned int pwm_en_inv;
> > > > +	unsigned int backlight;
> > > > +	unsigned int pre_div;
> > > > +	unsigned int scale;
> > > > +	int ret;
> > > > +
> > > > +	if (!pdata->pwm_enabled) {
> > > > +		ret = pm_runtime_get_sync(pdata->dev);
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > > +
> > > > +		ret = regmap_update_bits(pdata->regmap, SN_GPIO_CTRL_REG,
> > > > +				SN_GPIO_MUX_MASK << (2 * SN_PWM_GPIO_IDX),
> > > > +				SN_GPIO_MUX_SPECIAL << (2 * SN_PWM_GPIO_IDX));
> > > > +		if (ret) {
> > > > +			dev_err(pdata->dev, "failed to mux in PWM function\n");
> > > > +			goto out;
> > > > +		}
> > > 
> > > Do you need to do this even if state->enabled is false?
> > 
> > I presume I should be able to explicitly mux in the GPIO function and
> > configure that to output low. But I am not able to find anything in the
> > data sheet that would indicate this to be preferred.
> 
> My question targetted a different case. If the PWM is off
> (!pdata->pwm_enabled) and should remain off (state->enabled is false)
> you can shortcut here, can you not?
> 

Right, if we're going off->off then we don't need to touch the hardware.

But am I expected to -EINVAL improper period and duty cycle even though
enabled is false?


And also, what is the supposed behavior of enabled = false? Is it
supposedly equivalent of asking for a duty_cycle of 0?

> > > Does this already modify the output pin?
> > 
> > Yes, coming out of reset this pin is configured as input, so switching
> > the mux here will effectively start driving the pin.
> 
> So please document this in the format the recently added drivers do,
> too. See e.g. drivers/pwm/pwm-sifive.c. (The idea is to start that with
> " * Limitations:" to make it easy to grep it.)
> 

Okay, will do. Although I believe that for this driver it makes sense to
place such comment close to this function, rather than at the top of the
driver.

> > > Lets continue the above example with the fixed calculation. So we have:
> > > 
> > > 	pdata->pwm_refclk_freq = 3333334
> > > 	state->period = 100000 [ns]
> > > 	state->duty_cycle = 600
> > > 	scale = 332
> > > 
> > > so the actually emitted period = 99899.98002000399 ns
> > > 
> > > Now you calculate:
> > > 
> > > 	backlight = 1
> > > 
> > > which yields an actual duty_cycle of 299.99994 ns, with backlight = 2
> > > you would get an actual duty_cycle of 599.99988 ns, which is better. The
> > > culprit here is that you divide by state->period but instead should
> > > divide by the actual period.
> > 
> > What do I do about the case where the actual period is lower than the
> > requested one and thereby the duty cycle becomes larger than the period?
> 
> The general principle is: Pick the biggest possible duty_cycle available
> for the just picked period. So in your example you have to clamp it to
> period (assuming you can, otherwise pick the next lower possible value).
> 

Sounds good.

Thank you,
Bjorn

> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


