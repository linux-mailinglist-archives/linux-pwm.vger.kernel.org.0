Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1B731BAD9
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Feb 2021 15:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBOOTK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Feb 2021 09:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhBOOTI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Feb 2021 09:19:08 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A64EC061574;
        Mon, 15 Feb 2021 06:18:28 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id c44so2411120uad.12;
        Mon, 15 Feb 2021 06:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkNyAS6eMcPhEpMPKFlNgf2kOWM3dGOcbf1ISpcwe/c=;
        b=jGZyyVVCYMk0D78xryAnvDALibBeg4qMklKuLcrr12J8ReHaXad2+IHXRrFKFUZb/i
         DeKddPdxdk3ie2ope8DivM/4H2ebX88PjicM50fmm6dK9kAStN3NAkYRXzsw8pvY8y0g
         3c/tyd5xCYQd9XF99JvigikmhQYrEzRGa+iaxcyTMz68t9O5P5J+/Lk+x8PRAx5jJEe5
         ORQNmoHumTAJBzSQkHc4HQmqoK2MJe135Vjx6dWSwrEV/RYlW7w1XWhApmJwr34Yoa9N
         LSYPO82fyPgdoopQihoHWuwPkFTgj9swrEPLPN22kgRfJOCbbIjIB3gqNtvQDFUeyruX
         xEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkNyAS6eMcPhEpMPKFlNgf2kOWM3dGOcbf1ISpcwe/c=;
        b=pPPsgNEqwZqoac9545Hj8pdHm2ZwrE9HI1i2PwoovSSzGovh550m8cQeRuwx1indAR
         V71Q85MemIUfyIkPH6nnZpSqZmQCXVuIWAksu8xovHhSxkFR8K2ChJN8G5VlJh4vLbgU
         G+iS2B48EyV6pNnbiQ5BXYVCyNStbN4tNW2YSHr8V1G9l7dH2oJPn3zz7hjKGhJoRQak
         /k7j1PIkmYrVWnuO+UCZUKy0jxGPmmNRLrsCnEkGbOmXDuJxH9I+uiDOGyp2IQYk2wsU
         jxCvysLKcnutzwHwh/I73ac+I0aTc23B1wSul2mM3CuayVIGM9TjAZwxcadl6jy4aRpq
         od+g==
X-Gm-Message-State: AOAM530zDPtlbTK5Z7NlQ0OtY92lFzlB5bNt6OF784Qj/aG+AGlwGnij
        ZrjG6P/givH2QzYq3+Uqocl0cud9BHEaWBDCckY=
X-Google-Smtp-Source: ABdhPJxu3LvnHPyEAD8T9tnva6iCu0otMcb/YaxTz98zbbc5OoSlhfJkCg/5MtqtrqsJew8ycUpaymlmtDUYA4Ygsz8=
X-Received: by 2002:ab0:5b0e:: with SMTP id u14mr8636749uae.19.1613398706639;
 Mon, 15 Feb 2021 06:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20210212163229.68270-1-krzk@kernel.org> <20210215085241.GG179940@dell>
In-Reply-To: <20210215085241.GG179940@dell>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 15 Feb 2021 14:18:15 +0000
Message-ID: <CACvgo53wn84G8wuyF++=bwtjnVzVB31BA2_JBWnihnwinSFD7A@mail.gmail.com>
Subject: Re: [PATCH v4] MAINTAINERS: move Milo Kim to credits
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-pwm@vger.kernel.org,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux PM <linux-pm@vger.kernel.org>, linux-iio@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Greetings everyone,

On Mon, 15 Feb 2021 at 08:52, Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 12 Feb 2021, Krzysztof Kozlowski wrote:
>
> > Milo Kim's email in TI bounces with permanent error (550: Invalid
> > recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> > credits and remove the separate driver entries for:
> >  - TI LP855x backlight driver,
> >  - TI LP8727 charger driver,
> >  - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> >
> > ---
> >
> > Dear Lee,
> >
> > Could you take care about this patch?
>
> Yes, but I'll be sending out my pull-request for v5.12 in the next
> couple of days (maybe even today if I can find some time), so this
> will have to wait until v5.13.
>
Would it make sense to keep the MAINTAINERS entries as "orphan"?
Checking with linux-next, the drivers are still present in-tree.

HTH
-Emil
