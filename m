Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2DB1EF50A
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgFEKJW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 06:09:22 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:33177 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFEKJT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 06:09:19 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C88EF22EE4;
        Fri,  5 Jun 2020 12:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591351756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MsgwKzto2IoOJjvjTzGrigwCXuk4v4Z5kvEN1IzyNVY=;
        b=YOz7DoaZopOBIiCVRhTaDmoHMSotqFUD1klTT5xzP/DYKwRApaTqVpxiFqUj62wQlkCeso
        rmShm/jyM0iW0HJQFp/yx0Rrr4/4YkFrd+I1dZGiEUATTJIfds6yt2ig9EK80aeePTx5yV
        JdQmMvjA6eyQ/Ls2P9eum9CkF6m0QN0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Jun 2020 12:09:15 +0200
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
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management
 controller
In-Reply-To: <CAHp75Vd-R3yqhq88-whY6vdDhESpzvFCsbi-ygSTjfXfUzOrtg@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
 <CAHp75Vd-R3yqhq88-whY6vdDhESpzvFCsbi-ygSTjfXfUzOrtg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <8ed988b3e0bc48ea9219d0847c1b1b8e@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andy,

Am 2020-06-05 10:01, schrieb Andy Shevchenko:
> On Fri, Jun 5, 2020 at 12:16 AM Michael Walle <michael@walle.cc> wrote:
>> 
>> Add the core support for the board management controller found on the
>> SMARC-sAL28 board. It consists of the following functions:
>>  - watchdog
>>  - GPIO controller
>>  - PWM controller
>>  - fan sensor
>>  - interrupt controller
>> 
>> At the moment, this controller is used on the Kontron SMARC-sAL28 
>> board.
>> 
>> Please note that the MFD driver is defined as bool in the Kconfig
>> because the next patch will add interrupt support.
> 
> ...
> 
>> +config MFD_SL28CPLD
>> +       bool "Kontron sl28 core driver"
>> +       depends on I2C=y
> 
> Why not module?

There are users of the interupt lines provided by the interrupt 
controller.
For example, the gpio-button driver. If this is compiled into the kernel
(which it is by default in the arm64 defconfig), probing will fail 
because
the interrupt is not found. Is there a better way for that? I guess the 
same
is true for the GPIO driver.

> 
>> +       depends on OF
> 
> I didn't find an evidence this is needed.

see below.

> 
> No Compile Test?

ok

>> +       select REGMAP_I2C
>> +       select MFD_CORE
> 
> ...
> 
>> +#include <linux/of_platform.h>
> 
> No evidence of user of this.
> I think you meant mod_devicetable.h.

devm_of_platform_populate(), so I need CONFIG_OF, too right?


>> +static struct i2c_driver sl28cpld_driver = {
>> +       .probe_new = sl28cpld_probe,
>> +       .driver = {
>> +               .name = "sl28cpld",
>> +               .of_match_table = of_match_ptr(sl28cpld_of_match),
> 
> Drop of_match_ptr(). It has a little sense in this context (depends 
> OF).
> It will have a little sense even if you drop depends OF b/c you will
> introduce a compiler warning.

ok

> 
>> +       },
>> +};

-- 
-michael
