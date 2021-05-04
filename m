Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA217372DCA
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhEDQOq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 12:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhEDQO1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 May 2021 12:14:27 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AE1C061347
        for <linux-pwm@vger.kernel.org>; Tue,  4 May 2021 09:13:31 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c36-20020a05683034a4b02902a5b84b1d12so8323488otu.8
        for <linux-pwm@vger.kernel.org>; Tue, 04 May 2021 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3wRKaltWU+JFnZ/hG1tIlEiOTvi8Xhm6Fr3GYe0oO4M=;
        b=jA2rD37U0ZLBrvXb2KILcxRKLjTuQZ1y6nhFpadkHkfxqkO3O43zPUhyWarbRFz+Nn
         VaQ3WO7HWHIKEZ1lrivt2csRxyY0WMht8Zj0lCVT32oEqw58xf+zOvINjXiX9veZxtm5
         Oc+uLHs2Oh4LKO/pKydiVQKOjOZlj5sd7xNpbER201yVT5vGarBqM8uk8TfX+KvvnFTX
         8jVDv+qKqv3O7jvqZMGqCZpwOPYYzqomI7fI1rNGgdHC5RqzthR5SlkFWA1yFM9Lbvcl
         Qp5i2quIN/XHUEm+XZJdVQ3LqbwsTTgFJTOUTOoI0DyEO8pwcABbAsF+4q9XcCcNYVP8
         u3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3wRKaltWU+JFnZ/hG1tIlEiOTvi8Xhm6Fr3GYe0oO4M=;
        b=N7zMcB7PCVCiFrr2PcNv6lUga80mAZy8S8wrs39tmZwKkb7HKYJKWWXusa3yqKtOIZ
         pxUt7cGSI2DIND/H09SS5UAXsGiDs4okZV4RXw0FeJnDnfTyrQkTptGCCIPrA5Bcno8S
         OUPo66r6pkPXpQrmDEURUfUjbJ7syy+fyBPPLBSJSlLSfeOr0/UMrqxZoCQdQzdEv1MW
         1UFGe75Q0XwEtonhpVpH18vlS/0dF8HLMGUz+rTWVGDpGSkTJ1KS3fEIr4ncTT6HxCeH
         OW39uDjT+y4DskQfpAX+rBhwIyn1ReCwQmBO4S/1L+AOHytOZ0pBLVUJDhxzkEKdHF9B
         Yorw==
X-Gm-Message-State: AOAM530Vx2ZPTUqfA5LfLIe+TnZ1dUDu44rkv60bNETJcnLBoGn2/JAJ
        CNzPQWM0y+6QnoycBOzrlCiEjQ==
X-Google-Smtp-Source: ABdhPJy+Wbpig9dvXrYjUC7ApSdIhLL8bzonH2lnEjnjc21qQR5xN3P6IwXPzDbdvpZzsYl/HHbbrA==
X-Received: by 2002:a05:6830:2086:: with SMTP id y6mr19982990otq.356.1620144810641;
        Tue, 04 May 2021 09:13:30 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z9sm856289otj.44.2021.05.04.09.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:13:30 -0700 (PDT)
Date:   Tue, 4 May 2021 11:13:27 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
Message-ID: <20210504161327.GF2484@yoga>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
 <20201021201224.3430546-3-bjorn.andersson@linaro.org>
 <20201029181357.GE26053@duo.ucw.cz>
 <YIn50NW+Pimqfsih@builder.lan>
 <20210429211223.GA5480@amd>
 <20210429212920.GB2484@yoga>
 <YJFridMwwMV1K98m@mobian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJFridMwwMV1K98m@mobian>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue 04 May 10:43 CDT 2021, Pavel Machek wrote:

> Hi!
> 
> > > > One such example is the laptop in front of me, which has 3 channels
> > > > wired to an RGB LED and 1 channel wired as a backlight control signal
> > > > (i.e. using pwm-backlight).  Another example is a devboard where the
> > > > 4 channels are wired to 4 LEDs.
> > > 
> > > Ok, so this is actually important. In this case you should have PWM
> > > layer, exporting PWMs, and then rgb-LED driver that takes three of
> > > those PWMs and turns them into LED, no?
> > > 
> > > And ... surprise ... that is likely to help other people, as LEDs
> > > connected to PWMs are quite common.
> > > 
> > > Hmm.?
> > > 
> > > If you can't do this for some reason, you should probably explain in
> > > the changelog, because this is going to be FAQ.
> > > 
> > 
> > This is exactly what the downstream implementation does and in the case
> > of a solid color LED this works fine.
> > 
> > But the hardware has a shared chunk of memory where you can write
> > duty-cycle values, then for each PWM channel you can specify the
> > start/stop index and pace for the PWM to read and update the configured
> > duty-cycle. This is how the hardware implements pattern support.
> 
> Ok.
> 
> > So downstream they have (last time I looked at the code) an addition in
> > the PWM API where the LED driver can inform the PWM driver part about
> > the indices to use. Naturally I don't think that's a good idea.
> 
> Dunno. Is it bad idea?
> 
> pattern support for other PWMs (vibration?) seems useful, too. Yes, it
> means more discussion and extending PWMs properly..
> 

@Thierry, @Lee, @Uwe, are you interested in extending the PWM api with
some sort of support for specifying an array of "duty_cycle" and some
property for how fast the hardware should cycle through those duty
cycles? (And I need a bit/bool to indicate if the pattern should run
once of be repeated)

The (current) use case relates to being able to alter the duty cycle
over time to create "effects" such as pulsing an LED.

> > Additionally, representing this as individual PWM channels means we're
> > loosing the grouping that now comes from the description of multicolor
> > LEDs, which serves the basis for synchronizing the pattern traversal
> > between the involved channels.
> 
> Yes, keeping grouping would be nice, but perhaps pattern API for PWMs
> can do that too?
> 

I don't think it's viable to push this concept down to the PWM core, the
LED framework needs to know which channels are grouped as LEDs (and
which aren't) and the thing that drives the hardware needs to know which
channels to sync with when starting the pattern. So afaict we'd have to
describe these properties in two places - or ignore some properties of
the problem.

> You can have solid-color-only driver now, with patterns being added
> as discussion with PWM people progresses...
> 

I don't see how that would work, the overall design of the driver and
the devicetree binding depends heavily on this fundamental decision.

Regards,
Bjorn
