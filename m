Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02B11AC690
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 16:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394460AbgDPOlg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 10:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394448AbgDPOl0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Apr 2020 10:41:26 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E945CC061A0C;
        Thu, 16 Apr 2020 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tLjN/nPsRscBzXHkmgVPun+eK2xtxPpGYdMPS7Z6B9M=; b=w3aiss/S89mWYK6GKHriGLOdo
        UCj3P6LDJQougYx1COFdPAWZEQvQmq0cr7MskscE1hM0hr5uapWgBpJES4Vifk5UYcdMG9YyUPuG9
        JsW9KRlADfJ4jf6mwxtZ800Ci4EvuxDN2+mEHP/yQowVsDlyKOey3EOLmEEP065Czz2/9Gmz+sV4O
        fsKJuBbMrvuFP7/Jxb7OEtcfC0tBAImx/lNEhRxJxRWAom00aNfauVHDDsqla7UiMyFpJPNC/MJy0
        Gx1+41HDFbRWen5KQvD95/lCJSLD4eStn4EgfxIOP6qB+d+wtzX11rPi52HR4XyAt43xQ4krZ5GR7
        6UmMu9w7w==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46746)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jP5hc-0004hW-KW; Thu, 16 Apr 2020 15:41:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jP5ha-0001y9-6X; Thu, 16 Apr 2020 15:41:14 +0100
Date:   Thu, 16 Apr 2020 15:41:14 +0100
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
Message-ID: <20200416144114.GI25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
 <20200416135039.GL657811@lunn.ch>
 <20200416142944.GH25745@shell.armlinux.org.uk>
 <20200416143645.GN657811@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416143645.GN657811@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 16, 2020 at 04:36:45PM +0200, Andrew Lunn wrote:
> > I said in the cover message "The cooling maps are experimental".
> > They work reasonably well for me with the fan I have (a noctua fan)
> > but other people may find them to be problematical, so one of the
> > reasons for sending it as RFC is to get people to test and see how
> > well it works.
> 
> Hi Russell
> 
> Maybe split the PWM parts from the cooling maps? I don't see any
> reason not to merge the PWM parts.

That's easy - the cooling maps are an entirely separate patch.
However, one thing we need to be careful of is whether someone has a
PWM fan plugged in, and whether not having any cooling maps results
in the fan stopping, as I think PWMs default to being disabled on
initialisation.

That could be a SoC-killing combination.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
