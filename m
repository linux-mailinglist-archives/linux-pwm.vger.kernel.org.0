Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825D21D3E5B
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 22:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgENUDz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 16:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729102AbgENUDy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 16:03:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760FDC061A0C
        for <linux-pwm@vger.kernel.org>; Thu, 14 May 2020 13:03:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w64so2307162wmg.4
        for <linux-pwm@vger.kernel.org>; Thu, 14 May 2020 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0T9FZKzhaNIAyAMhurXfRjBv09XxUrY4eeMiZKg77EU=;
        b=VAIiWBZd2orVmWNlsBdww0kQaG/rvtc7vet7nyyZlSVy3XFuYBQVE80Glibbmi1Q/H
         P7xZZPm/sIwfTWY1GifVPJ6d0KCv5ZLDS22MX0SAdwHCH6ahi3ME03a3kF/lqQvAxdpl
         XDNuG1qZ6i5qtfURURGheV0H/P+nYP3ryGwSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0T9FZKzhaNIAyAMhurXfRjBv09XxUrY4eeMiZKg77EU=;
        b=V1yNN5DLwhWjubQdEWmD+aWqIx//gKchWuTxW3Pq2cBvWoWNqZRab9ZXKH3Z/IGwBv
         0oEn/UiME8YwHHFSyf4MpjBYpggP83TAKTsR8D5mRTiLTfpBOmUPHjs49Irami8bk/T+
         UwSFOpe/i1MXITxOqD3EiT+10n+1NqpA/F0ATQUCCC4XIuDbgF4R4UWQKIvkBtT/Z/SZ
         81wWzEuc/dOjjNNYVYvEG2lSPaKidzHYvCC/GQZwXydW85y+a/8hXRi20eBhAfs+Eca+
         +HOPdY7ZSn41Qlk2TeRv/yYJnxRvwdPTKt+FkC7Pu6Mw0EYafZXLbTRY1GdCPo1//nxz
         Nn/g==
X-Gm-Message-State: AOAM533FwSQ3Fwd5oY8N4aQLwcpRLfplhDzALaVNyXMFNkmxAVi7691x
        qTnuNMkb7oM0XL28w3X5A727ag==
X-Google-Smtp-Source: ABdhPJyYd+AOcu5tx+w8CHn4dey+W+3+gPxvcA9FEiyAuntQNRmQiufc1W5mxesih8+QEvnI7mVCfQ==
X-Received: by 2002:a1c:c309:: with SMTP id t9mr14300wmf.113.1589486633043;
        Thu, 14 May 2020 13:03:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q14sm18882wrc.66.2020.05.14.13.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:03:52 -0700 (PDT)
Date:   Thu, 14 May 2020 22:03:49 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Uwe Kleine Konig <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-arm-msm@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Zheng Bin <zhengbin13@huawei.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        patches@opensource.cirrus.com, Enrico Weigelt <info@metux.net>
Subject: Re: [PATCH v1 08/18] backlight: add backlight_is_blank()
Message-ID: <20200514200349.GD206103@phenom.ffwll.local>
References: <20200514191001.457441-1-sam@ravnborg.org>
 <20200514191001.457441-9-sam@ravnborg.org>
 <20200514194116.GB206103@phenom.ffwll.local>
 <20200514194646.GA460099@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514194646.GA460099@ravnborg.org>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, May 14, 2020 at 09:46:46PM +0200, Sam Ravnborg wrote:
> Hi Daniel.
> 
> On Thu, May 14, 2020 at 09:41:16PM +0200, Daniel Vetter wrote:
> > On Thu, May 14, 2020 at 09:09:51PM +0200, Sam Ravnborg wrote:
> > > The backlight support has two properties that express the state:
> > > - power
> > > - state
> > > 
> > > It is un-documented and easy to get wrong.
> > > Add backlight_is_blank() helper to make it simpler for drivers
> > > to get the check of the state correct.
> > > 
> > > A lot of drivers also includes checks for fb_blank.
> > > This check is redundant when the state is checked
> > > as thus not needed in this helper function.
> > > Rolling out this helper to all relevant backlight drivers
> > > will eliminate almost all accesses to fb_blank.
> > > 
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > ---
> > >  include/linux/backlight.h | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> > > index b7839ea9d00a..e67e926de1e2 100644
> > > --- a/include/linux/backlight.h
> > > +++ b/include/linux/backlight.h
> > > @@ -165,6 +165,23 @@ static inline int backlight_disable(struct backlight_device *bd)
> > >  	return backlight_update_status(bd);
> > >  }
> > >  
> > > +/**
> > > + * backlight_is_blank - Return true if display is expected to be blank
> > > + * @bd: the backlight device
> > > + *
> > > + * Display is expected to be blank if any of these is true::
> > > + *
> > > + *   1) if power in not UNBLANK
> > > + *   2) if state indicate BLANK or SUSPENDED
> > > + *
> > > + * Returns true if display is expected to be blank, false otherwise.
> > > + */
> > > +static inline bool backlight_is_blank(struct backlight_device *bd)
> > > +{
> > > +	return bd->props.power != FB_BLANK_UNBLANK ||
> > > +	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
> > 
> > This definition here doesn't match backlight_enabled/disable() functions
> > we added. I think to avoid lots of pondering and surprises we should try
> > to make sure these are all matching, so that once we rolled them out
> > everywhere, we can just replace the complicated state with one flag.
> 
> Will add it in v2. When all user of fb_blank is dropped we can
> safely remove it then.
> And as you said on irc, the risk of introducing regressions is lower
> as we see some creative uses in the drivers today.
> I already did some kind of audit - but I may have missed something.

btw one pattern I've seen in a few places with a few greps I've just done
is maybe worth putting into a helper too:

backlight_force_enable(bl)
{
	if (bl->brightness == 0)
		bl->brightness = bl->max_brightness;
	backlight_enable(backlight);
}

Just in case you run out of ideas anytime soon :-)

Cheers, Daniel

> 
> 	Sam
> 
> > 
> > > +}
> > > +
> > >  extern struct backlight_device *backlight_device_register(const char *name,
> > >  	struct device *dev, void *devdata, const struct backlight_ops *ops,
> > >  	const struct backlight_properties *props);
> > > -- 
> > > 2.25.1
> > > 
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
