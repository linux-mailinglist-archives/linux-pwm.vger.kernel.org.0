Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996661EF545
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 12:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgFEKY5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 06:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgFEKY5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 06:24:57 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4838C08C5C2;
        Fri,  5 Jun 2020 03:24:56 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 83D3C22EE4;
        Fri,  5 Jun 2020 12:24:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591352694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILwM29qMSYKcVIWPmdUtNbrZy37LKLfK7PaTLUSzfUU=;
        b=f4MCEfYDpsR0K+oXpcdSTqRG43PxCzYJmSlibPHE6ofdGUuZ0CvMgQcaoPasbcub3jyhG3
        T7/ZANjnNC6nRvAdE8mYArlV8+FVqCiV8I5Nf5F6LoVxDZEw+Y5qeiGxMLUXrNUBgbBTSn
        EEQf07mVqq8+OrOiS2L2exaQBCw7f7o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Jun 2020 12:24:54 +0200
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
Subject: Re: [PATCH v4 04/11] watchdog: add support for sl28cpld watchdog
In-Reply-To: <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-5-michael@walle.cc>
 <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <8f042c2442852c29519c381833f3d289@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-06-05 10:14, schrieb Andy Shevchenko:
> On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:
>> 
>> Add support for the watchdog of the sl28cpld board management
>> controller. This is part of a multi-function device driver.
> 
> ...
> 
>> +#include <linux/of_device.h>
> 
> Didn't find a user of this.

I guess mod_devicetable.h then.

> 
> ...
> 
>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>> +module_param(nowayout, bool, 0);
>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started 
>> (default="
>> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT) 
>> ")");
>> +
>> +static int timeout;
>> +module_param(timeout, int, 0);
>> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
> 
> Guenter ACKed this, but I'm wondering why we still need module 
> parameters...

How would a user change the nowayout or the timeout? For the latter 
there is
a device tree entry, but thats not easy changable by the user.

> 
> ...
> 
>> +       int ret;
>> +
>> +       ret = regmap_read(wdt->regmap, wdt->offset + WDT_COUNT, &val);
>> +
>> +       return (ret < 0) ? 0 : val;
> 
> Besides extra parentheses and questionable ' < 0' part, the following
> would look better I think
> 
> ret = ...
> if (ret)
>   return 0;
> 
> return val;

yes, you're right.

> 
> ...
> 
>> +       int ret;
>> +
>> +       ret = regmap_write(wdt->regmap, wdt->offset + WDT_TIMEOUT, 
>> timeout);
>> +       if (!ret)
>> +               wdd->timeout = timeout;
>> +
>> +       return ret;
> 
> Similar story here:
> 
> ret = ...
> if (ret)
>   return ret;
> 
> wdd->... = ...
> return 0;
> 
> ...

ok

> 
>> +       ret = regmap_read(wdt->regmap, wdt->offset + WDT_CTRL, 
>> &status);
> 
>> +       if (ret < 0)
> 
> What ' < 0' means? Do we have some positive return values?
> Ditto for all your code.

probably not, I'll go over all return values and change them.

>> +               return ret;
> 
> ...
> 
>> +       if (status & WDT_CTRL_EN) {
>> +               sl28cpld_wdt_start(wdd);
> 
>> +               set_bit(WDOG_HW_RUNNING, &wdd->status);
> 
> Do you need atomic op here? Why?

I'd say consistency, all watchdog drivers do it like that. I just
had a look at where this is used, but it looks like access from
userspace is protected by a lock.

> 
>> +       }
> 
> ...
> 
>> +static const struct of_device_id sl28cpld_wdt_of_match[] = {
>> +       { .compatible = "kontron,sl28cpld-wdt" },
> 
>> +       {},
> 
> No comma.

yeah ;)

-- 
-michael
