Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CFF3DE810
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Aug 2021 10:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhHCIMG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Aug 2021 04:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234260AbhHCIMG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 3 Aug 2021 04:12:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A474260F35;
        Tue,  3 Aug 2021 08:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627978315;
        bh=msnR5QzQeo3Lq11b0UAkCf4kr/ykeiduGDAXCY8iwbw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=urCAC6Ev+tDAWmhFVuc36aGNlm/4q0CA0aQhxRhVjrC378XcgxLT+2NauPR+ev4nB
         kSQTcqx6GV8p+sXmGA8LLjetdmJoxKzbw98++UBcURojbIMG+9Mm0XL/gx1SzH7btB
         BfR06oa72KvsgXu+mKJxPz8EVem7/dkkHl36SBPSPGwDf9dXoauMDbP1KXYzVgIIfB
         SciCzuPQcywiGCqSlKJeMhom/PvMoFAndKcz6gAZe4BYC7ozau3zU++5NR6L+FlLDP
         n7EemAaNmXuEQ8uuNcrWYenWr142vQwlhSF9EjbSj3rx3hXSQ+T7/YlDJlBVD12B42
         BuFVGL3BLEpQg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210802163824.GK22278@shell.armlinux.org.uk>
References: <YPlfcbkxiBmB+vw1@kunai> <20210723091331.wl33wtcvvnejuhau@pengutronix.de> <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com> <20210728202547.7uvfwflpruku7yps@pengutronix.de> <20210728204033.GF22278@shell.armlinux.org.uk> <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com> <20210731120004.i3affxw7upl5y4c5@pengutronix.de> <20210802094810.GJ22278@shell.armlinux.org.uk> <20210802152755.ibisunvibmwhiyry@pengutronix.de> <20210802163824.GK22278@shell.armlinux.org.uk>
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of devm_clk_get for prepared and enabled clocks enabled clocks]
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     alexandre.belloni@bootlin.com,
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
To:     Russell King (Oracle) <linux@armlinux.org.uk>,
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 03 Aug 2021 01:11:54 -0700
Message-ID: <162797831443.714452.3551045763456936564@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Quoting Russell King (Oracle) (2021-08-02 09:38:24)
> On Mon, Aug 02, 2021 at 05:27:55PM +0200, Uwe Kleine-Konig wrote:
> > Hello Russell,
> >=20
> > On Mon, Aug 02, 2021 at 10:48:10AM +0100, Russell King (Oracle) wrote:
>=20
> > > There have been several different approaches to wrapping things up,
> > > but here's a question: should we make it easier to do the lazy thing
> > > (get+enable) or should we make it easier to be power efficient?
> > > Shouldn't we be encouraging people to write power efficient drivers?
> >=20
> > Yeah, sounds compelling, but I wonder if that's of practical importance.
> > How many driver authors do you expect to lure into making a better
> > driver just because devm_clk_get_prepared() doesn't exist? In contrast:
> > How many drivers become simpler with devm_clk_get_prepared() and so
> > it becomes easier to maintain them and easier to spot bugs?
> > In the absence of devm_clk_get_prepared(), is it better that several
> > frameworks (or drivers) open code it?
>=20
> It probably depends on where you stand on power management and power
> efficiency issues. Personally, I would like to see more effort put
> into drivers to make them more power efficient, and I believe in the
> coming years, power efficiency is going to become a big issue.
>=20

I agree we should put more effort into power efficiency in the kernel.
I've occasionally heard from driver writers that they never will turn
the clk off even in low power modes though. They feel like it's a
nuisance to have to do anything with the clk framework in their driver.
When I say "why not use runtime PM?" I get told that they're not turning
the clk off because it needs to be on all the time, so using runtime PM
makes the driver more complicated, not less, and adds no value. I think
some touchscreens are this way, and watchdogs too. Looking at the
drivers being converted in this series I suspect RTC is one of those
sorts of devices as well. But SPI and I2C most likely could benefit from
using runtime PM and so those ones don't feel appropriate to convert.

Maybe this series would be more compelling if those various drivers that
are hand rolling the devm action were converted to the consolidated
official devm function. The truth is it's already happening in various
subsystems so consolidating that logic into one place would be a win
code size wise and very hard to ignore.

Doing

 $ git grep devm_add_action | grep clk

seems to catch quite a few of them.
