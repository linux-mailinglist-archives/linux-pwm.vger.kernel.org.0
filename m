Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487AA22548B
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jul 2020 00:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGSWbf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 18:31:35 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38139 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgGSWbe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 18:31:34 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B5C8F22FEC;
        Mon, 20 Jul 2020 00:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1595197891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4N28ZYWIcbmHLT9PzLmmIKU9hPLYoVHxRdShOC5C/M=;
        b=N3H6X4pTPOFXN6bxZLOMhel7mRPg4vOcbE8OI1ADuH7cXiYE+9ibZZV3pFhuM7xrRn33ch
        mX6K7klggfZZgIqkaS9Gtjt15lU60QqayRU7HmZ37umopWGQglE5lXEsck7mXnLfvPn0bh
        A1ddZKFhuuBU1Zomb0T/y9yJvuTsELo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Jul 2020 00:31:29 +0200
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 02/13] mfd: add simple regmap based I2C driver
In-Reply-To: <20200717090656.GF3165313@dell>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-3-michael@walle.cc> <20200717090656.GF3165313@dell>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <52d85ea1ddc488762df547168e2001e9@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-07-17 11:06, schrieb Lee Jones:
> On Mon, 06 Jul 2020, Michael Walle wrote:
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
>> Changes since v4:
>>  - new patch. Lee, please bear with me. I didn't want to delay the
>>    new version (where a lot of remarks on the other patches were
>>    addressed) even more, just because we haven't figured out how
>>    to deal with the MFD part. So for now, I've included this one.
>> 
>>  drivers/mfd/Kconfig          |  9 +++++++
>>  drivers/mfd/Makefile         |  1 +
>>  drivers/mfd/simple-mfd-i2c.c | 50 
>> ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 60 insertions(+)
>>  create mode 100644 drivers/mfd/simple-mfd-i2c.c
>> 
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 33df0837ab41..f1536a710aca 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1162,6 +1162,15 @@ config MFD_SI476X_CORE
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called si476x-core.
>> 
>> +config MFD_SIMPLE_MFD_I2C
>> +	tristate "Simple regmap based I2C devices"
> 
> Doesn't look like tristate to me.
> 
> Haven't you made this builtin only?

Mh yeah, I forgot to change it to module in the driver. I don't
know whats better though, have it tristate or just offer a boolean
option because it should be small anyway. What do you think?
My interrupt driver will force it to boolean anyway.

> 
>> +	depends on I2C
>> +	select MFD_CORE
> 
> Why?

leftover :( I'll remove it.


>> +	select REGMAP_I2C
>> +	help
>> +	  This is a consolidated driver for all MFD devices which are
>> +	  basically just a regmap bus driver.
> 
> Please expand on this.  I think it deserves greater explanation.

ok.

> 
>>  config MFD_SM501
>>  	tristate "Silicon Motion SM501"
>>  	depends on HAS_DMA

-- 
-michael
