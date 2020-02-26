Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5E91708D8
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 20:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgBZTVI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 14:21:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42649 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbgBZTVI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2020 14:21:08 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j72Ey-0008TT-Cy; Wed, 26 Feb 2020 20:21:04 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j72Ex-0007E4-Rg; Wed, 26 Feb 2020 20:21:03 +0100
Date:   Wed, 26 Feb 2020 20:21:03 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
Message-ID: <20200226192103.bodplhjson7drvgm@pengutronix.de>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
 <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Feb 26, 2020 at 06:03:02PM +0100, Matthias Schiffer wrote:
> On Wed, 2020-02-26 at 16:10 +0100, Uwe Kleine-König wrote:
> > Hello Matthias,
> > 
> > as you seem to have this hardware on your desk, it would be great if
> > you
> > could answer the following questions:
> > 
> >  - Does the hardware complete the currently running period before
> >    applying a new setting?
> 
> The datasheet claims:
> 
> > Because the loading of the LEDn_ON and LEDn_OFF registers is via the
> > I 2 C-bus, and
> > asynchronous to the internal oscillator, we want to ensure that we do
> > not see any visual
> > artifacts of changing the ON and OFF values. This is achieved by
> > updating the changes at
> > the end of the LOW cycle.
> 
> My interpretation is that the hardware will complete its period before
> applying the new settings. I might check with a scope tomorrow-ish.

I agree given that you can update duty_cycle and period in a single
write as you considered below. Maybe it is worth playing with small
periods and a slow i2c bus speed (or hijack the bus by simulating a
clock stretch).
 
> >  - Is this racy somehow (i.e. can it happen that when going from
> >    duty_cycle/period = 1000/5000 to duty_cycle/period = 4000/10000 the
> >    output is 1000/10000 (or 4000/5000) for one cycle)?
> 
> It currently is racy. It should be possible to fix that either by
> updating all 4 registers in a single I2C write, or by using the "update
> on ACK" mode which requires all 4 registers to be updated before the
> new setting is applied (I'm not sure if this mode would require using a
> single I2C write as well though).

I can offer a second pair of eyeballs to interpret the datasheet. Will
take a look tomorrow.

> >  - Does the hardware complete the currently running period before
> >    .enabled = false is configured?
> 
> As my interpretation is that new settings are applied asynchronously, I
> assume that the final running period is completed after .enabled is set
> to false.
> 
> >  - How does the output pin behave on a disabled PWM. (Usual candidates
> >    are: freeze where is just happens to be, constant inactive and
> >    High-Z).
> 
> Constant inactive. This is also the case when the chip is put into
> sleep mode. Note that the interpretation of "inactive" depends in the
> invert flag in the MODE2 register.

This is optimal.

> As it turns out, this driver is broken in yet another way I didn't find
> before: For changing the global prescaler the chip needs to be put into
> sleep mode, but the driver doesn't follow the restart sequence
> described in the datasheet when waking it back up. In consequence,
> changing the period of one PWM does not only modify the period of all
> PWMs (which is bad enough, but can't be avoided with this hardware),
> but it also leaves all PWMs disabled...
> 
> As this hardware only has a single prescaler for all PWMs, should
> changing the period for individual PWMs even be allowed at all? Maybe
> only when all other PWMs are inactive?

yes, that is the general approach. Please document this in a
Limitiations: paragraph. See drivers/pwm/pwm-imx-tpm.c which has a
similar problem.
 
> I could imagine setting it in DTS instead (but I'm not sure what to do
> about non-OF users of this driver, for example when configured via
> ACPI).

I don't like fixing the period in the device tree. This isn't a hardware
property and it is less flexible than possible.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
