Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E481EF82D
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 14:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgFEMm6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 08:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgFEMm6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 08:42:58 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2623C08C5C2;
        Fri,  5 Jun 2020 05:42:57 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3389822FEC;
        Fri,  5 Jun 2020 14:42:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591360973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/2TzxsPSlfyINNO8TTfnGs1HicX0u51iSKBI+ftYOE=;
        b=ppjkq+9sTLA7e0BVJjM/uHM60R+cDCBYYMmhqDwQNcUvU9b7+pKRcr03C7m5x0zjrB3ziF
        YWsz9DFPvrHEqnF8RKJ1y+mHfSEf3iFURJD8DMeRu/20zVMLDC7Y4IGTLAjYc4Il/lkiaE
        DPx5ggCjNo0+Q9tyOM36Ky+mQkjuEFI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Jun 2020 14:42:53 +0200
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 06/11] gpio: add support for the sl28cpld GPIO
 controller
In-Reply-To: <CAHp75VfRhL1f-XD=PMbqd3BLeJQzQMFAupSzqAvx0g7-X_2VhQ@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-7-michael@walle.cc>
 <CAHp75VfRhL1f-XD=PMbqd3BLeJQzQMFAupSzqAvx0g7-X_2VhQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <216db3154b46bd80202873df055bb3f3@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-06-05 14:00, schrieb Andy Shevchenko:
> On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:
> 
>> Add support for the GPIO controller of the sl28 board management
>> controller. This driver is part of a multi-function device.
>> 
>> A controller has 8 lines. There are three different flavors:
>> full-featured GPIO with interrupt support, input-only and output-only.
> 
> ...
> 
>> +#include <linux/of_device.h>
> 
> I think also not needed.
> But wait...
> 
>> +       return devm_regmap_add_irq_chip_np(dev, dev_of_node(dev), 
>> regmap,
> 
> It seems regmap needs to be converted to use fwnode.

Mhh, this _np functions was actually part of this series in the
beginning.

>> +                                          irq, IRQF_SHARED | 
>> IRQF_ONESHOT, 0,
>> +                                          irq_chip, &gpio->irq_data);
> 
> ...
> 
>> +       if (!pdev->dev.parent)
>> +               return -ENODEV;
> 
> Are we expecting to get shot into foot? I mean why we need this check?

Can we be sure, that we always have a parent node? You are the first
which complains about this ;) There were some other comments to move
this to the beginning of the function.

> 
>> +       dev_id = platform_get_device_id(pdev);
>> +       if (dev_id)
>> +               type = dev_id->driver_data;
> 
> Oh, no. In new code we don't need this. We have facilities to provide
> platform data in a form of fwnode.

Ok I'll look into that.

But I already have a question, so there are of_property_read_xx(), which
seems to be the old functions, then there is device_property_read_xx() 
and
fwnode_property_read_xx(). What is the difference between the latter 
two?

> 
>> +       else
>> +               type = 
>> (uintptr_t)of_device_get_match_data(&pdev->dev);
> 
> So does this. device_get_match_data().
ok

> 
>> +       if (!type)
>> +               return -ENODEV;
> 
> ...
> 
>> +       if (irq_support &&
> 
> Why do you need this flag? Can't simple IRQ number be sufficient?

I want to make sure, the is no misconfiguration. Eg. only GPIO
flavors which has irq_support set, have the additional interrupt
registers.

> 
>> +           device_property_read_bool(&pdev->dev, 
>> "interrupt-controller")) {
>> +               irq = platform_get_irq(pdev, 0);
>> +               if (irq < 0)
>> +                       return irq;
>> +
>> +               ret = sl28cpld_gpio_irq_init(&pdev->dev, gpio, regmap,
>> +                                            base, irq);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               config.irq_domain = 
>> regmap_irq_get_domain(gpio->irq_data);
>> +       }
> 
> ...
> 
>> +static const struct of_device_id sl28cpld_gpio_of_match[] = {
> 
>> +       { .compatible = "kontron,sl28cpld-gpio",
>> +         .data = (void *)SL28CPLD_GPIO },
>> +       { .compatible = "kontron,sl28cpld-gpi",
>> +         .data = (void *)SL28CPLD_GPI },
>> +       { .compatible = "kontron,sl28cpld-gpo",
>> +         .data = (void *)SL28CPLD_GPO },
> 
> All above can be twice less LOCs.

They are longer than 80 chars. Or do I miss something?

> 
>> +       {},
> 
> No comma.

ok

>> +};
> 
> 
> ...
> 
>> +               .name = KBUILD_MODNAME,
> 
> This actually not good idea in long term. File name can change and 
> break an ABI.

Ahh an explanation, why this is bad. Ok makes sense, although to be 
fair,
.id_table should be used for the driver name matching. I'm not sure if
this is used somewhere else, though.


-- 
-michael
