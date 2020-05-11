Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ABE1CE819
	for <lists+linux-pwm@lfdr.de>; Tue, 12 May 2020 00:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgEKW3x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 May 2020 18:29:53 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38177 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgEKW3x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 May 2020 18:29:53 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E950223E4D;
        Tue, 12 May 2020 00:29:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1589236187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZWtR9bzSYXnNm25amIJ9C/96FTsepP7H5IrzZ9zpG/A=;
        b=YdDVOLeZBQ34l+NCgbOJbibwaRMlbhkryBPCyVboFq3OoIIcwGhTb4bpx1oqBWsLm0T3Ny
        CZp5yyu0djrMsi4kOWfKCfNplFlS7gp1ntDK+bdoeton2uRftwbJISw7i+6IVo7b7aosbu
        kNxvxZ/YLMcP4rurnW92mHmhw4rdMek=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 May 2020 00:29:46 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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
In-Reply-To: <f0fafa63047f00e912013b137e4db15c@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-6-michael@walle.cc> <20200511211359.GB3518@bogus>
 <f0fafa63047f00e912013b137e4db15c@walle.cc>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <7acbb6d9b2240b1856136fa35c1318bf@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-05-11 23:44, schrieb Michael Walle:
> Am 2020-05-11 23:13, schrieb Rob Herring:
>> On Thu, Apr 23, 2020 at 07:45:32PM +0200, Michael Walle wrote:
>>> This patch adds core support for the board management controller 
>>> found
>>> on the SMARC-sAL28 board. It consists of the following functions:
>>>  - watchdog
>>>  - GPIO controller
>>>  - PWM controller
>>>  - fan sensor
>>>  - interrupt controller
>>> 
>>> At the moment, this controller is used on the Kontron SMARC-sAL28 
>>> board.
>>> 
>>> Please note that the MFD driver is defined as bool in the Kconfig
>>> because the next patch will add interrupt support.
>>> 
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> ---
>>>  drivers/mfd/Kconfig    |  19 +++++
>>>  drivers/mfd/Makefile   |   2 +
>>>  drivers/mfd/sl28cpld.c | 153 
>>> +++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 174 insertions(+)
>>>  create mode 100644 drivers/mfd/sl28cpld.c
>>> 
>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>> index 0a59249198d3..be0c8d93c526 100644
>>> --- a/drivers/mfd/Kconfig
>>> +++ b/drivers/mfd/Kconfig
>>> @@ -2060,5 +2060,24 @@ config SGI_MFD_IOC3
>>>  	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
>>>  	  then say Y. Otherwise say N.
>>> 
>>> +config MFD_SL28CPLD
>>> +	bool "Kontron sl28 core driver"
>>> +	depends on I2C=y
>>> +	depends on OF
>>> +	select REGMAP_I2C
>>> +	select MFD_CORE
>>> +	help
>>> +	  This option enables support for the board management controller
>>> +	  found on the Kontron sl28 CPLD. You have to select individual
>>> +	  functions, such as watchdog, GPIO, etc, under the corresponding 
>>> menus
>>> +	  in order to enable them.
>>> +
>>> +	  Currently supported boards are:
>>> +
>>> +		Kontron SMARC-sAL28
>>> +
>>> +	  To compile this driver as a module, choose M here: the module 
>>> will be
>>> +	  called sl28cpld.
>>> +
>>>  endmenu
>>>  endif
>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>> index f935d10cbf0f..9bc38863b9c7 100644
>>> --- a/drivers/mfd/Makefile
>>> +++ b/drivers/mfd/Makefile
>>> @@ -259,3 +259,5 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>>>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>>> 
>>>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>>> +
>>> +obj-$(CONFIG_MFD_SL28CPLD)	+= sl28cpld.o
>>> diff --git a/drivers/mfd/sl28cpld.c b/drivers/mfd/sl28cpld.c
>>> new file mode 100644
>>> index 000000000000..1e5860cc7ffc
>>> --- /dev/null
>>> +++ b/drivers/mfd/sl28cpld.c
>>> @@ -0,0 +1,153 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * MFD core for the sl28cpld.
>>> + *
>>> + * Copyright 2019 Kontron Europe GmbH
>>> + */
>>> +
>>> +#include <linux/i2c.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/mfd/core.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/regmap.h>
>>> +
>>> +#define SL28CPLD_VERSION	0x03
>>> +#define SL28CPLD_WATCHDOG_BASE	0x04
>>> +#define SL28CPLD_HWMON_FAN_BASE	0x0b
>>> +#define SL28CPLD_PWM0_BASE	0x0c
>>> +#define SL28CPLD_PWM1_BASE	0x0e
>>> +#define SL28CPLD_GPIO0_BASE	0x10
>>> +#define SL28CPLD_GPIO1_BASE	0x15
>>> +#define SL28CPLD_GPO_BASE	0x1a
>>> +#define SL28CPLD_GPI_BASE	0x1b
>>> +#define SL28CPLD_INTC_BASE	0x1c
>> 
>> If you want to use 'reg' in the binding, these are the numbers you
>> should be using rather than making up numbering!
> 
> My motivation is that I don't want to hardcode the internal addresses
> of the management controller in the device tree. For example if they
> will move around with a later update of the controller, so a driver can
> be compatible with both the old and the new version. If they are in the
> device tree, only one register layout is possible.
> 
>> However, I still don't think you need any child nodes. All the data in
>> the DT binding is right here in the driver already. There's no 
>> advantage
>> to putting child nodes in DT, because this driver still has to be
>> updated if you add more nodes.
> 
> But then any phandle will reference the mfd device. And for example 
> there
> are two different interrupt controllers, that is the INTC and the 
> GPIO[01],
> which will then be combined into one device tree node, right?
> 
> So the mfd node would be
> 
> cpld: sl28cpld@4a {
>   interrupt-controller;
>   #interrupt-cells = <2>;
>   gpio-controller;
>   #gpio-cells = <2>;
>   [..]
> };
> 
> and then depending on the mapping one could use:
> 
> interrupts-extended = <&cpld 0 FLAGS>; /* gpio0 line 0 */
> interrupts-extended = <&cpld 8 FLAGS>; /* gpio1 line 0 */
> interrupts-extended = <&cpld 12 FLAGS>; /* irq0 */
> 
> gpios = <&cpld 0> /* gpio0 line 0 */
> 
> But there is also offset 12, but then it is the GPI controller:
> 
> gpios = <&cpld 12> /* gpi line 0, nothing to do with irq0 */
> 
> I don't know if this is good practice, I guess you have to tell me. And
> is it possible to combine any sub device into the mfd node in that way?

Oh I don't think that will work for the watchdog. If you just have one
watchdog it just looks odd.

cpld: sl28cpld@4a {
    interrupt-controller;
    #interrupt-cells = <2>;
    gpio-controller;
    #gpio-cells = <2>;
    timeout-sec = <10>; /* watchdog property */
};

And won't pass the dtbindings check because the nodename is not
"watchdog(@[0-9]+)?". But it really falls short if you want to have
two watchdogs with different properties.

-michael
