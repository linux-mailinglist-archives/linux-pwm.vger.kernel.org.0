Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA801ACE01
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 18:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgDPQty (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 12:49:54 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42144 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgDPQtx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Apr 2020 12:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YV1SAfrAwp0QaVFTYO0FSHpHPtlvDBOUkjggRuVS/W8=; b=U1chH8R3kb8KUrAc+3eJQcTwn8
        MDeJ/6p6u6fCmyrzaVmLr9Xb6n3BfYIsD259+oy6rHF4k2JzBkGCqhwGM0b6b4HKVg+dJC+TV2aK1
        YgUNOK/LU5DIofyvIIgLUhYeSZqEKS+dN67H3LP8yGRucvVgDoD+WS2eBNyQK/H6Nlao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jP7hw-0036fC-15; Thu, 16 Apr 2020 18:49:44 +0200
Date:   Thu, 16 Apr 2020 18:49:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Message-ID: <20200416164944.GS657811@lunn.ch>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
 <20200416135039.GL657811@lunn.ch>
 <5c7cb0ff-bf49-640a-3c4a-ef71495af7b7@arm.com>
 <20200416144231.GP657811@lunn.ch>
 <628cde2b-0e1b-4c07-4321-8b23d0b34384@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <628cde2b-0e1b-4c07-4321-8b23d0b34384@arm.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> > It is not really hope. It is very obvious when it is wrong, the whole
> > machine stops dead when you are missing a clock. Very simple to test.
> 
> Heh, that's still what I meant - the driver hopes that carrying on will be
> OK, and the end user is left to pick up the pieces when it isn't ;)

> Obviously that's less of an issue when said end-user is a kernel developer
> making a controlled change during SoC bringup, but perhaps more so for an
> eager inexperienced hacker cobbling together DTS fragments to convince a
> distro kernel to boot on some embedded device

Clocks are SoC level stuff, so it is in the DTSI file, not the DTS
file. An eager inexperienced hacker cobbling together DTS fragment is
not effected. Experienced kernel hackers have put together the DTSI
file and tested it. And if an eager inexperienced hacker does touch
the DTSI file, they probably deserve to get their finger burnt, and
will get a step closer to become an experience kernel hacker.

     Andrew
