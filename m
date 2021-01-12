Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B252F2D00
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Jan 2021 11:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbhALKh1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Jan 2021 05:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbhALKh0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Jan 2021 05:37:26 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2188C061575;
        Tue, 12 Jan 2021 02:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I1TOZTlIyWpJo6t+ktfKEwi2Grwz2ejbXpCqmeiGeoo=; b=bWaGhBd8PtoP/cQ7GvkqD3iEH
        vbtnhNtL3/0sktfKOgWpaPiT+pa4W7eLRYzfxQVhYuklWvXGb+53tLKrcz+lKUW0XtbvUUWb5WUAl
        Sij2k3/WNcOvU84Vyalstmgvz24Xij+13atBb0OhLQqE7zA7+n9T6Lda4J/jo6H599SLyMA3L7cL5
        PdmqKfrR8d+Z4+6y6PWKp5Ar0Ppyi/3eVTl+mBqufomfvlF4fllM8k4QFD6QvswBusmlPLWAqm9nG
        NP0SEHTXHAtAPTUp+YwEmsda2jvDNe/sWgNjvO8tJusxfBlibf0TJ4X7xq3dkRJC1/9Z5DKbw5DDU
        tE5m40bzQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46984)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kzH2J-000813-Ox; Tue, 12 Jan 2021 10:36:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kzH2A-0006CA-6h; Tue, 12 Jan 2021 10:36:18 +0000
Date:   Tue, 12 Jan 2021 10:36:18 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Rob Herring <robh@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, linux-pwm@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v7 3/3] dt-bindings: ap806: document gpio
 marvell,pwm-offset property
Message-ID: <20210112103617.GB1551@shell.armlinux.org.uk>
References: <cover.1610364681.git.baruch@tkos.co.il>
 <5e1b119a51df19ead32561e87ce2ee1441b67154.1610364681.git.baruch@tkos.co.il>
 <CACRpkdZAHpcgzXSJKZyQjBOriALZUoXbw_hBpPa_zxa27=F0hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZAHpcgzXSJKZyQjBOriALZUoXbw_hBpPa_zxa27=F0hg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jan 12, 2021 at 09:49:16AM +0100, Linus Walleij wrote:
> Hi Baruch,
> 
> this caught my eye:
> 
> On Mon, Jan 11, 2021 at 12:47 PM Baruch Siach <baruch@tkos.co.il> wrote:
> 
> > Update the example as well. Add the '#pwm-cells' and 'clocks' properties
> > for a complete working example.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> 
> (...)
> > +Optional properties:
> > +
> > +- marvell,pwm-offset: offset address of PWM duration control registers inside
> > +  the syscon block
> (...)
> >  ap_syscon: system-controller@6f4000 {
> >         compatible = "syscon", "simple-mfd";
> > @@ -101,6 +106,9 @@ ap_syscon: system-controller@6f4000 {
> >                 gpio-controller;
> >                 #gpio-cells = <2>;
> >                 gpio-ranges = <&ap_pinctrl 0 0 19>;
> > +               marvell,pwm-offset = <0x10c0>;
> 
> This seems to be one of those cases where we start to encode things related
> to the hardware variant into the device tree.
> 
> Is this just documenting ABI that was introduced in the past and we can not
> do anything about now? In that case it is OK I suppose.
> 
> For a new binding we would certainly require that the system controller
> provide a specific tertiary compatible string for this, lest we disguise
> the not-so-simple system controller as "simple-mfd" so:
> 
> compatible = "syscon", "simple-mfd", "my-silicon-id";
> 
> Then detect the PWM offset by using
> if(of_device_is_compatibe(np, "my-silicon-id"))
> in the code rather than parsing any marvell,pwm-offset property.

I think it would be a good idea to describe the hardware more fully.
For the CP110 and AP80x dies on Armada 8040:

CP110	AP80x
Offset	Offset
00/40	5040	Data Out
04/44	5044	Data Out Enable
08/48	5048	Blink Enable
0c/4c	504c	Data In polarity
10/50	5050	Data In
14/54	5054	IRQ Cause
18/58	5058	IRQ Mask
1c/5c	505c	IRQ Level mask
20/60	5060	Blink Counter Select
28/68	5068	Control Set
2c/6c	506c	Control Clear
30/70	5070	Data Out Set
34/74	5074	Data Out Clear
f0	50c0	Blink Counter A ON duration
f4	50c4	Blink Counter A OFF duration
f8	50c8	Blink Counter B ON duration
fc	50cc	Blink Counter B OFF duration

We identify both of these using a compatible of "marvell,armada-8k-gpio"
which really only describes the first 64 bytes of the register set:

			ap_gpio: gpio@1040 {
				compatible = "marvell,armada-8k-gpio";
				offset = <0x1040>;
				...
			};

			CP11X_LABEL(gpio1): gpio@100 {
				compatible = "marvell,armada-8k-gpio";
				offset = <0x100>;
				...
			};

			CP11X_LABEL(gpio2): gpio@140 {
				compatible = "marvell,armada-8k-gpio";
				offset = <0x140>;
				...
			};

Note that on the CP11x dies, there are two GPIO controllers sharing the
same set of blink counter registers - one at offset 0 the other at
offset 0x40.

However, the pwm-offset is the offset in the regmap of the parent node.

It is possible to use a more specific compatible that would describe
the PWM offset for the CP11x and AP806 (which would need two different
ones) but that starts getting messy when you consider that we already
describe an offset in regmap for the first 64 registers, and encoding
the blink register offset in a compatible would partially end up
encoding the "offset" we already have.

In any case, these offsets are a function of how it was originally
chosen to describe the hardware in DT, rather than anything about the
hardware itself. The choice to use a syscon/regmap is purely an
implementation decision rather than something from the hardware, so
this DT description is already based around describing what is required
for the Linux implementation, rather than purely being a hardware
description.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
