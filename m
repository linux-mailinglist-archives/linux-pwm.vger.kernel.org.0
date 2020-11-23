Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4203C2C17CC
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Nov 2020 22:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbgKWViP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Nov 2020 16:38:15 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:34543 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbgKWViP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Nov 2020 16:38:15 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id BDBBC240009;
        Mon, 23 Nov 2020 21:38:08 +0000 (UTC)
Date:   Mon, 23 Nov 2020 22:38:08 +0100
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
Message-ID: <20201123213808.GP348979@piout.net>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-6-j.neuschaefer@gmx.net>
 <20201122231054.GH348979@piout.net>
 <20201123213105.GC456020@latitude>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201123213105.GC456020@latitude>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23/11/2020 22:31:05+0100, Jonathan Neuschäfer wrote:
> > > +	res = regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MINUTE, ntxec_reg8(tm->tm_min));
> > > +	if (res)
> > > +		return res;
> > > +
> > > +	return regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND, ntxec_reg8(tm->tm_sec));
> > 
> > Couldn't you do a regmap_block_write or a regmap_multi_reg_write which
> > would be more efficient as they would be locking the regmap only once.
> 
> I can't find regmap_block_write anywhere, but regmap_multi_reg_write
> looks like a good approach to simplify the code here.
> 

I was thinking regmap_bulk_write but regmap_multi_reg_write is probably
more fitting here.

> 
> [...]
> > Note that this won't compile after
> > https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?id=fdcfd854333be5b30377dc5daa9cd0fa1643a979
> > 
> > We can solve that with immutable branches though.
> 
> Thanks for the heads-up. Please let me know if/when there is any action
> that I need to take here.
> 

I wouldn't think so, I can carry a patch once Lee provides his usual
immutable branch.



-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
