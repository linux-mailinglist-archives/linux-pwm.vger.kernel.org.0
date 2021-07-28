Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AC03D96EC
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jul 2021 22:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhG1Ukv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Jul 2021 16:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhG1Ukv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Jul 2021 16:40:51 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0E2C061757;
        Wed, 28 Jul 2021 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3C4ckl4hBFKuszgFWuJ5cYd/cB9Dk9csJZ3u87C62W4=; b=M/eFAK97k7Nkw7itXgaJLcSJR
        J25DTtE/gEYgmIpDIeF+wOccrGjrlAjZYHjVZmlxSZPoHIAiuOLK+4ayJ19RMTPWDxlA8TrAbRl8C
        kj4ZsXqHS0AJS/J/YIReMy0To2AGo/QEAHiMeHjydd9ANr2thbrZXOAB1ZQaE9pSetedNsl6Ptm8o
        tRNqqze9tqkKKsmlFxFz5HQxgLWBAsmM5UiWdl9yZRlQU6LqJI4C3dwDz0N/D215D8ASdUkOdBCsn
        jp124LaZmNrlFEXYSgDwwTZ3CFTX5syOebGZ6akdED7dBcN0rBgXS82CHxM1R3FH8WlB0bwu0fApZ
        suXcK4fzw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46706)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m8qM3-0008Ta-3T; Wed, 28 Jul 2021 21:40:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m8qLy-0006rx-7Y; Wed, 28 Jul 2021 21:40:34 +0100
Date:   Wed, 28 Jul 2021 21:40:34 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
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
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of
 devm_clk_get for prepared and enabled clocks enabled clocks]
Message-ID: <20210728204033.GF22278@shell.armlinux.org.uk>
References: <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
 <20210705080144.zfbzkm7l3gmnh6st@pengutronix.de>
 <20210722060654.nudpdtemosi64nlb@pengutronix.de>
 <YPkg0wtYIoHKpTUW@kunai>
 <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
 <YPlfcbkxiBmB+vw1@kunai>
 <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
 <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
 <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
 <20210728202547.7uvfwflpruku7yps@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210728202547.7uvfwflpruku7yps@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jul 28, 2021 at 10:25:47PM +0200, Uwe Kleine-König wrote:
> I adapted the Subject in the hope to catch Stephen's and Michael's
> attention. My impression is that this thread isn't on their radar yet,
> but the topic here seems important enough to get a matching Subject.

Have you thought about sending your pull request to the clk API
maintainer (iow, me) ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
