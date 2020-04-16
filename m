Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AED1AC5E7
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392766AbgDPOaG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 10:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390867AbgDPOaE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Apr 2020 10:30:04 -0400
X-Greylist: delayed 22509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Apr 2020 07:30:02 PDT
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A3BC061A0C;
        Thu, 16 Apr 2020 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KneQJooGNroMsnVhWpDNmOJcUpQzDw2TtA1XPoL0v94=; b=gpjzjvJ1SeNwiy64EvyosJQ8U
        XL1D/lWSZEPz8nh71eZGnsa8wJymRu0HxttL22t1hKWPT7wk33UPO3X8aXHE9hIFE++kTF7+9U1yx
        5jos7uFLFpiJyBwnjhrVHtWiiRzTpNHcxdGxfXopk8ecSU1y/osTb+cDOjx5VsHQtCp5ZOoCeruaz
        libTRH86hFC6aupenZGdh7F2wIR9PRVNJPI+6mwdVGTOuvMJdO86X4GdYe2NDH71WRYjqoFOK9htC
        XUAFco+ZR7JcPv1WXl9Ua6kNpoRcSWfo18uyeZ7fC7pmBX/6y2RMFmaO8TwQRRSD2RZ8WzoL+WyUW
        SarV3nEjg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:39222)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jP5WX-0004dh-LL; Thu, 16 Apr 2020 15:29:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jP5WS-0001x6-Nr; Thu, 16 Apr 2020 15:29:44 +0100
Date:   Thu, 16 Apr 2020 15:29:44 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Message-ID: <20200416142944.GH25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
 <20200416135039.GL657811@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416135039.GL657811@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 16, 2020 at 03:50:39PM +0200, Andrew Lunn wrote:
> On Thu, Apr 16, 2020 at 09:51:37AM +0200, Linus Walleij wrote:
> > On Sun, Mar 29, 2020 at 12:46 PM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > 
> > > This series adds support for the fan PWM output on the Clearfog GT8K
> > > platform, and can potentially be extended to the Macchiatobin.
> > 
> > The gpio changes all look fine to me +/- fixes for review comments.
> > 
> > Could the MVEBU maintainers provide some feedback?
> 
> Hi Linus
> 
> I took a quick look at this when it was first posted. I also wrote the
> PWM support in this driver. The hardware is mostly a GPIO driver, but
> it has some basic PWM facilities. It is not possible to cleanly split
> it into two drivers, which is why it has the current structure. And
> the PWM maintainers ask that the PWM parts be listed in MAINTAINERS as
> such, so they got to know about any changes.
> 
> Clocking with Marvell devices has always been interesting. Core IP
> like this gets reused between different generations of SoCs. The
> original Orion5x had no clock control at all. Latter SoCs have had
> more and more complex clock trees. So care has to be taken to not
> change old behaviour when adding support for new clocks. So Russell
> 2/6 patch looks good to me, and Uwe request could break on some
> SoCs. It would need testing on a lot of SoCs, with and without PWM
> support. 
> 
> I assume Russell will at some point repost without the RFC tag. At
> that point i will take a second look and add Reviewed-by.

I said in the cover message "The cooling maps are experimental".
They work reasonably well for me with the fan I have (a noctua fan)
but other people may find them to be problematical, so one of the
reasons for sending it as RFC is to get people to test and see how
well it works.

I may have had greater success getting people to test if I'd added
maps for the Macchiatobin, but that wasn't my target system. That's
relatively easy to do - it's the same pin as on the gt8k, so merely
putting the same DT changes onto Macchiatobin would allow testing
with those settings.

Whether that's correct for my Macchiatobin server setup is an
entirely separate problem - where the fan PWM controls front panel
fans and there's a bigger fanless heatsink on the Armada 8040 (as
per the first revision of the Macchiatobin boards).  As the boards
ship without a PWM controllable fan, it would be of limited use.

So, really, I think the DT configuration of the PWM parameters is
"for the user" and not actually for mainline kernels - which
brings with it the problems of understanding control systems,
stability of such systems, feedback, and how to configure the
thermal subsystem... which is not easy.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
