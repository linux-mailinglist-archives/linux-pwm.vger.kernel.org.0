Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617A32BFCF0
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Nov 2020 00:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgKVXLA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 22 Nov 2020 18:11:00 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60791 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgKVXLA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 22 Nov 2020 18:11:00 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 7F3591BF206;
        Sun, 22 Nov 2020 23:10:54 +0000 (UTC)
Date:   Mon, 23 Nov 2020 00:10:54 +0100
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
Subject: Re: [PATCH v4 5/7] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <20201122231054.GH348979@piout.net>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-6-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201122222739.1455132-6-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 22/11/2020 23:27:37+0100, Jonathan Neuschäfer wrote:
> With this driver, mainline Linux can keep its time and date in sync with
> the vendor kernel.
> 
> Advanced functionality like alarm and automatic power-on is not yet
> supported.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

However, two comments below:

> +static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct ntxec_rtc *rtc = dev_get_drvdata(dev);
> +	int res = 0;
> +
> +	/*
> +	 * To avoid time overflows while we're writing the full date/time,
> +	 * set the seconds field to zero before doing anything else. For the
> +	 * next 59 seconds (plus however long it takes until the RTC's next
> +	 * update of the second field), the seconds field will not overflow
> +	 * into the other fields.
> +	 */
> +	res = regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND, ntxec_reg8(0));
> +	if (res)
> +		return res;
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

Couldn't you do a regmap_block_write or a regmap_multi_reg_write which
would be more efficient as they would be locking the regmap only once.

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

Note that this won't compile after
https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?id=fdcfd854333be5b30377dc5daa9cd0fa1643a979

We can solve that with immutable branches though.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
