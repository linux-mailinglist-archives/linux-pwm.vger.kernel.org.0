Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FCC1ACDFF
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgDPQt1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 12:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727784AbgDPQt0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Apr 2020 12:49:26 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C76C061A0C;
        Thu, 16 Apr 2020 09:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n3/jm2QI7rsfG4KaHdXHQXij6hzOO1V7ELxRqZ5QX9o=; b=UJrUTL8NDYOy2e7kwBRYLHN2O
        u3d+MbDcUtlLd7inP8Rl+5AwOi6EVc14fCdRFbM82r4GWdpiGnEsOSqhLNuP+PS+HgVL+9WN4rKwJ
        Aqtn5arpLZxEJcgTXHeuLMdiKye4iZg9oW8FjGhG1xaK9rOgS4aiO5ugaGNEEDLupqGMgIdxqmgkq
        JA6UUzoDNDieqAchNgdiEmxjbP4i1Ggw8J0Lv7ezlh5LbJ4LC1hIXoKVT+dy/NhVIk7zOKd93/Vng
        O1Ireoz/o3I0FmqgnliFvlaakd+lVpzwlOOzpUSoYNWZtGdxRw0OOgFzbTJz4hIlsz5fkyBL40lu2
        VTkZE3EHA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50926)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jP7hU-0005JU-7E; Thu, 16 Apr 2020 17:49:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jP7hS-00022u-8F; Thu, 16 Apr 2020 17:49:14 +0100
Date:   Thu, 16 Apr 2020 17:49:14 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Message-ID: <20200416164914.GM25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
 <20200416135039.GL657811@lunn.ch>
 <5c7cb0ff-bf49-640a-3c4a-ef71495af7b7@arm.com>
 <20200416145517.GK25745@shell.armlinux.org.uk>
 <010ccb32-42f1-cc32-0527-e608fc91a879@arm.com>
 <20200416163748.GL25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416163748.GL25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 16, 2020 at 05:37:48PM +0100, Russell King - ARM Linux admin wrote:
> On Thu, Apr 16, 2020 at 04:55:44PM +0100, Robin Murphy wrote:
> > On 2020-04-16 3:55 pm, Russell King - ARM Linux admin wrote:
> > > On Thu, Apr 16, 2020 at 03:37:40PM +0100, Robin Murphy wrote:
> > > > On 2020-04-16 2:50 pm, Andrew Lunn wrote:
> > > > [...]
> > > > > Clocking with Marvell devices has always been interesting. Core IP
> > > > > like this gets reused between different generations of SoCs. The
> > > > > original Orion5x had no clock control at all. Latter SoCs have had
> > > > > more and more complex clock trees. So care has to be taken to not
> > > > > change old behaviour when adding support for new clocks.
> > > > 
> > > > FWIW, that sounds like a good argument for encoding the clock requirements
> > > > of each variant in the of_match_data, so the driver doesn't have to simply
> > > > trust the DT and hope.
> > > 
> > > Please read my patches.  This is exactly what I'm doing.  I'm preserving
> > > as closely as possible the current driver behaviour while adding support
> > > for the Armada 8040 PWM while keeping compatibility with older DT.
> > > 
> > > And I'm doing that by keying off the match data, exactly as you're
> > > suggesting above.
> > 
> > AFAICS you're encoding the *PWM capability* in the match data and using that
> > to extend the existing behaviour, which comprises using soc_variant to maybe
> > treat the stashed error code as fatal somewhere else much later if
> > CONFIG_PWM happens to be enabled, and is subtle enough that at least two
> > reviewers overlooked or failed to make sense of it.
> > 
> > Compare and contrast with how self-contained and obvious this is:
> > 
> > -	mvchip->clk = devm_clk_get(&pdev->dev, NULL);
> > -	/* Not all SoCs require a clock.*/
> > -	if (!IS_ERR(mvchip->clk))
> > -		clk_prepare_enable(mvchip->clk);
> > 
> > +	/* Not all SoCs require a clock.*/
> > +	if (data->needs_clock)
> > +		mvchip->clk = devm_clk_get(&pdev->dev, NULL);
> > +		if (IS_ERR(mvchip->clk))
> > +			return PTR_ERR(mvchip_clk);
> > +		clk_prepare_enable(mvchip->clk);
> > +	}
> > 
> > If achieving the same end result by very different and roundabout means
> > constitutes "exactly the same thing", does me having written this email mean
> > that my house is exactly the same as the Arm office and someone else will be
> > along to clean the kitchen shortly? Here's hoping... :D
> 
> What if we have a platform where DT mentions the clock, and relies
> on it being enabled as per how the driver is coded today?  I don't
> know if that's true or not, I don't have the hardware to test.
> 
> So, while we can make improvements as you describe above, it's
> dangerous to do so because we don't have the information to know
> whether what's being proposed is correct or not.  Hence, it's safer
> to do the minimum amount of changes, and not do gratuitous potential
> regression causing cleanups as you're suggesting.
> 
> If we want to clean up the driver in potentially regression causing
> ways, that can be done at a later date.

And, here's proof that such an approach will cause a regression:

arch/arm/boot/dts/armada-375.dtsi:

gpio0: gpio@18100 {
        compatible = "marvell,orion-gpio";
        reg = <0x18100 0x40>;
        ngpios = <32>;
        gpio-controller;
        #gpio-cells = <2>;
        interrupt-controller;
        #interrupt-cells = <2>;
        interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
                     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
                     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
                     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
};

Uses "marvell,orion-gpio" compatible, but no clock.

arch/arm/boot/dts/kirkwood.dtsi:

gpio0: gpio@10100 {
        compatible = "marvell,orion-gpio";
        #gpio-cells = <2>;
        gpio-controller;
        reg = <0x10100 0x40>;
        ngpios = <32>;
        interrupt-controller;
        #interrupt-cells = <2>;
        interrupts = <35>, <36>, <37>, <38>;
        clocks = <&gate_clk 7>;
};

Uses "marvell,orion-gpio" compatible, but there is a clock, and the
driver will enable this clock.

So, if the decision about the clock is keyed off the compatible as
you're suggesting it _will_ cause gratuitous regressions.

Random changes to drivers, especially when they have a long history,
always tends to end up causing regressions, which is why it's better
to do as I've done when adding PWM support for the A8040, and only
make the _minimum_ number of changes.  Not to clean up the driver in
random ways to "improve" it, or make it taste better.  Because such
things cause regressions.  As I've said several times in this thread.

Point proven.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
