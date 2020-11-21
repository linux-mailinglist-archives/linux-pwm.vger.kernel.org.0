Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B4D2BC258
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Nov 2020 23:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgKUWAY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 21 Nov 2020 17:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgKUWAX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 21 Nov 2020 17:00:23 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8799C0613CF;
        Sat, 21 Nov 2020 14:00:22 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id u7so7068370vsq.11;
        Sat, 21 Nov 2020 14:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MY8NzMGPcLXMY/ED4DpGvzZfCPFifC8yIRCCQIJaAG8=;
        b=sH8eYt+nuILX4uSEZPd8QQEZZ1sJYsmp0hOBlQs2XgLAJFtvjAvNEPKSHY6tKzmARY
         SqD6woaXcqAIK7niRps8kAehaeMYBgcbDmw1Yx7KxJukvQ/VLJyf1KvBGfM1VozUkA4K
         3BgALZkFxDU1e+n+GSTt5EVe9oV9Tt9dq6kUjgO0hHUPHOowO1UTgkp+t8/Nbjh5mLOK
         NkqvItf7XARVpIbGJfwLM5XhY9Yxcm1JgrSi+WlHy8xy0dRrcDcpelW0X7xL3in3RTZ9
         VzSQiy8Ipv7QFY72BAs3MW5ezeToTuMxsdD6wrwDKfbfIlTno97yTcUW055yCnEdU/OT
         81Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MY8NzMGPcLXMY/ED4DpGvzZfCPFifC8yIRCCQIJaAG8=;
        b=Bv/aXmcBfK8gtZ9ep/pzObcK1+D0Cb3R63gq67lONMyeTSpfF+kwAzIkxqeSe5Rr+5
         BEeph635gep18H9GeYCOpcTymnegSKJRPPJJsLEia8g7KX6WjN2CELuMxMUHvJp4pJK1
         xoJEOwdK20rac7fffEz3fDjhlPayl/5Fd0AL+P4cUskL1jKre2sVhaMa+6N5d47G+63J
         WC4t4o/E9W0V4iOtZ4BcytS0ywenw3QZPZIqOAShDop+p2HVPmYlUG9FMYbQLlOrEt25
         q1DqLV0U/YfWXt/pAhqgaOsm2IUm3sO4Y2N5mdObYkpcdBmrYvy/VzdvUgOttVl9476v
         VCEw==
X-Gm-Message-State: AOAM5332lTyJZ0B4IQM7VixlyZJfWcEkLYTLwtLbRghqjMS0yqvGS7Uo
        S+BTA7ys6PaJfAMiVgRTOTq+jtylfotZII3rHlo=
X-Google-Smtp-Source: ABdhPJyM5fgCbpzyQBMLyFUj2jZYULdnUezsPW1i/hsn0T5zQd5HbyDJmLzm+qad0ideMIVov0zq3o8Sz6uTgDGucuE=
X-Received: by 2002:a67:ff10:: with SMTP id v16mr15914156vsp.40.1605996021829;
 Sat, 21 Nov 2020 14:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20201118174417.278011-1-clemens.gruber@pqgruber.com>
 <CAGngYiV+oDeagaCfpeACMzQyDHVzk9ERbSBjW_fW5hoQANHqog@mail.gmail.com>
 <20201119100005.GA703@workstation.tuxnet> <CAGngYiU7+X1AbadQ0kFBQOqxK-adowg6CTOMx260fyF1-rpO-Q@mail.gmail.com>
 <20201119160013.GA217674@workstation.tuxnet> <CAGngYiUELShMgFnvq6XzF0v=2UAwj7gJsPmbdGkmyAbzhM8OLA@mail.gmail.com>
 <X7krI+JkhCO5nYC+@workstation.tuxnet>
In-Reply-To: <X7krI+JkhCO5nYC+@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 21 Nov 2020 17:00:10 -0500
Message-ID: <CAGngYiWKwDoeM+Hgj-ehJBRp16u2_-dDULzvVbGEUQ2ZOY9w4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] pwm: pca9685: Switch to atomic API
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Nov 21, 2020 at 9:58 AM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> I'd rather continue supporting this driver with !CONFIG_PM. (In our
> company we have a product with a !CONFIG_PM build using this driver)

Absolutely, makes sense. If you do add support for !CONFIG_PM, then it's
important that both PM and !PM cases get tested by you.

>
> I am thinking about the following solution:
> #ifdef CONFIG_PM
>   /* Set runtime PM status according to chip sleep state */
>   if (reg & MODE1_SLEEP)
>     pm_runtime_set_suspended(..);
>   else
>     pm_runtime_set_active(..);
>
>   pm_runtime_enable(..);
> #else
>   /* If in SLEEP state on non-PM environments, wake the chip up */
>   if (reg & MODE1_SLEEP)
>     pca9685_set_sleep_mode(.., false)
> #endif

I don't think we need the #ifdef CONFIG_PM, because all pm_runtime_xxx
functions become no-ops when !CONFIG_PM.

Also, I believe "if (IS_ENABLED(CONFIG_XXX))" is preferred, because
it allows the compiler to syntax-check disabled code.

How about the following? It should be correct, short, and easy to understand.
Yes, there's one single unnecessary register write (+ 500us delay if !PM) when
the chip is already active on probe(). But maybe that's worth it if it makes
the code easier to understand?

probe()
{
    ...
    pm_runtime_set_active(&client->dev);
    pm_runtime_enable(&client->dev);

    if (!IS_ENABLED(CONFIG_PM))
        pca9685_set_sleep_mode(pca, false);

    return 0;
}

remove()
{
    ...
    pm_runtime_disable(&client->dev);

    if (!IS_ENABLED(CONFIG_PM))
        pca9685_set_sleep_mode(pca, true);

    return 0;
}

>
> About the regmap cache: I looked into it and think it is a good idea but
> it's probably best to get these patches merged first and then rework the
> driver to using the regmap cache?

Good suggestion, I agree.
