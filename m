Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B339D351C29
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Apr 2021 20:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhDASNr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Apr 2021 14:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbhDASJj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Apr 2021 14:09:39 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557BBC022586;
        Thu,  1 Apr 2021 08:19:50 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 7EF5EC72850;
        Thu,  1 Apr 2021 17:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617290382;
        bh=tT0FEIHy1AZG5V42yfNXqku3bOLvq1PgHkhzVzYTvoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1dkgjXALuojsa/8H3J4tpOlwOsclnmnNwYW4IqBA+2nUaoWknHXtj4UheHJBG0kb
         obZ4FSYK1lhhuc4DfU0rUy/U+dOZ8yoi2qj2TVyq0yJWGcv6QDahJm5Wg7koSHvOXJ
         CdpC7TBrm87nec9q3KTXv25F3l0+VxTDMZOHpu00=
Date:   Thu, 1 Apr 2021 17:19:40 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pwm: pca9685: Support staggered output ON times
Message-ID: <YGXkjLDl/A0LpjXg@workstation.tuxnet>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-4-clemens.gruber@pqgruber.com>
 <20210329170357.par7c3izvtmtovlj@pengutronix.de>
 <YGILdjZBCc2vVlRd@workstation.tuxnet>
 <20210329180206.rejl32uajslpvbgi@pengutronix.de>
 <YGRqZsi4WApZcwIT@workstation.tuxnet>
 <YGShjDE8R31LwAbi@orome.fritz.box>
 <YGV7VJ72nWDIjNbu@workstation.tuxnet>
 <YGXO7oKWPjYYrVFy@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YGXO7oKWPjYYrVFy@orome.fritz.box>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 01, 2021 at 03:47:26PM +0200, Thierry Reding wrote:
> On Thu, Apr 01, 2021 at 09:50:44AM +0200, Clemens Gruber wrote:
> > Hi Thierry,
> > 
> > On Wed, Mar 31, 2021 at 06:21:32PM +0200, Thierry Reding wrote:
> > > On Wed, Mar 31, 2021 at 02:26:14PM +0200, Clemens Gruber wrote:
> > > > On Mon, Mar 29, 2021 at 08:02:06PM +0200, Uwe Kleine-König wrote:
> > > > > On Mon, Mar 29, 2021 at 07:16:38PM +0200, Clemens Gruber wrote:
> > > > > > On Mon, Mar 29, 2021 at 07:03:57PM +0200, Uwe Kleine-König wrote:
> > > > > > > On Mon, Mar 29, 2021 at 02:57:04PM +0200, Clemens Gruber wrote:
> > > > > > > > The PCA9685 supports staggered LED output ON times to minimize current
> > > > > > > > surges and reduce EMI.
> > > > > > > > When this new option is enabled, the ON times of each channel are
> > > > > > > > delayed by channel number x counter range / 16, which avoids asserting
> > > > > > > > all enabled outputs at the same counter value while still maintaining
> > > > > > > > the configured duty cycle of each output.
> > > > > > > > 
> > > > > > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > > > > > 
> > > > > > > Is there a reason to not want this staggered output? If it never hurts I
> > > > > > > suggest to always stagger and drop the dt property.
> > > > > > 
> > > > > > There might be applications where you want multiple outputs to assert at
> > > > > > the same time / to be synchronized.
> > > > > > With staggered outputs mode always enabled, this would no longer be
> > > > > > possible as they are spread out according to their channel number.
> > > > > > 
> > > > > > Not sure how often that usecase is required, but just enforcing the
> > > > > > staggered mode by default sounds risky to me.
> > > > > 
> > > > > There is no such guarantee in the PWM framework, so I don't think we
> > > > > need to fear breaking setups. Thierry?
> > > > 
> > > > Still, someone might rely on it? But let's wait for Thierry's opinion.
> > > 
> > > There's currently no way to synchronize two PWM channels in the PWM
> > > framework. And given that each PWM channel is handled separately the
> > > programming for two channels will never happen atomically or even
> > > concurrently, so I don't see how you could run two PWMs completely
> > > synchronized to one another.
> > 
> > As the PCA9685 has only one prescaler and one counter per chip, by
> > default, all PWMs enabled will go high at the same time. If they also
> > have the same duty cycle configured, they also go low at the same time.
> 
> What happens if you enable one of them, it then goes high and then you
> enable the next one? Is the second one going to get enabled on the next
> period? Or will it start in the middle of the period?

The channel configuration is updated at the end of the low cycle of the
channel in question and if the counter is already past the ON time, it
will start with the next period. So the second one should never start
while the first one is high (unless staggering mode is enabled).

> To truly enable them atomically, you'd have to ensure they all get
> enabled in basically the same write, right? Because otherwise you can
> still end up with just a subset enabled and the rest getting enabled
> only after the first period.

Yes. This could probably be achieved with auto-increment for consecutive
channels or with the special ALL channel for all channels.

In our usecases this is not required. I'd still like to send a follow up
patch in the future that at least implements the register writes per
channel with auto increment to not have intermediate states (due to high
and low byte being written separately)

> > > Or did I misunderstand and it's only the start time of the rising edge
> > > that's shifted, but the signal will remain high for a full duty cycle
> > > after that and then go down and remain low for period - duty - offset?
> > 
> > Yes, that's how it works.
> 
> That's less problematic because the signal will remain a standard PWM,
> it's just shifted by some amount. Technically pwm_apply_state() must
> only return when the signal has been enabled, so very strictly speaking
> you'd have to wait for a given amount of time to ensure that's correct.
> But again, I doubt that any use-case would require you to be that
> deterministic.

Yes, probably not and if we make it opt-in, it shouldn't be a problem.

> 
> > > That's slightly better than the above in that it likely won't trip up
> > > any consumers. But it might still be worth to make this configurable per
> > > PWM (perhaps by specifying a third specifier cell, in addition to the
> > > period and flags, that defines the offset/phase of the signal).
> > > 
> > > In both cases, doing this on a per-PWM basis will allow the consumer to
> > > specify that they're okay with staggered mode and you won't actually
> > > force it onto anyone. This effectively makes this opt-in and there will
> > > be no change for existing consumers.
> > 
> > I agree that it should be opt-in, but I am not sure about doing it
> > per-pwm:
> > The reason why you'd want staggered mode is to reduce EMI or current
> > spikes and it is most effective if it is enabled for all PWMs.
> > 
> > If it is specified in the DT anyway and you have a consumer that does
> > not support staggered mode (probably rare but can happen), then I'd
> > suggest just disabling it globally by not specifying nxp,staggered-mode;
> > 
> > Also it would make the configuration more complicated: You have to do
> > the "staggering" yourself and assign offsets per channel.
> > It's certainly easier to just enable or disable it.
> > 
> > What do you think?
> 
> Yeah, if you use an offset in the PWM specifier, users would have to
> manually specify the offset. An interesting "feature" of that would be
> that they could configure a subset of PWM channels to run synchronized
> (module the atomicity problems discussed above). Not sure if that's
> something anyone would ever want to do.

Yes and for the common case where you don't care it would be more work
for the user.

> 
> Another option would be to add some new flag that specifies that a given
> PWM channel may use this mode. In that case users wouldn't have to care
> about specifying the exact offset and instead just use the flag and rely
> on the driver to pick some offset. Within the driver you could then just
> keep the same computation that offsets by channel index, or you could
> have any other mechanism that you want.

OK, so maybe a PWM_STAGGERING_ALLOWED flag in dt-bindings/pwm/pwm.h,
pass it through via a new bool staggering_allowed in struct pwm_args?

Thanks,
Clemens
