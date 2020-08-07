Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E1D23E7F4
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Aug 2020 09:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHGH2j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Aug 2020 03:28:39 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:45747 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGH2i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Aug 2020 03:28:38 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CF4A922ED8;
        Fri,  7 Aug 2020 09:28:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1596785315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tqzu9cLvHIN1w+G0QnQy/FU9UJymmPP1GnHUTyNwIWU=;
        b=CLO9uFSoOVH3XA6dnULEy2QmA0Enr2120+59hiwzIkhJvSLxb9rm0SLTIdWKZS0qIbZFtU
        KwVkQj9aBlA4svDMmN0bz9kL32a7s3yo8YNO/WNoOE6x6OAMBh+I4qg7O4PZqCTGIa9ifG
        zUXv755+HfYWp7qQtzjFvlJnemNYLak=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 07 Aug 2020 09:28:31 +0200
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
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
In-Reply-To: <20200806084000.k3aj5nmqdodmb35v@pengutronix.de>
References: <20200803093559.12289-1-michael@walle.cc>
 <20200803093559.12289-7-michael@walle.cc>
 <20200806084000.k3aj5nmqdodmb35v@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <e288ca6cfee819223395712e04159dd9@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe, Hi Lee,

Am 2020-08-06 10:40, schrieb Uwe Kleine-König:
> On Mon, Aug 03, 2020 at 11:35:52AM +0200, Michael Walle wrote:
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 7dbcf6973d33..a0d50d70c3b9 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -428,6 +428,16 @@ config PWM_SIFIVE
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-sifive.
>> 
>> +config PWM_SL28CPLD
>> +	tristate "Kontron sl28cpld PWM support"
>> +	select MFD_SIMPLE_MFD_I2C
> 
> Is it sensible to present this option to everyone? Maybe
> 
> 	depends on SOME_SYMBOL_ONLY_TRUE_ON_SL28CPLD || COMPILE_TEST

Because there is now no real MFD driver anymore, there is also
no symbol for that. The closest would be ARCH_ARM64 but I don't
think that is a good idea.

Lee, what do you think about adding a symbol to the MFD, which
selects MFD_SIMPLE_MFD_I2C but doesn't enable any C modules?

I.e.
config MFD_SL28CPLD
     tristate "Kontron sl28cpld"
     select MFD_SIMPLE_MFD_I2C
     help
       Say yes here to add support for the Kontron sl28cpld board
       management controller.

Then all the other device driver could depend on the MFD_SL28CPLD
symbol.

[..]

>> +static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
>> +				   struct pwm_device *pwm,
>> +				   struct pwm_state *state)
>> +{
>> +	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
>> +	unsigned int reg;
>> +	int prescaler;
>> +
>> +	sl28cpld_pwm_read(priv, SL28CPLD_PWM_CTRL, &reg);
>> +
>> +	state->enabled = reg & SL28CPLD_PWM_CTRL_ENABLE;
>> +
>> +	prescaler = FIELD_GET(SL28CPLD_PWM_CTRL_PRESCALER_MASK, reg);
>> +	state->period = SL28CPLD_PWM_PERIOD(prescaler);
>> +
>> +	sl28cpld_pwm_read(priv, SL28CPLD_PWM_CYCLE, &reg);
>> +	state->duty_cycle = SL28CPLD_PWM_TO_DUTY_CYCLE(reg);
> 
> Should reg be masked to SL28CPLD_PWM_CYCLE_MAX, or is it guaranteed 
> that
> the upper bits are zero?

Mh, the hardware guarantees that bit7 is zero. So masking with
SL28CPLD_PWM_CYCLE_MAX won't buy us much. But what I could think
could go wrong is this: someone set the prescaler to != 0 and the
duty cycle to a value greater than the max value for this particular
prescaler mode. For the above calculations this would result in a
duty_cycle greater than the period, if I'm not mistaken.

The behavior of the hardware is undefined in that case (at the moment
it will be always on, I guess). So this isn't a valid setting.
Nevertheless it might happen. So what about the following:

state->duty_cycle = min(state->duty_cycle, state->period);

-michael
