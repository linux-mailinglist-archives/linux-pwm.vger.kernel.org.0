Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002E62CED40
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 12:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgLDLjb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 06:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgLDLja (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 06:39:30 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69654C0613D1;
        Fri,  4 Dec 2020 03:38:50 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 2613AC63B3; Fri,  4 Dec 2020 11:38:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1607081927; bh=Az/uDrcMyA9/dLYwyl4sQ5Fgc9q8oK/Kxxi0WSvZST4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuaTLHk6t5PWIq8CN0UUidPilVW6Fw6sSC3EJL4dWj62vDf1kYjZJmlJFPz4zQQFS
         yLQWocauR2jIvec/j0HKqlxH9wgKBSMlE5y60gHsBGw/vWlQPurXXpy5h+O72xUZA4
         FmRlg51yNiXA3mfHemg8p/hgd7CiuB23rczJij48Q3yIiSrESCaYrG2so7bMxr0+/I
         Ac5UOPYrayS3tkULu6uAw0J+LMPO3jvq7DRKfXbMQjSTJkKLUiYZZv61bLHtJyZYPv
         aNGbOr2KpTr4Yr1xFJ0Dztrxr2w19JxhKVtbgh3T9M0RNZvKI/7gItixlhWODJHops
         5ndnB27gqImsg==
Date:   Fri, 4 Dec 2020 11:38:46 +0000
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, thierry.reding@gmail.com,
        lee.jones@linaro.org, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201204113846.GA6547@gofer.mess.org>
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204084417.GA2154@gofer.mess.org>
 <20201204111326.qjux6k2472dmukot@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201204111326.qjux6k2472dmukot@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Fri, Dec 04, 2020 at 12:13:26PM +0100, Uwe Kleine-König wrote:
> On Fri, Dec 04, 2020 at 08:44:17AM +0000, Sean Young wrote:
> > On Fri, Dec 04, 2020 at 12:42:15AM +0100, Lino Sanfilippo wrote:
> > > > You're storing an unsigned long long (i.e. 64 bits) in an u32. If
> > > > you are sure that this won't discard relevant bits, please explain
> > > > this in a comment for the cursory reader.
> > > 
> > > What about an extra check then to make sure that the period has not been truncated,
> > > e.g:
> > > 
> > > 	value = DIV_ROUND_CLOSEST_ULL(state->period, scaler);
> > > 
> > > 	/* dont accept a period that is too small or has been truncated */
> > > 	if ((value < PERIOD_MIN) ||
> > > 	    (value != DIV_ROUND_CLOSEST_ULL(state->period, scaler)))
> > > 		return -EINVAL;
> > 
> > Rather than doing another 64 bit division which is expensive (esp on 32 bit
> > kernels), you could assign to u64 and check:
> > 
> > 	if (value < PERIOD_MIN || value > U32_MAX)
> > 		return -EINVAL;
> 
> Given that value is a u32, value > U32_MAX will never trigger.

I meant that value is declared u64 as well ("assign to u64").

> Maybe checking period before doing the division is more sensible.

That could introduce rounding errors, exactly why PERIOD_MIN was introduced.

> > > > Also note that round_closed is probably wrong, as .apply() is
> > > > supposed to round down the period to the next achievable period. (But
> > > > fixing this has to do done in a separate patch.)
> > > 
> > > According to commit 11fc4edc4 rounding to the closest integer has been introduced
> > > to improve precision in case that the pwm controller is used by the pwm-ir-tx driver.
> > > I dont know how strong the requirement is to round down the period in apply(), but I
> > > can imagine that this may be a good reason to deviate from this rule.
> > > (CCing Sean Young who introduced DIV_ROUND_CLOSEST)
> > 
> > There was a problem where the carrier is incorrect for some IR hardware
> > which uses a carrier of 455kHz. With periods that small, rounding errors
> > do really matter and rounding down might cause problems.
> > 
> > A policy of rounding down the carrier is not the right thing to do
> > for pwm-ir-tx, and such a change will probably break pwm-ir-tx in some
> > edge cases.
> 
> IMO it's not an option to say: pwm-driver A is used for IR, so A's
> .apply uses round-nearest and pwm-driver B is used for $somethingelse,
> so B's .apply uses round-down.

I'm not saying that one driver should have one it one way and another driver
another way.

> To be a sensible API pwm_apply_state
> should have a fixed behaviour. I consider round-down the sensible
> choice (because it is easier to implmement the other options with this)

It's not sensible when it's wrong about half the time.

Why is is easier to implement?

> and for consumers like the IR stuff we need to provide some more
> functions to allow it selecting a better suited state. Something like:
> 
> 	pwm_round_state_nearest(pwm, { .period = 2198, .. }, &state)
> 
> which queries the hardwares capabilities and then assigns state.period =
> 2200 instead of 2100.

This is very elaborate and surely not "easier to implement". Why not just
do the right thing in the first place and round-closest?

> Where can I find the affected (consumer) driver?

So there is the pwm-ir-tx driver. The infrared led is directly connected
to the pwm output pin, so that's all there is.

Thanks,

Sean
