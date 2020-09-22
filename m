Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB0B273901
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Sep 2020 04:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgIVC7P (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Sep 2020 22:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbgIVC7O (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 21 Sep 2020 22:59:14 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A63F239A1;
        Tue, 22 Sep 2020 02:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600743554;
        bh=b2qwnEFh+ba+rThRPVC7+mIXVik4Np6wC8ogIy5np/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkH+HRlJL6TKGegQlflvBRnj+TIfWuAQPjXVI8pWBtpZOXwhNMefqNKGTU0bpuMVw
         DD6Ga0B1wscRBHHGKEVoH5uyZqzR4yY2wu+W2k4UwMKfHbrxS9AtdUUgF6f1ZMGon/
         YGWy+3a3BE7LVRfsD2XXyK7tnl3j5p/XgI+sKie8=
Date:   Tue, 22 Sep 2020 10:59:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v10 11/13] arm64: dts: freescale: sl28: enable LED support
Message-ID: <20200922025904.GX25109@dragon>
References: <20200914214341.14268-1-michael@walle.cc>
 <20200914214341.14268-12-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914214341.14268-12-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 14, 2020 at 11:43:39PM +0200, Michael Walle wrote:
> Now that we have support for GPIO lines of the SMARC connector, enable
> LED support on the KBox A-230-LS. There are two LEDs without fixed
> functions, one is yellow and one is green. Unfortunately, it is just one
> multi-color LED, thus while it is possible to enable both at the same
> time it is hard to tell the difference between "yellow only" and "yellow
> and green".
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
> Changes since v9:
>  - none
> 
> Changes since v8:
>  - none
> 
> Changes since v7:
>  - use new "function" and "color" properties instead of a label
>  - added default-on trigger for the power-led
> 
> Changes since v6:
>  - none
> 
> Changes since v5:
>  - changed the label, suggested by Pavel Machek
> 
> Changes since v4:
>  - none
> 
> Changes since v3:
>  - see cover letter
> 
>  .../fsl-ls1028a-kontron-kbox-a-230-ls.dts      | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
> index 4b4cc6a1573d..dd516c0efd8b 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
> @@ -11,11 +11,29 @@
>  
>  /dts-v1/;
>  #include "fsl-ls1028a-kontron-sl28-var4.dts"
> +#include <dt-bindings/leds/common.h>
>  
>  / {
>  	model = "Kontron KBox A-230-LS";
>  	compatible = "kontron,kbox-a-230-ls", "kontron,sl28-var4",
>  		     "kontron,sl28", "fsl,ls1028a";
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		alarm-led {
> +			function = LED_FUNCTION_ALARM;
> +			color = <LED_COLOR_ID_YELLOW>;
> +			gpios = <&sl28cpld_gpio0 0 0>;
> +		};
> +
> +		power-led {
> +			linux,default-trigger = "default-on";
> +			function = LED_FUNCTION_POWER;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&sl28cpld_gpio1 3 0>;

Use GPIO_ACTIVE_HIGH for polarity to improve the readability.

I fixed them up and applied patch #9 ~ #13.

Shawn

> +		};
> +	};
>  };
>  
>  &enetc_mdio_pf3 {
> -- 
> 2.20.1
> 
