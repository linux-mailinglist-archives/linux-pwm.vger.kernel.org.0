Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA363ABB2E
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Jun 2021 20:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhFQSJN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Jun 2021 14:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhFQSJE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Jun 2021 14:09:04 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130A6C06175F
        for <linux-pwm@vger.kernel.org>; Thu, 17 Jun 2021 11:06:55 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t40so7454317oiw.8
        for <linux-pwm@vger.kernel.org>; Thu, 17 Jun 2021 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j0BoPIDWyRZ7eAOWVfRNbOKSmlASWPNoA23yKtrI5ho=;
        b=nagItiJOYVW49+/5vU4doda2lcVxieX6XBp6OU1p7rLIlna2fWea5Hzux1s9Qv3XPp
         mkzQFz/7ikotqVDzlYJEj7ohH6nAydgqN72Cu9zo574X732cQLhnEgh/L13zG2sJ+qh1
         q/b1FeD7vJCdGWeHuuMLDulmYr3r3z53O5102oNNr6ZdqLVzmD/xbqeG3E5vN/MmmZON
         bjGoe89sMUlSJHu8JKkSGkN8CZqvBk+2xvO3phc9VAsxPO7IoCf4pgZP8H/H8tidQ0l3
         Hi+whcqq//54vhfzIak3thse8mRnFwNvO9xR/GOknzjYbXWSGH3Qv3DUH2ELZpbBkR2P
         Dcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j0BoPIDWyRZ7eAOWVfRNbOKSmlASWPNoA23yKtrI5ho=;
        b=NxwlMQ8GRLya+V9N1hFsM8+LeGf2s1zKAgrscXXQ7IJaRtZL0xpp/VJOXQUBJ4byUw
         k0eb5OTj57e8MWAYAv9tzK+X2gULVdqsJ/bQ3T6T9Y5X24efa+6TDN+9IsMhdwOF7J8i
         pRsVdc3wIoH5K2UvAS6Ds+xNnazYLB9TgLXQVmygHtQP03s1EvbzC5VRVl1ubMCep7Pm
         mk7IDfWllfPrcdXJcixBUrX5SktSDcpXT4Ak4rjhKiqG6djQOjth9Yt6tM4CUdWocT+G
         atJeRZAUaeZFoatiZfcKttBwSMYTVQ2n9n+ZDlenSANyeL06MR9elGfIeWoteW1ma7IO
         8hjw==
X-Gm-Message-State: AOAM531+lkbefL5KXoAI3bH04zid9TSVVcTIEzn0NsybAoKUEKWgJi/B
        n1hL5MRy+RyNz0KTUoGoehoJeA==
X-Google-Smtp-Source: ABdhPJy+fr+LYbN4bzr1VMR9PctoEjjX+j+mrqwEdqZJcP5Mn9YqiVzeZEiVjQZScItvxKRqPZxw8g==
X-Received: by 2002:aca:3385:: with SMTP id z127mr4149757oiz.142.1623953214100;
        Thu, 17 Jun 2021 11:06:54 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l24sm1219735oii.45.2021.06.17.11.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 11:06:53 -0700 (PDT)
Date:   Thu, 17 Jun 2021 13:06:51 -0500
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
Message-ID: <YMuPO3iKRSFNLbNZ@yoga>
References: <20210615231828.835164-1-bjorn.andersson@linaro.org>
 <20210615231828.835164-2-bjorn.andersson@linaro.org>
 <20210616075637.jtoa25uyhnqkctlu@pengutronix.de>
 <YMq/6VhXrYJoTVnj@yoga>
 <20210617062449.qwsjcpkyiwzdyfi3@pengutronix.de>
 <YMt6gvXQKijtPOql@yoga>
 <20210617165433.ltugrrj6ntmc6j57@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210617165433.ltugrrj6ntmc6j57@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu 17 Jun 11:54 CDT 2021, Uwe Kleine-K?nig wrote:

