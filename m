Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C1E1B245D
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Apr 2020 12:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgDUKvG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 Apr 2020 06:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgDUKvF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Apr 2020 06:51:05 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CF0C061A0F;
        Tue, 21 Apr 2020 03:51:04 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3C07E23059;
        Tue, 21 Apr 2020 12:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1587466263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSieuTLDTWJZlGZSja3Um3+Gmk1FrxNg3rEeH5FZD9Y=;
        b=lomhw53NjPGviUGO5c6ReoggM7XHM605itwqG5h1JP3Dpj8r6pXCY28LtwhLVpYpY40Ihd
        Ku3dGMHKcp68tgLHGsSTqOfceoAzyHJUvzqjunut4xiPDyHEsdpt6Wwkcg8Nu0BdYzkTzj
        pFap2F6Dl6lKIfJ4b7WMMOlrxShKN0w=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 21 Apr 2020 12:50:59 +0200
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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
In-Reply-To: <f82706a8596436d13642c49e26233133@walle.cc>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CACRpkdaqgHhPwdKdUai4zvi21qR-cSQUKyzZ3SyfWBLPN9us3w@mail.gmail.com>
 <f82706a8596436d13642c49e26233133@walle.cc>
Message-ID: <3ef94b68893e2fb3075bd5236d0fa6ee@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 3C07E23059
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         NEURAL_HAM(-0.00)[-0.743];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,baylibre.com,kernel.org,suse.com,roeck-us.net,linaro.org,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

Am 2020-04-17 08:34, schrieb Michael Walle:
> Hi Linus,
> 
> Am 2020-04-16 11:27, schrieb Linus Walleij:
>> On Thu, Apr 2, 2020 at 10:37 PM Michael Walle <michael@walle.cc> 
>> wrote:
>> 
>>> There are quite a lot simple GPIO controller which are using regmap 
>>> to
>>> access the hardware. This driver tries to be a base to unify existing
>>> code into one place. This won't cover everything but it should be a 
>>> good
>>> starting point.
>>> 
>>> It does not implement its own irq_chip because there is already a
>>> generic one for regmap based devices. Instead, the irq_chip will be
>>> instanciated in the parent driver and its irq domain will be 
>>> associate
>>> to this driver.
>>> 
>>> For now it consists of the usual registers, like set (and an optional
>>> clear) data register, an input register and direction registers.
>>> Out-of-the-box, it supports consecutive register mappings and 
>>> mappings
>>> where the registers have gaps between them with a linear mapping 
>>> between
>>> GPIO offset and bit position. For weirder mappings the user can 
>>> register
>>> its own .xlate().
>>> 
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>> 
>> Overall I really like this driver and I think we should merge is as 
>> soon
>> as it is in reasonable shape and then improve on top so we can start
>> migrating drivers to it.
>> 
>>> +static int gpio_regmap_to_irq(struct gpio_chip *chip, unsigned int 
>>> offset)
>>> +{
>>> +       struct gpio_regmap_data *data = gpiochip_get_data(chip);
>>> +       struct gpio_regmap *gpio = data->gpio;
>>> +
>>> +       /* the user might have its own .to_irq callback */
>>> +       if (gpio->to_irq)
>>> +               return gpio->to_irq(gpio, offset);
>>> +
>>> +       return irq_create_mapping(gpio->irq_domain, offset);
>> 
>> I think that should at least be irq_find_mapping(), the mapping should
>> definately not be created by the .to_irq() callback since that is just
>> a convenience function.
> 
> what do you mean by conenience function? are there other ways? if you 
> use
> irq_find_mapping() who will create the mappings? most gpio drivers use 
> a
> similar function like gpio_regmap_to_irq().
> 
>> 
>>> +       if (gpio->irq_domain)
>>> +               chip->to_irq = gpio_regmap_to_irq;
>> 
>> I don't know about this.
>> (...)
>>> + * @irq_domain:                (Optional) IRQ domain if the 
>>> controller is
>>> + *                     interrupt-capable
>> (...)
>>> +       struct irq_domain *irq_domain;
>> 
>> I don't think this is a good storage place for the irqdomain, we 
>> already have
>> gpio_irq_chip inside gpio_chip and that has an irqdomain, we should
>> strive to reuse that infrastructure also for regmap GPIO I think, for 
>> now
>> I would just leave .to_irq() out of this and let the driver deal with 
>> any
>> irqs.
> 
> How would a driver attach the to_irq callback then? At the moment, the
> gpio_regmap doesn't expose the gpio_chip. So either we have to do that 
> or
> the config still have to have a .to_irq property.

Also, if I move the interrupt hanling completely out of the gpio-regmap, 
the
driver would have to deal with "struct gpio_chip" which I would like to 
avoid
if possible and keep it private to gpio-regmap.

Unfortunately, I don't have much experience how a good API for the 
interrupt
handling and the gpio-regmap might look like. And there seems to be some
overlap between regmap-irq and the interrupt stuff in gpiolib. For 
example,
both provide and set the irq_domain_ops. Thus handing the domain over to
gpio-regmap looked like a good idea to me. I get you point, that there 
is
already a irqdomain in gpiolib and also a _to_irq() which is the same as
the current implementation in gpio-regmap. Maybe it makes sense to just
have a new function

int gpiolib_add_irqdomain(struct gpio_chip *gc, struct irq_domain 
domain)
{
   gc->irq.domain = domain;
   gc->to_irq = gpiochip_to_irq;
}

which is called by gpio_regmap_register() if a config->irq_domain is 
given.

-michael
