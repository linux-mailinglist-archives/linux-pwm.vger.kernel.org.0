Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7493E36F174
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Apr 2021 22:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhD2Uz2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Apr 2021 16:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbhD2Uz1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Apr 2021 16:55:27 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2263C06138C
        for <linux-pwm@vger.kernel.org>; Thu, 29 Apr 2021 13:54:40 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso29635262otp.7
        for <linux-pwm@vger.kernel.org>; Thu, 29 Apr 2021 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cDEQYYCABMBKlLd20tFhLfZu2zu60qgD4qzCgh4a7Hs=;
        b=DuAjdN32RcXze+taixHhxgfk+J8jEGyrIP07wW6CuRJlnkwYge0i/2pVD3UWE00LPu
         2flBNq/HqM9PGCVOSQWWXLDOWL2LXZ+8OWH564Jz/f2/RuF7rOr3X+xmikVY9yjiXFHu
         Uy5t2Ep3oGnuPCWrbpmv0BXDicBzrU7UYFgvFMEG6yYstAhpThE3oANFC9alPuOBjjN0
         eOa4614uUoD7/6gx2klBruypLvTfZiCHOJx1aF1Fdz27XD8gyLUSkMpeT4o20YnIccPz
         VdREWbe+js7q1E8RdxjeMb7FknGneURiYzQyhC6WXvxSVPdUNS3hPBZz4eRMuc0Jlsto
         Bweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cDEQYYCABMBKlLd20tFhLfZu2zu60qgD4qzCgh4a7Hs=;
        b=bDQHvh1yBEeY1cEy+XGBeBFgl/JcoDd2Ibnbs3sC9fn17WBpU4h7CimZ6EqmahbZR8
         9PkDuhLO3TQAIfs746VWqOXd6VYdiYB92UXDBOfQwc2cZDRvqGNdHc7auYZaLqzlCv0Q
         JErqsGOfWhpUW0AHTBLk2PCrjHwJI6YmZuPWw0aPH0ZbdfYpC4M3Kiat3HPzsbVkwBKc
         kxwfue0zFokInf/hmNXPA7yvrKBKug5S+7gQBuTvEQRG3e0U8gbwZtSMJVTpgdhfMKiH
         wlXCrXJ+MUku0aJ9R1BdjgtCDwidXXfnX67rxs+wcFdiWLodx7dsuzpDBfGC8x2fvCi1
         +OhQ==
X-Gm-Message-State: AOAM532KkoC/x5YsvuFsarNQAWLhJRaK6BZwE5qQiOR7BqCsVgQlodgI
        t8jQfyUfJumUkl+NZzcJzK4eiQ==
X-Google-Smtp-Source: ABdhPJwb1Us3vfLjZyNwGpHnKQtg+2ziIVzR4m/46fSQ3cNvwsZZhbPQrBPKVaThPYh2I7jxQRlUIA==
X-Received: by 2002:a9d:17e9:: with SMTP id j96mr1019565otj.143.1619729679793;
        Thu, 29 Apr 2021 13:54:39 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i9sm200057otr.19.2021.04.29.13.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 13:54:39 -0700 (PDT)
Date:   Thu, 29 Apr 2021 15:54:36 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
Message-ID: <20210429205436.GA2484@yoga>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
 <20201021201224.3430546-3-bjorn.andersson@linaro.org>
 <881fb5a3-fb51-3967-63de-a09950839855@somainline.org>
 <20210428223939.GN1908499@yoga>
 <f7fa3d57-3541-130a-e5fc-0df31206598f@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7fa3d57-3541-130a-e5fc-0df31206598f@somainline.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu 29 Apr 14:31 CDT 2021, Marijn Suijten wrote:

> On 4/29/21 12:39 AM, Bjorn Andersson wrote:
> > On Sun 18 Apr 16:54 CDT 2021, Marijn Suijten wrote:
[..]
> > > > +	ret = lpg_init_lut(lpg);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > 
> > > 
> > > How about turning these returns into dev_err_probe?  I'm not sure if that's
> > > the expected way to go nowadays, but having some form of logging when a
> > > driver fails to probe is always good to have.
> > > 
> > 
> > The intention is that each code path through these functions will either
> > pass or spit out an error in the log. I looked through them again and
> > think I cover all paths...
> 
> 
> That is true, all the errors not covered are extremely unlikely like
> -ENOMEM.  I vaguely recall having to insert extra logging to get through
> initial probe, but that might have been something inside lpg_add_led as
> well.  Fine to leave this as it is.
> 

When kzalloc et al returns -ENOMEM it will be done with an error print,
so that does not need an additional print. That said, another pass
through lpg_add_led() made me spot that if you get a parse error on
the "color" property we would silently return -EINVAL. I've corrected
this.

Thanks,
Bjorn
