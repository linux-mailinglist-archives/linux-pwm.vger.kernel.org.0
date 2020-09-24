Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E074277A96
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 22:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIXUks (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 16:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgIXUkr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Sep 2020 16:40:47 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1132BC0613CE;
        Thu, 24 Sep 2020 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YdMmIrFjy96JjZkrcSCWZWLABUbKOvDG/JNltuFZSaU=; b=BRtvxQYh1Y3OMCq4Kf1YBUAwZg
        AdlcG1QdMUxg3ALlmkBMcq8Fes7GkNqPgbSkFwUY2V54/jeKT8Q05AcH4bBOHmAQc9aouuKfzC72q
        aG24wLj1cSKhR4DYSdYTwVw163dOCYVYxDNsXX+DF1G7KUlaVk8ZmNzLEDmGihP+/OUg=;
Received: from p200300ccff10b0001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff10:b000:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kLY2G-0001pe-BJ; Thu, 24 Sep 2020 22:40:12 +0200
Date:   Thu, 24 Sep 2020 22:40:11 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 5/7] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <20200924224011.074d7a19@aktux>
In-Reply-To: <20200924192455.2484005-6-j.neuschaefer@gmx.net>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
        <20200924192455.2484005-6-j.neuschaefer@gmx.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 24 Sep 2020 21:24:53 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> With this driver, mainline Linux can keep its time and date in sync with
> the vendor kernel.
>=20
> Advanced functionality like alarm and automatic power-on is not yet
> supported.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>=20
> v3:
> - Add email address to copyright line
> - Remove OF compatible string and don't include linux/of_device.h
> - Don't use a comma after sentinels
> - Avoid ret |=3D ... pattern
> - Move 8-bit register conversion to ntxec.h
> - Relicense as GPLv2 or later
>=20
> v2:
> - https://lore.kernel.org/lkml/20200905133230.1014581-7-j.neuschaefer@gmx=
.net/
> - Rework top-of-file comment [Lee Jones]
> - Sort the #include lines [Alexandre Belloni]
> - don't align =3D signs in struct initializers [Uwe Kleine-K=C3=B6nig]
> - Switch to regmap
> - Fix register number used to read minutes and seconds
> - Prefix registers with NTXEC_REG_
> - Add help text to the Kconfig option
> - Use devm_rtc_allocate_device and rtc_register_device, set ->range_min a=
nd ->range_max
> ---
>  drivers/rtc/Kconfig     |   8 +++
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-ntxec.c | 132 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 141 insertions(+)
>  create mode 100644 drivers/rtc/rtc-ntxec.c
>=20
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 48c536acd777f..ae8f3dc36c9a3 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1301,6 +1301,14 @@ config RTC_DRV_CROS_EC
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-cros-ec.
>=20
> +config RTC_DRV_NTXEC
> +	tristate "Netronix embedded controller RTC driver"
> +	depends on MFD_NTXEC
> +	help
> +	  Say yes here if you want to support the RTC functionality of the
> +	  embedded controller found in certain e-book readers designed by the
> +	  ODM Netronix.
> +
>  comment "on-CPU RTC drivers"
>=20
>  config RTC_DRV_ASM9260
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 880e08a409c3d..733479db18896 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -111,6 +111,7 @@ obj-$(CONFIG_RTC_DRV_MT7622)	+=3D rtc-mt7622.o
>  obj-$(CONFIG_RTC_DRV_MV)	+=3D rtc-mv.o
>  obj-$(CONFIG_RTC_DRV_MXC)	+=3D rtc-mxc.o
>  obj-$(CONFIG_RTC_DRV_MXC_V2)	+=3D rtc-mxc_v2.o
> +obj-$(CONFIG_RTC_DRV_NTXEC)	+=3D rtc-ntxec.o
>  obj-$(CONFIG_RTC_DRV_OMAP)	+=3D rtc-omap.o
>  obj-$(CONFIG_RTC_DRV_OPAL)	+=3D rtc-opal.o
>  obj-$(CONFIG_RTC_DRV_PALMAS)	+=3D rtc-palmas.o
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
> + * Copyright 2020 Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
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
> +	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
> +	unsigned int value;
> +	int res;
> +
> +	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_YM, &value);
> +	if (res < 0)
> +		return res;
> +
> +	tm->tm_year =3D (value >> 8) + 100;
> +	tm->tm_mon =3D (value & 0xff) - 1;
> +
> +	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_DH, &value);
> +	if (res < 0)
> +		return res;
> +
> +	tm->tm_mday =3D value >> 8;
> +	tm->tm_hour =3D value & 0xff;
> +
> +	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_MS, &value);
> +	if (res < 0)
> +		return res;
> +
> +	tm->tm_min =3D value >> 8;
> +	tm->tm_sec =3D value & 0xff;
> +
> +	return 0;
> +}
> +
> +static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
> +	int res =3D 0;
> +
> +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_YEAR, ntxec_reg8(=
tm->tm_year - 100));
> +	if (res)
> +		return res;
> +
> +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MONTH, ntxec_reg8=
(tm->tm_mon + 1));
> +	if (res)
> +		return res;
> +
> +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_DAY, ntxec_reg8(t=
m->tm_mday));
> +	if (res)
> +		return res;
> +
> +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_HOUR, ntxec_reg8(=
tm->tm_hour));
> +	if (res)
> +		return res;
> +
> +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MINUTE, ntxec_reg=
8(tm->tm_min));
> +	if (res)
> +		return res;
> +
> +	return regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND, ntxec_reg8=
(tm->tm_sec));
> +}
> +
> +static const struct rtc_class_ops ntxec_rtc_ops =3D {
> +	.read_time =3D ntxec_read_time,
> +	.set_time =3D ntxec_set_time,
> +};
> +
> +static int ntxec_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rtc_device *dev;
> +	struct ntxec_rtc *rtc;
> +
> +	rtc =3D devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	rtc->dev =3D &pdev->dev;
> +	rtc->ec =3D dev_get_drvdata(pdev->dev.parent);
> +	platform_set_drvdata(pdev, rtc);
> +
> +	dev =3D devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(dev))
> +		return PTR_ERR(dev);
> +
> +	dev->ops =3D &ntxec_rtc_ops;
> +	dev->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
> +	dev->range_max =3D 9025257599LL; /* 2255-12-31 23:59:59 */
> +
> +	return rtc_register_device(dev);
> +}
> +
> +static struct platform_driver ntxec_rtc_driver =3D {
> +	.driver =3D {
> +		.name =3D "ntxec-rtc",
> +	},
> +	.probe =3D ntxec_rtc_probe,
> +};
> +module_platform_driver(ntxec_rtc_driver);
> +
I think module autoloading will not work without

MODULE_ALIAS("platform:ntxec-rtc");

Same for the pwm device.
> +MODULE_AUTHOR("Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>");
> +MODULE_DESCRIPTION("RTC driver for Netronix EC");
> +MODULE_LICENSE("GPL");
> --
> 2.28.0
>=20
>=20

Regards,
Andreas
