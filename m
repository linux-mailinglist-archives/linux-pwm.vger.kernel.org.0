Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0651F00BE
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 22:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgFEUHk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 16:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbgFEUHk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 16:07:40 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86799C08C5C3;
        Fri,  5 Jun 2020 13:07:39 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C7B7222FEB;
        Fri,  5 Jun 2020 22:07:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591387657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4yi/Grhaf0w4jjGNDMnsTZ5HJKkIfL4Ymq6vlFIb8I=;
        b=OuBQyumVx9fvWq152YNCm2zk5nOR6UzVoQFWmfvSoHap0daT70FokziRiSbd6uS36mmPq6
        G+e8cV1FzWm9bwj7zpeF8fVaVmGgJnv9KD/GT5DtDfSlaIe9MSW8xvNitMyQkuNc0sFibr
        gIo1iXnMpABriffMl0K69T6+nevu00I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Jun 2020 22:07:36 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
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
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management
 controller
In-Reply-To: <20200605105026.GC5413@sirena.org.uk>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc> <20200605065709.GD3714@dell>
 <20200605105026.GC5413@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

Am 2020-06-05 12:50, schrieb Mark Brown:
> On Fri, Jun 05, 2020 at 07:57:09AM +0100, Lee Jones wrote:
>> On Thu, 04 Jun 2020, Michael Walle wrote:
> 
>> > +	sl28cpld->regmap = devm_regmap_init_i2c(i2c, &sl28cpld_regmap_config);
>> > +	if (IS_ERR(sl28cpld->regmap))
>> > +		return PTR_ERR(sl28cpld->regmap);
> 
>> This is now a shared memory allocator and not an MFD at all.
> 
>> I'm clamping down on these type of drivers!
> 
>> Please find a better way to accomplish this.
> 
> What is the concern with this?  Looking at the patch I'm guessing the
> concern would be that the driver isn't instantiating any MFD children
> and instead requiring them to be put in the DT?
> 
>> Potentially using "simple-mfd" and "simple-regmap".
> 
>> The former already exists and does what you want.  The latter doesn't
>> yet exist, but could solve your and lots of other contributor's
>> issues.
> 
> I have no idea what you are thinking of when you say "simple-regmap" so
> it is difficult to comment.

I guess, Lee is suggesting to be able to create a regmap instance via
device tree (and populate its child nodes?). Like
   compatible = "syscon", "simple-mfd";
but for any regmap, not just MMIO.

But, there is more in my driver:
  (1) there is a version check
  (2) there is another function for which there is no suitable linux
      subsystem I'm aware of and thus which I'd like to us sysfs
      attributes for: This controller supports 16 non-volatile
      configuration bits. (this is still TBD)

I don't see what is different between this driver and for example the
gateworks-gsc.c. Just that mine doesn't use a global register set, but
local offsets and a base for each component. From a hardware
perspective its one device behind an I2C address providing different
functions across multiple driver subsystems.

Actually, I've tried to remove the devm_of_platform_populate() and
instead added the "simple-mfd" to my mfd node:
  compatible = "kontron,sl28cpld-r1", "simple-mfd";

I guess that doesn't work because the device is below the i2c bus?

-- 
-michael
