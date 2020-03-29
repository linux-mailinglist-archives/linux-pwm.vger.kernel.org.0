Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9BA6196DAB
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2020 15:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgC2NeP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Mar 2020 09:34:15 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37584 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2NeP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Mar 2020 09:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3C6tfF5Ul0fw3udMKyjvurS5QtWeo4pSfQAUnxBXyAY=; b=03Bz54I1bcN1+oZhNl0RWIA7u
        u3TIb2qtWRgALFddvdLJWDf7InsOpmxtRXdcZ1dwuIOpiPmx0j260PDH/if+o1UzW7tIxAnq13lFd
        fvhpP1mjLMojQk/HeUD9b3FSpxA0yPsfZLfv9b708+JMhVVmdbSzgGK9Tc2nUefUTxLNB5Ivf9rcs
        o1zpN4AvMfErLybwHlRByrvaZji4ZinfC+USvfYA86CCmw6UkYq44reUM/6Ur/OUzZ1fjs8nRtM8A
        5wK3x/1Heaz/S9iArQvPpmrBi2r/viaaElG9n/3aHa8119Z74J/z2wHNtPNm9Cis+F/qsmzIBVZIT
        JhjFr68WQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42932)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jIY4i-0005E4-F2; Sun, 29 Mar 2020 14:34:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jIY4e-0006FN-8B; Sun, 29 Mar 2020 14:34:00 +0100
Date:   Sun, 29 Mar 2020 14:34:00 +0100
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
Message-ID: <20200329133400.GA25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <E1jIVU9-0005h4-QU@rmk-PC.armlinux.org.uk>
 <20200329131659.4hbshjst4ccvje2n@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200329131659.4hbshjst4ccvje2n@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Mar 29, 2020 at 03:16:59PM +0200, Uwe Kleine-König wrote:
> On Sun, Mar 29, 2020 at 11:48:09AM +0100, Russell King wrote:
> > Honour deferred probing for devm_clk_get() so that we can get the clock
> > for PWM.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/gpio/gpio-mvebu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> > index fa5641615db6..ee13b11c5298 100644
> > --- a/drivers/gpio/gpio-mvebu.c
> > +++ b/drivers/gpio/gpio-mvebu.c
> > @@ -1132,6 +1132,9 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	mvchip->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (mvchip->clk == ERR_PTR(-EPROBE_DEFER))
> > +		return -EPROBE_DEFER;
> > +
> >  	/* Not all SoCs require a clock.*/
> >  	if (!IS_ERR(mvchip->clk))
> >  		clk_prepare_enable(mvchip->clk);
> 
> I'd say the following is the right thing to do here:
> 
> 	mvchip->clk = devm_clk_get_optional(...);
> 	if (IS_ERR(mvchip->clk))
> 		return ...

It's not that simple.  The clock is required for Armada 370, and is
optional for Armada 8040.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
