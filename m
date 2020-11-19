Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004572B959C
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Nov 2020 16:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgKSO6j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Nov 2020 09:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbgKSO6j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Nov 2020 09:58:39 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E663FC0613CF;
        Thu, 19 Nov 2020 06:58:38 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id x13so2001728uar.4;
        Thu, 19 Nov 2020 06:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0X6ei3+dw0Ixie54vJ6xzjoLnN3RiQKq6WUuQ/cy9nE=;
        b=nSCUSMcsc87MgfVVWxgQ3p9zU/yWpk9azEszsZ+ip8PIgBW1c4GC0jSe/zPWJoHWTZ
         r6uB0lo1yzn8vmzdilpX+zG/sTkdypXBFVhw0t/3UELss7Nbg2nRSdv7a9ZAQf/CJaoA
         bJCLu63Ao/qnPxwQpyiGfQbD6YnDSvVJFNzi9CN+t6elmBz370FroTmN2Dc8C+fXQw3Q
         lHa7sEIwbtwQWr6nyiRnEakgA/5ldBnyqvGXjh7FPuQNHl/r6ktYVmHW33Jsw3A/9UKO
         FkrgRRlfl1v2sqEedV2hh+5EP5SFyKffFHuSGKzB9R9ec8q9c7iwintxQksrfZhJAhnx
         IzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0X6ei3+dw0Ixie54vJ6xzjoLnN3RiQKq6WUuQ/cy9nE=;
        b=cBsVJtnVw5oGrSeMTIQWFmgCVfjidtH3zL7+gTfmKKBQRe9v04o6yrzoTvv6cRZ2Os
         DZZVBnEZ2VCmlW55fgvM9dNNnFYIr/a9AIkdquwFjYuS26tpTJaEDXNCTrd1/tldOjzu
         0ZswXf64kTApJgeF7/5D5b0LpJcWPt/emGF4yTWduutPKickdBl8nSG58g3LBvSagy+b
         W1xtzv1Uy3Vmo7BOAoRnVOOW+ckxsj3pi5QXa/VwBSJKsLfArj0SAXT4TkiJEApjf59L
         Z0K7DsgZxhU5C1jinrB7CnTaXZ9lDOc9GJ4eEzSbl3S7vu9xbQDsbZvhm3OwKNg1rHD6
         rL6w==
X-Gm-Message-State: AOAM532asXfqmor6syWh1dyUhhCFitFj2ES7e71zfOTl/CtFukj5ZNX8
        FzuvDA1BRcKUwan9bPe9s00K+Kr2wtkYAwZ5H5o=
X-Google-Smtp-Source: ABdhPJybH08eUOhkjXA+uy1MK5oybKgxRANfgJy2clNuS38q+12ZHNjvPr0fBnTO5j+7AUIDD1aA3PwhK5Hv/WZnqMs=
X-Received: by 2002:a9f:2583:: with SMTP id 3mr6980138uaf.134.1605797917764;
 Thu, 19 Nov 2020 06:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20201118174417.278011-1-clemens.gruber@pqgruber.com>
 <CAGngYiV+oDeagaCfpeACMzQyDHVzk9ERbSBjW_fW5hoQANHqog@mail.gmail.com> <20201119100005.GA703@workstation.tuxnet>
In-Reply-To: <20201119100005.GA703@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 19 Nov 2020 09:58:26 -0500
Message-ID: <CAGngYiU7+X1AbadQ0kFBQOqxK-adowg6CTOMx260fyF1-rpO-Q@mail.gmail.com>
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

On Thu, Nov 19, 2020 at 5:00 AM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> > You appear to mix cached and uncached uses of prescale,
> > is there a need for this? If not, perhaps pick one and use
> > it consistently?
>
> Yes, sticking to the cached value is probably the way to go.
>

I would suggest going one step further, and turn on the cache in
regmap, i.e. .cache_type = REGCACHE_RBTREE, then:
- no need to cache pca->prescale explicitly, you can just read it with
  regmap_read() every time, and it won't result in bus activity.
  then you can eliminate pca->prescale, which simplifies the driver.
- pca9685_pwm_get_state() no longer results in bus reads, every regmap_read()
  is cached, this is extremely efficient.
- pca9685_pwm_apply() and pca9685_pwm_gpio_set() now only does bus writes if
  registers actually change, i.e. calling pwm_apply() multiple times in a row
  with the same parameters, writes the registers only once.

We can do this safely because this chip never actively writes to its
registers (as far as I know).

But maybe that's a suggestion for a follow-up patch...

> > Also, if the prescale register contains an invalid value
> > during probe(), e.g. 0x00 or 0x01, would it make sense
> > to explicitly overwrite it with a valid setting?
>
> As long as it is overwritten with a correct setting when the PWM is used
> for the first time, it should be OK?

I'm not sure. Consider the following scenario:
- prescale register is invalid at probe, say it contains 0x02
- user calls pwm_apply() but with an invalid period, which results
  in a calculated prescale value of 0x02
- pca9685_pwm_apply() skips prescale setup because prescale does not
  change, returns OK(0)
- user believes setup was ok, actually it's broken...

Also, some people use this chip exclusively as a gpiochip, in that
case the prescale register is never touched. So an invalid prescale
at probe is never corrected.

Speaking of the gpiochip side, would it make sense to call
pca9685_pwm_full_on()/_off() in pca9685_pwm_gpio_set() too?
