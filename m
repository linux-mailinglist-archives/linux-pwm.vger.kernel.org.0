Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA68278452
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Sep 2020 11:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgIYJrc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 05:47:32 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:48574 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgIYJrb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Sep 2020 05:47:31 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id B3C553AFB59
        for <linux-pwm@vger.kernel.org>; Fri, 25 Sep 2020 09:36:50 +0000 (UTC)
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4F9B3FF809;
        Fri, 25 Sep 2020 09:36:15 +0000 (UTC)
Date:   Fri, 25 Sep 2020 11:36:14 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 5/7] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <20200925093614.GZ9675@piout.net>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-6-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200924192455.2484005-6-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 24/09/2020 21:24:53+0200, Jonathan Neuschäfer wrote:
> With this driver, mainline Linux can keep its time and date in sync with
> the vendor kernel.
> 
> Advanced functionality like alarm and automatic power-on is not yet
> supported.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v3:
> - Add email address to copyright line
> - Remove OF compatible string and don't include linux/of_device.h
> - Don't use a comma after sentinels
> - Avoid ret |= ... pattern
> - Move 8-bit register conversion to ntxec.h
> - Relicense as GPLv2 or later

I don't think you had to relicense. The kernel is GPL 2 only, you are
free to license your code under GPL 2 only if that is what you desire.

