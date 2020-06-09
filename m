Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9661F3EC3
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 17:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbgFIPBZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 11:01:25 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:41115 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgFIPBX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jun 2020 11:01:23 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ECD3222F2D;
        Tue,  9 Jun 2020 17:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591714878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMjIHhTy6QW0P3MAj5LndzKCaO3yMkaVaezROboWYDQ=;
        b=euAsn1+18dDVaj3N75vATYwEPsegHDppC2VkD83JeqzT2R996iBd9IREmPEKKWtU3l6Y87
        FIevxYAgjKLBLJOEfvarLgLrdMoq2oGSqGMdyVuvbdXSk4KVSd+kZBW/cn+mGMxySwB626
        jCO4U5VjZWc1OyJMGDZeHKyJ7fca1Ik=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Jun 2020 17:01:17 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        david.m.ertman@intel.com, shiraz.saleem@intel.com,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K?= =?UTF-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management
 controller
In-Reply-To: <20200609144201.GK4583@sirena.org.uk>
References: <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
 <20200606114645.GB2055@sirena.org.uk>
 <dc052a5c77171014ecc465b1da8b7ef8@walle.cc> <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc> <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc> <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
 <20200609144201.GK4583@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <a2bae71634fe288f067d5e92090b7561@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-06-09 16:42, schrieb Mark Brown:
> On Tue, Jun 09, 2020 at 04:38:31PM +0200, Michael Walle wrote:
> 
>>   mfd-device@10 {
>>     compatible = "simple-regmap", "simple-mfd";
>>     reg = <10>;
>>     regmap,reg-bits = <8>;
>>     regmap,val-bits = <8>;
>>     sub-device@0 {
>>       compatible = "vendor,sub-device0";
>>       reg = <0>;
>>     };
> 
> A DT binding like this is not a good idea, encoding the details of the
> register map into the DT binding makes it an ABI which is begging for
> trouble.  I'd also suggest that any device using a generic driver like
> this should have a specific compatible string for the device so we can
> go back and add quirks later if we need them.

Like in the spidev case, yes. But OTOH if I _just_ encode the parameters
for the regmap a MFD, Lee don't agree because its just a shim. So either
way I seem to be stuck here.

Where should I put the code to create an i2c driver, init a regmap and
populate its childen?

-michael

> 
>>     ...
>> };
>> 
>> Or if you just want the regmap:
>> 
>> &soc {
>>   regmap: regmap@fff0000 {
>>     compatible = "simple-regmap";
>>     reg = <0xfff0000>;
>>     regmap,reg-bits = <16>;
>>     regmap,val-bits = <32>;
>>   };
>> 
>>   enet-which-needs-syscon-too@1000000 {
>>     vendor,ctrl-regmap = <&regmap>;
>>   };
>> };
>> 
>> Similar to the current syscon (which is MMIO only..).
>> 
>> -michael
>> 
>> >
>> > I can't think of any reasons why not, off the top of my head.
>> >
>> > Does Regmap only deal with shared accesses from multiple devices
>> > accessing a single register map, or can it also handle multiple
>> > devices communicating over a single I2C channel?
>> >
>> > One for Mark perhaps.
>> >
>> > > > The issues I wish to resolve using 'simple-mfd' are when sub-devices
>> > > > register maps overlap and intertwine.
>> >
>> > [...]
>> >
>> > > > > > > What do these bits configure?
>> > > > >
>> > > > > - hardware strappings which have to be there before the board powers
>> > > > > up,
>> > > > >   like clocking mode for different SerDes settings
>> > > > > - "keep-in-reset" bits for onboard peripherals if you want to save
>> > > > > power
>> > > > > - disable watchdog bits (there is a watchdog which is active right
>> > > > > from
>> > > > >   the start and supervises the bootloader start and switches to
>> > > > > failsafe
>> > > > >   mode if it wasn't successfully started)
>> > > > > - special boot modes, like eMMC, etc.
>> > > > >
>> > > > > Think of it as a 16bit configuration word.
>> > > >
>> > > > And you wish for users to be able to view these at run-time?
>> > >
>> > > And esp. change them.
>> > >
>> > > > Can they adapt any of them on-the-fly or will the be RO?
>> > >
>> > > They are R/W but only will only affect the board behavior after a
>> > > reset.
>> >
>> > I see.  Makes sense.  This is board controller territory.  Perhaps
>> > suitable for inclusion into drivers/soc or drivers/platform.

-- 
-michael
