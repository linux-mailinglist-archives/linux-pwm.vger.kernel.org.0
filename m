Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD3D35105E
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Apr 2021 09:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhDAHuu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Apr 2021 03:50:50 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:57568 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhDAHuu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 1 Apr 2021 03:50:50 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id A1142C729F1;
        Thu,  1 Apr 2021 09:50:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617263446;
        bh=ODlCl+gxfx826JgxdXLsP1/L3ZuE5RKRNde/2G0M1Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vm+unAxxzDYDDAcYzcIshqmlQmjx+ANEzg1cgGmBq9xzMCYhIJ/cFBWPtQwro6mc6
         fzPSM8dsHHH5a8LZXO4Xpv1VRp0BBUz2QHpolY/yaImPbWenQJkygrhaIsAwKRl4xX
         ddFCPs1eUdFEati69EG92OOU1ZnE38BTW5cJAgB4=
Date:   Thu, 1 Apr 2021 09:50:44 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pwm: pca9685: Support staggered output ON times
Message-ID: <YGV7VJ72nWDIjNbu@workstation.tuxnet>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-4-clemens.gruber@pqgruber.com>
 <20210329170357.par7c3izvtmtovlj@pengutronix.de>
 <YGILdjZBCc2vVlRd@workstation.tuxnet>
 <20210329180206.rejl32uajslpvbgi@pengutronix.de>
 <YGRqZsi4WApZcwIT@workstation.tuxnet>
 <YGShjDE8R31LwAbi@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YGShjDE8R31LwAbi@orome.fritz.box>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

On Wed, Mar 31, 2021 at 06:21:32PM +0200, Thierry Reding wrote:
> On Wed, Mar 31, 2021 at 02:26:14PM +0200, Clemens Gruber wrote:
> > On Mon, Mar 29, 2021 at 08:02:06PM +0200, Uwe Kleine-König wrote:
> > > On Mon, Mar 29, 2021 at 07:16:38PM +0200, Clemens Gruber wrote:
> > > > On Mon, Mar 29, 2021 at 07:03:57PM +0200, Uwe Kleine-König wrote:
> > > > > On Mon, Mar 29, 2021 at 02:57:04PM +0200, Clemens Gruber wrote:
> > > > > > The PCA9685 supports staggered LED output ON times to minimize current
> > > > > > surges and reduce EMI.
> > > > > > When this new option is enabled, the ON times of each channel are
> > > > > > delayed by channel number x counter range / 16, which avoids asserting
> > > > > > all enabled outputs at the same counter value while still maintaining
> > > > > > the configured duty cycle of each output.
> > > > > > 
> > > > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > > > 
> > > > > Is there a reason to not want this staggered output? If it never hurts I
> > > > > suggest to always stagger and drop the dt property.
> > > > 
> > > > There might be applications where you want multiple outputs to assert at
> > > > the same time / to be synchronized.
> > > > With staggered outputs mode always enabled, this would no longer be
> > > > possible as they are spread out according to their channel number.
> > > > 
> > > > Not sure how often that usecase is required, but just enforcing the
> > > > staggered mode by default sounds risky to me.
> > > 
> > > There is no such guarantee in the PWM framework, so I don't think we
> > > need to fear breaking setups. Thierry?
> > 
> > Still, someone might rely on it? But let's wait for Thierry's opinion.
> 
> There's currently no way to synchronize two PWM channels in the PWM
> framework. And given that each PWM channel is handled separately the
> programming for two channels will never happen atomically or even
> concurrently, so I don't see how you could run two PWMs completely
> synchronized to one another.

As the PCA9685 has only one prescaler and one counter per chip, by
default, all PWMs enabled will go high at the same time. If they also
have the same duty cycle configured, they also go low at the same time.

> Or did I misunderstand and it's only the start time of the rising edge
> that's shifted, but the signal will remain high for a full duty cycle
> after that and then go down and remain low for period - duty - offset?

Yes, that's how it works.

> 
> That's slightly better than the above in that it likely won't trip up
> any consumers. But it might still be worth to make this configurable per
> PWM (perhaps by specifying a third specifier cell, in addition to the
> period and flags, that defines the offset/phase of the signal).
> 
> In both cases, doing this on a per-PWM basis will allow the consumer to
> specify that they're okay with staggered mode and you won't actually
> force it onto anyone. This effectively makes this opt-in and there will
> be no change for existing consumers.

I agree that it should be opt-in, but I am not sure about doing it
per-pwm:
The reason why you'd want staggered mode is to reduce EMI or current
spikes and it is most effective if it is enabled for all PWMs.

If it is specified in the DT anyway and you have a consumer that does
not support staggered mode (probably rare but can happen), then I'd
suggest just disabling it globally by not specifying nxp,staggered-mode;

Also it would make the configuration more complicated: You have to do
the "staggering" yourself and assign offsets per channel.
It's certainly easier to just enable or disable it.

What do you think?

> > > One reason we might not want staggering is if we have a consumer who
> > > cares about config transitions. (This however is moot it the hardware
> > > doesn't provide sane transitions even without staggering.)
> > > 
> > > Did I already ask about races in this driver? I assume there is a
> > > free running counter and the ON and OFF registers just define where in
> > > the period the transitions happen, right? Given that changing ON and OFF
> > > needs two register writes probably all kind of strange things can
> > > happen, right? (Example thought: for simplicity's sake I assume ON is
> > > always 0. Then if you want to change from OFF = 0xaaa to OFF = 0xccc we
> > > might see a period with 0xacc. Depending on how the hardware works we
> > > might even see 4 edges in a single period then.)
> > 
> > Yes, there is a free running counter from 0 to 4095.
> > And it is probably true, that there can be short intermediate states
> > with our two register writes.
> > 
> > There is a separate mode "Update on ACK" (MODE2 register, bit 3 "OCH"),
> > which is 0 by default (Outputs change on STOP command) but could be set
> > to 1 (Outputs change on ACK):
> > "Update on ACK requires all 4 PWM channel registers to be loaded before
> > outputs will change on the last ACK."
> 
> This sounds like it would allow atomic updates of the PWM settings.
> That's probably something that you want to implement to avoid any
> glitches.
> 
> > The chip datasheet also states:
> > "Because the loading of the LEDn_ON and LEDn_OFF registers is via the
> > I2C-bus, and asynchronous to the internal oscillator, we want to ensure
> > that we do not see any visual artifacts of changing the ON and OFF
> > values. This is achieved by updating the changes at the end of the LOW
> > cycle."
> > 
> > We could look into this in a future patch series, however I would like
> > to keep the register updating as-is for this series (otherwise I would
> > have to do all the tests with the oscilloscope again and the transitions
> > were like this since the driver was first implemented).
> 
> Yeah, it sounds fine to implement this at a later point in time. No need
> to conflate it with the current series.

Sounds good.

Thanks,
Clemens
