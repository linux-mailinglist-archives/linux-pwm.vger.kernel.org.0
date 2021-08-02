Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1980A3DE0A6
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Aug 2021 22:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhHBU3T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Aug 2021 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHBU3S (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Aug 2021 16:29:18 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C0EC06175F;
        Mon,  2 Aug 2021 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l+fsYpXHnA5UWflt6UdASmUhsqYZSqpyJ5dbaN1LNhI=; b=vjQduL25s9hj45Yfu4BTWPBTU
        kSrAkTSvbBkmMoP+U+eq7jLxh9RY41POf05sbal5DLZUOHV14VyAkDosbwqMP6hNbjJNzszGxQOFb
        5wYJIChsZvBSrMFJdmAcTH4YkXzYoyuavecHIGnNfsnYkoQHkamhrzD+2t/mLD6cSA8AE/lejVALP
        o14n71qmu350xdj1XuaKMWTtEqYO2HM34dB006g4k7212DICITO8uYJP3CFtt6kaRoKcMqpnwP50V
        UIFDzpfSBBtP1nJ9QQnkdI2ASdn0BAlsWuimFTpAKGqcXPn7safpQjAHW1AXfy3hNuN5xHrP1qriX
        LkVuUtlRQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46868)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mAeYW-0006Ce-VV; Mon, 02 Aug 2021 21:29:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mAeYR-0003Bf-Ax; Mon, 02 Aug 2021 21:28:55 +0100
Date:   Mon, 2 Aug 2021 21:28:55 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of
 devm_clk_get for prepared and enabled clocks enabled clocks]
Message-ID: <20210802202855.GL22278@shell.armlinux.org.uk>
References: <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
 <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
 <20210728202547.7uvfwflpruku7yps@pengutronix.de>
 <20210728204033.GF22278@shell.armlinux.org.uk>
 <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
 <20210731120004.i3affxw7upl5y4c5@pengutronix.de>
 <20210802094810.GJ22278@shell.armlinux.org.uk>
 <20210802152755.ibisunvibmwhiyry@pengutronix.de>
 <20210802163824.GK22278@shell.armlinux.org.uk>
 <CAHp75VcpA0vOwN8gBj2iikXW2dw+KCgZEM=QJ5Jx6UWqww=iCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcpA0vOwN8gBj2iikXW2dw+KCgZEM=QJ5Jx6UWqww=iCw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 02, 2021 at 08:13:05PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 2, 2021 at 7:38 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> > It probably depends on where you stand on power management and power
> > efficiency issues. Personally, I would like to see more effort put
> > into drivers to make them more power efficient, and I believe in the
> > coming years, power efficiency is going to become a big issue.
> 
> While in the ideal world I 100% agree with the approach, IRL we have
> to deal with constantly degrading quality of the code and instead of
> thinking about power management and efficiency the absence of APIs
> such as discussed provokes not only creating the power management
> inefficient code, but also memory leaks here and there.

The point of my previous reply that you quoted above was to make a
prediction, it wasn't a rejection of the approach.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
