Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6174300002
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Jan 2021 11:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbhAVKRs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Jan 2021 05:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbhAVKQX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Jan 2021 05:16:23 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36965C061786
        for <linux-pwm@vger.kernel.org>; Fri, 22 Jan 2021 02:15:23 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m22so6772855lfg.5
        for <linux-pwm@vger.kernel.org>; Fri, 22 Jan 2021 02:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JeOk+55hs/OjAgPyY2pb0nUEwkpKQZfK7wFamZWRbYs=;
        b=ZutjUI2lm71tLSgZAaQNa0u/+Urgw/34kwRHkYdDkn5FxIxtrRCeAOTHzgeWePnwYs
         kUSrCiLPSzdFwOlKTwcAzg09jPp+C0rMFFdw0krhbTLHYaJ8cPBw9TSgpEesedTLXDo0
         jGY6dXbt8fMo6RPM/UWHbEthK2UMyq/nU6RbWeAYDB8/Q5q1Z4hwltIvJZOSSmzRu9Lz
         ypDtXM6pz5ZAKV6IuJYFAzfOZL/4u1harAEtafCjedsMab9QVBiHaon68kJ9HC3Eib2j
         o/vFbypqY3CqiRpX+P70hkrAVAX4Z1qoac2LNHlnACwRBydFFKCkAaIDaCmPHZ1roA9Y
         BJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JeOk+55hs/OjAgPyY2pb0nUEwkpKQZfK7wFamZWRbYs=;
        b=Cc+3l2dTO0Vql8y32w5cj3TUdsVRIZOWXfprOQPymhtOiCOckHBHLUMaP1NLABxNPe
         dDvAXERyjpw2bfpiyZdoOfawTvZ866AlsAdHHC1TR7XlnygBjQJIywrZz43nOaCc/lJs
         1jyVkZUoQDiEKFp43BDAfIDklemoi/uQ9R9uEjX/E0J98nnuJPkDkZ/bt68d9vq3OPVv
         CZVG8IVAiQR9ZxLSng/njaiSz91EYZksPo9LVpzOXKYXjFNz6RhB1+Bz8VHoQk2QseHF
         gfyDEAl/j1iGCXbzUuu5YO3AclzTSVr1Evx8mfm9JW1la167aSGJtG+D3sZowZgv63Xc
         bbbA==
X-Gm-Message-State: AOAM5308+EERZz5aIr4HGB9gItyhauW8dtrv7O2ETZQNC3BI8iJ4vyx4
        ygUhrH5JnSafZ5DE0oa0R/l6N0LaOIy1s4n2yu0VBQ==
X-Google-Smtp-Source: ABdhPJxxdubXPUSxQzdq6d+z5fTzKW36/7vCD1kavkda0eM8/Ly6Qv8oTZwe5Q/8DW3CLRR1CypzljgEijF8mX6PknA=
X-Received: by 2002:a05:6512:3238:: with SMTP id f24mr1964113lfe.29.1611310521729;
 Fri, 22 Jan 2021 02:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com> <20201211170432.6113-2-nicola.dilieto@gmail.com>
 <20210117130434.663qpp6noujptdyt@pengutronix.de>
In-Reply-To: <20210117130434.663qpp6noujptdyt@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jan 2021 11:15:10 +0100
Message-ID: <CACRpkdawMpuznr-XC2uvZm8PvOj-jObpnbz6iptV-Q4OFxjesw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Nicola Di Lieto <nicola.dilieto@gmail.com>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Nicola, Uwe,

thanks for looping me in on this very interesting driver!

This can be really helpful, I already see that it would be possible to
replace the hopeless idiomatic driver for the NSLU2 ixp4xx
beeper speaker with this driver.

On Sun, Jan 17, 2021 at 2:04 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> > +static void pwm_gpio_work(struct work_struct *work)
> > +{
> > +     struct pwm_gpio *pwm_gpio =3D container_of(work, struct pwm_gpio,=
 work);
> > +
> > +     gpiod_set_value_cansleep(pwm_gpio->desc, pwm_gpio->output);
>
> Usually you want to check the return value of gpiod_set_value. @Linus +
> Bartosz: What do you think, does it need checking for an error here?

We have traditionally been quite relaxed on that. But since it is
the cansleep variant, meaning this GPIO could be on a GPIO
expander on I2C or SPI, it would be more important.

However: in this specific case for PWM I wonder if we should
stick with gpio_set_value() without _cansleep, and then we can
definitely skip the error check.

That means GPIO PWM can happen on on-chip GPIOs that
are just a register write. Certainly no need to check the return
value of these. Also we know it will satisfy timing.

If we allow GPIO PWM on slow buses and expanders that can
sleep I do not think the PWM will be very good or reliable.

For example on an I2C expander, with the bus speed of
max 400 kHz, what kind of PWM can we create on that?
Certainly now above 200 kHz (Nyquist frequency) and
probably less. And we have to way to actually check the
frequency of the underlying bus, so I am a bit skeptic
here.

Would gpio_set_value() work for now or do we need to
support expanders and _cansleep?

Yours,
Linus Walleij
