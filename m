Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A701EF8BD
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 15:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgFENP3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 09:15:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:61808 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbgFENP3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 5 Jun 2020 09:15:29 -0400
IronPort-SDR: hDay6+sP/Xbm6Cdru3WbeELqAe9tguzQLXjLNKS916hDlpki4t4fO5K+EXJblEEuU+4DW3j+hd
 YghXPkuZ7upw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 06:15:28 -0700
IronPort-SDR: 8z64UIpITHvnMyk+hpzKUgfEq+GlBhraZiuh97RJehWFeDVXSXsoR2BA/l3B/XSSk2a/rUPVZY
 91vGmgg9lXIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="258028176"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2020 06:15:23 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jhCBx-00B2CL-6c; Fri, 05 Jun 2020 16:15:25 +0300
Date:   Fri, 5 Jun 2020 16:15:25 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Michael Walle <michael@walle.cc>
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 06/11] gpio: add support for the sl28cpld GPIO
 controller
Message-ID: <20200605131525.GK2428291@smile.fi.intel.com>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-7-michael@walle.cc>
 <CAHp75VfRhL1f-XD=PMbqd3BLeJQzQMFAupSzqAvx0g7-X_2VhQ@mail.gmail.com>
 <216db3154b46bd80202873df055bb3f3@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216db3154b46bd80202873df055bb3f3@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jun 05, 2020 at 02:42:53PM +0200, Michael Walle wrote:
> Am 2020-06-05 14:00, schrieb Andy Shevchenko:
> > On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:

> > > +       return devm_regmap_add_irq_chip_np(dev, dev_of_node(dev),
> > > regmap,
> > 
> > It seems regmap needs to be converted to use fwnode.
> 
> Mhh, this _np functions was actually part of this series in the
> beginning.

Then, please, make them fwnode aware rather than OF centric.

> > > IRQF_ONESHOT, 0,
> > > +                                          irq_chip, &gpio->irq_data);

...

> > > +       dev_id = platform_get_device_id(pdev);
> > > +       if (dev_id)
> > > +               type = dev_id->driver_data;
> > 
> > Oh, no. In new code we don't need this. We have facilities to provide
> > platform data in a form of fwnode.
> 
> Ok I'll look into that.
> 
> But I already have a question, so there are of_property_read_xx(), which
> seems to be the old functions, then there is device_property_read_xx() and
> fwnode_property_read_xx(). What is the difference between the latter two?

It's easy. device_*() requires struct device to be established for this, so,
operates only against devices, while the fwnode_*() operates on pure data which
might or might not be related to any devices. If you understand OF examples
better, consider device node vs. child of such node.

...

> > > +       if (irq_support &&
> > 
> > Why do you need this flag? Can't simple IRQ number be sufficient?
> 
> I want to make sure, the is no misconfiguration. Eg. only GPIO
> flavors which has irq_support set, have the additional interrupt
> registers.

In gpio-dwapb, for example, we simple check two things: a) hardware limitation
(if IRQ is assigned to a proper port) and b) if there is any IRQ comes from DT,
ACPI, etc.

> > > +           device_property_read_bool(&pdev->dev,
> > > "interrupt-controller")) {
> > > +               irq = platform_get_irq(pdev, 0);
> > > +               if (irq < 0)
> > > +                       return irq;
> > > +
> > > +               ret = sl28cpld_gpio_irq_init(&pdev->dev, gpio, regmap,
> > > +                                            base, irq);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               config.irq_domain =
> > > regmap_irq_get_domain(gpio->irq_data);
> > > +       }

...

> > > +       { .compatible = "kontron,sl28cpld-gpio",
> > > +         .data = (void *)SL28CPLD_GPIO },
> > > +       { .compatible = "kontron,sl28cpld-gpi",
> > > +         .data = (void *)SL28CPLD_GPI },
> > > +       { .compatible = "kontron,sl28cpld-gpo",
> > > +         .data = (void *)SL28CPLD_GPO },
> > 
> > All above can be twice less LOCs.
> 
> They are longer than 80 chars. Or do I miss something?

We have 100 :-)

...

> > > +               .name = KBUILD_MODNAME,
> > 
> > This actually not good idea in long term. File name can change and break
> > an ABI.
> 
> Ahh an explanation, why this is bad. Ok makes sense, although to be fair,
> .id_table should be used for the driver name matching. I'm not sure if
> this is used somewhere else, though.

I saw in my practice chain of renames for a driver. Now, if somebody
somewhere would like to instantiate a platform driver by its name...
Oops, ABI breakage.

And of course using platform data for such device makes less sense.

-- 
With Best Regards,
Andy Shevchenko


