Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F13F230450
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 09:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgG1Hmb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 03:42:31 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:33621 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgG1Hmb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 03:42:31 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 69A5C22F00;
        Tue, 28 Jul 2020 09:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1595922147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DC6gum5wOvUP2X+C5yQP2AHFRnsyKf6fYNW2wyHxMVM=;
        b=I6rNi06zPnazYFalcbs0vLthy4gWBQJg8/qm5BUVtwruTFD/KLG2Dt4JaIQJiucRvBMC+E
        pXWjrsc7NzX6sKxMPMsXnBWPzdU/gvRm0JPSE0ewoTBJdzD0PzPeEymnqHDi8Y/CTfpyvK
        0iBV1hk6gqZvMxj+xCiKPeFG+hPp2oM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jul 2020 09:42:26 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 01/13] mfd: add simple regmap based I2C driver
In-Reply-To: <20200728071949.GE1850026@dell>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-2-michael@walle.cc> <20200728071949.GE1850026@dell>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <23a9ecf5fe4f15b9b20a91cc292aca80@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-07-28 09:19, schrieb Lee Jones:
> On Sun, 26 Jul 2020, Michael Walle wrote:
> 
>> There are I2C devices which contain several different functions but
>> doesn't require any special access functions. For these kind of 
>> drivers
>> an I2C regmap should be enough.
>> 
>> Create an I2C driver which creates an I2C regmap and enumerates its
>> children. If a device wants to use this as its MFD core driver, it has
>> to add an individual compatible string. It may provide its own regmap
>> configuration.
>> 
>> Subdevices can use dev_get_regmap() on the parent to get their regmap
>> instance.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> Changes since v5:
>>  - removed "select MFD_CORE" in Kconfig
>>  - removed help text in Kconfig, we assume that the users of this
> 
> That's the opposite of what I asked for.

What is the use to describe the symbol, if it is not user selectable?
I'm not aware this is done anywhere in the kernel, am I missing
something?

>>    driver will have a "select MFD_SIMPLE_MFD_I2C". Instead added
>>    a small description to the driver itself.
>>  - removed "struct simple_mfd_i2c_config" and use regmap_config
>>    directly
>>  - changed builtin_i2c_driver() to module_i2c_driver(), added
>>    MODULE_ boilerplate
>>  - cleaned up the included files
>> 
>> Changes since v4:
>>  - new patch. Lee, please bear with me. I didn't want to delay the
>>    new version (where a lot of remarks on the other patches were
>>    addressed) even more, just because we haven't figured out how
>>    to deal with the MFD part. So for now, I've included this one.
>> 
>>  drivers/mfd/Kconfig          |  5 ++++
>>  drivers/mfd/Makefile         |  1 +
>>  drivers/mfd/simple-mfd-i2c.c | 55 
>> ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 61 insertions(+)
>>  create mode 100644 drivers/mfd/simple-mfd-i2c.c
>> 
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 33df0837ab41..c08539c7a166 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1162,6 +1162,11 @@ config MFD_SI476X_CORE
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called si476x-core.
>> 
>> +config MFD_SIMPLE_MFD_I2C
>> +	tristate
>> +	depends on I2C
>> +	select REGMAP_I2C
> 
> Please provide a full help.

See above.

> 
>>  config MFD_SM501
>>  	tristate "Silicon Motion SM501"
>>  	depends on HAS_DMA
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index a60e5f835283..78d24a3e7c9e 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -264,3 +264,4 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>>  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>> 
>>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>> +obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
>> diff --git a/drivers/mfd/simple-mfd-i2c.c 
>> b/drivers/mfd/simple-mfd-i2c.c
>> new file mode 100644
>> index 000000000000..45090ddad104
>> --- /dev/null
>> +++ b/drivers/mfd/simple-mfd-i2c.c
>> @@ -0,0 +1,55 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * A very simple I2C MFD driver
> 
> Simple MFD - I2C

ok.

>> + * The driver enumerates its children and registers a common regmap. 
>> Use
>> + * dev_get_regmap(pdev->dev.parent, NULL) in the child nodes to fetch 
>> that
>> + * regmap instance.
> 
> This driver creates a single register map with the intention for it to
> be shared by all sub-devices.  Children can use their parent's device
> structure (dev.parent) in order reference it.

Should this be appended or should it replace my paragraph? If its the 
latter,
the "enumeration of the children" is missing.

>> + * In the future this driver might be extended to support also other 
>> interfaces
>> + * like SPI etc.
> 
> Remove this please.

Why would you remove information about the intention of this driver? If 
someone
looks for a place to implement its SPI/I3C/Slimbus MFD driver this might 
come
in handy.

-michael
