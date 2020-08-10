Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75D7240291
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Aug 2020 09:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgHJHbt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Aug 2020 03:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgHJHbt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Aug 2020 03:31:49 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBA0C061756;
        Mon, 10 Aug 2020 00:31:48 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EDE7F22ED5;
        Mon, 10 Aug 2020 09:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1597044704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5klQWMMHU8Ee9M3fQmjdVoNMXn8r8NKjAB/+jN2Z22o=;
        b=RskBIHUqm9dJEuq24ixJy/wnCPI1k+LlLwGD3YDaMNrIxpT7alp+IYBbidU9g/DDYL17L4
        +i3UjQC+yZJzfyR+7fP0K9WgOcXXb0uA7lTIZWVLIgGcL8iORxooes7NnEN1Xjqmv1M1tg
        UbCyOZUMcttJxhVpPMjuSDQ4j3mrgTQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 10 Aug 2020 09:31:38 +0200
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
In-Reply-To: <20200810071328.GB4411@dell>
References: <20200803093559.12289-1-michael@walle.cc>
 <20200803093559.12289-7-michael@walle.cc>
 <20200806084000.k3aj5nmqdodmb35v@pengutronix.de>
 <e288ca6cfee819223395712e04159dd9@walle.cc> <20200810071328.GB4411@dell>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <2ca0a3a3f03a1f5b9b2777738824123b@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-08-10 09:13, schrieb Lee Jones:
> On Fri, 07 Aug 2020, Michael Walle wrote:
> 
>> Hi Uwe, Hi Lee,
>> 
>> Am 2020-08-06 10:40, schrieb Uwe Kleine-König:
>> > On Mon, Aug 03, 2020 at 11:35:52AM +0200, Michael Walle wrote:
>> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> > > index 7dbcf6973d33..a0d50d70c3b9 100644
>> > > --- a/drivers/pwm/Kconfig
>> > > +++ b/drivers/pwm/Kconfig
>> > > @@ -428,6 +428,16 @@ config PWM_SIFIVE
>> > >  	  To compile this driver as a module, choose M here: the module
>> > >  	  will be called pwm-sifive.
>> > >
>> > > +config PWM_SL28CPLD
>> > > +	tristate "Kontron sl28cpld PWM support"
>> > > +	select MFD_SIMPLE_MFD_I2C
>> >
>> > Is it sensible to present this option to everyone? Maybe
>> >
>> > 	depends on SOME_SYMBOL_ONLY_TRUE_ON_SL28CPLD || COMPILE_TEST
>> 
>> Because there is now no real MFD driver anymore, there is also
>> no symbol for that. The closest would be ARCH_ARM64 but I don't
>> think that is a good idea.
>> 
>> Lee, what do you think about adding a symbol to the MFD, which
>> selects MFD_SIMPLE_MFD_I2C but doesn't enable any C modules?
>> 
>> I.e.
>> config MFD_SL28CPLD
>>     tristate "Kontron sl28cpld"
>>     select MFD_SIMPLE_MFD_I2C
>>     help
>>       Say yes here to add support for the Kontron sl28cpld board
>>       management controller.
>> 
>> Then all the other device driver could depend on the MFD_SL28CPLD
>> symbol.
> 
> You want to add a virtual symbol to prevent having to present a real
> one?  How is that a reasonable solution?

(1) Its a symbol on which all sl28cpld will depend on. Thus they will
     all be hidden if that is not set.
(2) the drivers itself wouldn't need to depend on MFD_SIMPLE_MFD_I2C,
     which is more correct, because they don't have anything to do with
     i2c.

-michael
