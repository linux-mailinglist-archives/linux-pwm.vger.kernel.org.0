Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52761B87ED
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Apr 2020 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgDYRCz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 Apr 2020 13:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726156AbgDYRCy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 Apr 2020 13:02:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165C2C09B04D;
        Sat, 25 Apr 2020 10:02:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k18so4983893pll.6;
        Sat, 25 Apr 2020 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VBIKmrJmiLWT4Ougw5jkUobA+4SdhZWTwHOXjczvwT8=;
        b=F1xHEvaM/b0ETQppnfeYOtPh30ENq2JghHVih6jnKJLKWHYcJGY+xrsuK3WO83ZqJx
         z0pucKqy8sY00PZVachPpDczSX62gIOpqRdgHD7OuRop8AWrYpQGvcokOJluORRgY7wb
         n5dmX1cCrT9fnHHz843nHVYboBmN/LopNAySkSD0CFmWcx7CxIf8zfM/aTqOf3Yxwg1A
         JX5k+O0rLeXxIRNbnNoUDiwcgPwWpEkCR9Y/nRXtrg7iN13m/LgfT2yZ0KyUSgwTVbKA
         8Lh6z2F/xT69/sqzw5bwuxS0R4qk9Y5ClcO2c7kBJCKOKCvG7RczXvIjsAGkaBZ1eoH4
         5HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VBIKmrJmiLWT4Ougw5jkUobA+4SdhZWTwHOXjczvwT8=;
        b=V0s9UTkJPyfDr+1+6YGN35vqOUS6c2YAoYcqldqFNeIy/qsUEdO0fHBA2RPnND6+s2
         szmgIQTIJ7HJcW61KOo/2GoFeDo8xl2CNike95F55wi1Maos8vGsSJtkSWmsBQqcPGUG
         oRvoe0JUzYYj49CU7H0yMb6Pd9aOJ/gJop/mc1r2odK/s10tDdAcQX4hjDPFqGbP0MPV
         NurTmCYck/nUCahlMFqIiiK7C5urLMy/XQgSKQv/REjvoyXeAsTY079vsRhowXcnJpQU
         EMLjWJFvpTrF0K+AbjuqZt3FviS6SPnyPJ3sgwo4Nb7n25xaI+cxSO8QC03GjSjnfviV
         quJg==
X-Gm-Message-State: AGi0PuaaK1Q2lm/XPru7PaDMddRTzU5tG5ZdEv4LUJm+yHLrz6/vC24m
        Fzw3wviJD41Q+v3IETTMBiI=
X-Google-Smtp-Source: APiQypLt+dLMSaesv3UmaS6qMNSUbYz8bicIkLNwhtfCAYBPi7k45+K175L6T0qLP+x69lMz7tEucw==
X-Received: by 2002:a17:90a:a893:: with SMTP id h19mr13405208pjq.138.1587834173439;
        Sat, 25 Apr 2020 10:02:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z5sm8397473pfn.142.2020.04.25.10.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 10:02:52 -0700 (PDT)
