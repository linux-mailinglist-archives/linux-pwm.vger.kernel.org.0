Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C907114374D
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2020 07:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgAUGzi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 Jan 2020 01:55:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40754 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUGzh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Jan 2020 01:55:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id s21so912431plr.7;
        Mon, 20 Jan 2020 22:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6PzqgL/8WGciYWOgKUtVnsTmTFSDBewNa2kfoHRg408=;
        b=pAryYGyoK4/sFt4zgrOzH7793pBByZ9HUDxTtfP6f5KMblHeSzrIjcEi06s0aeZ69g
         fr0bLC7abgju9zmn/O1RbT0zk5TmM60tTV0jTCmzTLvqa9RN4YggILape/e2ZLg/zsVL
         svJ68qbh3v/CjrtZydJotBGq9RxyBWvTmYfb5Dnkf+pC7F32+oZs28PExNlAYV5VJ9cU
         FNMeTKui5yVwF+/sELlOoKIwfukf9CmUBk8WFaQ4ghxE8aUgHM0zFJBLS1pt6WxxMLrn
         Yr/KFwSbpKRPXsc/+ra5+ZoPQXGvVtnEFEM4F2q9Lec6ZqDjPuj8k5xWrE1MtSg48qVi
         gU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6PzqgL/8WGciYWOgKUtVnsTmTFSDBewNa2kfoHRg408=;
        b=BFITXBIKZc3HrhLjPGxPMQu9Lom48K6bSCqg0epN7bduPtBYJpNaykwBQZ7lA4rhQN
         AJ0tdN3UT6a/sUz95DysIqTvz4+6nYYw4a3tm10jDuPtfkNP35rKt9E+WVJPKkqfYyqD
         4CrDzmdRVuGo1JI04JwiLUqFD1xE3LDX0Pp10jg3JCyCJVgkf/xWIPGl2wF0j/X20bBa
         kvTfZCUVlR317tQmVLgAfG5+GaVhzTl6cbOroRRA99Lva4Rg0wuQplhmABaEyc7wuLRO
         JzwkKnPNdcCV5iGa++DW+EYknfsxWf2MFBVwcfMiH+rXC/rO0lR3AicnKinJOhcgAwwV
         Cqmw==
X-Gm-Message-State: APjAAAWQVqhVRYLA+lcvfySTN/NjLmMoS8FUO52GApUQy5j9I+RaiKB7
        kiTVcSZp1iFuqk0Ac4tXpzo=
X-Google-Smtp-Source: APXvYqy2oCuI8DpNUIqrjh8m6wK7ReCcFVoWOkZIMvvB48sYPFNbfSRoLvWgRkjV5RD1NiQnC7EkDg==
X-Received: by 2002:a17:902:b78b:: with SMTP id e11mr4027580pls.129.1579589736901;
        Mon, 20 Jan 2020 22:55:36 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i3sm43361101pfo.72.2020.01.20.22.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 22:55:36 -0800 (PST)
Date:   Mon, 20 Jan 2020 22:55:33 -0800
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v4 3/7] input: keyboard: Add support for Azoteq
 IQS620A/621/622/624/625
Message-ID: <20200121065533.GN47797@dtor-ws>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-4-git-send-email-jeff@labundy.com>
 <20200117213330.GF47797@dtor-ws>
 <20200119224025.GA28865@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119224025.GA28865@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jan 19, 2020 at 10:40:31PM +0000, Jeff LaBundy wrote:
> On Fri, Jan 17, 2020 at 01:33:30PM -0800, dmitry.torokhov@gmail.com wrote:
> > On Fri, Jan 17, 2020 at 02:35:46AM +0000, Jeff LaBundy wrote:
> > > +
> > > +	ret = device_property_read_u32_array(&pdev->dev, "linux,keycodes",
> > > +					     iqs62x_keys->keycode,
> > > +					     iqs62x_keys->keycodemax);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "Failed to read keycodes: %d\n", ret);
> > > +		return ret;
> > > +	}
> > 
> > I wonder why you can't simply use
> > 
> > 	error = device_property_read_u32_array(&pdev->dev, "linux,keycodes",
> > 						iqs62x_keys->keycode,
> > 						IQS62X_NUM_KEYS);
> > 
> > Are you concerned with someone trying to set up keys that are not
> > actually exposed later via EVOCSKEYCODES and that is why you are
> > limiting keycodemax?
> 
> When I try this, I find that device_property_read_u32_array returns -EOVERFLOW
> for arrays with fewer than IQS62X_NUM_KEYS elements. To avoid forcing users to
> pad the array all the way out to IQS62X_NUM_KEYS in the case of simple channel
> assignments (like those in the example bindings), keycodemax must be passed to
> device_property_read_u32_array which means it must be limited before-hand. The
> same method seems to be used in other drivers as well (e.g. mpr121_touchkey).

Ah, indeed, ignore me here please.

...

> > > +MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
> > > +MODULE_DESCRIPTION("Azoteq IQS620A/621/622/624/625 Keys and Switches");
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_ALIAS("platform:" IQS62X_DRV_NAME_KEYS);
> > 
> > Otherwise
> > 
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > I suppose it will be merged through MFD?
> 
> That's the plan; Lee confirmed this would be OK once the series is ready. Just
> as a heads up, I expect minor changes to this and other patches as iqs62x.h is
> hardened (e.g. "iqs62x->map" --> "iqs62x->regmap"). I assume you're OK with me
> keeping your Acked-by unless there are major changes, but let me know if you'd
> prefer I didn't.

Yes, please keep Acked-by unless there is significant rework.

Thanks.

-- 
Dmitry
