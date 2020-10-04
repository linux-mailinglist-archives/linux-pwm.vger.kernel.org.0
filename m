Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADB42829B5
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Oct 2020 10:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgJDIwJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 4 Oct 2020 04:52:09 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:39918 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDIwJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 4 Oct 2020 04:52:09 -0400
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 850BA3A59E9;
        Sun,  4 Oct 2020 08:42:38 +0000 (UTC)
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 88518200002;
        Sun,  4 Oct 2020 08:42:09 +0000 (UTC)
Date:   Sun, 4 Oct 2020 10:42:09 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 5/7] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <20201004084209.GV2804081@piout.net>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-6-j.neuschaefer@gmx.net>
 <20200925054424.snlr3lggnsv575wu@pengutronix.de>
 <20201004014323.GD500800@latitude>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201004014323.GD500800@latitude>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 04/10/2020 03:43:23+0200, Jonathan Neuschäfer wrote:
> > > +static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
> > > +{
> > > +	struct ntxec_rtc *rtc = dev_get_drvdata(dev);
> > > +	int res = 0;
> > > +
> > > +	res = regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_YEAR, ntxec_reg8(tm->tm_year - 100));
> > > +	if (res)
> > > +		return res;
> > > +
> > > +	res = regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MONTH, ntxec_reg8(tm->tm_mon + 1));
> > > +	if (res)
> > > +		return res;
> > > +
> > > +	res = regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_DAY, ntxec_reg8(tm->tm_mday));
> > > +	if (res)
> > > +		return res;
> > > +
> > > +	res = regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_HOUR, ntxec_reg8(tm->tm_hour));
> > > +	if (res)
> > > +		return res;
> > > +
> > > +	res = regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MINUTE, ntxec_reg8(tm->tm_min));
> > > +	if (res)
> > > +		return res;
> > > +
> > > +	return regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND, ntxec_reg8(tm->tm_sec));
> > 
> > I wonder: Is this racy? If you write minute, does the seconds reset to
> > zero or something like that? Or can it happen, that after writing the
> > minute register and before writing the second register the seconds
> > overflow and you end up with the time set to a minute later than
> > intended? If so it might be worth to set the seconds to 0 at the start
> > of the function (with an explaining comment).
> 
> The setting the minutes does not reset the seconds, so I think this race
> condition is possible. I'll add the workaround.
> 

Are you sure this happens? Usually, the seconds are not reset but the
internal 32768kHz counter is so you have a full second to write all the
registers.

> > .read_time has a similar race. What happens if minutes overflow between
> > reading NTXEC_REG_READ_DH and NTXEC_REG_READ_MS?
> 
> Yes, we get read tearing in that case. It could even propagate all the
> way to the year/month field, for example when the following time rolls
> over:
> 	   A   |  B  |  C
> 	2020-10-31 23:59:59
> 	2020-11-01 00:00:00
> 
> - If the increment happens after reading C, we get         2020-10-31 23:59:59
> - If the increment happens between reading B and C, we get 2020-10-31 23:00:00
> - If the increment happens between reading A and B, we get 2020-10-01 00:00:00
> - If the increment happens before reading A, we get        2020-11-01 00:00:00
> 
> ... both of which are far from correct.
> 
> To mitigate this issue, I think something like the following is needed:
> 
> - Read year/month
> - Read day/hour
> - Read minute/second
> - Read day/hour, compare with previously read value, restart on mismatch
> - Read year/month, compare with previously read value, restart on mismatch
> 
> The order of the last two steps doesn't matter, as far as I can see, but
> if I remove one of them, I can't catch all cases of read tearing.
> 

Are you also sure this happens?

Only one comparison is necessary, the correct order would be:

 - Read minute/second
 - Read day/hour
 - Read year/month
 - Read minute/second, compare

If day/hour changes but not minute/second, it would mean that it took at
least an hour to read all the registers. At this point, I think you have
other problems and the exact time doesn't matter anymore.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