Subject: Re: [PATCH v3 07/16] watchdog: add support for sl28cpld watchdog
To:     Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-8-michael@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <eaa00592-8b9b-458e-f445-c7f7b5bcd007@roeck-us.net>
Date:   Sat, 25 Apr 2020 10:02:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423174543.17161-8-michael@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 4/23/20 10:45 AM, Michael Walle wrote:
> This adds support for the watchdog of the sl28cpld board management
> controller. This is part of a multi-function device driver.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig        |  11 ++
>  drivers/watchdog/Makefile       |   1 +
>  drivers/watchdog/sl28cpld_wdt.c | 233 ++++++++++++++++++++++++++++++++
>  3 files changed, 245 insertions(+)
>  create mode 100644 drivers/watchdog/sl28cpld_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0663c604bd64..6c53c1d0f348 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -340,6 +340,17 @@ config MLX_WDT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mlx-wdt.
>  
> +config SL28CPLD_WATCHDOG
> +	tristate "Kontron sl28 watchdog"
> +	depends on MFD_SL28CPLD
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the watchdog timer
> +	  on the Kontron sl28 CPLD.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sl28cpld_wdt.
> +
>  # ALPHA Architecture
>  
>  # ARM Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 6de2e4ceef19..b9ecdf2d7347 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -224,3 +224,4 @@ obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
>  obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
>  obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
>  obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
> +obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
> diff --git a/drivers/watchdog/sl28cpld_wdt.c b/drivers/watchdog/sl28cpld_wdt.c
> new file mode 100644
> index 000000000000..2640084ace5c
> --- /dev/null
> +++ b/drivers/watchdog/sl28cpld_wdt.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * sl28cpld watchdog driver.
> + *
> + * Copyright 2019 Kontron Europe GmbH
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/watchdog.h>
> +
> +/*
> + * Watchdog timer block registers.
> + */
> +#define WDT_CTRL			0x00
> +#define  WDT_CTRL_EN			BIT(0)
> +#define  WDT_CTRL_LOCK			BIT(2)
> +#define  WDT_CTRL_ASSERT_SYS_RESET	BIT(6)
> +#define  WDT_CTRL_ASSERT_WDT_TIMEOUT	BIT(7)
> +#define WDT_TIMEOUT			0x01
> +#define WDT_KICK			0x02
> +#define  WDT_KICK_VALUE			0x6b
> +#define WDT_COUNT			0x03
> +
> +#define WDT_DEFAULT_TIMEOUT		10
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int timeout;
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
> +
> +struct sl28cpld_wdt {
> +	struct watchdog_device wdd;
> +	struct regmap *regmap;
> +	u32 offset;
> +	bool assert_wdt_timeout;
> +};
> +
> +static int sl28cpld_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_write(wdt->regmap, wdt->offset + WDT_KICK,
> +			    WDT_KICK_VALUE);
> +}
> +
> +static int sl28cpld_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +	unsigned int val;
> +
> +	val = WDT_CTRL_EN | WDT_CTRL_ASSERT_SYS_RESET;
> +	if (wdt->assert_wdt_timeout)
> +		val |= WDT_CTRL_ASSERT_WDT_TIMEOUT;
> +	if (nowayout)
> +		val |= WDT_CTRL_LOCK;
> +
> +	return regmap_update_bits(wdt->regmap, wdt->offset + WDT_CTRL,
> +				  val, val);
> +}
> +
> +static int sl28cpld_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_update_bits(wdt->regmap, wdt->offset + WDT_CTRL,
> +				  WDT_CTRL_EN, 0);
> +}
> +
> +static unsigned int sl28cpld_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(wdt->regmap, wdt->offset + WDT_COUNT, &val);
> +
> +	return (ret < 0) ? 0 : val;
> +}
> +
> +static int sl28cpld_wdt_set_timeout(struct watchdog_device *wdd,
> +				    unsigned int timeout)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	ret = regmap_write(wdt->regmap, wdt->offset + WDT_TIMEOUT, timeout);
> +	if (!ret)
> +		wdd->timeout = timeout;
> +
> +	return ret;
> +}
> +
> +static const struct watchdog_info sl28cpld_wdt_info = {
> +	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.identity = "sl28cpld watchdog",
> +};
> +
> +static struct watchdog_ops sl28cpld_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = sl28cpld_wdt_start,
> +	.stop = sl28cpld_wdt_stop,
> +	.ping = sl28cpld_wdt_ping,
> +	.set_timeout = sl28cpld_wdt_set_timeout,
> +	.get_timeleft = sl28cpld_wdt_get_timeleft,
> +};
> +
> +static int sl28cpld_wdt_probe(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdd;
> +	struct sl28cpld_wdt *wdt;
> +	struct resource *res;
> +	unsigned int status;
> +	unsigned int val;
> +	int ret;
> +
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!wdt->regmap)
> +		return -ENODEV;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
> +	if (!res)
> +		return -EINVAL;
> +	wdt->offset = res->start;
> +
> +	wdt->assert_wdt_timeout = device_property_read_bool(&pdev->dev,
> +							    "kontron,assert-wdt-timeout-pin");
> +
> +	/* initialize struct watchdog_device */
> +	wdd = &wdt->wdd;
> +	wdd->parent = &pdev->dev;
> +	wdd->info = &sl28cpld_wdt_info;
> +	wdd->ops = &sl28cpld_wdt_ops;
> +	wdd->min_timeout = 1;
> +	wdd->max_timeout = 255;
> +
> +	watchdog_set_drvdata(wdd, wdt);
> +	watchdog_stop_on_reboot(wdd);
> +
> +	/*
> +	 * Read the status early, in case of an error, we haven't modified the
> +	 * hardware.
> +	 */
> +	ret = regmap_read(wdt->regmap, wdt->offset + WDT_CTRL, &status);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Initial timeout value, may be overwritten by device tree or module
> +	 * parmeter in watchdog_init_timeout().
> +	 *
> +	 * Reading a zero here means that either the hardware has a default
> +	 * value of zero (which is very unlikely and definitely a hardware
> +	 * bug) or the bootloader set it to zero. In any case, we handle
> +	 * this case gracefully and set out own timeout.
> +	 */
> +	ret = regmap_read(wdt->regmap, wdt->offset + WDT_TIMEOUT, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (val)
> +		wdd->timeout = val;
> +	else
> +		wdd->timeout = WDT_DEFAULT_TIMEOUT;
> +
> +	watchdog_init_timeout(wdd, timeout, &pdev->dev);
> +	sl28cpld_wdt_set_timeout(wdd, wdd->timeout);
> +
> +	/* if the watchdog is locked, we set nowayout */
> +	if (status & WDT_CTRL_LOCK)
> +		nowayout = true;
> +	watchdog_set_nowayout(wdd, nowayout);
> +
> +	/*
> +	 * If watchdog is already running, keep it enabled, but make
> +	 * sure its mode is set correctly.
> +	 */
> +	if (status & WDT_CTRL_EN) {
> +		sl28cpld_wdt_start(wdd);
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> +	}
> +
> +	ret = devm_watchdog_register_device(&pdev->dev, wdd);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register watchdog device\n");
> +		return ret;
> +	}
> +
> +	dev_info(&pdev->dev, "initial timeout %d sec%s\n",
> +		 wdd->timeout, nowayout ? ", nowayout" : "");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sl28cpld_wdt_of_match[] = {
> +	{ .compatible = "kontron,sl28cpld-wdt" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sl28cpld_wdt_of_match);
> +
> +static const struct platform_device_id sl28cpld_wdt_id_table[] = {
> +	{ "sl28cpld-wdt" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(platform, sl28cpld_wdt_id_table);
> +
> +static struct platform_driver sl28cpld_wdt_driver = {
> +	.probe = sl28cpld_wdt_probe,
> +	.id_table = sl28cpld_wdt_id_table,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = sl28cpld_wdt_of_match,
> +	},
> +};
> +module_platform_driver(sl28cpld_wdt_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld Watchdog Driver");
> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_LICENSE("GPL");
> 

