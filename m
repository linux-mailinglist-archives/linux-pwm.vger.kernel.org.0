Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B061EFFFB
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgFESo4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 14:44:56 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:54305 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgFESo4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 14:44:56 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D4F3122FEB;
        Fri,  5 Jun 2020 20:44:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591382693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRXENm/x2WRLoyAXS0BfjnJoOn+fwaDtXQJ9FoOZsLA=;
        b=j0Eus+/W8QMEAKZ/SsmQb0kD+m3/XjNNl0Ufda7uFq9odKfuAWBB0W5v8SY60Q1bF9vcpo
        3dLqeh4xxOffGdO2kS4EOmwn50MCn0MU8NYl8Kzc+MvIKFbpci3tRwsSDkQdqSIrU3phYb
        jaddnH0/bDjBanv1kCnlJbG0xT/VxY0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Jun 2020 20:44:52 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
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
Subject: Re: [PATCH v4 06/11] gpio: add support for the sl28cpld GPIO
 controller
In-Reply-To: <20200605131525.GK2428291@smile.fi.intel.com>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-7-michael@walle.cc>
 <CAHp75VfRhL1f-XD=PMbqd3BLeJQzQMFAupSzqAvx0g7-X_2VhQ@mail.gmail.com>
 <216db3154b46bd80202873df055bb3f3@walle.cc>
 <20200605131525.GK2428291@smile.fi.intel.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <bf587fc3f907d58609a0ea3d65cd5b37@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-06-05 15:15, schrieb Andy Shevchenko:
> On Fri, Jun 05, 2020 at 02:42:53PM +0200, Michael Walle wrote:
>> Am 2020-06-05 14:00, schrieb Andy Shevchenko:
>> > On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:
> 
>> > > +       return devm_regmap_add_irq_chip_np(dev, dev_of_node(dev),
>> > > regmap,
>> >
>> > It seems regmap needs to be converted to use fwnode.
>> 
>> Mhh, this _np functions was actually part of this series in the
>> beginning.
> 
> Then, please, make them fwnode aware rather than OF centric.

ok

> 
>> > > IRQF_ONESHOT, 0,
>> > > +                                          irq_chip, &gpio->irq_data);
> 
> ...
> 
>> > > +       dev_id = platform_get_device_id(pdev);
>> > > +       if (dev_id)
>> > > +               type = dev_id->driver_data;
>> >
>> > Oh, no. In new code we don't need this. We have facilities to provide
>> > platform data in a form of fwnode.
>> 
>> Ok I'll look into that.
>> 
>> But I already have a question, so there are of_property_read_xx(), 
>> which
>> seems to be the old functions, then there is device_property_read_xx() 
>> and
>> fwnode_property_read_xx(). What is the difference between the latter 
>> two?
> 
> It's easy. device_*() requires struct device to be established for 
> this, so,
> operates only against devices, while the fwnode_*() operates on pure 
> data which
> might or might not be related to any devices. If you understand OF 
> examples
> better, consider device node vs. child of such node.

Ahh thanks, got it.

> 
> ...
> 
>> > > +       if (irq_support &&
>> >
>> > Why do you need this flag? Can't simple IRQ number be sufficient?
>> 
>> I want to make sure, the is no misconfiguration. Eg. only GPIO
>> flavors which has irq_support set, have the additional interrupt
>> registers.
> 
> In gpio-dwapb, for example, we simple check two things: a) hardware 
> limitation
> (if IRQ is assigned to a proper port) and b) if there is any IRQ comes 
> from DT,
> ACPI, etc.

I can't follow you here. irq_support is like your (a); or the
"pp->idx == 0" in your example.

>> > > +           device_property_read_bool(&pdev->dev,
>> > > "interrupt-controller")) {
>> > > +               irq = platform_get_irq(pdev, 0);
>> > > +               if (irq < 0)
>> > > +                       return irq;
>> > > +
>> > > +               ret = sl28cpld_gpio_irq_init(&pdev->dev, gpio, regmap,
>> > > +                                            base, irq);
>> > > +               if (ret)
>> > > +                       return ret;
>> > > +
>> > > +               config.irq_domain =
>> > > regmap_irq_get_domain(gpio->irq_data);
>> > > +       }
> 
> ...
> 
>> > > +       { .compatible = "kontron,sl28cpld-gpio",
>> > > +         .data = (void *)SL28CPLD_GPIO },
>> > > +       { .compatible = "kontron,sl28cpld-gpi",
>> > > +         .data = (void *)SL28CPLD_GPI },
>> > > +       { .compatible = "kontron,sl28cpld-gpo",
>> > > +         .data = (void *)SL28CPLD_GPO },
>> >
>> > All above can be twice less LOCs.
>> 
>> They are longer than 80 chars. Or do I miss something?
> 
> We have 100 :-)

oh come on, since 6 days *g*

>> > > +               .name = KBUILD_MODNAME,
>> >
>> > This actually not good idea in long term. File name can change and break
>> > an ABI.
>> 
>> Ahh an explanation, why this is bad. Ok makes sense, although to be 
>> fair,
>> .id_table should be used for the driver name matching. I'm not sure if
>> this is used somewhere else, though.
> 
> I saw in my practice chain of renames for a driver. Now, if somebody
> somewhere would like to instantiate a platform driver by its name...
> Oops, ABI breakage.
> 
> And of course using platform data for such device makes less sense.

i just removed the id_table from all drivers anyways.

-michael
