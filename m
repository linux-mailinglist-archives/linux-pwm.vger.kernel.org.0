Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9523A2183F6
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2020 11:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgGHJhm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Jul 2020 05:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgGHJhm (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 8 Jul 2020 05:37:42 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43645206C3;
        Wed,  8 Jul 2020 09:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594201061;
        bh=FMfBPrKkg56I41HR/oz9HArqZ/nbHhmy/CTSfaxeBGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sbfNACTpkqCbWD5aa302J26Zs8H/6wJy04I81wZIXqHfv+8h6aPihY0skXI9Ws3xT
         uAQODNbO+TB96nVJfyWxe4AJMxm3KcaEVeT2NPqd0QsMsw08Ymc9EpHUlZBqYUpSVe
         odhxBTqdT7vgRn7mxOsVMthPOc9wK/pckWYf0oao=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jt6WJ-00A2JK-Qa; Wed, 08 Jul 2020 10:37:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Jul 2020 10:37:39 +0100
From:   Marc Zyngier <maz@kernel.org>
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
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 05/13] irqchip: add sl28cpld interrupt controller
 support
In-Reply-To: <20200706175353.16404-6-michael@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-6-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <30c8a3b40003f8805ba8ebacd328583c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: michael@walle.cc, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net, lee.jones@linaro.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, wim@linux-watchdog.org, shawnguo@kernel.org, leoyang.li@nxp.com, tglx@linutronix.de, jason@lakedaemon.net, broonie@kernel.org, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2020-07-06 18:53, Michael Walle wrote:
> Add support for the interrupt controller inside the sl28 CPLD 
> management
> controller.
> 
> The interrupt controller can handle at most 8 interrupts and is really
> simplistic and consists only of an interrupt mask and an interrupt
> pending register.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v4:
>  - update copyright year
>  - don't use "int irq" instead of "unsigne int irq", because
>    platform_get_irq() might return a negative error code. Found by 
> "kernel
>    test robot <lkp@intel.com>
>  - remove comma in terminator line of the compatible strings list,
>    suggested by Andy
>  - use newer devm_regmap_add_irq_chip_fwnode()
>  - don't use KBUID_MODNAME, suggested by Andy
>  - remove the platform device table
> 
> Changes since v3:
>  - see cover letter
> 
>  drivers/irqchip/Kconfig        |  8 +++
>  drivers/irqchip/Makefile       |  1 +
>  drivers/irqchip/irq-sl28cpld.c | 96 ++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 drivers/irqchip/irq-sl28cpld.c

Acked-by: Marc Zyngier <maz@kernel.org>

Given the dependency on the MFD patches, I assume this will
be routed to that subsystem. Please let me know if you want
it to be handled differently.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
