Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD69F2F234F
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Jan 2021 01:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbhALAYd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 19:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390099AbhAKWoS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jan 2021 17:44:18 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B40DC061786;
        Mon, 11 Jan 2021 14:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i7DbEQRd3KODIrytfRH/tzu+gaudCnJu2oc8ZbuI9m8=; b=d9YcJTdu75D1I9oj5doSKlgWz
        qGzZtdm+YOI+NDU82RBo9WNhleXtN0J5J18cVd6UBDAkmHJKzobNnxIfZ1hPTVgUzBXEG5KSODYpv
        xxQ/UmENI5GUTHVDwZpWO8jqAZQB/zP3BUAoOiMQhs270wKb8/s5ENdRZbwIMA+dZZyCeCKBnp+VS
        zdhKO3coRLnCTEiQn/kayIZLZgh7v30kCZnrp3YT+tSLzrnvMdTfUbwclSjL9yUNBVp9nALCiZJ6q
        EBhKkG7sFBcOVUcX91jJzikVTWztD524oAP6zH6YL04ShlgvUbFzyxFoJYdl8WYepdtDdPh7h6nmJ
        9WQwxah+Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46776)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kz5u6-0007Y7-Ns; Mon, 11 Jan 2021 22:43:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kz5ts-0005dx-HA; Mon, 11 Jan 2021 22:43:00 +0000
Date:   Mon, 11 Jan 2021 22:43:00 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] gpio: mvebu: document zero pwm duty cycle limitation
Message-ID: <20210111224300.GA1551@shell.armlinux.org.uk>
References: <cover.1610362661.git.baruch@tkos.co.il>
 <fa809a148e2a008c124677d61ea4ecba55cea7d0.1610362661.git.baruch@tkos.co.il>
 <20210111202413.lk3mxthlqagdhy7t@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111202413.lk3mxthlqagdhy7t@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jan 11, 2021 at 09:24:13PM +0100, Uwe Kleine-König wrote:
> On Mon, Jan 11, 2021 at 01:17:06PM +0200, Baruch Siach wrote:
> > Add a comment on why the code never sets the 'on' register to zero.
> > 
> > Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > ---
> >  drivers/gpio/gpio-mvebu.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> > index eb7456fa6d86..4261e3b22b4e 100644
> > --- a/drivers/gpio/gpio-mvebu.c
> > +++ b/drivers/gpio/gpio-mvebu.c
> > @@ -706,6 +706,7 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	val = DIV_ROUND_UP_ULL(val, NSEC_PER_SEC);
> >  	if (val > UINT_MAX)
> >  		return -EINVAL;
> > +	/* zero 'on' value does not work as expected for some reason */
> 
> What does the reference manual say about this? If there is no
> information about this, please point this out, too. (Something like: The
> reference manual is silent about this issue though.) Also I'd prefer to
> read about the behaviour, so maybe mention that there is an occational
> peek even when on is configured to 0. Does '$off = 0' has a symmetrical
> issue?

It isn't a proper PWM block - it's documented as being a "blink
function". It contains two counters, one defines the "on" duration,
and the other defines the "off" duration.

The block is not well documented in the reference manual, so we have
to resort to experimentation - and experimentation reveals that if
we program both registers to zero, then we get about 17s on and 17s
off. That is 2^32 / 250MHz seconds. So, a value of 0 in either register
is interpreted by the hardware as a value of 2^32.

So, let's say we want a 25kHz signal. If we program the "on" duration
to 10000 and the "off" duration to 0, what we actually get a 40us
on duration, and a 17.2s off duration - resulting in a frequency of
0.058Hz!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
