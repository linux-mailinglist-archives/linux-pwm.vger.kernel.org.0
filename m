Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895F12F6E2F
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Jan 2021 23:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbhANW3C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Jan 2021 17:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbhANW3C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Jan 2021 17:29:02 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C6EC061757;
        Thu, 14 Jan 2021 14:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+c27JvaG+gyEJ2essLvjqsTpAebaaMjXRpDRTZS4lnw=; b=YxlVRLcvHz4lnPRWymzjv3YzN
        iKbQBygqTA+prJsHeB+ccZVZ2dPnxs4bcbW6RbH1oY/O36r8+aqboK6nynPAfRwZHhKI/OTfGZXrN
        uDzQEzDKhMQxjK0pAaaGySnKWg0PAZpKY7Q75O5tAA/jYd/BVheHORO16oT41bH1I9or543fMgQHz
        8FRz8nF2oH4cFIwqYN/vbpKCWeJvLnWOf4a5AA8gKxkKHjI7LqRELWx4qoIiGWTab6OWdJL8ycAVA
        jc6TYc2ZBGBl3wzDH8FhijlVlD1XCW74O0Ql4BuK7NL4I53g6McEB6jgUmXbaHy8z4PMhLUQz3nTX
        DQ6cCBg1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48046)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l0B6A-00030H-QS; Thu, 14 Jan 2021 22:28:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l0B62-0000Ha-LP; Thu, 14 Jan 2021 22:28:02 +0000
Date:   Thu, 14 Jan 2021 22:28:02 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andrew Lunn <andrew@lunn.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-gpio@vger.kernel.org,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v3 5/5] gpio: mvebu: document zero pwm duty cycle
 limitation
Message-ID: <20210114222802.GY1551@shell.armlinux.org.uk>
References: <cover.1610628807.git.baruch@tkos.co.il>
 <7c18dd67d3bf3e3ed9a8efa2edd33e8f29f09a7a.1610628807.git.baruch@tkos.co.il>
 <20210114202545.7wnc5ikeffc45xk5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114202545.7wnc5ikeffc45xk5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jan 14, 2021 at 09:25:45PM +0100, Uwe Kleine-König wrote:
> Hello Baruch,
> 
> On Thu, Jan 14, 2021 at 08:57:37PM +0200, Baruch Siach wrote:
> > Add a comment on why the code never sets on/off registers to zero.
> > 
> > Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Analyzed-by: Russell King <linux@armlinux.org.uk>
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > ---
> >  drivers/gpio/gpio-mvebu.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> > index 6b017854ce61..09780944bef9 100644
> > --- a/drivers/gpio/gpio-mvebu.c
> > +++ b/drivers/gpio/gpio-mvebu.c
> > @@ -706,6 +706,10 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	do_div(val, NSEC_PER_SEC);
> >  	if (val > UINT_MAX)
> >  		return -EINVAL;
> > +	/*
> > +	 * Zero on/off values don't work as expected. Experimentation shows
> > +	 * that zero value is treated as 2^32. This behavior is not documented.
> > +	 */
> 
> This is too easy. The right thing to do is to adapt .apply and
> .get_state to use this new information.

What exactly do you expect the changes to be?

Bear in mind that the hardware is not capable of atomically updating
e.g. the duty cycle without affecting the period, because any change
in duty cycle needs the "on" and "off" durations to be separately
programmed, and there's a chance that the hardware could start using
either value mid-update.

Also, disabling "blink" mode to achieve a steady output (for 0% or 100%
duty cycle) would require further investigation to find out how the
hardware behaves at the moment where blink mode is disabled: does the
output retain its current state (does the bit in the output register
toggle with the blink) or does it revert to the value in the output
register that was programmed before blink mode was enabled.

Again, none of that is documented, so would need experimentation with
the hardware to work out how to achieve it.

And then if you want even more complexity, I suppose we could try and
read the current state of the pin, add a delay, recheck it and try and
work out the optimal place to disable the blink mode.

Exactly how far do you want to go with this?

All of this is likely getting rediculously complicated for the use
cases of it today that don't need it. Yes, it's annoying that we can't
achieve 0% or 100% duty cycle with this hardware that was never
designed as a PWM without jumping through a lot of hoops but currently
settle for a minimum pulse width of 4ns at each end of the range.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
