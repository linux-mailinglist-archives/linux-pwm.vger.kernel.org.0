Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0D3202788
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 02:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgFUALS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 20:11:18 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33317 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgFUALS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 20 Jun 2020 20:11:18 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id AE2151C0005;
        Sun, 21 Jun 2020 00:11:07 +0000 (UTC)
Date:   Sun, 21 Jun 2020 02:11:06 +0200
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
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [RFC PATCH 08/10] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <20200621001106.GC131826@piout.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-7-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200620224222.1312520-7-j.neuschaefer@gmx.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 21/06/2020 00:42:19+0200, Jonathan Neuschäfer wrote:
> With this driver, mainline Linux can keep its time and date in sync with
> the vendor kernel.
> 
> Advanced functionality like alarm and automatic power-on is not yet
> supported.
> 

Please report the results of rtctest (from the kernel tree) and
rtc-range
(https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/tree/rtc-range.c)

> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  drivers/rtc/Kconfig     |   4 ++
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-ntxec.c | 115 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+)
>  create mode 100644 drivers/rtc/rtc-ntxec.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index b54d87d45c89b..2310d08933f9c 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1300,6 +1300,10 @@ config RTC_DRV_CROS_EC
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-cros-ec.
> 
> +config RTC_DRV_NTXEC
> +	tristate "Netronix embedded controller RTC driver"
> +	depends on MFD_NTXEC
> +

This should get an help section.


>  comment "on-CPU RTC drivers"
> 
>  config RTC_DRV_ASM9260
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 0721752c6ed4c..8653d04aefa99 100644
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
> index 0000000000000..44d5a5eedb597
> --- /dev/null
> +++ b/drivers/rtc/rtc-ntxec.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright 2020 Jonathan Neuschäfer
> +
> +#include <linux/rtc.h>
> +#include <linux/mfd/ntxec.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

Please sort the includes.

> +
> +struct ntxec_rtc {
> +	struct device *dev;
> +	struct ntxec *ec;
> +};
> +
> +#define NTXEC_WRITE_YEAR	0x10
> +#define NTXEC_WRITE_MONTH	0x11
> +#define NTXEC_WRITE_DAY		0x12
> +#define NTXEC_WRITE_HOUR	0x13
> +#define NTXEC_WRITE_MINUTE	0x14
> +#define NTXEC_WRITE_SECOND	0x15
> +
> +#define NTXEC_READ_YM		0x20
> +#define NTXEC_READ_DH		0x21
> +#define NTXEC_READ_MS		0x22
> +
> +
> +static int ntxec_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct ntxec_rtc *rtc = dev_get_drvdata(dev);
> +	int res;
> +
> +	res = ntxec_read16(rtc->ec, NTXEC_READ_YM);
> +	if (res < 0)
> +		return res;
> +
> +	tm->tm_year = (res >> 8) + 100;
> +	tm->tm_mon = (res & 0xff) - 1;
> +
> +	res = ntxec_read16(rtc->ec, NTXEC_READ_DH);
> +	if (res < 0)
> +		return res;
> +
> +	tm->tm_mday = res >> 8;
> +	tm->tm_hour = res & 0xff;
> +
> +	res = ntxec_read16(rtc->ec, NTXEC_READ_MS);
> +	if (res < 0)
> +		return res;
> +
> +	tm->tm_min = res >> 8;
> +	tm->tm_sec = res & 0xff;
> +
> +	return 0;
> +}
> +
> +static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct ntxec_rtc *rtc = dev_get_drvdata(dev);
> +	int res = 0;
> +
> +	res |= ntxec_write8(rtc->ec, NTXEC_WRITE_YEAR, tm->tm_year - 100);
> +	res |= ntxec_write8(rtc->ec, NTXEC_WRITE_MONTH, tm->tm_mon + 1);
> +	res |= ntxec_write8(rtc->ec, NTXEC_WRITE_DAY, tm->tm_mday);
> +	res |= ntxec_write8(rtc->ec, NTXEC_WRITE_HOUR, tm->tm_hour);
> +	res |= ntxec_write8(rtc->ec, NTXEC_WRITE_MINUTE, tm->tm_min);
> +	res |= ntxec_write8(rtc->ec, NTXEC_WRITE_SECOND, tm->tm_sec);
> +
> +	return (res < 0)? -EIO : 0;
> +}
> +
> +static const struct rtc_class_ops ntxec_rtc_ops = {
> +	.read_time		= ntxec_read_time,
> +	.set_time		= ntxec_set_time,
> +};
> +
> +static int ntxec_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rtc_device *rtcdev;
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
> +	rtcdev = devm_rtc_device_register(&pdev->dev, "ntxec-rtc",
> +					  &ntxec_rtc_ops, THIS_MODULE);

Please use devm_rtc_allocate_device and rtc_register_device. Also, set
the supported range (->range_min and ->range_max).


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
