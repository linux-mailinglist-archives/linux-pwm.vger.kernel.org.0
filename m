Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345543DDDD0
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Aug 2021 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhHBQio (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Aug 2021 12:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhHBQio (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Aug 2021 12:38:44 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626C9C06175F;
        Mon,  2 Aug 2021 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2C5VpDvj4kp12ZP3fbrD/BbegWSigYIIIq38MkNNSfo=; b=hxhcVz2qm9o0yLFpGk1SYcoHF
        Wodep1rqY0KYRewJxH1HNutRiIyNnLcsfFFJXK0pLy4JMS0Y+Q00eEALPAjZF/E88PHgAuUWrEV7R
        7RFY/jMJqxD6dcxMyu3GKV5wJcKbqsbLrhp604K8raxA7uF1hWFysvkVQGu7Hmwfhe921uQjmco7k
        Orst7YoxF6wmS97e7jXieXl/iegssZYMzEnZCNTfs0RiFH8HQjj7iFHVG4euTh2Ku61Hp+T0oj12H
        mzJelcqgmFGXZLq7trh1ErTuVE6ywE1Syi8lLtsdc7bDtDQzGYom28l7JBBxXg5CFLU1/xMKb5DVf
        YnDgRptgQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46858)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mAaxP-0005x4-VN; Mon, 02 Aug 2021 17:38:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mAaxM-00032D-Kg; Mon, 02 Aug 2021 17:38:24 +0100
Date:   Mon, 2 Aug 2021 17:38:24 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     alexandre.belloni@bootlin.com,
        Michael Turquette <mturquette@baylibre.com>,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        Ludovic.Desroches@microchip.com, o.rempel@pengutronix.de,
        andy.shevchenko@gmail.com, aardelean@deviqon.com,
        linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        broonie@kernel.org, Jonathan.Cameron@huawei.com,
        linux-arm-kernel@lists.infradead.org, a.zummo@towertech.it,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, wsa@kernel.org, kernel@pengutronix.de,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        Claudiu.Beznea@microchip.com
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of
 devm_clk_get for prepared and enabled clocks enabled clocks]
Message-ID: <20210802163824.GK22278@shell.armlinux.org.uk>
References: <YPlfcbkxiBmB+vw1@kunai>
 <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
 <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
 <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
 <20210728202547.7uvfwflpruku7yps@pengutronix.de>
 <20210728204033.GF22278@shell.armlinux.org.uk>
 <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
 <20210731120004.i3affxw7upl5y4c5@pengutronix.de>
 <20210802094810.GJ22278@shell.armlinux.org.uk>
 <20210802152755.ibisunvibmwhiyry@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210802152755.ibisunvibmwhiyry@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 02, 2021 at 05:27:55PM +0200, Uwe Kleine-König wrote:
> Hello Russell,
> 
> On Mon, Aug 02, 2021 at 10:48:10AM +0100, Russell King (Oracle) wrote:
> > I think devm_clk_get() should not be part of CCF but should be
> > part of the interface level - it's silly to have devm_clk_get()
> > being CCF but not clk_get(). The same should go for the other
> > devm wrappers around the plain clk_* interfaces.
> 
> What is the practical difference between "Function X is part of CCF" and
> "Function X is part of the clk interface and there is only CCF who
> implements it"?

clkdev is maintained by me as part of the API, and provides clk_get()
functionality for all clk implementations. To then have devm_clk_get(),
which merely provides a wrapper around clk_get() adding the devm
semantics being part of CCF is not sane - devm_clk_get() isn't
specific to CCF or in fact any clk API implementation.

> > There have been several different approaches to wrapping things up,
> > but here's a question: should we make it easier to do the lazy thing
> > (get+enable) or should we make it easier to be power efficient?
> > Shouldn't we be encouraging people to write power efficient drivers?
> 
> Yeah, sounds compelling, but I wonder if that's of practical importance.
> How many driver authors do you expect to lure into making a better
> driver just because devm_clk_get_prepared() doesn't exist? In contrast:
> How many drivers become simpler with devm_clk_get_prepared() and so
> it becomes easier to maintain them and easier to spot bugs?
> In the absence of devm_clk_get_prepared(), is it better that several
> frameworks (or drivers) open code it?

It probably depends on where you stand on power management and power
efficiency issues. Personally, I would like to see more effort put
into drivers to make them more power efficient, and I believe in the
coming years, power efficiency is going to become a big issue.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
