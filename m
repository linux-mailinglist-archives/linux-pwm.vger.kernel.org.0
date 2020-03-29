Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E159196F12
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2020 20:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgC2SBH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Mar 2020 14:01:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57769 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgC2SBH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Mar 2020 14:01:07 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jIcF1-0007F3-27; Sun, 29 Mar 2020 20:00:59 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jIcEy-0002N8-L3; Sun, 29 Mar 2020 20:00:56 +0200
Date:   Sun, 29 Mar 2020 20:00:56 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH RFC 2/6] gpio: mvebu: honour EPROBE_DEFER for
 devm_clk_get()
Message-ID: <20200329180056.cwju3zqviwnwwjd6@pengutronix.de>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <E1jIVU9-0005h4-QU@rmk-PC.armlinux.org.uk>
 <20200329131659.4hbshjst4ccvje2n@pengutronix.de>
 <20200329133400.GA25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200329133400.GA25745@shell.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Russell,

On Sun, Mar 29, 2020 at 02:34:00PM +0100, Russell King - ARM Linux admin wrote:
> On Sun, Mar 29, 2020 at 03:16:59PM +0200, Uwe Kleine-König wrote:
> > On Sun, Mar 29, 2020 at 11:48:09AM +0100, Russell King wrote:
> > > diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> > > index fa5641615db6..ee13b11c5298 100644
> > > --- a/drivers/gpio/gpio-mvebu.c
> > > +++ b/drivers/gpio/gpio-mvebu.c
> > > @@ -1132,6 +1132,9 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
> > >  	}
> > >  
> > >  	mvchip->clk = devm_clk_get(&pdev->dev, NULL);
> > > +	if (mvchip->clk == ERR_PTR(-EPROBE_DEFER))
> > > +		return -EPROBE_DEFER;
> > > +
> > >  	/* Not all SoCs require a clock.*/
> > >  	if (!IS_ERR(mvchip->clk))
> > >  		clk_prepare_enable(mvchip->clk);
> > 
> > I'd say the following is the right thing to do here:
> > 
> > 	mvchip->clk = devm_clk_get_optional(...);
> > 	if (IS_ERR(mvchip->clk))
> > 		return ...
> 
> It's not that simple.  The clock is required for Armada 370, and is
> optional for Armada 8040.

I'd say it is still the right approach here. On Armada 370 the dtb then
has a clk and on Armada 8040 it doesn't. So if with
devm_clk_get_optional() something goes wrong that's because the dtb is
wrong. And in fact the handling is even better than with your suggested
patch as every error (but EPROBE_DEFER) is ignored instead of passed to
the caller with your (and the existing) approach.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
