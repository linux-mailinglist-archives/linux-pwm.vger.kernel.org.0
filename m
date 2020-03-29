Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFCEB196F40
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2020 20:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgC2SWv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Mar 2020 14:22:51 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40694 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgC2SWu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Mar 2020 14:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ul5mPuoITZiwsLENljEvGuoEiNdCieYNeoF+CgVtynY=; b=fazfmfEZAjksByCU8DCpoS9F+
        Nr90jbUdAi42KYu8HacKRPIMwtSxS8gPV08oocVVKktH55e304YKnr90bFNgyYt2QdC6Xo/x1JCLe
        MeRgQnh2C3QeyvqYQ8+L1rm2X7XpkYeZf2LSddGAxZZwyi/MC5qfNUH7IICpLRcznIUswY/hP9LbD
        G4Sr5nykVqVuGxItgtmgYImpYs/uMsRUiZ77JSOE+KLbqGB6hWPDdTpsOER/1oj+L3kuk1YV4S2MR
        F37blPxMy0YhqGydl4ZS6VnWEQ9q7PCOx7sAvRpULKz8Nt04SRvjE0A+hPeGf4wkCK6cklh8gZUlC
        etqkiKGaA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:59598)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jIca0-0006Mb-Bc; Sun, 29 Mar 2020 19:22:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jIcZw-0006QA-JB; Sun, 29 Mar 2020 19:22:36 +0100
Date:   Sun, 29 Mar 2020 19:22:36 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
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
Message-ID: <20200329182236.GC25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <E1jIVU9-0005h4-QU@rmk-PC.armlinux.org.uk>
 <20200329131659.4hbshjst4ccvje2n@pengutronix.de>
 <20200329133400.GA25745@shell.armlinux.org.uk>
 <20200329180056.cwju3zqviwnwwjd6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200329180056.cwju3zqviwnwwjd6@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Mar 29, 2020 at 08:00:56PM +0200, Uwe Kleine-K�nig wrote:
> Hello Russell,
> 
> On Sun, Mar 29, 2020 at 02:34:00PM +0100, Russell King - ARM Linux admin wrote:
> > On Sun, Mar 29, 2020 at 03:16:59PM +0200, Uwe Kleine-K�nig wrote:
> > > On Sun, Mar 29, 2020 at 11:48:09AM +0100, Russell King wrote:
> > > > diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> > > > index fa5641615db6..ee13b11c5298 100644
> > > > --- a/drivers/gpio/gpio-mvebu.c
> > > > +++ b/drivers/gpio/gpio-mvebu.c
> > > > @@ -1132,6 +1132,9 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
> > > >  	}
> > > >  
> > > >  	mvchip->clk = devm_clk_get(&pdev->dev, NULL);
> > > > +	if (mvchip->clk == ERR_PTR(-EPROBE_DEFER))
> > > > +		return -EPROBE_DEFER;
> > > > +
> > > >  	/* Not all SoCs require a clock.*/
> > > >  	if (!IS_ERR(mvchip->clk))
> > > >  		clk_prepare_enable(mvchip->clk);
> > > 
> > > I'd say the following is the right thing to do here:
> > > 
> > > 	mvchip->clk = devm_clk_get_optional(...);
> > > 	if (IS_ERR(mvchip->clk))
> > > 		return ...
> > 
> > It's not that simple.  The clock is required for Armada 370, and is
> > optional for Armada 8040.
> 
> I'd say it is still the right approach here. On Armada 370 the dtb then
> has a clk and on Armada 8040 it doesn't. So if with
> devm_clk_get_optional() something goes wrong that's because the dtb is
> wrong. And in fact the handling is even better than with your suggested
> patch as every error (but EPROBE_DEFER) is ignored instead of passed to
> the caller with your (and the existing) approach.

Sort of.  Every error is currently treated as "no clock", and only
later does such an error become fatal in the driver _if_ PWM is
configured into the kernel and we're running on Armada 370.  If PWM
is disabled in the kernel, or on some other SoC, then the driver
doesn't care whether getting the clock reported any kind of error.

Your proposal is to always treat any error getting the clock,
irrespective of whether there is PWM or not, as a fatal error for
the driver.

That is an entirely seperate functional change.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
