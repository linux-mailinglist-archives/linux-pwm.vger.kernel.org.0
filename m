Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5746B22372C
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jul 2020 10:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgGQIgR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 04:36:17 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56612 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgGQIgQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 04:36:16 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2E8971C0BEB; Fri, 17 Jul 2020 10:36:11 +0200 (CEST)
Date:   Fri, 17 Jul 2020 10:36:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Michael Walle <michael@walle.cc>
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
Message-ID: <20200717083610.GC1027@bug>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-13-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706175353.16404-13-michael@walle.cc>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi!

> Now that we have support for GPIO lines of the SMARC connector, enable
> LED support on the KBox A-230-LS. There are two LEDs without fixed
> functions, one is yellow and one is green. Unfortunately, it is just one
> multi-color LED, thus while it is possible to enable both at the same
> time it is hard to tell the difference between "yellow only" and "yellow
> and green".

> +		user_yellow {
> +			label = "s1914:yellow:user";
> +			gpios = <&sl28cpld_gpio0 0 0>;
> +		};
> +
> +		user_green {
> +			label = "s1914:green:user";
> +			gpios = <&sl28cpld_gpio1 3 0>;
> +		};

This is not suitable label for such LEDs... there's zero chance userland will
know what to do with these.

Do they have some kind of "usual" function?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
