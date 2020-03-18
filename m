Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1DA18945C
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 04:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCRDRi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 23:17:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33892 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgCRDRh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 23:17:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so13113865pfj.1;
        Tue, 17 Mar 2020 20:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BQpN5gwQ9Pni7mIRi1IxJySWLMfNLsPgNCigMN7KRto=;
        b=lQ2lv92+R/G5Ea/zXcdigQMx/8y8BGvTQ8XvYk3mtH0kt3LYlyrxcjKZLEGs79WNJR
         M8bLAyh4dA0Wt8XGdK8qdrtgQZlxdIBMpBcvrFgmVN4F1RD/mHPKU+pco8hUqZNqkT1Z
         pe24nnyOmg2fUpbZ9qqM3RhlQAXpQfzHTGOAJs5YbU8AkNafzzrIG822vUxCYM1m1/dU
         FFyO3G9+7xOXC0BWsR24UEADRhkLvQQhfDz28fe8RH1Y7/88kHYNAVK09IDX0SbkhRLN
         fndUMpNEwKQIgRaBdhj+/rHKmAHS2nmb97/JtRuOtVe3OMeVosRNAcypaZjRJlTZ1JFn
         5T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BQpN5gwQ9Pni7mIRi1IxJySWLMfNLsPgNCigMN7KRto=;
        b=LpKkloVN5NbjiBV2H9hsOuMTmK5Zo0efOHODgIuyScmQoBWDu5/225GV1hyzxVqtKj
         vzL/Gqmyu3/5iVKDn8iHKk0WT8ojTPrcFRqrY3QRagR76jrQgYXmal3t8BlU+/oB50fd
         yxbjF0GLjUac+xUk3vue59j53LJ6TtWAIvSsIlwGmB3xQPfbvB9tx0Tt0Li9hDJIM4fx
         hRccYWYx75KKE/ZavLqK8tq55UcCUrj4lnPwKF+qqPZamvtltAmlPWrqeYCmNheANSA2
         OzSiHu5V6wTHszmx1zp2oWT18wet0S+eKBbRYuJuGMMAaA2xARl8QdmNCZQooYx6c4Uo
         cpnQ==
X-Gm-Message-State: ANhLgQ2Q2vien5h7iEqU96Jyr4/n0rLJFyuQPU5D3UyH1sL1aV0tuvgX
        nXvoTBRpW8rY6D/IA8L6nGM=
X-Google-Smtp-Source: ADFU+vuwEafdq1XlC1xIsngjrJ5FMvcZhPADN5x/5jrrdLN6pcmUGzCj6PvzZZOxOhJo1j1YcuugZA==
X-Received: by 2002:aa7:8659:: with SMTP id a25mr2049195pfo.95.1584501455356;
        Tue, 17 Mar 2020 20:17:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m12sm646096pjk.20.2020.03.17.20.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 20:17:34 -0700 (PDT)
Subject: Re: [PATCH 08/18] watchdog: add support for sl28cpld watchdog
To:     Michael Walle <michael@walle.cc>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
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
        Marc Zyngier <maz@kernel.org>
References: <20200317205017.28280-1-michael@walle.cc>
 <20200317205017.28280-9-michael@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <943270c6-970a-1552-5547-c30aea597b4a@roeck-us.net>
