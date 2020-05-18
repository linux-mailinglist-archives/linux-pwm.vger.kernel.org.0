Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CBE1D8893
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 21:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgERT5C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 15:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgERT5B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 15:57:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF17C061A0C
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 12:57:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so721202wmj.3
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 12:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PbdRyg5kcd//DX8aThqSi8QmNWbORlgHp5rh1J6SqIY=;
        b=kA7beYhILj0prjYk3znsZ8vtZ7ZDrlQiKMA8sojxIRQXdGFCC8xIgp5oYZcsv/epOa
         z+WwumTl1Z5l7ZX9B/eSRrqY5mx549cQYP//s64DW4RKuMRcjPBWW5fQi5fAZlenSkZJ
         Nt1WvnhlH1BgUXRpg/hIsSY/DfNuQGXGDvjHA4ulU45A3PQ10l2Ii7oIjU1ZrqUblkDo
         NA0ch0kHTUl/VyMp6QdehDNFFaESotNNxJsywuZFaJQrnp3f1uIg+jX+nk1vK3Ecm+b4
         P6xmu/BErHxodXVZt88F3zAeY0oXRqfODvYoE6KNDpKet9iKSLYq8FddTeCPBpnQTVNX
         KOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PbdRyg5kcd//DX8aThqSi8QmNWbORlgHp5rh1J6SqIY=;
        b=bA/uZBaFDLkugCrE4p+A+Z2whjz/4SgBGR72PuPZCoN8L+D3xPPbmNPT0jbz+DbYGh
         AijasN+EA8cMcwwVb5uzYVxtasdE9TDJW86c2DAlGf1p5CSrB9wOO8Bsk6zijD6E7zGC
         2NjbmsxfI1/LgUd9LwIlq1RY+WH4A1vDo7xtVrIIGQJaNjTQK8xtg/zUbgqWYQIeXzff
         xyCORfnoycX1EegUT9YF0EZcR+kptX30Z29qNugChtHQAEy1ukAxAgFVyzh17tOdlz5o
         qa/z8UT0b87bD+YUzvGjPDwL/8tyRdTQfZ7bv6kgcYSkzk7Z/hExnzb34pWdXIIOWo3y
         czlQ==
X-Gm-Message-State: AOAM533CgSagV8NERLddRTfkHRsQj8i4qLCEV6Vp5i2c7nvBgf/1zSpr
        e3HbPNH7nj8pWrn+93YUKCURYA==
X-Google-Smtp-Source: ABdhPJzoU8qbbvxxC3cizf6NI6NFIEqaKyHByjJ4SgRZLqqZ0f2ZQseTGjC1Xa9OdZep5QtoO5pCtw==
X-Received: by 2002:a1c:3b87:: with SMTP id i129mr1150807wma.38.1589831819961;
        Mon, 18 May 2020 12:56:59 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u10sm769695wmc.31.2020.05.18.12.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:56:59 -0700 (PDT)
Date:   Mon, 18 May 2020 20:56:56 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-arm-msm@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 15/16] backlight: make of_find_backlight_by_node()
 static
Message-ID: <20200518195656.z2wag34mbr3e2hip@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-16-sam@ravnborg.org>
 <20200518165648.ltgtofjsteyyse4j@holly.lan>
 <20200518181227.GC770425@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518181227.GC770425@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 18, 2020 at 08:12:27PM +0200, Sam Ravnborg wrote:
> On Mon, May 18, 2020 at 05:56:48PM +0100, Daniel Thompson wrote:
> > On Sun, May 17, 2020 at 09:01:38PM +0200, Sam Ravnborg wrote:
> > > There are no external users of of_find_backlight_by_node().
> > > Make it static so we keep it that way.
> > > 
> > > v2:
> > >   - drop EXPORT of of_find_backlight_by_node
> > > 
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > 
> > Assuming the 0day-ci comments are because some of the patches have
> > already been sucked up in a different tree then:
> Correct. For now only drm-misc-next have no users of
> of_find_backlight_by_node() which is why the other trees failed.
> 
>  
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Thanks for all your reviews!
> I will shortly (within a few days) address the comments and send out a v3.
> 
> Is is correct that I assume you or Lee or Jingoo will apply the patches
> to a backlight tree somewhere when they are ready?
> If you have a tree you use for backlight patches I can base v3 on that,
> given that I get a link and have access to pull from it.

Absent holidays and the like, Lee usually does that actual patch
hoovering.


Daniel.
