Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242D03B24BD
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jun 2021 04:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFXCMp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Jun 2021 22:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhFXCMo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Jun 2021 22:12:44 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AC6C061756
        for <linux-pwm@vger.kernel.org>; Wed, 23 Jun 2021 19:10:25 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t40so5591337oiw.8
        for <linux-pwm@vger.kernel.org>; Wed, 23 Jun 2021 19:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lVMx0aLboEd+DY9Nn5ud8IvPS215FXHota98NrfM/gk=;
        b=gXLVsqIaMUXTWEm8qJCTsTizHPer17xpHWSQtH9QUCSEbKB4L2kFDgdwnl9mw0xMsb
         3S3YLyuFrRQXlAiRgwulIdOWoQoIqRCGb9QqXwltscU2JyMtFkEod6cHCbe+sG74rC+S
         J4vGitYn8iou2m67zf5PKtiYuZlHQPxBhcY8zeEN/BUWNoC0CDpXNHJDvR9wum081JM2
         F4jij1kPtR0mFihli4Kp19DU5pryo3ZKeJC05r/sa44GEbyJ+UNIjzsNK+BnweI3o5Ip
         /3/PtNkC45FrkNcSmYDOCy1Rew8QkdAdVrwv0PnTyfyeZ5yIOIwLgz1tuqzH5Kao8o0Z
         0bhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lVMx0aLboEd+DY9Nn5ud8IvPS215FXHota98NrfM/gk=;
        b=kJ20GWc8dTazJXb1xLSP4r3VwALmObQ7vuQECj21Im+NDMBmnFswfToiGDNMaysxgu
         I87sEORXt1juxbIIbEGBLR4v/02HSD4NmqKdJCwMh/rb7n4XGDadwACXshz5soAs6ddf
         f/a1t4HIS9PMEoK+L+e72XrKxVNvQolhiQTFxbMIIp5LBVKXZKOlhIFBDag8wXqHy+KX
         UK2aI5kHcV/exJURkCArQ9XaxyZETeGqFbe2F3XawMHC8KeXPt/DpU94ggplhsirtLk8
         jV0TbS3OVzUrLgrqwtsOQHCK0LKWHvK/Vin1R+4brtv8qSMRK4oVn8D7j7Wr2shE93Aq
         x7Mw==
X-Gm-Message-State: AOAM5333D1cxW35EAJaVo6BDiDHSrMDSW4eXorv78rvYc5zm+oA76Ein
        jEo5M59BL4nyVqwiFJs2GfYV9w==
X-Google-Smtp-Source: ABdhPJyCo237ujxep1rxcr99QcnPerQ+VAICG1zF4Vb10nPWCjQqTL7U4EIr6vK37TKLhZC/thV0mg==
X-Received: by 2002:a05:6808:8fb:: with SMTP id d27mr5710094oic.115.1624500624350;
        Wed, 23 Jun 2021 19:10:24 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e23sm389492otk.67.2021.06.23.19.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 19:10:23 -0700 (PDT)
Date:   Wed, 23 Jun 2021 21:10:21 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] pwm: Introduce single-PWM of_xlate function
Message-ID: <YNPpjV+9mhF2eABj@yoga>
References: <20210623032755.1170809-1-bjorn.andersson@linaro.org>
 <CAD=FV=VbWu-zK=uuuYRBnddao4X5ELT29L=Dn_mBLG57kzuK4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VbWu-zK=uuuYRBnddao4X5ELT29L=Dn_mBLG57kzuK4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed 23 Jun 17:19 CDT 2021, Doug Anderson wrote:

> Hi,
> 
> On Tue, Jun 22, 2021 at 8:28 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
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
> > Changes since v3:
> > - None
> >
> > Changes since v2:
> > - None
> >
> >  drivers/pwm/core.c    | 26 ++++++++++++++++++++++++++
> >  drivers/pwm/pwm-pxa.c | 16 +---------------
> >  include/linux/pwm.h   |  2 ++
> >  3 files changed, 29 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index a42999f877d2..5e9c876fccc4 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -152,6 +152,32 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
> >  }
> >  EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
> >
> > +struct pwm_device *
> > +of_pwm_single_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
> 
> It's probably up to PWM folks, but to make it symmetric to
> of_pwm_xlate_with_flags() I probably would have named it with the
> "_with_flags" suffix.
> 

I don't see a reason for having the no-flags variant of this, but you're
right in that it does look more uniform.

> 
> > +{
> > +       struct pwm_device *pwm;
> > +
> > +       if (pc->of_pwm_n_cells < 1)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       /* validate that one cell is specified, optionally with flags */
> > +       if (args->args_count != 1 && args->args_count != 2)
> > +               return ERR_PTR(-EINVAL);
> 
> I don't know all the rules for attempted forward compatibility, but
> unless there's a strong reason I'd expect to match the rules for
> of_pwm_xlate_with_flags(). That function doesn't consider it to be an
> error if either "pc->of_pwm_n_cells" or "args->args_count" is bigger
> than you need. Unless there's a reason to be inconsistent, it seems
> like we should be consistent between the two functions. That would
> make the test:
> 
> if (args->args_count < 1)
>   return ERR_PTR(-EINVAL);
> 

My crystal ball is foggy, but I guess I could follow suite even though I
don't see what that might be.

> 
> > +
> > +       pwm = pwm_request_from_chip(pc, 0, NULL);
> > +       if (IS_ERR(pwm))
> > +               return pwm;
> > +
> > +       pwm->args.period = args->args[0];
> > +       pwm->args.polarity = PWM_POLARITY_NORMAL;
> > +
> > +       if (args->args_count == 2 && args->args[2] & PWM_POLARITY_INVERTED)
> 
> Similar to above, should this be ">= 2" rather than "== 2" ?
> 
> I also notice that in commit cf38c978cf1d ("pwm: Make
> of_pwm_xlate_with_flags() work with #pwm-cells = <2>") Uwe added a
> check for "pc->of_pwm_n_cells" in of_pwm_xlate_with_flags() right
> around here. You're not checking it in your function.
> 
> I _think_ your code is fine because I can't see how "args->args_count"
> could ever be greater than "pc->of_pwm_n_cells" but maybe I'm not
> seeing something. Assuming your code is correct then maybe the right
> thing to do is to remove the extra check from
> of_pwm_xlate_with_flags() to make the two functions more similar.
> 

I guess the way of_pwm_xlate_with_flags() is written the optional flags
will only be considered if the driver has stated that it supports the
3rd field.

The way I wrote this means that I don't care if the drivers supports
flags I will pick up that INVERTED bit. I suppose this means that if a
driver where to increment of_pwm_n_cells we suddenly start to care about
a cell that we previously never looked at...

But it would be consistent to follow this, and I don't really have an
opinion about these nuances.

Thanks for your feedback Doug.

Regards,
Bjorn
