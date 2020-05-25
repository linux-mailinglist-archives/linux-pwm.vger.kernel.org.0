Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD41E09A1
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2020 11:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389207AbgEYJGF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 May 2020 05:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389198AbgEYJGF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 05:06:05 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB982C08C5C2
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 02:06:03 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q8so449864qkm.12
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dPuZPyJHL9y310jCMBab1+wUqEyxBpL9sxzRpIMUcDw=;
        b=nO2zcmFBdCWzlGqLw1pR2ThUuz31GiwsX9FmLMPWXkIRbISIRdArAGzOKpkV7Qzv10
         5VetiQSFGmqqkEyKB7+SGACaU0qLz2m+9iyUgPiDy2IDRCPxhwFx8/5DMtWUHYRsjtlL
         0atWQF/ahgFhsYQYAzdXXs0aRQhob0wySOVyDYs2DXpouokBCqB6slqb/TvDM+I33ev8
         yk0brFmDMsprGHiwBPRLvyh/NVcy/OCFMiVYdFYc4bQaZFP6VvDRpzKRyp0zTf5FOVWN
         aSAJO9abuoljXUYQUaIMlrcVwRxlonf00RVbuDaEI1E+vkonNYosmqgXcWB0HgzUmBS7
         NMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dPuZPyJHL9y310jCMBab1+wUqEyxBpL9sxzRpIMUcDw=;
        b=CCXNWxzvo30vy54gH6H5ObA8TliqRs/2vXFnAMz12i+jU9qSh1nLbl5PbXHP5f6S9C
         DiqXaMGVtNtX8rizzdfuGaHXVqEmrgR2irx4YElJj1F2mgjYhoIMkgIdJ1zbeD+9/PBB
         AF01mQhptkvhdzvMI8kH9ChhnYpJ0VzDGnSefeEqNeIZqz2yzeFjEQG7LGu6/WA4WHFT
         7b8O+4Xpd2vKPvR9nvJWRDjBCifw5WUfRWajQsy5idZtBrGii37qVKQlV1XUJo/vBgW2
         1WnRML6LqbbEtZ/Rvw1tv3m7KOzFXRbQlwek0IYF2Zjfvee6Pypvce5qdF3Zp/O8ilCg
         p2hw==
X-Gm-Message-State: AOAM530hCAf/81EANhyDPYwOmp44/SWK9GPuiW3BWE1zsoeeEhgACa7k
        xW7IB9q0AeaH2AuLlKDeCfgW4yfnUi/g0bse/2QOUg==
X-Google-Smtp-Source: ABdhPJwwogx5lD1d892oBsZ0UV12gKR+k0N+3QkhwPrACB1IANnU5OS7w1qWs680sMYLIO0JDYTSL1iYK1byj+QAdpM=
X-Received: by 2002:a37:5b47:: with SMTP id p68mr26336785qkb.120.1590397562647;
 Mon, 25 May 2020 02:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200423174543.17161-1-michael@walle.cc> <20200423174543.17161-11-michael@walle.cc>
 <CAMpxmJV3XTOxuoKeV-z2d75qWqHkgvV9419tfe3idDeKwoeoLA@mail.gmail.com> <75bff2917be1badd36af9f980cf59d2c@walle.cc>
In-Reply-To: <75bff2917be1badd36af9f980cf59d2c@walle.cc>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 25 May 2020 11:05:51 +0200
Message-ID: <CAMpxmJXctc5cbrjSeJxa7DfmjiVsbyhqAbEKt-gtayKhQj0Cnw@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] gpio: add a reusable generic gpio_chip using regmap
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

wt., 12 maj 2020 o 16:41 Michael Walle <michael@walle.cc> napisa=C5=82(a):
>
> >> +
> >> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> >> +MODULE_DESCRIPTION("GPIO generic regmap driver core");
> >> +MODULE_LICENSE("GPL");
> >> diff --git a/include/linux/gpio-regmap.h b/include/linux/gpio-regmap.h
> >> new file mode 100644
> >> index 000000000000..a868cbcde6e9
> >> --- /dev/null
> >> +++ b/include/linux/gpio-regmap.h
> >> @@ -0,0 +1,69 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +
> >> +#ifndef _LINUX_GPIO_REGMAP_H
> >> +#define _LINUX_GPIO_REGMAP_H
> >> +
> >> +struct gpio_regmap;
> >> +
> >> +#define GPIO_REGMAP_ADDR_ZERO ((unsigned long)(-1))
> >> +#define GPIO_REGMAP_ADDR(addr) ((addr) ? : GPIO_REGMAP_ADDR_ZERO)
> >> +
> >
> > What if the addr is actually 0?
>
> Then the driver has to set GPIO_REGMAP_ADDR_ZERO or use the convenience
> macro GPIO_REGMAP_ADDR.
>
> So you can have
>
>    struct gpio_regmap_config config =3D { 0 };
>    config.reg_dat_base =3D 0x10;
>    config.reg_dir_out_base =3D 0x20;
>
> or
>
>    config.reg_dat_base =3D GPIO_REGMAP_ADDR_ZERO;
>
> or if you can't be sure if the RHS value might be zero:
>
>    config.reg_dat_base =3D GPIO_REGMAP_ADDR(reg);
>
>
> > Maybe drop GPIO_REGMAP_ADDR and require users to set unused registers
> > to GPIO_REGMAP_ADDR_ZERO?
>
> Thats bad because:
>   * you'd have to set plenty of unused base registers for a simple driver
>   * if there will be additional properties in the future, you have to
> touch
>     all other drivers, because they are initialized as 0 (ie. valid reg
> 0).
>
> >> +/**
> >> + * struct gpio_regmap_config - Description of a generic regmap
> >> gpio_chip.
> >> + *
> >> + * @parent:            The parent device
> >> + * @regmap:            The regmap used to access the registers
> >> + *                     given, the name of the device is used
> >> + * @label:             (Optional) Descriptive name for GPIO
> >> controller.
> >> + *                     If not given, the name of the device is used.
> >> + * @ngpio:             Number of GPIOs
> >> + * @reg_dat_base:      (Optional) (in) register base address
> >> + * @reg_set_base:      (Optional) set register base address
> >> + * @reg_clr_base:      (Optional) clear register base address
> >> + * @reg_dir_in_base:   (Optional) out setting register base address
> >> + * @reg_dir_out_base:  (Optional) in setting register base address
> >
> > The two above are inverted I think?
> good catch.
>
> > Also: why the limitation of only supporting one at a time?
>
> they should be exclusive, either you have a register where you set the
> output bits to one, or the input bits. Maybe this need a bit more
> context
> above. in gpio-mmio.c you can set both and both are used in
> set_direction(), but only one is read in get_direction().
>
> That being said, I have no strong opinion wether they should be
> exclusive
> or not, besides the symmetry of set_/get_direction().
>
> -michael
>

Sorry for the late response, your comments make sense to me. Are you
going to submit a v4 before the v5.8 merge window?

Bart
