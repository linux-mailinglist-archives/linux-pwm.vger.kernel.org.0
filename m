Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA393DD342
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Aug 2021 11:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhHBJsd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Aug 2021 05:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhHBJsd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Aug 2021 05:48:33 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14297C06175F;
        Mon,  2 Aug 2021 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EuWMmKq4SfpJmtGNCymVReAeRTht0Bdg7VG7/exrrCw=; b=yb4BJMeklOXEuLu6GHSoDZ382
        JZ+rWCauEZ4nW4CeuE0cZ46WaGcFVsah2s21cKq7LWBnQZbSilf6ZLgm1RuMW2+efdfa4R5oUyS33
        iccBCQjCQgM5WxFlRxXKmtigRhrVf2fIbr/kjSdntCaSPK/D8zcePV7r7YaMBQt0yQNKJ6QA0VJ0X
        Iu3fG+7/u13Ps85rSxkMA/tDV/Cveq7ySLmUP6NX+6Rnu050OCnX8eWOpKaYVTfp0CmjhSVslUEO1
        hPiAYviPJylj4ooTBA+mh8PgdUoSzVaICpIkOD3ZT0V1Q0Ui3+X/nCQ48Ry9XpBAs21GVdYNS0ler
        mUH6f8Bdg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46850)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mAUYS-0005LR-30; Mon, 02 Aug 2021 10:48:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mAUYM-0002nN-Mu; Mon, 02 Aug 2021 10:48:10 +0100
Date:   Mon, 2 Aug 2021 10:48:10 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>, alexandre.belloni@bootlin.com,
        Michael Turquette <mturquette@baylibre.com>,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        Ludovic.Desroches@microchip.com, o.rempel@pengutronix.de,
        andy.shevchenko@gmail.com, aardelean@deviqon.com,
        linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        broonie@kernel.org, Jonathan.Cameron@huawei.com,
        linux-arm-kernel@lists.infradead.org, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        wsa@kernel.org, kernel@pengutronix.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, Claudiu.Beznea@microchip.com
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of
 devm_clk_get for prepared and enabled clocks enabled clocks]
Message-ID: <20210802094810.GJ22278@shell.armlinux.org.uk>
References: <YPkg0wtYIoHKpTUW@kunai>
 <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
 <YPlfcbkxiBmB+vw1@kunai>
 <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
 <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
 <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
 <20210728202547.7uvfwflpruku7yps@pengutronix.de>
 <20210728204033.GF22278@shell.armlinux.org.uk>
 <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
 <20210731120004.i3affxw7upl5y4c5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210731120004.i3affxw7upl5y4c5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Jul 31, 2021 at 02:00:04PM +0200, Uwe Kleine-König wrote:
> Hi Russell, hi Stephen,
> 
> On Sat, Jul 31, 2021 at 12:41:19AM -0700, Stephen Boyd wrote:
> > +1 This patch doesn't fall under CCF maintainer.
> 
> Given that CCF is the only implementer of devm_clk_get at least an Ack
> from your side would still be good I guess?

I think devm_clk_get() should not be part of CCF but should be
part of the interface level - it's silly to have devm_clk_get()
being CCF but not clk_get(). The same should go for the other
devm wrappers around the plain clk_* interfaces.

> I found a patch set adding devm variants of clk_enable (e.g.
> https://lore.kernel.org/patchwork/patch/755667/) but this approach is
> different as it also contains clk_get which IMHO makes more sense 
> The discussion considered wrapping get+enable at one point, but I didn't
> find a followup.

There have been several different approaches to wrapping things up,
but here's a question: should we make it easier to do the lazy thing
(get+enable) or should we make it easier to be power efficient?
Shouldn't we be encouraging people to write power efficient drivers?

> > I still wonder if it would be better if we had some sort of DT binding
> > that said "turn this clk on when the driver probes this device and keep
> > it on until the driver is unbound".
> 
> This doesn't sound like a hardware property and so I don't think this
> belongs into DT and I would be surprised if the dt maintainers would be
> willing to accept an idea with this semantic.

I really don't like that idea - enabling or disabling a clock is
an implementation decision, one which can change over time. Even
if a clock is required to be on for e.g. accessing device registers,
we may decide that, if we want maximum power savings, to disable
that clock when the device is not being used, but an initial driver
implementation may not do that. If we encourage people to throw a
property in DT, then the driver's runtime behaviour becomes a
combination of the DT being used and the driver implementation.
Let's keep that to a minimum.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
