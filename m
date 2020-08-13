Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EFE243473
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Aug 2020 09:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHMHJo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Aug 2020 03:09:44 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:46899 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHMHJn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Aug 2020 03:09:43 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E483222EDE;
        Thu, 13 Aug 2020 09:09:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1597302580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ok4pEqRTPwdokbHa/IMlTv6DhwAEzETP5M+d49NSRsM=;
        b=KMS6BhghAQ9AwIZUVDheuUNtL7OEYIkis7uX8/9dUmN63Qe/n9j00W7sI8bUHvL/pRW1/7
        wOlmzcsgJNfoPreYCDGd6SiW85qjkd2QMTfXndnjgrXQHNuuWI+BHnE3e91xiw1pZ/N7aV
        eCxtpctn8ewVaU0Ah6sRQJrKLcV7OaI=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 13 Aug 2020 09:09:32 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 06/13] pwm: add support for sl28cpld PWM controller
In-Reply-To: <2ca0a3a3f03a1f5b9b2777738824123b@walle.cc>
References: <20200803093559.12289-1-michael@walle.cc>
 <20200803093559.12289-7-michael@walle.cc>
 <20200806084000.k3aj5nmqdodmb35v@pengutronix.de>
 <e288ca6cfee819223395712e04159dd9@walle.cc> <20200810071328.GB4411@dell>
 <2ca0a3a3f03a1f5b9b2777738824123b@walle.cc>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <514d83dadc2055abb5e6b5328eff4d97@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-08-10 09:31, schrieb Michael Walle:
> Am 2020-08-10 09:13, schrieb Lee Jones:
>> On Fri, 07 Aug 2020, Michael Walle wrote:
>> 
>>> Hi Uwe, Hi Lee,
>>> 
>>> Am 2020-08-06 10:40, schrieb Uwe Kleine-König:
>>> > On Mon, Aug 03, 2020 at 11:35:52AM +0200, Michael Walle wrote:
>>> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>> > > index 7dbcf6973d33..a0d50d70c3b9 100644
>>> > > --- a/drivers/pwm/Kconfig
>>> > > +++ b/drivers/pwm/Kconfig
>>> > > @@ -428,6 +428,16 @@ config PWM_SIFIVE
>>> > >  	  To compile this driver as a module, choose M here: the module
>>> > >  	  will be called pwm-sifive.
>>> > >
>>> > > +config PWM_SL28CPLD
>>> > > +	tristate "Kontron sl28cpld PWM support"
>>> > > +	select MFD_SIMPLE_MFD_I2C
>>> >
>>> > Is it sensible to present this option to everyone? Maybe
>>> >
>>> > 	depends on SOME_SYMBOL_ONLY_TRUE_ON_SL28CPLD || COMPILE_TEST
>>> 
>>> Because there is now no real MFD driver anymore, there is also
>>> no symbol for that. The closest would be ARCH_ARM64 but I don't
>>> think that is a good idea.
>>> 
>>> Lee, what do you think about adding a symbol to the MFD, which
>>> selects MFD_SIMPLE_MFD_I2C but doesn't enable any C modules?
>>> 
>>> I.e.
>>> config MFD_SL28CPLD
>>>     tristate "Kontron sl28cpld"
>>>     select MFD_SIMPLE_MFD_I2C
>>>     help
>>>       Say yes here to add support for the Kontron sl28cpld board
>>>       management controller.
>>> 
>>> Then all the other device driver could depend on the MFD_SL28CPLD
>>> symbol.
>> 
>> You want to add a virtual symbol to prevent having to present a real
>> one?  How is that a reasonable solution?
> 
> (1) Its a symbol on which all sl28cpld will depend on. Thus they will
>     all be hidden if that is not set.
> (2) the drivers itself wouldn't need to depend on MFD_SIMPLE_MFD_I2C,
>     which is more correct, because they don't have anything to do with
>     i2c.

Lee, would you accept such a symbol? Otherwise, I'd leave it as is.

-michael
