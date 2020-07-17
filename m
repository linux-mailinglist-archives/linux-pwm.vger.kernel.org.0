Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F891224603
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jul 2020 23:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGQVyu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 17:54:50 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:37007 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgGQVyu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 17:54:50 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BE8012304C;
        Fri, 17 Jul 2020 23:54:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1595022887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CGb6zPojzWptr9RntI9Q3NPEKDFmlMY+j6ZpL+FsLqc=;
        b=lXUBPhprMxuWRTGWj9ooCq/GJ4mduBqqCqkYMgu/pDyDfu75YE4/ef2ZgJ+fQ3e7CL1Tl9
        MRG/bXe1GHq2w8n/hrhFFsoN+fiFgxupsc0LkwpgnlFow0FVYgv4Qq4LQRjSeokbD6WD9N
        nh2GUUA2A7+CA/NgsN+TkqLnuF/u2tk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 Jul 2020 23:54:42 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pavel Machek <pavel@ucw.cz>
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
        Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 12/13] arm64: dts: freescale: sl28: enable LED support
In-Reply-To: <20200717083610.GC1027@bug>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-13-michael@walle.cc> <20200717083610.GC1027@bug>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <af0584da0f43cb6cfffeb8fcf2235acb@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Pavel,

Am 2020-07-17 10:36, schrieb Pavel Machek:
> Hi!
> 
>> Now that we have support for GPIO lines of the SMARC connector, enable
>> LED support on the KBox A-230-LS. There are two LEDs without fixed
>> functions, one is yellow and one is green. Unfortunately, it is just 
>> one
>> multi-color LED, thus while it is possible to enable both at the same
>> time it is hard to tell the difference between "yellow only" and 
>> "yellow
>> and green".
> 
>> +		user_yellow {
>> +			label = "s1914:yellow:user";
>> +			gpios = <&sl28cpld_gpio0 0 0>;
>> +		};
>> +
>> +		user_green {
>> +			label = "s1914:green:user";
>> +			gpios = <&sl28cpld_gpio1 3 0>;
>> +		};
> 
> This is not suitable label for such LEDs... there's zero chance 
> userland will
> know what to do with these.
> 
> Do they have some kind of "usual" function?

Unfortunately, they do not. I guess the green one could be something 
like
"application ready" and the yellow one could be an indication that some
fault occurred.

Do you have any suggestions?

-michael