Date:   Tue, 17 Mar 2020 20:17:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317205017.28280-9-michael@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 3/17/20 1:50 PM, Michael Walle wrote:
> This adds support for the watchdog of the sl28cpld board management
> controller. This is part of a multi-function device driver.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/watchdog/Kconfig        |  11 ++
>  drivers/watchdog/Makefile       |   1 +
>  drivers/watchdog/sl28cpld_wdt.c | 238 ++++++++++++++++++++++++++++++++
>  3 files changed, 250 insertions(+)
>  create mode 100644 drivers/watchdog/sl28cpld_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9ea2b43d4b01..c78b90ccc8cf 100644
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
> index 2ee352bf3372..060e2f895fe8 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -223,3 +223,4 @@ obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
>  obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
>  obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
>  obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
> +obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
> diff --git a/drivers/watchdog/sl28cpld_wdt.c b/drivers/watchdog/sl28cpld_wdt.c
> new file mode 100644
> index 000000000000..5927b7ad0be4
> --- /dev/null
> +++ b/drivers/watchdog/sl28cpld_wdt.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SMARC-sAL28 Watchdog driver.
> + *
> + * Copyright 2019 Kontron Europe GmbH
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +
> +/*
> + * Watchdog timer block registers.
> + */
> +#define SL28CPLD_WDT_CTRL	0
> +#define  WDT_CTRL_EN		BIT(0)
> +#define  WDT_CTRL_LOCK		BIT(2)
> +#define SL28CPLD_WDT_TIMEOUT	1
> +#define SL28CPLD_WDT_KICK	2
> +#define  WDT_KICK_VALUE		0x6b
> +#define SL28CPLD_WDT_COUNT	3
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
> +};
> +
> +static int sl28cpld_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_write(wdt->regmap, wdt->offset + SL28CPLD_WDT_KICK,
> +			    WDT_KICK_VALUE);
> +}
> +
> +static int sl28cpld_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +	unsigned int val;
> +
> +	val = WDT_CTRL_EN;
> +	if (nowayout)
> +		val |= WDT_CTRL_LOCK;
> +
> +	return regmap_update_bits(wdt->regmap, wdt->offset + SL28CPLD_WDT_CTRL,
> +				  val, val);
> +}
> +
> +static int sl28cpld_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_update_bits(wdt->regmap, wdt->offset + SL28CPLD_WDT_CTRL,
> +				  WDT_CTRL_EN, 0);
> +}
> +
> +static unsigned int sl28cpld_wdt_status(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +	unsigned int status;
> +	int ret;
> +
> +	ret = regmap_read(wdt->regmap, wdt->offset + SL28CPLD_WDT_CTRL,
> +			  &status);
> +	if (ret < 0)
> +		return 0;
> +
> +	/* is the watchdog timer running? */
> +	return (status & WDT_CTRL_EN) << WDOG_ACTIVE;
> +}
> +
> +static unsigned int sl28cpld_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +	int ret;
> +	unsigned int val;
> +
> +	ret = regmap_read(wdt->regmap, wdt->offset + SL28CPLD_WDT_COUNT, &val);
> +	if (ret < 0)
> +		return 0;
> +
> +	return val;
> +}
> +
> +static int sl28cpld_wdt_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int timeout)
> +{
> +	int ret;
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	ret = regmap_write(wdt->regmap, wdt->offset + SL28CPLD_WDT_TIMEOUT,
> +			   timeout);
> +	if (ret == 0)
> +		wdd->timeout = timeout;
> +
> +	return ret;
> +}
> +
> +static const struct watchdog_info sl28cpld_wdt_info = {
> +	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.identity = "SMARC-sAL28 CPLD watchdog",
> +};
> +
> +static struct watchdog_ops sl28cpld_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = sl28cpld_wdt_start,
> +	.stop = sl28cpld_wdt_stop,
> +	.status = sl28cpld_wdt_status,
> +	.ping = sl28cpld_wdt_ping,
> +	.set_timeout = sl28cpld_wdt_set_timeout,
> +	.get_timeleft = sl28cpld_wdt_get_timeleft,
> +};
> +
> +static int sl28cpld_wdt_locked(struct sl28cpld_wdt *wdt)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(wdt->regmap, wdt->offset + SL28CPLD_WDT_CTRL, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return val & WDT_CTRL_LOCK;
> +}
> +
> +static int sl28cpld_wdt_probe(struct platform_device *pdev)
> +{
> +	struct sl28cpld_wdt *wdt;
> +	struct watchdog_device *wdd;
> +	struct resource *res;
> +	unsigned int val;
> +	int ret;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
> +
> +	wdt->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!wdt->regmap)
> +		return -ENODEV;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
> +	if (res == NULL)
> +		return -EINVAL;
> +	wdt->offset = res->start;
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
> +
> +	/* if the watchdog is locked, we set nowayout to true */
> +	ret = sl28cpld_wdt_locked(wdt);
> +	if (ret < 0)
> +		return ret;
> +	if (ret)
> +		nowayout = true;
> +	watchdog_set_nowayout(wdd, nowayout);
> +
> +	/*
> +	 * Initial timeout value, can either be set by kernel parameter or by
> +	 * the device tree. If both are not given the current value is used.
> +	 */
> +	watchdog_init_timeout(wdd, timeout, &pdev->dev);
> +	if (wdd->timeout) {
> +		sl28cpld_wdt_set_timeout(wdd, wdd->timeout);
> +	} else {
> +		ret = regmap_read(wdt->regmap,
> +				  wdt->offset + SL28CPLD_WDT_TIMEOUT, &val);
> +		if (ret < 0)
> +			return ret;
> +		wdd->timeout = val;
> +	}
> +
> +	ret = watchdog_register_device(wdd);

Please use devm_watchdog_register_device().

> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register watchdog device\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	dev_info(&pdev->dev, "CPLD watchdog: initial timeout %d sec%s\n",
> +		wdd->timeout, nowayout ? ", nowayout" : "");
> +
> +	return 0;
> +}
> +
> +static int sl28cpld_wdt_remove(struct platform_device *pdev)
> +{
> +	struct sl28cpld_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static void sl28cpld_wdt_shutdown(struct platform_device *pdev)

Please use watchdog_stop_on_reboot().

Thanks,
Guenter

> +{
> +	struct sl28cpld_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	sl28cpld_wdt_stop(&wdt->wdd);
> +}
> +
> +static struct platform_driver sl28cpld_wdt_driver = {
> +	.probe = sl28cpld_wdt_probe,
> +	.remove = sl28cpld_wdt_remove,
> +	.shutdown = sl28cpld_wdt_shutdown,
> +	.driver = {
> +		.name = "sl28cpld-wdt",
> +	},
> +};
> +module_platform_driver(sl28cpld_wdt_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld Watchdog Driver");
> +MODULE_LICENSE("GPL");
> 

