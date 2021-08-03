Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F223DE767
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Aug 2021 09:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhHCHo2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Aug 2021 03:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234137AbhHCHo1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 3 Aug 2021 03:44:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EE2860F70;
        Tue,  3 Aug 2021 07:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627976657;
        bh=zJTYPdrqBdBI+iQ5yhHZVFDlufFj0L6ikGhtn2lcFFw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mMMmChjY3DZNkw1INo8gOxHT+nYeyYP7yNG8Cq7kXrGuwppP/hyJLZmW14vRquvsq
         mrA6JLlrHCRDR0wyqRN43YcgrswcpSDWckfc587HNlFGoFLJP2xms573lRC8w9XLB8
         KS53fmAMxRX9WRs9mjOwd1yW4e6xPfwZW8D9UOsWjlGS1zZ4LZTGZlTb/3eKz8eDeA
         Ll5q+SWVB3CwVgMjYr1EsLv03cqCvHCt0HeI44BNCrg9eoVdEhpYDe+TqKgWoeuSsW
         StN4wnqaRxSJop+JeEGFjw5Ngitn4kprtialS//uLYwsdTrh0VbW6EL7KxqfuPpn3c
         WQ4pzQwFQzz2w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210802094810.GJ22278@shell.armlinux.org.uk>
References: <YPkg0wtYIoHKpTUW@kunai> <YPlfcbkxiBmB+vw1@kunai> <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com> <20210723091331.wl33wtcvvnejuhau@pengutronix.de> <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com> <20210728202547.7uvfwflpruku7yps@pengutronix.de> <20210728204033.GF22278@shell.armlinux.org.uk> <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com> <20210731120004.i3affxw7upl5y4c5@pengutronix.de> <20210802094810.GJ22278@shell.armlinux.org.uk>
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
Date:   Tue, 03 Aug 2021 00:44:15 -0700
Message-ID: <162797665579.714452.9746229195858722362@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Quoting Russell King (Oracle) (2021-08-02 02:48:10)
>=20
> > > I still wonder if it would be better if we had some sort of DT binding
> > > that said "turn this clk on when the driver probes this device and ke=
ep
> > > it on until the driver is unbound".
> >=20
> > This doesn't sound like a hardware property and so I don't think this
> > belongs into DT and I would be surprised if the dt maintainers would be
> > willing to accept an idea with this semantic.
>=20
> I really don't like that idea - enabling or disabling a clock is
> an implementation decision, one which can change over time. Even
> if a clock is required to be on for e.g. accessing device registers,
> we may decide that, if we want maximum power savings, to disable
> that clock when the device is not being used, but an initial driver
> implementation may not do that. If we encourage people to throw a
> property in DT, then the driver's runtime behaviour becomes a
> combination of the DT being used and the driver implementation.
> Let's keep that to a minimum.
>=20

I suspect that sometimes we want to express that some clk is on all the
time in DT because there isn't any sort of consumer driver for it. We
have fixed rate clks that sort of do that, but I'm thinking about
something like a GPIO clk gate that is downstream of some clk source,
and this gpio gate is enabled once at boot and then forgotten about. I
suppose in this case we could have a property in the clk gpio binding
that expresses this property of the hardware so it's best to not make
something more generic that could be abused.
