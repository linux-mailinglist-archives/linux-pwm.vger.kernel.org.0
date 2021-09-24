Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB744176CA
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Sep 2021 16:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhIXObR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Sep 2021 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhIXObP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Sep 2021 10:31:15 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED040C061571
        for <linux-pwm@vger.kernel.org>; Fri, 24 Sep 2021 07:29:41 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so13384722ota.6
        for <linux-pwm@vger.kernel.org>; Fri, 24 Sep 2021 07:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/HUdMFtSIgoDC8oIDLutFI0kXoCcazheaXJ199ftm9g=;
        b=aXxY4VUYQrGrb+hPUPt171rF7ZoorniSwGe2E4HTBrAkPzlbS/JkVWAJ0jufnLCdL8
         iwxiEweiMD5hpDUOcfs2WOovGWeBpLHVrqqXHl9WA6ojcQFjDbJyp2bKejo2NPTClxfJ
         hG3aCAfuOLoq7fWUY88c3I7QFz8FYaJGyzTjGYi6ede+vj4ZVhD4OT1mMOYpgbECpHsX
         Eu7hr8YTMjLSlcIkW5r92gwT7jDakW1i3QDiUTxg5awGkEWxpFEJxSNSHY+tCXMsZuwG
         YVxv9qPmUK+5uhbw1Jb3fWng7Xuk8jQSgLSYy02Ecp9dIrmx/xzA3tjEMGBrEED7T4Ub
         VeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/HUdMFtSIgoDC8oIDLutFI0kXoCcazheaXJ199ftm9g=;
        b=WVe/ulbC0h63Tt/ntzYYPu6YoEF9yEy+gQp84332cGwY1A6obYNdeW1fK9MaVWpODt
         oT3PBVYktMfeQ8UJTHs9l85e9f/8VoOdnkt4HDapcfcwmYv0gTpVoNHuVemESYrRA2vg
         jnrJawEyERrNnN2ACCwe5Db/TSjJlUa3O16t0BTxcps8VUC9uxVa+dOO/OAYikUz4fBq
         +RIbjKJjlhQJRcKQi4ok6RzuwDwBtrxo2lbs3PSWUf8O6eSTjzViflzG1rkPu7vMR9kQ
         h6rvdTZ6D6fFpEg+6544IW1EmQwxXjFT+yuV12ZGo3Zz6pNXc/FWoJAWj3leiyoGTSqx
         nDBQ==
X-Gm-Message-State: AOAM530iplwBIacIY663i0IMmeFTZtYAyB8Ynjoy/1F+FmYYBoUOzlh9
        YozXKSU1a53lWVBH1cScC3W+Jw==
X-Google-Smtp-Source: ABdhPJzv7ZLmAjdY7QEBnhVbHV9uXR3NPTSGFDmN2meB1pCWCEzM5B7NDpR1KtO4BLg6jokSeq1YvA==
X-Received: by 2002:a9d:6192:: with SMTP id g18mr4321765otk.314.1632493781163;
        Fri, 24 Sep 2021 07:29:41 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j4sm2121137oia.56.2021.09.24.07.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:29:40 -0700 (PDT)
Date:   Fri, 24 Sep 2021 07:30:19 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, Doug Anderson <dianders@google.com>
Subject: Re: [PATCH v5 1/2] pwm: Introduce single-PWM of_xlate function
Message-ID: <YU3g+8Rwfyq3yp5S@ripper>
References: <20210924021225.846197-1-bjorn.andersson@linaro.org>
 <20210924071652.skkx2jgeivg4uiht@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924071652.skkx2jgeivg4uiht@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri 24 Sep 00:16 PDT 2021, Uwe Kleine-K?nig wrote:

> On Thu, Sep 23, 2021 at 09:12:24PM -0500, Bjorn Andersson wrote:
> > The existing pxa driver and the upcoming addition of PWM support in the
> > TI sn565dsi86 DSI/eDP bridge driver both has a single PWM channel and
> > thereby a need for a of_xlate function with the period as its single
> > argument.
> > 
> > Introduce a common helper function in the core that can be used as
> > of_xlate by such drivers and migrate the pxa driver to use this.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v4:
> > - None
> > 
> >  drivers/pwm/core.c    | 26 ++++++++++++++++++++++++++
> >  drivers/pwm/pwm-pxa.c | 16 +---------------
> >  include/linux/pwm.h   |  2 ++
> >  3 files changed, 29 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 4527f09a5c50..2c6b155002a2 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -152,6 +152,32 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
> >  }
> >  EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
> >  
> > +struct pwm_device *
> > +of_pwm_single_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
> > +{
> > +	struct pwm_device *pwm;
> > +
> > +	if (pc->of_pwm_n_cells < 1)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	/* validate that one cell is specified, optionally with flags */
> > +	if (args->args_count != 1 && args->args_count != 2)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	pwm = pwm_request_from_chip(pc, 0, NULL);
> > +	if (IS_ERR(pwm))
> > +		return pwm;
> > +
> > +	pwm->args.period = args->args[0];
> > +	pwm->args.polarity = PWM_POLARITY_NORMAL;
> > +
> > +	if (args->args_count == 2 && args->args[2] & PWM_POLARITY_INVERTED)
> > +		pwm->args.polarity = PWM_POLARITY_INVERSED;
> 
> of_pwm_xlate_with_flags is a bit more complicated. Translating
> accordingly this would yield:
> 
> 	if (pc->of_pwm_n_cells >= 2) {
> 		if (args->args_count > 1 && args->args[1] & PWM_POLARITY_INVERTED)
> 			pwm->args.polarity = PWM_POLARITY_INVERSED;
> 	}
> 
> Given that pc->of_pwm_n_cells isn't used when a phandle is parsed (in
> of_pwm_get()) I think your variant is fine.
> 

Right, the difference from of_pwm_xlate_with_flags is that this version
will pick up the flags even if the driver says it has n_cells = 1.

I didn't see a strong reason for doing the extra check and the drawback
with it is that if I then write in my dts that my channel should be
INVERTED the driver won't be able to bump the n_cells to 2, because that
would cause a regression.

Would you like me to add this extra check? Or perhaps ensure that the
commit message captures my reasoning here?

> So I think technically the patch is good, for me the question is if we
> want to make new drivers of_pwm_xlate_with_flags for consistency even
> though this would mean that the first argument has to be 0 for all
> phandles. Thierry? Lee?
> 

I find it typical for single entity providers to be defined with
#foo-cells = <0> (or 1 if you have flags) and not pass a "dummy" 0.

We did talk about this with Rob in a previous version of this patch and
came to the conclusion that this was the appropriate thing to do...

Thanks,
Bjorn