> 
> v2:
> - https://lore.kernel.org/lkml/20200905133230.1014581-7-j.neuschaefer@gmx.net/
> - Rework top-of-file comment [Lee Jones]
> - Sort the #include lines [Alexandre Belloni]
> - don't align = signs in struct initializers [Uwe Kleine-König]
> - Switch to regmap
> - Fix register number used to read minutes and seconds
> - Prefix registers with NTXEC_REG_
> - Add help text to the Kconfig option
> - Use devm_rtc_allocate_device and rtc_register_device, set ->range_min and ->range_max
> ---
>  drivers/rtc/Kconfig     |   8 +++
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-ntxec.c | 132 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 141 insertions(+)
>  create mode 100644 drivers/rtc/rtc-ntxec.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 48c536acd777f..ae8f3dc36c9a3 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1301,6 +1301,14 @@ config RTC_DRV_CROS_EC
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-cros-ec.
> 
> +config RTC_DRV_NTXEC
> +	tristate "Netronix embedded controller RTC driver"
> +	depends on MFD_NTXEC
> +	help
> +	  Say yes here if you want to support the RTC functionality of the
> +	  embedded controller found in certain e-book readers designed by the
> +	  ODM Netronix.
> +
>  comment "on-CPU RTC drivers"
> 
>  config RTC_DRV_ASM9260
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 880e08a409c3d..733479db18896 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -111,6 +111,7 @@ obj-$(CONFIG_RTC_DRV_MT7622)	+= rtc-mt7622.o
>  obj-$(CONFIG_RTC_DRV_MV)	+= rtc-mv.o
>  obj-$(CONFIG_RTC_DRV_MXC)	+= rtc-mxc.o
>  obj-$(CONFIG_RTC_DRV_MXC_V2)	+= rtc-mxc_v2.o
> +obj-$(CONFIG_RTC_DRV_NTXEC)	+= rtc-ntxec.o
>  obj-$(CONFIG_RTC_DRV_OMAP)	+= rtc-omap.o
>  obj-$(CONFIG_RTC_DRV_OPAL)	+= rtc-opal.o
>  obj-$(CONFIG_RTC_DRV_PALMAS)	+= rtc-palmas.o
> diff --git a/drivers/rtc/rtc-ntxec.c b/drivers/rtc/rtc-ntxec.c
> new file mode 100644
> index 0000000000000..af23c7cc76544
> --- /dev/null
> +++ b/drivers/rtc/rtc-ntxec.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * The Netronix embedded controller is a microcontroller found in some
> + * e-book readers designed by the ODM Netronix, Inc. It contains RTC,
> + * battery monitoring, system power management, and PWM functionality.
> + *
> + * This driver implements access to the RTC time and date.
> + *
> + * Copyright 2020 Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> + */
> +
> +#include <linux/mfd/ntxec.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/rtc.h>
> +#include <linux/types.h>
> +
> +struct ntxec_rtc {
> +	struct device *dev;
> +	struct ntxec *ec;
> +};
> +
> +#define NTXEC_REG_WRITE_YEAR	0x10
> +#define NTXEC_REG_WRITE_MONTH	0x11
> +#define NTXEC_REG_WRITE_DAY	0x12
> +#define NTXEC_REG_WRITE_HOUR	0x13
> +#define NTXEC_REG_WRITE_MINUTE	0x14
> +#define NTXEC_REG_WRITE_SECOND	0x15
> +
> +#define NTXEC_REG_READ_YM	0x20
> +#define NTXEC_REG_READ_DH	0x21
> +#define NTXEC_REG_READ_MS	0x23
> +
> +static int ntxec_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct ntxec_rtc *rtc = dev_get_drvdata(dev);
> +	unsigned int value;
> +	int res;
> +
> +	res = regmap_read(rtc->ec->regmap, NTXEC_REG_READ_YM, &value);
> +	if (res < 0)
> +		return res;
> +
> +	tm->tm_year = (value >> 8) + 100;
> +	tm->tm_mon = (value & 0xff) - 1;
> +
> +	res = regmap_read(rtc->ec->regmap, NTXEC_REG_READ_DH, &value);
> +	if (res < 0)
> +		return res;
> +
> +	tm->tm_mday = value >> 8;
> +	tm->tm_hour = value & 0xff;
> +
> +	res = regmap_read(rtc->ec->regmap, NTXEC_REG_READ_MS, &value);
> +	if (res < 0)
> +		return res;
> +
> +	tm->tm_min = value >> 8;
> +	tm->tm_sec = value & 0xff;
> +
> +	return 0;
> +}
> +
> +static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct ntxec_rtc *rtc = dev_get_drvdata(dev);
> +	int res = 0;
> +
> +	res = regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_YEAR, ntxec_reg8(tm->tm_year - 100));
> +	if (res)
> +		return res;
> +
> +	res = regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MONTH, ntxec_reg8(tm->tm_mon + 1));
> +	if (res)
> +		return res;
> +
> +	res = regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_DAY, ntxec_reg8(tm->tm_mday));
> +	if (res)
> +		return res;
> +
> +	res = regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_HOUR, ntxec_reg8(tm->tm_hour));
> +	if (res)
> +		return res;
> +
> +	res = regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MINUTE, ntxec_reg8(tm->tm_min));
> +	if (res)
> +		return res;
> +
> +	return regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND, ntxec_reg8(tm->tm_sec));
> +}
> +
> +static const struct rtc_class_ops ntxec_rtc_ops = {
> +	.read_time = ntxec_read_time,
> +	.set_time = ntxec_set_time,
> +};
> +
> +static int ntxec_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rtc_device *dev;
> +	struct ntxec_rtc *rtc;
> +
> +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	rtc->dev = &pdev->dev;
> +	rtc->ec = dev_get_drvdata(pdev->dev.parent);
> +	platform_set_drvdata(pdev, rtc);
> +
> +	dev = devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(dev))
> +		return PTR_ERR(dev);
> +
> +	dev->ops = &ntxec_rtc_ops;
> +	dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	dev->range_max = 9025257599LL; /* 2255-12-31 23:59:59 */
> +
> +	return rtc_register_device(dev);
> +}
> +
> +static struct platform_driver ntxec_rtc_driver = {
> +	.driver = {
> +		.name = "ntxec-rtc",
> +	},
> +	.probe = ntxec_rtc_probe,
> +};
> +module_platform_driver(ntxec_rtc_driver);
> +
> +MODULE_AUTHOR("Jonathan Neuschäfer <j.neuschaefer@gmx.net>");
> +MODULE_DESCRIPTION("RTC driver for Netronix EC");
> +MODULE_LICENSE("GPL");
> --
> 2.28.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
