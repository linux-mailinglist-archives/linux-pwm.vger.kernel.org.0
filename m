Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2003DC47D
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Jul 2021 09:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhGaHl2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 31 Jul 2021 03:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhGaHl1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 31 Jul 2021 03:41:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3148A60EE6;
        Sat, 31 Jul 2021 07:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627717281;
        bh=Hv1Kjt0wM3IMrL51Qq27kQRTwgyaY1whymskpzTrLBg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Mfe/v8Uz7KZzXezwTwjXNOUR+12p4qzmq6509mWK4HR6HXGPAgYYHOsPNIDypMN4W
         dptRTFmjMlRcoslggxxB3pGQBj0x6UrIzpyRhgK0eHShF1H4ayZFJwSjbVOjohBESi
         S7z2KmeryQRXtF7eCeDb2EWvnztkdGkPMUlZcvNgWKzC+b7h/pDhgVb1avCQX29DcW
         jD3PhoYFAFhcJd+plY+0d1jbLOvWrCoQRpOp8y4dhHXeVVhAQXt6M5qmuAJacc37Fb
         htU5NUsNIGPVW4EzuZd3O1Ri4wdN/qcx17MjnStx1zor6X+sjRKLhzQ7jQZ84kkJOU
         +DAteW7woUfZA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210728204033.GF22278@shell.armlinux.org.uk>
References: <20210625171434.3xusxpxjprcdqa47@pengutronix.de> <20210722060654.nudpdtemosi64nlb@pengutronix.de> <YPkg0wtYIoHKpTUW@kunai> <20210722081817.2tsjzof4gvldq6ka@pengutronix.de> <YPlfcbkxiBmB+vw1@kunai> <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com> <20210723091331.wl33wtcvvnejuhau@pengutronix.de> <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com> <20210728202547.7uvfwflpruku7yps@pengutronix.de> <20210728204033.GF22278@shell.armlinux.org.uk>
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of devm_clk_get for prepared and enabled clocks enabled clocks]
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Claudiu.Beznea@microchip.com, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        lee.jones@linaro.org, linux-clk@vger.kernel.org,
        linux-rtc@vger.kernel.org, Ludovic.Desroches@microchip.com,
        o.rempel@pengutronix.de, andy.shevchenko@gmail.com,
        aardelean@deviqon.com, linux-pwm@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, broonie@kernel.org,
        Jonathan.Cameron@huawei.com, linux-arm-kernel@lists.infradead.org,
        a.zummo@towertech.it, linux-spi@vger.kernel.org, wsa@kernel.org,
        kernel@pengutronix.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
To:     Russell King (Oracle) <linux@armlinux.org.uk>,
        <u.kleine-koenig@pengutronix.de>
Date:   Sat, 31 Jul 2021 00:41:19 -0700
Message-ID: <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Quoting Russell King (Oracle) (2021-07-28 13:40:34)
> > I adapted the Subject in the hope to catch Stephen's and Michael's
> > attention. My impression is that this thread isn't on their radar yet,
> > but the topic here seems important enough to get a matching Subject.

The thread is on my radar but...

>=20
> Have you thought about sending your pull request to the clk API
> maintainer (iow, me) ?
>=20

+1 This patch doesn't fall under CCF maintainer.

 $ ./scripts/get_maintainer.pl -f include/linux/clk.h
 Russell King <linux@armlinux.org.uk> (maintainer:CLK API)
 linux-clk@vger.kernel.org (open list:CLK API)
 linux-kernel@vger.kernel.org (open list)

Finally, this sort of patch has been discussed for years and I didn't
see any mention of those previous attempts in the patch series. Has
something changed since that time? I think we've got a bunch of hand
rolled devm things in the meantime but not much else.=20

I still wonder if it would be better if we had some sort of DT binding
that said "turn this clk on when the driver probes this device and keep
it on until the driver is unbound". That would probably work well for
quite a few drivers that don't want to ever call clk_get() or
clk_prepare_enable() and could tie into the assigned-clock-rates
property in a way that let us keep the platform details out of the
drivers. We could also go one step further and make a clk pm domain when
this new property is present and then have the clk be enabled based on
runtime PM of the device (and if runtime PM is disabled then just enable
it at driver probe time).
