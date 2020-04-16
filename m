Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1831ABCAD
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 11:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440193AbgDPJUz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 05:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392127AbgDPJUy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Apr 2020 05:20:54 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD230C061BD3
        for <linux-pwm@vger.kernel.org>; Thu, 16 Apr 2020 02:20:51 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m2so5024445lfo.6
        for <linux-pwm@vger.kernel.org>; Thu, 16 Apr 2020 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iuZQPq25LlhzAjymFw6DX/CB5GWOdpk6lIwmaoZu2BE=;
        b=hkTtnz2DkVpj5FadPidho1Yi0E3E7wBAIYmB61/Kj4lK/X8UrCLL81x5xmrcWGWc+H
         azS6fkmcowWvwOnDXcI9l4y6Ucno0mzyziNpLxV9Mthz8Y0YUdXq82D8FzhAITXPdDF8
         3tFd/DXFS5Ty+STvGvcwXllNt8lFNMCiTuvCiXYSz2PukY3ig/gTtCqCjuJHHyXpd1A3
         QDfx/KUMUCLzLxrTqLoSlNd+gU4YBuAYH/DvcY6yoeUzHZc1o3NaKorVY+VcrIzkfObd
         u7uovSiNsexRzNZk8c0flO0ZydCK1WaSDd1IcMQT71DefMnE/zm8iho+FD/0QJcA2MJG
         wMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iuZQPq25LlhzAjymFw6DX/CB5GWOdpk6lIwmaoZu2BE=;
        b=M2XS8lu2Qo5Vf7ClWf9IgDtQ8P8U/QmH79GdUrLCFXyAzU7W8I2TNMrih/JOGJdsNg
         3THwe1Ap70AFtUAzC0uxHkouhBmer7VVrYuBfJa+ip7Id2e8tc0EDq+lkv2uuqVcPbWD
         P0ImuXIKKVq2xYQWrwHjlRQhpqaNX/RoV76ejWCiQiWnPyn0dG7S77N35RtT5sGT8tWr
         SlqA+hLhByIPxHX28Pf0NvSl6XIhgS6Bx7TYs075n2Dh+HXD9uIblE1RFUwWvIu0MV3l
         DnEvdZXrMbmjX6mhnJIu2/AtYTnjQy9HAaEocdL/fvalS+AJowvt60lr0gzNoOZ3hgZn
         pVtA==
X-Gm-Message-State: AGi0Pub3S7ppsstxUn9+fCS0RuHF2FsYOH+FfHaeAZNf2o6ux/a84bhA
        ox4CUkXkYQQus5SalzhfXKbcREIv7b7Vj18WmIcsNA==
X-Google-Smtp-Source: APiQypJvAs9P0NYlc+VDp3QIFWPUjuxP+cKRiyTPcwcbTngB4Tr+zwZ10UYlTO8u+2AsTbbibFkxTpAAASs25r3y/l8=
X-Received: by 2002:a05:6512:52c:: with SMTP id o12mr5352302lfc.217.1587028850060;
 Thu, 16 Apr 2020 02:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200402203656.27047-1-michael@walle.cc> <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc> <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
 <e0388a2137e23d76b2415a7549c01dd1@walle.cc> <CAMpxmJW1x4Orh1BZ4TUoCsYeaAAZ4NBUNvoMG9JgP0iLvXTOtg@mail.gmail.com>
 <62d157198a75a59ada15c496deeab49b@walle.cc> <eab972adf53bbac20b5a9e613fcfb5b0@walle.cc>
In-Reply-To: <eab972adf53bbac20b5a9e613fcfb5b0@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 11:20:38 +0200
Message-ID: <CACRpkdZPZ4nFQ6B3tGG9wvceoTWqAkfY0r1UKs2pf_c=ZNBG=w@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using regmap
To:     Michael Walle <michael@walle.cc>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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

On Tue, Apr 14, 2020 at 9:57 PM Michael Walle <michael@walle.cc> wrote:

> So what about the following:
>
> #define GPIO_REGMAP_ADDR_ZERO (unsigned int)(-1)

Yeah with regmap explicitly using int I guess we can't use
S32_MAX, so that is fair.

> So this way the user might assign the base addresses the normal way
> except when he wants to use zero, in that case he has to use
>
>    ->base_adr = GPIO_REGMAP_ADDR_ZERO;
>
> gpio-regmap.c could use then:
>
> if (base_addr)
>    something_useful(gpio_regmap_addr(base_addr));
>
> unsigned int gpio_regmap_addr(unsigned int addr)
> {
>    return (addr == GPIO_REGMAP_ADDR_ZERO) ? 0 : addr;
> }

That's reasonably clean.

Yours,
Linus Walleij
