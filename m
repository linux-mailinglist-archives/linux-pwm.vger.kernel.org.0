Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CCA2829F3
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Oct 2020 11:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgJDJ6Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Sun, 4 Oct 2020 05:58:24 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49374 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDJ6Y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 4 Oct 2020 05:58:24 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 897651C0B76; Sun,  4 Oct 2020 11:58:20 +0200 (CEST)
Date:   Sun, 4 Oct 2020 11:58:19 +0200
From:   Pavel Machek <pavel@denx.de>
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v9 11/13] arm64: dts: freescale: sl28: enable LED support
Message-ID: <20201004095818.GA1104@bug>
References: <20200907213802.26745-1-michael@walle.cc>
 <20200907213802.26745-12-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200907213802.26745-12-michael@walle.cc>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon 2020-09-07 23:38:00, Michael Walle wrote:
> Now that we have support for GPIO lines of the SMARC connector, enable
> LED support on the KBox A-230-LS. There are two LEDs without fixed
> functions, one is yellow and one is green. Unfortunately, it is just one
> multi-color LED, thus while it is possible to enable both at the same
> time it is hard to tell the difference between "yellow only" and "yellow
> and green".
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Pavel Machek <pavel@ucw.cz>


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
