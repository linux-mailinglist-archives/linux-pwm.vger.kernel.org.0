Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2080B3DD303
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Aug 2021 11:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhHBJhV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 2 Aug 2021 05:37:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3545 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhHBJhU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Aug 2021 05:37:20 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdXvx51CTz6H6tD;
        Mon,  2 Aug 2021 17:37:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 11:37:08 +0200
Received: from localhost (10.47.9.82) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 10:37:06 +0100
Date:   Mon, 2 Aug 2021 10:36:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <alexandre.belloni@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        <thierry.reding@gmail.com>, <lee.jones@linaro.org>,
        <linux-clk@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <o.rempel@pengutronix.de>,
        <andy.shevchenko@gmail.com>, <aardelean@deviqon.com>,
        <linux-pwm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <broonie@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <a.zummo@towertech.it>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <wsa@kernel.org>,
        <kernel@pengutronix.de>, <akpm@linux-foundation.org>,
        <torvalds@linux-foundation.org>, <Claudiu.Beznea@microchip.com>
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of
 devm_clk_get for prepared and enabled clocks enabled clocks]
Message-ID: <20210802103638.00000448@Huawei.com>
In-Reply-To: <20210731120004.i3affxw7upl5y4c5@pengutronix.de>
References: <20210722060654.nudpdtemosi64nlb@pengutronix.de>
        <YPkg0wtYIoHKpTUW@kunai>
        <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
        <YPlfcbkxiBmB+vw1@kunai>
        <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
        <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
        <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
        <20210728202547.7uvfwflpruku7yps@pengutronix.de>
        <20210728204033.GF22278@shell.armlinux.org.uk>
        <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
        <20210731120004.i3affxw7upl5y4c5@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.9.82]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, 31 Jul 2021 14:00:04 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> Hi Russell, hi Stephen,
> 
> On Sat, Jul 31, 2021 at 12:41:19AM -0700, Stephen Boyd wrote:
> > Quoting Russell King (Oracle) (2021-07-28 13:40:34)  
> > > > I adapted the Subject in the hope to catch Stephen's and Michael's
> > > > attention. My impression is that this thread isn't on their radar yet,
> > > > but the topic here seems important enough to get a matching Subject.  
> > 
> > The thread is on my radar but...
> >   
> > > 
> > > Have you thought about sending your pull request to the clk API
> > > maintainer (iow, me) ?  
> 
> I wasn't really aware that Russell has the clk API hat (or that this
> separate hat actually exists and this isn't purely a CCF topic). I
> assume I only did
> 
> 	$ scripts/get_maintainer.pl -f drivers/clk/clk-devres.c
> 
> which is where the current and new code implementing devm_clk_get et al
> lives.
> 
> @Russell: What is your position here, do you like the approach of
> devm_clk_get_enabled? I can send a new pull request in your direction if
> you like it and are willing to take it.
> 
> > +1 This patch doesn't fall under CCF maintainer.  
> 
> Given that CCF is the only implementer of devm_clk_get at least an Ack
> from your side would still be good I guess?
> 
> > Finally, this sort of patch has been discussed for years and I didn't
> > see any mention of those previous attempts in the patch series. Has
> > something changed since that time? I think we've got a bunch of hand
> > rolled devm things in the meantime but not much else.   
> 
> I found a patch set adding devm variants of clk_enable (e.g.
> https://lore.kernel.org/patchwork/patch/755667/) but this approach is
> different as it also contains clk_get which IMHO makes more sense 
> The discussion considered wrapping get+enable at one point, but I didn't
> find a followup.
> 
> > I still wonder if it would be better if we had some sort of DT binding
> > that said "turn this clk on when the driver probes this device and keep
> > it on until the driver is unbound".  
> 
> This doesn't sound like a hardware property and so I don't think this
> belongs into DT and I would be surprised if the dt maintainers would be
> willing to accept an idea with this semantic.

Agreed. It's not unheard of to have a driver start out just enabing
clock at probe and dropping it at remove. When the driver gets more
sophisticated it will then manage the clock more frequently.
Whilst that's often tied to runtime_pm I'm not sure it always is.

Given the mess that would be involved in having a property that we
need to later ignore for particular drivers, I'd keep this management
explicit in the driver. This series makes that trivial to do for these
easy cases.

Jonathan

> 
> > That would probably work well for quite a few drivers that don't want
> > to ever call clk_get() or clk_prepare_enable() and could tie into the
> > assigned-clock-rates property in a way that let us keep the platform
> > details out of the drivers. We could also go one step further and make
> > a clk pm domain when this new property is present and then have the
> > clk be enabled based on runtime PM of the device (and if runtime PM is
> > disabled then just enable it at driver probe time).  
> 
> clk pm domain sounds good, but introducing devm_clk_get_enabled() is
> much easier and converting to it can be done without dt changes and more
> or less mechanically. So I consider the cost-usage-value of
> devm_clk_get_enabled() much better.
> 
> Best regards
> Uwe
> 

