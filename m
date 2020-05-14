Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EDA1D3DDA
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgENTq4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:46:56 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:59840 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgENTq4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:46:56 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D604980548;
        Thu, 14 May 2020 21:46:47 +0200 (CEST)
Date:   Thu, 14 May 2020 21:46:46 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
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
Message-ID: <20200514194646.GA460099@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
 <20200514191001.457441-9-sam@ravnborg.org>
 <20200514194116.GB206103@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514194116.GB206103@phenom.ffwll.local>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
        a=25-AhOLfAAAA:8 a=e5mUnYsNAAAA:8 a=QBaoSajrUL0e5rbjbiEA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=cvBusfyB2V15izCimMoJ:22
        a=dnuY3_Gu-P7Vi9ynLKQe:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Daniel.

On Thu, May 14, 2020 at 09:41:16PM +0200, Daniel Vetter wrote:
> On Thu, May 14, 2020 at 09:09:51PM +0200, Sam Ravnborg wrote:
> > The backlight support has two properties that express the state:
> > - power
> > - state
> > 
> > It is un-documented and easy to get wrong.
> > Add backlight_is_blank() helper to make it simpler for drivers
> > to get the check of the state correct.
> > 
> > A lot of drivers also includes checks for fb_blank.
> > This check is redundant when the state is checked
> > as thus not needed in this helper function.
> > Rolling out this helper to all relevant backlight drivers
> > will eliminate almost all accesses to fb_blank.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > ---
> >  include/linux/backlight.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> > index b7839ea9d00a..e67e926de1e2 100644
> > --- a/include/linux/backlight.h
> > +++ b/include/linux/backlight.h
> > @@ -165,6 +165,23 @@ static inline int backlight_disable(struct backlight_device *bd)
> >  	return backlight_update_status(bd);
> >  }
> >  
> > +/**
> > + * backlight_is_blank - Return true if display is expected to be blank
> > + * @bd: the backlight device
> > + *
> > + * Display is expected to be blank if any of these is true::
> > + *
> > + *   1) if power in not UNBLANK
> > + *   2) if state indicate BLANK or SUSPENDED
> > + *
> > + * Returns true if display is expected to be blank, false otherwise.
> > + */
> > +static inline bool backlight_is_blank(struct backlight_device *bd)
> > +{
> > +	return bd->props.power != FB_BLANK_UNBLANK ||
> > +	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
> 
> This definition here doesn't match backlight_enabled/disable() functions
> we added. I think to avoid lots of pondering and surprises we should try
> to make sure these are all matching, so that once we rolled them out
> everywhere, we can just replace the complicated state with one flag.

Will add it in v2. When all user of fb_blank is dropped we can
safely remove it then.
And as you said on irc, the risk of introducing regressions is lower
as we see some creative uses in the drivers today.
I already did some kind of audit - but I may have missed something.

	Sam

> 
> > +}
> > +
> >  extern struct backlight_device *backlight_device_register(const char *name,
> >  	struct device *dev, void *devdata, const struct backlight_ops *ops,
> >  	const struct backlight_properties *props);
> > -- 
> > 2.25.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
