Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1B31AC87F
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 17:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408667AbgDPNu4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 09:50:56 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41660 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408557AbgDPNuv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Apr 2020 09:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EF/f9myVVbgrLxXwzUMzNnUxGooj5hG2873Zghg3qio=; b=f5c9A4Fn3ySTK1wzQTyIowkDaW
        o2L99bBr1lFDYtL4BfBJGLRkjJyMo2p4ZrbupRO58aeykvzS/cr/UeCXY+d23IiSHcp6i7CeihRhq
        jZli5GjTIUplIniSlLGL4h7pv3GwqBpq82wY+p3xcMk7emkYyilPwPjrq7EfOWM4IAck=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jP4ud-0034yA-Ey; Thu, 16 Apr 2020 15:50:39 +0200
Date:   Thu, 16 Apr 2020 15:50:39 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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
Message-ID: <20200416135039.GL657811@lunn.ch>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 16, 2020 at 09:51:37AM +0200, Linus Walleij wrote:
> On Sun, Mar 29, 2020 at 12:46 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> 
> > This series adds support for the fan PWM output on the Clearfog GT8K
> > platform, and can potentially be extended to the Macchiatobin.
> 
> The gpio changes all look fine to me +/- fixes for review comments.
> 
> Could the MVEBU maintainers provide some feedback?

Hi Linus

I took a quick look at this when it was first posted. I also wrote the
PWM support in this driver. The hardware is mostly a GPIO driver, but
it has some basic PWM facilities. It is not possible to cleanly split
it into two drivers, which is why it has the current structure. And
the PWM maintainers ask that the PWM parts be listed in MAINTAINERS as
such, so they got to know about any changes.

Clocking with Marvell devices has always been interesting. Core IP
like this gets reused between different generations of SoCs. The
original Orion5x had no clock control at all. Latter SoCs have had
more and more complex clock trees. So care has to be taken to not
change old behaviour when adding support for new clocks. So Russell
2/6 patch looks good to me, and Uwe request could break on some
SoCs. It would need testing on a lot of SoCs, with and without PWM
support. 

I assume Russell will at some point repost without the RFC tag. At
that point i will take a second look and add Reviewed-by.

     Andrew
