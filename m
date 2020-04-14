Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F00C1A7821
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 12:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438121AbgDNKH3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 06:07:29 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:39923 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438129AbgDNKHW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 06:07:22 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3CF8C22EEB;
        Tue, 14 Apr 2020 12:07:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1586858831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=APa0klHYbq0nRnZCFsgw5rX3mQ0o6Wd2E6ZRzR/tOMM=;
        b=uLyAAYMIctXbXn9cwOwmR55h8ibp43+Djfg86KlNcR7vgHgZZwlDgYiRikLd5qtnEMmsMc
        PzDJsZxopbkE54MxXLnOoNx1pAf8tR0ohLsnwK7dyAuGExIalFgJsLgv7Fxr4qrCcCMQhy
        F83tczkLaB8z8xbA7ARkBZ9/CpoYSSU=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 14 Apr 2020 12:07:01 +0200
From:   Michael Walle <michael@walle.cc>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
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
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
In-Reply-To: <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
 <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
Message-ID: <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 3CF8C22EEB
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         NEURAL_HAM(-0.00)[-1.081];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,linaro.org,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-04-14 11:50, schrieb Bartosz Golaszewski:
> pon., 6 kwi 2020 o 12:10 Michael Walle <michael@walle.cc> napisał(a):
>> 
>> 
>> Hi Bartosz, Hi Mark Brown,
>> 
>> Am 2020-04-06 09:47, schrieb Bartosz Golaszewski:
>> > czw., 2 kwi 2020 o 22:37 Michael Walle <michael@walle.cc> napisał(a):
>> >>
>> >> There are quite a lot simple GPIO controller which are using regmap to
>> >> access the hardware. This driver tries to be a base to unify existing
>> >> code into one place. This won't cover everything but it should be a
>> >> good
>> >> starting point.
>> >>
>> >> It does not implement its own irq_chip because there is already a
>> >> generic one for regmap based devices. Instead, the irq_chip will be
>> >> instanciated in the parent driver and its irq domain will be associate
>> >> to this driver.
>> >>
>> >> For now it consists of the usual registers, like set (and an optional
>> >> clear) data register, an input register and direction registers.
>> >> Out-of-the-box, it supports consecutive register mappings and mappings
>> >> where the registers have gaps between them with a linear mapping
>> >> between
>> >> GPIO offset and bit position. For weirder mappings the user can
>> >> register
>> >> its own .xlate().
>> >>
>> >> Signed-off-by: Michael Walle <michael@walle.cc>
>> >
>> > Hi Michael,
>> >
>> > Thanks for doing this! When looking at other generic drivers:
>> > gpio-mmio and gpio-reg I can see there are some corner-cases and more
>> > specific configuration options we could add
>> 
>> I didn't want to copy every bit without being able to test it.
>> 
> 
> Sure, I didn't mean we need to do it now - just set it as the future 
> goal.
> 
>> > but it's not a blocker,
>> > we'll probably be extending this one as we convert more drivers to
>> > using it.
>> 
>> correct, that was also my plan.
>> 
>> > Personally I'd love to see gpio-mmio and gpio-reg removed
>> > and replaced by a single, generic regmap interface eventually.
>> 
>> agreed.
>> 
>> 
> 
> [snip!]
> 
>> >> +
>> >> +/**
>> >> + * gpio_regmap_simple_xlate() - translate base/offset to reg/mask
>> >> + *
>> >> + * Use a simple linear mapping to translate the offset to the
>> >> bitmask.
>> >> + */
>> >> +int gpio_regmap_simple_xlate(struct gpio_regmap *gpio, unsigned int
>> >> base,
>> >> +                            unsigned int offset,
>> >> +                            unsigned int *reg, unsigned int *mask)
>> >> +{
>> >> +       unsigned int line = offset % gpio->ngpio_per_reg;
>> >> +       unsigned int stride = offset / gpio->ngpio_per_reg;
>> >> +
>> >> +       *reg = base + stride * gpio->reg_stride;
>> >> +       *mask = BIT(line);
>> >> +
>> >> +       return 0;
>> >> +}
>> >> +EXPORT_SYMBOL_GPL(gpio_regmap_simple_xlate);
>> >
>> > Why does this need to be exported?
>> 
>> Mh, the idea was that a user could also set this xlate() by himself 
>> (for
>> whatever reason). But since it is the default, it is not really
>> necessary.
>> That being said, I don't care if its only local to this module.
>> 
> 
> Let's only export symbols that have external users then.
> 
> [snip!]
> 
>> >> +
>> >> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
>> >> +MODULE_DESCRIPTION("GPIO generic regmap driver core");
>> >> +MODULE_LICENSE("GPL");
>> >> diff --git a/include/linux/gpio-regmap.h b/include/linux/gpio-regmap.h
>> >> new file mode 100644
>> >> index 000000000000..ad63955e0e43
>> >> --- /dev/null
>> >> +++ b/include/linux/gpio-regmap.h
>> >> @@ -0,0 +1,88 @@
>> >> +/* SPDX-License-Identifier: GPL-2.0-only */
>> >> +
>> >> +#ifndef _LINUX_GPIO_REGMAP_H
>> >> +#define _LINUX_GPIO_REGMAP_H
>> >> +
>> >> +struct gpio_regmap_addr {
>> >> +       unsigned int addr;
>> >> +       bool valid;
>> >> +};
>> >
>> > I'm not quite sure what the meaning behind the valid field here is.
>> > When would we potentially set it to false?
>> 
>> Some base addresses are optional, but on the other hand, a base 
>> address
>> of 0 could also be valid. So I cannot use 0 as an indicator whether a
>> base address is set or not. The generic mmio driver has some special
>> case for the ack base, where there is a use_ack flag which forces to
>> use the ack register even if its zero. So I've had a look at the 
>> kernel
>> if there is a better idiom for that, but I haven't found anything.
>> 
>> So the best from a user perspective I've could come up with was:
>> 
>>    ->base_reg = GPIO_REGMAP_ADDR(addr);
>> 
>> I'm open for suggestions.
>> 
> 
> Maybe setting the pointer to ERR_PTR(-ENOENT) which will result in
> IS_ERR() returning true?

