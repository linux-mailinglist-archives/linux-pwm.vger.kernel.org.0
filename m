Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AEA3521C1
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Apr 2021 23:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhDAVha (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Apr 2021 17:37:30 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:35812 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234867AbhDAVha (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 1 Apr 2021 17:37:30 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 283B4C729F1;
        Thu,  1 Apr 2021 23:37:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617313049;
        bh=p5kZuTveqp9eRTnaDLrAtIqVsVynuwzgYhc+h/xNDjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=piYrk7f9OePKMTA0TFuLiwU8zJBtJa5jsOWuSdWFvBt3pxSmbgGkLUtmTlQbwQK1m
         99Sp+s9UIOi8P7a+QBvi96rms+ncjywXO3fx4seqATP53iYLEBP3hkPAuOdxt7fMst
         TpW6H5ki02K99zx73UWIMzpbNVJvSMKtwbHNK8p4=
Date:   Thu, 1 Apr 2021 23:37:27 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pwm: pca9685: Support staggered output ON times
Message-ID: <YGY9F9PNW8lz4vrS@workstation.tuxnet>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-4-clemens.gruber@pqgruber.com>
 <20210329170357.par7c3izvtmtovlj@pengutronix.de>
 <YGILdjZBCc2vVlRd@workstation.tuxnet>
 <20210329180206.rejl32uajslpvbgi@pengutronix.de>
 <YGRqZsi4WApZcwIT@workstation.tuxnet>
 <20210401205819.soloiozcrgq4eool@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401205819.soloiozcrgq4eool@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

On Thu, Apr 01, 2021 at 10:58:19PM +0200, Uwe Kleine-König wrote:
> Hello Clemens,
> 
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
> Someone might rely on the pca9685 driver being as racy as a driver with
> legacy bindings usually is. Should this be the reason to drop this whole
> series?

That's not really a fair comparison. I just don't want the whole
staggering mode patch to get reverted someday because it broke someone's
setup. If it is opt-in, something like that can't happen.

If you say that we don't have to care about usecases that are not
officialy guaranteed by the framework, then I'm fine with enabling it by
default.

But in the meantime, Thierry also argued against enabling it by default.

> 
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
> This is about the ACK and STOP in the i2c communication, right? I fail
> to understand the relevance of this difference. I guess I have to read
> the manual myself.

Yes. Not sure why they added the other mode myself, as you should be
able to send multiple bytes before the STOP with auto-increment as well.
But I did not try this out yet as this won't go into this series anyway.
I will look into it in more detail and do some experiments as soon as
this series is merged.

>  
> > The chip datasheet also states:
> > "Because the loading of the LEDn_ON and LEDn_OFF registers is via the
> > I2C-bus, and asynchronous to the internal oscillator, we want to ensure
> > that we do not see any visual artifacts of changing the ON and OFF
> > values. This is achieved by updating the changes at the end of the LOW
> > cycle."
> 
> So we're only out of luck if the first register write happens before and
> the second after the end of the LOW cycle, aren't we?

Yes. And this will be fixed with the auto-increment feature when we can
write all registers in one transaction.

Thanks,
Clemens
