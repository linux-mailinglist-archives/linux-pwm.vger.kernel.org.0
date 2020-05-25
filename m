Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC491E0EE6
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2020 14:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390624AbgEYM7t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 May 2020 08:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390609AbgEYM7s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 08:59:48 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB13C08C5C3
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 05:59:48 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u16so8708262lfl.8
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXtqB8Wun/tgjNkBpbPrNbEYBqWbgFsLrLS2OmL1m/M=;
        b=JqXkjdW/TwAhV/+ZstLcQDiGkcnh2vaThxK4UuXw1ZT4EbewRbqEMxF8cLo9srENSG
         y2bzMe8eVT4GRDrV5lIfGsLezcWERXdbNA0we0XcZSk7s/wgI/0Bg36o+Q5s+WrQwFnR
         9Ezeei8Zk5ZuBxczU7luJMzFJL4NWTdRSEvpgnxSVbeH3cK/DSXlN9Tdbn/KKHl0ElRF
         1c79At+nt2Qv3ftKSagmriY4yHRJuT3SfL5MLqCGu+N67fiYVIz6F+xk123QNykV4Ed1
         Wi4Uy6bedneHNi7QQrkTEzS6GmgrbN7iai2K6CwtEDX6745b9xMfceJdYvhJEE/s2F96
         nJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXtqB8Wun/tgjNkBpbPrNbEYBqWbgFsLrLS2OmL1m/M=;
        b=uVhxyaV3o+VVRdm+Z4qlFHG/JzXaW5EYd/Jfj3ZTOXDa6bWmFZe/mX3OdIYj97tUtC
         6sOKh76PB0AKxyg/w+yUjvRxLJo8bfTmgQ9nVz5YuKbNGdxgw+ciWB7PVBLvY5Al+Ro/
         94ami5pkrY5Cc264FtxKQXDYxXcmj6N3swNDxiN4rkoryb3gfQ3khdDGKUHlwSWcOSAO
         hbOcNKEoJFQvkclrOEr8yTnO+xYl457kr0Uo846qx/rx+py809UtNKd0UeM4AbCp4vuu
         Yjv5CMhrqcHmtIEXFc6SwkbiZe/nRAZb+Nqg3fnVxGKDL7R8pi0rP+IpFfPiZSpbpbKs
         UY1w==
X-Gm-Message-State: AOAM5300/8w0vt6ywxlIgkp1qBY5F/m9ELS6w3roZjqMi/ZGHfZIta6L
        RG+m4Lx99dU6PD86Ig6IxwBQdDG06oG6YFzDScrpWg==
X-Google-Smtp-Source: ABdhPJxD2+KgVOK9WTwoquq8HqW2c21+zgJ2wXOdh5XtNRaWnyUiVdw++6s8JUaftb7+v3ytf4RuSWtwx/6fIhWUhyk=
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr14490822lfn.77.1590411586745;
 Mon, 25 May 2020 05:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200423174543.17161-1-michael@walle.cc> <20200423174543.17161-11-michael@walle.cc>
 <CAMpxmJV3XTOxuoKeV-z2d75qWqHkgvV9419tfe3idDeKwoeoLA@mail.gmail.com>
 <75bff2917be1badd36af9f980cf59d2c@walle.cc> <CAMpxmJXctc5cbrjSeJxa7DfmjiVsbyhqAbEKt-gtayKhQj0Cnw@mail.gmail.com>
 <951244aab2ff553a463f7431ba09bf27@walle.cc>
In-Reply-To: <951244aab2ff553a463f7431ba09bf27@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 14:59:36 +0200
Message-ID: <CACRpkdZYEZk7o+Y2-AqnHGsY8N7KGGmPGSuSS=H7YY8VLZ3jZw@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] gpio: add a reusable generic gpio_chip using regmap
To:     Michael Walle <michael@walle.cc>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 25, 2020 at 12:20 PM Michael Walle <michael@walle.cc> wrote:

> If you like I could submit this patch on its own. But then there
> wouldn't be a user for it.

I'm pretty much fine with that, we do merge code that has no
users if we anticipate they will be around the corner.

Yours,
Linus Walleij
