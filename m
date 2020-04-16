Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3881AC645
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 16:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404764AbgDPOg7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 10:36:59 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41770 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbgDPOg6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Apr 2020 10:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/8bvKF2o1FMLSPyNiMKCVFF5p7ETHhZaS3xirlYJxCo=; b=rWeuuWiFEE5MOHCmJEfSzIm00J
        facqd23NiAseSzFUdRTyme4ieALF1sczwdo03+DZJ1EipaG6tzGYLacdpRUWp7u5z+1Dxgns745Sp
        /mRkpWyc2X6/TPjS3hTbpPWFd40D4ok56TZG7ppI9yK1zrTiYhU6i9DgaEnF1r1qQyq0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jP5dF-0035Nx-9d; Thu, 16 Apr 2020 16:36:45 +0200
Date:   Thu, 16 Apr 2020 16:36:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
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
Message-ID: <20200416143645.GN657811@lunn.ch>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
 <20200416135039.GL657811@lunn.ch>
 <20200416142944.GH25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416142944.GH25745@shell.armlinux.org.uk>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> I said in the cover message "The cooling maps are experimental".
> They work reasonably well for me with the fan I have (a noctua fan)
> but other people may find them to be problematical, so one of the
> reasons for sending it as RFC is to get people to test and see how
> well it works.

Hi Russell

Maybe split the PWM parts from the cooling maps? I don't see any
reason not to merge the PWM parts.

Maybe sometime later I might take a closer look at the maps. I have a
wrt1900ac, which is Armada XP based. It has a fan on a GPIO pin. I
currently have a userspace daemon controlling the fan based on hwmon
device data. Getting the kernel to do it all would be nice.

       Andrew
