Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FD43DDE40
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Aug 2021 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhHBRN4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Aug 2021 13:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhHBRNz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Aug 2021 13:13:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35962C06175F;
        Mon,  2 Aug 2021 10:13:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso918153pjf.4;
        Mon, 02 Aug 2021 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DsrhQp/km3AN3/nCdXzxLh4fYNOYR+90bwDH6yArIzw=;
        b=LLoLo79j5gKbVjYyumPfqd8k2EvfByskVN/mylgwfFPReilrjWca0h5TBvIfJCDdfl
         2zIGt7WZV35tZMJt/IAZdVyiR52+3ZBNfH5xiHgVnvEMuFvLJz1iIogrnR1Ivwq2TjSE
         qyLItKXQ3zNFIOA+sMmEqqyFRn5BFQMwBDZ2ygWI0gNlLanC77pCxeZPVjbMFggnWZvx
         +0OjCKyFGmd8NSyV4tHRb/LcYH4M+AmwBz6dJ2uFuH8dU5t+oi+Fx2KZk+nmDTDldBTc
         pF42/DPbjvs7QJw7qOO2FdoPYSKy8E4p1BQld6tr9Jt4Mj3q0Wh77HlK+2w8IxSYIhx7
         Rt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DsrhQp/km3AN3/nCdXzxLh4fYNOYR+90bwDH6yArIzw=;
        b=fivqjxIZt8QoS/+tRVHuUVdjLNdEZdRrsLvE4zlqT/faWYQTNwAFf3pOwDc7/G2Pb5
         NgYYQFuppzRXpTf99Lf6f+RGhFX9D1HqW5ag/yDjqOC41STw+x5ewFAa2bd1Gs6vs2+G
         Qvvj4d5d4o7ImkMdhHR7f5OTwdYKRxi29hQY52+lIBFqqZIRM14WgCXvCGSJ0ed7u1wo
         SeK8gJP7zy3gq4aixN13Nn3mx09DUM6ijGiJBEjOwJ8DVCnUQcaxPnVvpbvYEkt+EuXO
         dey9djw2MYgzcqbQ9l5jjLIHCjtlnBmv4rHgJxJdfJ+SbCTbYHPGLr9T2Mcx1rDyn/bt
         UIXA==
X-Gm-Message-State: AOAM531KUWVzI8v1UrW6hotoQP6S2L2WRDPNrWc6duBK8OFKBKCspP5O
        MKPG+BSa1mE6BsuFAY6B/iOQv3n0DEGUGlnubVU=
X-Google-Smtp-Source: ABdhPJweUosf0ntXfg8F9h9vRNrNHxM5yHY1ehTtGvwGd7VLgJy3fO+s26kJwFxctl4nX18uDgzE3HlPXdBmU9REuUE=
X-Received: by 2002:a63:5a5b:: with SMTP id k27mr2335806pgm.74.1627924425668;
 Mon, 02 Aug 2021 10:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <YPlfcbkxiBmB+vw1@kunai> <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
 <20210723091331.wl33wtcvvnejuhau@pengutronix.de> <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
 <20210728202547.7uvfwflpruku7yps@pengutronix.de> <20210728204033.GF22278@shell.armlinux.org.uk>
 <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
 <20210731120004.i3affxw7upl5y4c5@pengutronix.de> <20210802094810.GJ22278@shell.armlinux.org.uk>
 <20210802152755.ibisunvibmwhiyry@pengutronix.de> <20210802163824.GK22278@shell.armlinux.org.uk>
In-Reply-To: <20210802163824.GK22278@shell.armlinux.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 Aug 2021 20:13:05 +0300
Message-ID: <CAHp75VcpA0vOwN8gBj2iikXW2dw+KCgZEM=QJ5Jx6UWqww=iCw@mail.gmail.com>
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of
 devm_clk_get for prepared and enabled clocks enabled clocks]
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 2, 2021 at 7:38 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> On Mon, Aug 02, 2021 at 05:27:55PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Russell,
> > On Mon, Aug 02, 2021 at 10:48:10AM +0100, Russell King (Oracle) wrote:

...

> > > There have been several different approaches to wrapping things up,
> > > but here's a question: should we make it easier to do the lazy thing
> > > (get+enable) or should we make it easier to be power efficient?
> > > Shouldn't we be encouraging people to write power efficient drivers?
> >
> > Yeah, sounds compelling, but I wonder if that's of practical importance=
.
> > How many driver authors do you expect to lure into making a better
> > driver just because devm_clk_get_prepared() doesn't exist? In contrast:
> > How many drivers become simpler with devm_clk_get_prepared() and so
> > it becomes easier to maintain them and easier to spot bugs?
> > In the absence of devm_clk_get_prepared(), is it better that several
> > frameworks (or drivers) open code it?
>
> It probably depends on where you stand on power management and power
> efficiency issues. Personally, I would like to see more effort put
> into drivers to make them more power efficient, and I believe in the
> coming years, power efficiency is going to become a big issue.

While in the ideal world I 100% agree with the approach, IRL we have
to deal with constantly degrading quality of the code and instead of
thinking about power management and efficiency the absence of APIs
such as discussed provokes not only creating the power management
inefficient code, but also memory leaks here and there.

--=20
With Best Regards,
Andy Shevchenko