> Hello Bjorn,
> 
> On Thu, Jun 17, 2021 at 11:38:26AM -0500, Bjorn Andersson wrote:
> > On Thu 17 Jun 01:24 CDT 2021, Uwe Kleine-K?nig wrote:
> > > On Wed, Jun 16, 2021 at 10:22:17PM -0500, Bjorn Andersson wrote:
> > > > > > +static int ti_sn_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > > > +			   const struct pwm_state *state)
> > > > > > +{
> > > > > > +	struct ti_sn65dsi86 *pdata = pwm_chip_to_ti_sn_bridge(chip);
> > > > > > +	unsigned int pwm_en_inv;
> > > > > > +	unsigned int backlight;
> > > > > > +	unsigned int pre_div;
> > > > > > +	unsigned int scale;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	if (!pdata->pwm_enabled) {
> > > > > > +		ret = pm_runtime_get_sync(pdata->dev);
> > > > > > +		if (ret < 0)
> > > > > > +			return ret;
> > > > > > +
> > > > > > +		ret = regmap_update_bits(pdata->regmap, SN_GPIO_CTRL_REG,
> > > > > > +				SN_GPIO_MUX_MASK << (2 * SN_PWM_GPIO_IDX),
> > > > > > +				SN_GPIO_MUX_SPECIAL << (2 * SN_PWM_GPIO_IDX));
> > > > > > +		if (ret) {
> > > > > > +			dev_err(pdata->dev, "failed to mux in PWM function\n");
> > > > > > +			goto out;
> > > > > > +		}
> > > > > 
> > > > > Do you need to do this even if state->enabled is false?
> > > > 
> > > > I presume I should be able to explicitly mux in the GPIO function and
> > > > configure that to output low. But I am not able to find anything in the
> > > > data sheet that would indicate this to be preferred.
> > > 
> > > My question targetted a different case. If the PWM is off
> > > (!pdata->pwm_enabled) and should remain off (state->enabled is false)
> > > you can shortcut here, can you not?
> > 
> > Right, if we're going off->off then we don't need to touch the hardware.
> > 
> > But am I expected to -EINVAL improper period and duty cycle even though
> > enabled is false?
> > 
> > And also, what is the supposed behavior of enabled = false? Is it
> > supposedly equivalent of asking for a duty_cycle of 0?
> 
> In my book enabled = false is just syntactic sugar to say:
> "duty_cycle=0, period=something small". So to answer your questions: if
> enabled = false, the consumer doesn't really care about period and
> duty_cycle. Some care that the output becomes inactive, some others
> don't, so from my POV just emit the inactive level on the output and
> ignore period and duty_cycle.
> 

Giving this some further thought.

In order to have a known state of the PWM signal we need the sn65dsi86
to be powered. The documentation describes a "suspend mode", but this is
currently not implemented in the driver, so there's a large power cost
coming from just keeping the pin low when disabled.

As such in the current implementation I use state->enabled to also
control if the device should be kept powered, which means that this
follows the backlight power status of the pwm-backlight. Which is
sufficient as the backlight won't be powered when !state->enabled.


For the typical use case the pwm-backlight has some independent control
over gpio and power to toggle the actual backlight. But in the even that
this wouldn't be available I think we need to extend the driver to
implement the suspend mode.

In which case muxing in the PWM function should probably happen at the
time the PWM channel is requested.

This does come at an additional power cost (not as high as keeping the
chip awake though), so (in addition to the effort) I think it's
reasonable to document this as a limitation for now and implement this
as the need arise.

Thanks,
Bjorn

> > > > > Does this already modify the output pin?
> > > > 
> > > > Yes, coming out of reset this pin is configured as input, so switching
> > > > the mux here will effectively start driving the pin.
> > > 
> > > So please document this in the format the recently added drivers do,
> > > too. See e.g. drivers/pwm/pwm-sifive.c. (The idea is to start that with
> > > " * Limitations:" to make it easy to grep it.)
> > > 
> > 
> > Okay, will do. Although I believe that for this driver it makes sense to
> > place such comment close to this function, rather than at the top of the
> > driver.
> 
> Yes, agreed.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


