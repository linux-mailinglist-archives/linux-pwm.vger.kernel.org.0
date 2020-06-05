Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CB11EF6C5
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 13:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgFELvL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFELvL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 07:51:11 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E342C08C5C2;
        Fri,  5 Jun 2020 04:51:11 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 726BF22FEC;
        Fri,  5 Jun 2020 13:51:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591357869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ER+pXew699aFz9lRU/UtY269UriM4m1gHDqBzilNF0=;
        b=WOTqL1q5lVzt+KkEj2owI4A1lqxulU6qjVgnX7Fgolv/1VHdSWTe5qwcdYnZRfLQ2I7sHo
        1EUptsptx9N4EuPomc09TB5DOJoQNPkRGpLSCB/Ur9LH8PQiLUnhh+iLM7hAcyB7Q9jxZH
        VBka4JiutxAQHctV0rsFn+jcdze1zKQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Jun 2020 13:51:09 +0200
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
In-Reply-To: <CAHp75Vf00w_UUvXULVd=OgSVM+p_pmNMJRPVnf8GNZW10c_j5w@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
 <CAHp75Vd-R3yqhq88-whY6vdDhESpzvFCsbi-ygSTjfXfUzOrtg@mail.gmail.com>
 <8ed988b3e0bc48ea9219d0847c1b1b8e@walle.cc>
 <CAHp75Vf00w_UUvXULVd=OgSVM+p_pmNMJRPVnf8GNZW10c_j5w@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <dd0e4cedd004768d1090766d6eeff10a@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-06-05 12:48, schrieb Andy Shevchenko:
> On Fri, Jun 5, 2020 at 1:09 PM Michael Walle <michael@walle.cc> wrote:
>> Am 2020-06-05 10:01, schrieb Andy Shevchenko:
>> > On Fri, Jun 5, 2020 at 12:16 AM Michael Walle <michael@walle.cc> wrote:
> 
> ...
> 
>> >> +       bool "Kontron sl28 core driver"
>> >> +       depends on I2C=y
>> >
>> > Why not module?
>> 
>> There are users of the interupt lines provided by the interrupt
>> controller.
>> For example, the gpio-button driver. If this is compiled into the 
>> kernel
>> (which it is by default in the arm64 defconfig), probing will fail
>> because
>> the interrupt is not found. Is there a better way for that? I guess 
>> the
>> same
>> is true for the GPIO driver.
> 
> And GPIO nicely handles this via deferred probe mechanism. Why it
> can't be used here?
> So, we really need to have a strong argument to limit module nowadays
> to be only builtin.

Was that a question for me? TBH thats how other interrupt drivers doing
it for now. And it would be the users who need to be fixed, right? Or
even the platform code? Because it will complain with

[    2.962990] irq: no irq domain found for interrupt-controller@1c !
[    2.975762] gpio-keys buttons0: Found button without gpio or irq
[    2.981872] gpio-keys: probe of buttons0 failed with error -22

>> >> +       depends on OF
>> >
>> > I didn't find an evidence this is needed.
> 
>> >> +#include <linux/of_platform.h>
>> >
>> > No evidence of user of this.
>> > I think you meant mod_devicetable.h.
>> 
>> devm_of_platform_populate(), so I need CONFIG_OF, too right?
> 
> Ah, this explains header, thanks!
> But it doesn't explain depends OF.
> 
> So, perhaps,
> 
> depends OF || COMPILE_TEST will be more informative, i.e.
> tells "okay, this driver can be compiled w/o OF, but won't be 
> functional".

ok


-- 
-michael
