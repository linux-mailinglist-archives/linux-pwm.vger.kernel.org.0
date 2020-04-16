Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0BC1AC760
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 16:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406125AbgDPOyQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 10:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729215AbgDPOyF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Apr 2020 10:54:05 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8BAC061A0C;
        Thu, 16 Apr 2020 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+reo/VTJ0mbrAtwez0qUHllJui2LGmUqeZZaPT2jjgk=; b=I1swcTqPXReZ6oCvu5oUeU1y3
        d/deFRuczBe4+pedkOkWyodhigLl1Ms/+hrs7CBSbxm0nOq5jrAAPHDlea8ojxzyLHGPBXC07hrLN
        c2j/N8sEMQ+E6d8dBg87isBtsUrfmjPVaHNJ3M3FdMrjbyR+Wt10umDBlUD+D0nXA9v9UxZLBy7ht
        jDQewrW/vTJSEcTpUQf0oImbJWtQWVqwko3oJSTcz7Ibh9sEcYts+np/iOJZpAfgOwBfJf8RDHqhY
        GjSCCOC4gh5436SCT1xl9gP/uGcbrIT348QH19BrYkcEOAZ1haMRyF/y56gXY00kuIZmrwPKQ6Dq9
        EfYggOTkQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50888)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jP5tq-0004lG-8i; Thu, 16 Apr 2020 15:53:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jP5to-0001yN-8z; Thu, 16 Apr 2020 15:53:52 +0100
Date:   Thu, 16 Apr 2020 15:53:52 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>, linux-pwm@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Message-ID: <20200416145352.GJ25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
 <20200416081412.GG25745@shell.armlinux.org.uk>
 <CACRpkdYFBGvQX3i4P1+cF5ExXOSKieT6cJNPTNuKFxEhtJVEjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYFBGvQX3i4P1+cF5ExXOSKieT6cJNPTNuKFxEhtJVEjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 16, 2020 at 02:08:36PM +0200, Linus Walleij wrote:
> On Thu, Apr 16, 2020 at 10:14 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Thu, Apr 16, 2020 at 09:51:37AM +0200, Linus Walleij wrote:
> 
> > > The gpio changes all look fine to me +/- fixes for review comments.
> >
> > I think Uwe is incorrect for his GPIO comments; the clock is only
> > optional on A8040.  We know this because A8040 has worked fine
> > without PWM support without the clock, whereas for Armada 370,
> > the driver has hard-failed if the clock is not present.
> 
> It's fine. You are running the hardware and it should work for you.
> I usually go by the IETF motto "rough consensus and running code".
> 
> > About the only change I would make is to move the check introduced
> > in patch 2 into patch 3 instead, inside the MVEBU_PWM_SOC_VARIANT_A8K
> > case, so that deferring for the clock works (which is necessary for
> > the PWM driver to be useful.)
> 
> OK let's go with this.

Well, it turns out to not be particularly nice to do that.  The best
I can come up with is:

        mvchip->clk = devm_clk_get(&pdev->dev, NULL);
        if (soc_variant->pwm && IS_ENABLED(CONFIG_PWM) &&
            mvchip->clk == ERR_PTR(-EPROBE_DEFER))
                return -EPROBE_DEFER;

Doing it in mvebu_pwm_probe() means that we have to deal with unwinding
the very complex probing (tearing down all the interrupt functionality
and GPIO stuff) which the driver currently does not do, even on failure.

Is this a shoddy driver that doesn't clean up after itself...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