Unfortunatly, its not a pointer, but only a regular unsigned int (ie
the type the regmap API has for its "reg" property). It could be a
pointer of course but then the user would have to allocate additional
memory.

-michael

> 
>> >
>> >> +#define GPIO_REGMAP_ADDR(_addr) \
>> >> +       ((struct gpio_regmap_addr) { .addr = _addr, .valid = true })
>> >> +
>> >> +/**
>> >> + * struct gpio_regmap - Description of a generic regmap gpio_chip.
>> >> + *
>> >> + * @parent:            The parent device
>> >> + * @regmap:            The regmap use to access the registers
>> >
>> > s/use/used/
>> >
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
>> >> + * @reg_stride:                (Optional) May be set if the registers
>> >> (of the
>> >> + *                     same type, dat, set, etc) are not consecutive.
>> >> + * @ngpio_per_reg:     Number of GPIOs per register
>> >> + * @irq_domain:                (Optional) IRQ domain if the
>> >> controller is
>> >> + *                     interrupt-capable
>> >> + * @reg_mask_xlate:     (Optional) Translates base address and GPIO
>> >> + *                     offset to a register/bitmask pair. If not
>> >> + *                     given the default gpio_regmap_simple_xlate()
>> >> + *                     is used.
>> >> + * @to_irq:            (Optional) Maps GPIO offset to a irq number.
>> >> + *                     By default assumes a linear mapping of the
>> >> + *                     given irq_domain.
>> >> + * @driver_data:       Pointer to the drivers private data. Not used
>> >> by
>> >> + *                     gpio-regmap.
>> >> + *
>> >> + * The reg_mask_xlate translates a given base address and GPIO offset
>> >> to
>> >> + * register and mask pair. The base address is one of the given
>> >> reg_*_base.
>> >> + */
>> >> +struct gpio_regmap {
>> >
>> > I'd prefer to follow a pattern seen in other such APIs of calling this
>> > structure gpio_regmap_config and creating another private structure
>> > called gpio_regmap used in callbacks that would only contain necessary
>> > fields.
>> 
>> something like the following?
>> 
>> struct gpio_regmap *gpio_regmap_register(struct gpio_regmap_config *)
>> 
>> but if that structure is private, how can a callback access individual
>> elements? Or do you mean private in "local to the gpio drivers"?
>> 
> 
> Either making the structure local to drivers/gpio or making it
> entirely opaque and providing accessor functions. Depending on how
> much of the structure one may want to access.
> 
>> Also I was unsure about the naming, eg. some use
>> stuff_register()/stuff_unregister() and some 
>> stuff_add()/stuff_remove().
>> 
> 
> register/unregister is fine with me.
> 
> Bart
