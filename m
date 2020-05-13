Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBDA1D21CA
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 00:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgEMWPa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 May 2020 18:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730532AbgEMWP3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 May 2020 18:15:29 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A1EC061A0C;
        Wed, 13 May 2020 15:15:29 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5752922FEC;
        Thu, 14 May 2020 00:15:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1589408125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjMyCHfdnLjEuVo++xDGBWjambq+Fde/qc+KEJNfdSc=;
        b=eKf0mnWxRhNAeHVKoNWCeiV9u0yLpbJAusnkLK3vNXKHhQeGeNYWKXQ++zSpwJbX38tbdU
        2EJap+54vaZnLGcacA4UH6AZs5fGtsgB2NmyXR2hFOrHme+LDvtC1sdogLUw19sHNQKzAs
        BwssZiT/tIG61qYJfOLJ1Eowufi8hK0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 May 2020 00:15:22 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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
Subject: Re: [PATCH v3 05/16] mfd: Add support for Kontron sl28cpld management
 controller
In-Reply-To: <CAL_JsqJBAghgdKmH1OfpH0B508st7Gx3GMtjufjZvBWM_c6GAQ@mail.gmail.com>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-6-michael@walle.cc> <20200511211359.GB3518@bogus>
 <f0fafa63047f00e912013b137e4db15c@walle.cc>
 <CAL_JsqJBAghgdKmH1OfpH0B508st7Gx3GMtjufjZvBWM_c6GAQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <c170d7ad3874567e624bb827c1eac661@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-05-12 23:59, schrieb Rob Herring:
> On Mon, May 11, 2020 at 4:45 PM Michael Walle <michael@walle.cc> wrote:
>> 
>> Am 2020-05-11 23:13, schrieb Rob Herring:
>> > On Thu, Apr 23, 2020 at 07:45:32PM +0200, Michael Walle wrote:
>> >> +#define SL28CPLD_VERSION    0x03
>> >> +#define SL28CPLD_WATCHDOG_BASE      0x04
>> >> +#define SL28CPLD_HWMON_FAN_BASE     0x0b
>> >> +#define SL28CPLD_PWM0_BASE  0x0c
>> >> +#define SL28CPLD_PWM1_BASE  0x0e
>> >> +#define SL28CPLD_GPIO0_BASE 0x10
>> >> +#define SL28CPLD_GPIO1_BASE 0x15
>> >> +#define SL28CPLD_GPO_BASE   0x1a
>> >> +#define SL28CPLD_GPI_BASE   0x1b
>> >> +#define SL28CPLD_INTC_BASE  0x1c
>> >
>> > If you want to use 'reg' in the binding, these are the numbers you
>> > should be using rather than making up numbering!
>> 
>> My motivation is that I don't want to hardcode the internal addresses
>> of the management controller in the device tree. For example if they
>> will move around with a later update of the controller, so a driver 
>> can
>> be compatible with both the old and the new version. If they are in 
>> the
>> device tree, only one register layout is possible.
> 
> I don't understand, if the addresses change, then the above defines
> have to change. So your driver is only compatible with 1 version. If
> you change the CPLD, then that's a h/w change and your h/w description
> (DT) should change. That can either be the compatible string changing
> and updating the driver with new match data such as register offsets
> or all the differences are in DT and there's no kernel change.

The CPLD and the board is designed in a way that it is possible to
update and/or change its function (or parts of it). It must not be
a hardware change, although I admit thats a bit of a grey area wether
you treat it as hardware or "firmware". Anyway, yes you'd have to
change the register offsets, but as this is code it might support
different register offsets. For example you could dynamically add
functionality, if there is a newer controller version while still
being compatible with older versions.

>> > However, I still don't think you need any child nodes. All the data in
>> > the DT binding is right here in the driver already. There's no
>> > advantage
>> > to putting child nodes in DT, because this driver still has to be
>> > updated if you add more nodes.
>> 
>> But then any phandle will reference the mfd device. And for example
>> there
>> are two different interrupt controllers, that is the INTC and the
>> GPIO[01],
>> which will then be combined into one device tree node, right?
> 
> You either have to add a cell for 'bank' or divide the 1st cell into a
> bank and index. Both have been done before.

But this won't work with watchdogs, correct? See
https://lore.kernel.org/linux-devicetree/7acbb6d9b2240b1856136fa35c1318bf@walle.cc/

> To go the other direction, AIUI you shouldn't need OF_MFD_CELL_REG
> entries if you have the child devices in DT.

This is a general problem IMHO. There are mfd drivers which have mfd
cells and a device tree node associated with each cell. But it just
works as long as there is only one sub device per unique compatible
string. So you cannot have multiple mfd cells with the same
compatible string.

That being said, I can try to reimplement it using
of_platform_populate() and its internal offset as its unit address.

> Pick one way or the
> other. It's ultimately a judgement call. For a one-off device, sub
> devices in DT doesn't really buy you anything. If you have sub-blocks
> showing up multiple devices, then sub devices makes sense. If there's
> only 2-3 combinations, then it's a toss up.

-michael
