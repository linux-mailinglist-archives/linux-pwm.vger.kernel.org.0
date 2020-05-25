Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17BD1E0BAA
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2020 12:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389781AbgEYKUj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 May 2020 06:20:39 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:55171 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbgEYKUj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 06:20:39 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B2E8E224C1;
        Mon, 25 May 2020 12:20:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1590402035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DaBHew0vxxdSiEHFxN0/9/jK/7HdYOSYbRfKY5g0cf4=;
        b=ea1g/amuAFXkMGyk8b01UJ7SrnTfSaaC0mLpqaKs3JWGpnTuJMhPFxCjrOrj5hGTBW8g1t
        mYu/alo7xbuCw9vBpCPuDGeqDHA+jdYpRLceu125oZwEWGtTah1zfrAEd2LfXjKMyULS3n
        5CBwJkAWm0vxbZD5i+M/5MsdB4Z8DEI=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 25 May 2020 12:20:25 +0200
From:   Michael Walle <michael@walle.cc>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 10/16] gpio: add a reusable generic gpio_chip using
 regmap
In-Reply-To: <CAMpxmJXctc5cbrjSeJxa7DfmjiVsbyhqAbEKt-gtayKhQj0Cnw@mail.gmail.com>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-11-michael@walle.cc>
 <CAMpxmJV3XTOxuoKeV-z2d75qWqHkgvV9419tfe3idDeKwoeoLA@mail.gmail.com>
 <75bff2917be1badd36af9f980cf59d2c@walle.cc>
 <CAMpxmJXctc5cbrjSeJxa7DfmjiVsbyhqAbEKt-gtayKhQj0Cnw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <951244aab2ff553a463f7431ba09bf27@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-05-25 11:05, schrieb Bartosz Golaszewski:
> wt., 12 maj 2020 o 16:41 Michael Walle <michael@walle.cc> napisał(a):
>> 
>> >> +
>> >> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
>> >> +MODULE_DESCRIPTION("GPIO generic regmap driver core");
>> >> +MODULE_LICENSE("GPL");
>> >> diff --git a/include/linux/gpio-regmap.h b/include/linux/gpio-regmap.h
>> >> new file mode 100644
>> >> index 000000000000..a868cbcde6e9
>> >> --- /dev/null
>> >> +++ b/include/linux/gpio-regmap.h
>> >> @@ -0,0 +1,69 @@
>> >> +/* SPDX-License-Identifier: GPL-2.0-only */
>> >> +
>> >> +#ifndef _LINUX_GPIO_REGMAP_H
>> >> +#define _LINUX_GPIO_REGMAP_H
>> >> +
>> >> +struct gpio_regmap;
>> >> +
>> >> +#define GPIO_REGMAP_ADDR_ZERO ((unsigned long)(-1))
>> >> +#define GPIO_REGMAP_ADDR(addr) ((addr) ? : GPIO_REGMAP_ADDR_ZERO)
>> >> +
>> >
>> > What if the addr is actually 0?
>> 
>> Then the driver has to set GPIO_REGMAP_ADDR_ZERO or use the 
>> convenience
>> macro GPIO_REGMAP_ADDR.
>> 
>> So you can have
>> 
>>    struct gpio_regmap_config config = { 0 };
>>    config.reg_dat_base = 0x10;
>>    config.reg_dir_out_base = 0x20;
>> 
>> or
>> 
>>    config.reg_dat_base = GPIO_REGMAP_ADDR_ZERO;
>> 
>> or if you can't be sure if the RHS value might be zero:
>> 
>>    config.reg_dat_base = GPIO_REGMAP_ADDR(reg);
>> 
>> 
>> > Maybe drop GPIO_REGMAP_ADDR and require users to set unused registers
>> > to GPIO_REGMAP_ADDR_ZERO?
>> 
>> Thats bad because:
>>   * you'd have to set plenty of unused base registers for a simple 
>> driver
>>   * if there will be additional properties in the future, you have to
>> touch
>>     all other drivers, because they are initialized as 0 (ie. valid 
>> reg
>> 0).
>> 
>> >> +/**
>> >> + * struct gpio_regmap_config - Description of a generic regmap
>> >> gpio_chip.
>> >> + *
>> >> + * @parent:            The parent device
>> >> + * @regmap:            The regmap used to access the registers
>> >> + *                     given, the name of the device is used
>> >> + * @label:             (Optional) Descriptive name for GPIO
>> >> controller.
>> >> + *                     If not given, the name of the device is used.
>> >> + * @ngpio:             Number of GPIOs
>> >> + * @reg_dat_base:      (Optional) (in) register base address
>> >> + * @reg_set_base:      (Optional) set register base address
>> >> + * @reg_clr_base:      (Optional) clear register base address
>> >> + * @reg_dir_in_base:   (Optional) out setting register base address
>> >> + * @reg_dir_out_base:  (Optional) in setting register base address
>> >
>> > The two above are inverted I think?
>> good catch.
>> 
>> > Also: why the limitation of only supporting one at a time?
>> 
>> they should be exclusive, either you have a register where you set the
>> output bits to one, or the input bits. Maybe this need a bit more
>> context
>> above. in gpio-mmio.c you can set both and both are used in
>> set_direction(), but only one is read in get_direction().
>> 
>> That being said, I have no strong opinion wether they should be
>> exclusive
>> or not, besides the symmetry of set_/get_direction().
>> 
>> -michael
>> 
> 
> Sorry for the late response, your comments make sense to me. Are you
> going to submit a v4 before the v5.8 merge window?

I'm currently stuck with how to handle the MFD part. Ie. Rob doesn't
seem to like the logicial device numbering - or at least there wasn't
an answer to that one anymore, see patch 5/16.

If you like I could submit this patch on its own. But then there
wouldn't be a user for it.

-michael
