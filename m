Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853F33E1FFA
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Aug 2021 02:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhHFA0d (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Aug 2021 20:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235480AbhHFA0c (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 5 Aug 2021 20:26:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6C4D6103B;
        Fri,  6 Aug 2021 00:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628209577;
        bh=YFtjL1PAXNXSdcZpSOdpjOpPtHM0Uq0mwmaKoBiv7Ng=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nTBlAbLcMlktPMKTmuZWSwf8qZuNTuimEEJKAP/Jl70nzb4PuCp6jmXm8On/8rZ1e
         bHd3PWXnDvVTCHCQVNFqLBoxRx+9WiplFvAARRKooeyFeoZhQGZY5iw5Ny+qO8Fqa5
         rYC46cEsbkvsa/1RbsPZKrfbZLEjfoVhEE4Ue+/xAq8aIgEqmD9eoXeSQVBc//Kdie
         hmgHunpMJQAq3sRgiUdkuydl0OV6ikTNVBmDP2Q1nKrHjQ2f4jD3anKK/Jy40PXPeG
         ON3ASC7tam/ND04fURgRmqwi/Vb1kYry7MFHzvt2LrSGQzeU+NkmC5+yKOAxJL3DXL
         4yEushO9353bA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210803104012.wf2buscbukxufesl@pengutronix.de>
References: <20210723091331.wl33wtcvvnejuhau@pengutronix.de> <20210728202547.7uvfwflpruku7yps@pengutronix.de> <20210728204033.GF22278@shell.armlinux.org.uk> <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com> <20210731120004.i3affxw7upl5y4c5@pengutronix.de> <20210802094810.GJ22278@shell.armlinux.org.uk> <20210802152755.ibisunvibmwhiyry@pengutronix.de> <20210802163824.GK22278@shell.armlinux.org.uk> <162797831443.714452.3551045763456936564@swboyd.mtv.corp.google.com> <20210803104012.wf2buscbukxufesl@pengutronix.de>
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of devm_clk_get for prepared and enabled clocks enabled clocks]
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        alexandre.belloni@bootlin.com,
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
To:     <u.kleine-koenig@pengutronix.de>
Date:   Thu, 05 Aug 2021 17:26:16 -0700
Message-ID: <162820957661.19113.17221558053361108175@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2021-08-03 03:40:12)
> On Tue, Aug 03, 2021 at 01:11:54AM -0700, Stephen Boyd wrote:
> >=20
> > Maybe this series would be more compelling if those various drivers that
> > are hand rolling the devm action were converted to the consolidated
> > official devm function. The truth is it's already happening in various
> > subsystems so consolidating that logic into one place would be a win
> > code size wise and very hard to ignore.
> >=20
> > Doing
> >=20
> >  $ git grep devm_add_action | grep clk
> >=20
> > seems to catch quite a few of them.
>=20
> Another upside is that grepping for these drivers with a potential for
> further improvement become easier to grep for as
> devm_clk_get_{prepared,enabled} is a much better hint :-)

Sorry, but that's a pretty weak argument. I'd think grepping for the
absence of pm_ops in drivers would be the same hint.

>=20
> The changes to these drivers probably won't go through a clk tree, so
> adding these patches before adding devm_clk_get_enabled() would only
> help for the warm and cozy feeling that it is right to do so, correct?

It isn't to feel warm and cozy. It's to demonstrate the need for
consolidating code. Converting the i2c and spi drivers to use this is
actively damaging the cause though. Those driver frameworks are more
likely to encourage proper power management around bus transfers, so
converting them to use the devm API moves them away from power
management, not closer to it.

This proves why this topic is always contentious. It's too easy to
blindly convert drivers to get the clk and leave it enabled forever and
then they never use power management. The janitors win and nobody else.

Is there some way to avoid that trap? Maybe through some combination of
a device PM function that indicates the driver has no runtime PM
callbacks (pm_runtime_no_callbacks() perhaps?) and
devm_clk_get_enabled() checking for that and returning the clk only when
that call has been made (i.e. pm_runtime_has_no_callbacks())? This
approach would fail to catch the case where system wide suspend/resume
could turn the clk off but the driver doesn't do it. I'm not sure how
much we care about that case though.

>=20
> As my focus is limited to (mostly) drivers/pwm and I already have quite
> some other patch quests on my list:

Don't we all? :)
