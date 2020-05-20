Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C00D1DB7C6
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2020 17:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgETPLG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 May 2020 11:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETPLG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 May 2020 11:11:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AAEC061A0F
        for <linux-pwm@vger.kernel.org>; Wed, 20 May 2020 08:11:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w64so3253694wmg.4
        for <linux-pwm@vger.kernel.org>; Wed, 20 May 2020 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=06NUZT5oLkpj/XtrzauexC0pCoY/y9Ccf9pqJFj0T/w=;
        b=XeXcnSDzB20IzMYYaQc9pOwritNDhN6imrcAkJ4CQWTpEH4aPAeQSPDPNLbV92j0SA
         oAawwf0ELlavBL5WcYpoYotPxq3q80A0ycLUmleNIPklD/w0z2hOGmGw3g2l64l0ZcBa
         +eNoVGxtdarKvXxzaEpRw1bHNhwynO8pkMUwPDu2f7CK39ziSKfFLo4IUJfS5BuGXWQR
         nUl14WTVTeIchrBTfxakLBZ48pHDzKI1mtdnT6gerck5nHBfTtwAGvbpTOBmcAwxkbGh
         zO4UXftbsmhDety8B3sp1iDmZItDGTm/tZFBNsRvL0tBlDTZ61eOTckjW8Jx6yh4zDK5
         DlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=06NUZT5oLkpj/XtrzauexC0pCoY/y9Ccf9pqJFj0T/w=;
        b=jL5jfWbykIJWYm775CEB5WI2NB+loFw4L+n8OnXqZnC0y2oJL8Qgcq7kpd7v7hV9HK
         EKQBKYrM/Bv6T6baJagapOJU7bH+99gWLbT6ty23HqosIJ8/LbakVnOEmISacti3wih1
         c5w92CObNopWP8PJNP6bBMArbkMAieruwCM3lCsWezyXu7B5dGIdGsKGNFhUr6Qf3GOX
         OYCWfZW6e9EMM96Qf1nQWgEhO4yw4jyWKDDTdOVLtNqKfH6UtNMk11p0MDG2LQxJIozm
         rVb+XmdhPL52ZOZ/Y/sH/rTrRNijEtdpeYwxvxuZoI57Hc7g27tHY3VQsXbVou+UeUu3
         aI1w==
X-Gm-Message-State: AOAM532cJVffCMHRcXPQFJx72zki+GK1g7wwgMF3kw+u6Zm0KV+zizjh
        1nxwIkOkwofHHeT1aUGQIQ/Qcw==
X-Google-Smtp-Source: ABdhPJyXMBtgIyVHWRYhaf2yK4ztGsyMk20Pe4z2hkQyG7pzqRrGTcnZZ8hRIeRanLf0UxioF5MHfg==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr5281698wmc.137.1589987464578;
        Wed, 20 May 2020 08:11:04 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id p10sm3297653wra.78.2020.05.20.08.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 08:11:03 -0700 (PDT)
Date:   Wed, 20 May 2020 16:11:01 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-pwm@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        patches@opensource.cirrus.com,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 16/16] backlight: use backlight_is_blank() in all
 backlight drivers
Message-ID: <20200520151101.tp4eaiadqq36wyy7@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-17-sam@ravnborg.org>
 <CACvgo51C6zb_K3DBwG-xhf9=baoxmcp8YeCFEyB3XvqA5p7r2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACvgo51C6zb_K3DBwG-xhf9=baoxmcp8YeCFEyB3XvqA5p7r2A@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, May 20, 2020 at 11:56:43AM +0100, Emil Velikov wrote:
> Hi Sam,
> 
> On Sun, 17 May 2020 at 20:02, Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > --- a/drivers/video/backlight/88pm860x_bl.c
> > +++ b/drivers/video/backlight/88pm860x_bl.c
> > @@ -123,13 +123,7 @@ static int pm860x_backlight_update_status(struct backlight_device *bl)
> >  {
> >         int brightness = bl->props.brightness;
> >
> > -       if (bl->props.power != FB_BLANK_UNBLANK)
> > -               brightness = 0;
> > -
> > -       if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> > -               brightness = 0;
> > -
> > -       if (bl->props.state & BL_CORE_SUSPENDED)
> > +       if (backlight_is_blank(bl))
> >                 brightness = 0;
> Off the top of my head, the above two lines should really be in backlight core.
> There's nothing driver specific to them, plus it minimises the chances
> of next-driver getting it wrong.
> 
> 
> > --- a/drivers/video/backlight/as3711_bl.c
> > +++ b/drivers/video/backlight/as3711_bl.c
> > @@ -107,13 +107,11 @@ static int as3711_bl_update_status(struct backlight_device *bl)
> >         int brightness = bl->props.brightness;
> >         int ret = 0;
> >
> > -       dev_dbg(&bl->dev, "%s(): brightness %u, pwr %x, blank %x, state %x\n",
> > +       dev_dbg(&bl->dev, "%s(): brightness %u, pwr %x, state %x\n",
> >                 __func__, bl->props.brightness, bl->props.power,
> > -               bl->props.fb_blank, bl->props.state);
> > +               bl->props.state);
> >
> Let's also move this to backlight core.

Or just nuke it ;-)


Daniel.

