Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080672CFD19
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Dec 2020 19:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgLESTc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Dec 2020 13:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgLERqn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Dec 2020 12:46:43 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DC7C02B8FE;
        Sat,  5 Dec 2020 09:34:49 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 1ED13C639A; Sat,  5 Dec 2020 17:34:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1607189685; bh=6K7rElBSPR0xQZSNaofGRSbOXAKySpe+Vw6VI3vdyrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GuU3zNBZWHPF7qaWhhfXa15c6kmv2VK/HjcdVunPrrV6X6FPpgNhe02+u0ADm6bN+
         fFxdZbwvpQjI7DoWRZh4StWkkppCzres+Ee3VGjCmZaN2pCZCVPJzLxSPeLbQP2G3X
         A11a1KNCRYvbjCIxU9xNMrRQZWretOOz92+DXluXXwb6NaQQwyo0esa6WwtZf8+dxf
         3TkiW/vkLI+biEw9Wz5Uswi5/MqOy3YoUtexogL/qFVexkHDUUpnX+bnAIJ/9YrnRO
         hKh6MNMsC5xQTLb+CW7ieU2GRkh5XG5gdpmll12N70Ly3pNwgx3sCDmHn7ye6VuUG7
         /DJ1ZnrF31/Hw==
Date:   Sat, 5 Dec 2020 17:34:44 +0000
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
Message-ID: <20201205173444.GA1265@gofer.mess.org>
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204084417.GA2154@gofer.mess.org>
 <20201204111326.qjux6k2472dmukot@pengutronix.de>
 <20201204113846.GA6547@gofer.mess.org>
 <20201204232834.xzsafkzfmfpw7pqz@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201204232834.xzsafkzfmfpw7pqz@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

On Sat, Dec 05, 2020 at 12:28:34AM +0100, Uwe Kleine-König wrote:
> Hello Sean,
> 
> On Fri, Dec 04, 2020 at 11:38:46AM +0000, Sean Young wrote:
> > On Fri, Dec 04, 2020 at 12:13:26PM +0100, Uwe Kleine-König wrote:
> > > On Fri, Dec 04, 2020 at 08:44:17AM +0000, Sean Young wrote:
> > > > On Fri, Dec 04, 2020 at 12:42:15AM +0100, Lino Sanfilippo wrote:
> > > > > > You're storing an unsigned long long (i.e. 64 bits) in an u32. If
> > > > > > you are sure that this won't discard relevant bits, please explain
> > > > > > this in a comment for the cursory reader.
> > > > > 
> > > > > > Also note that round_closed is probably wrong, as .apply() is
> > > > > > supposed to round down the period to the next achievable period. (But
> > > > > > fixing this has to do done in a separate patch.)
> > > > > 
> > > > > According to commit 11fc4edc4 rounding to the closest integer has been introduced
> > > > > to improve precision in case that the pwm controller is used by the pwm-ir-tx driver.
> > > > > I dont know how strong the requirement is to round down the period in apply(), but I
> > > > > can imagine that this may be a good reason to deviate from this rule.
> > > > > (CCing Sean Young who introduced DIV_ROUND_CLOSEST)
> > > > 
> > > > There was a problem where the carrier is incorrect for some IR hardware
> > > > which uses a carrier of 455kHz. With periods that small, rounding errors
> > > > do really matter and rounding down might cause problems.
> > > > 
> > > > A policy of rounding down the carrier is not the right thing to do
> > > > for pwm-ir-tx, and such a change will probably break pwm-ir-tx in some
> > > > edge cases.
> > > 
> > > IMO it's not an option to say: pwm-driver A is used for IR, so A's
> > > .apply uses round-nearest and pwm-driver B is used for $somethingelse,
> > > so B's .apply uses round-down.
> > 
> > I'm not saying that one driver should have one it one way and another driver
> > another way.
> 
> I read between your lines that you think that round-nearest is the
> single best strategy, is that right?

Certain the default strategy. When setting a pwm of period X, I would
expect it set it to the closest period it can match to X. Doing anything
else by default is a surprising API.

What real life uses-cases are there for round down? If you want to round
down, is there any need for round up?

Hypothetically you may want e.g. nearest to 100kHz but absolutely no less
than 100kHz. I don't know when this comes up, it would be interesting to
hear where this is needed.

In fact, I am not sure you can guarantee this; when programming the hardware 
there is some division arithmetic which may do some rounding and you'll end
up with slightly more than 100kHz.

Equally, you way want e.g. nearest 1MHz but absolutely no more than 1MHz.
This would require round-up for the period.

> If you have two consumer drivers and one requires round-nearest and the
> other requires round-down, how would you suggest to implement these two?

So when does really happen?

> Always adapting the low-level driver depending on which consumer is in
> use sounds wrong. So I conclude that the expectation about the
> implemented rounding behaviour should be the same for all drivers.

Agreed.

> And
> if your consumer happens to require a different strategy you're either
> out of luck (bad), or we need to expand the PWM API to make this
> possible, probably by implementing a round_state callback that tells the
> caller the resulting state if the given state is applied.

Agreed.

> > Why is is easier to implement?
> 
> If pwm_apply_state (and so pwm_round_state) rounds down, you can achieve
> round-nearest (simplified: Ignoring polarity, just looking for period) using:
> 
> 	lower_state = pwm_round_state(pwm, target_state);
> 	upper_state = {
> 		.period = 2 * target_state.period - lower_state.period,
> 		...
> 	}
> 	tmp = pwm_round_state(pwm, upper)
> 
> 	if tmp.period < target_state.period:
> 		# tmp == lower_state
> 		return lower_state
> 
> 	else while tmp.period > target_state.period:
> 		upper = tmp;
> 		tmp.period -= 1
> 		tmp = pwm_round_state(pwm, tmp)
> 
> I admit it is not pretty. But please try to implement it the other way
> around (i.e. pwm_round_state rounding to nearest and search for a
> setting that yields the biggest period not above target.period without
> just trying all steps). I spend a few brain cycles and the corner cases
> are harder. (But maybe I'm not smart enough, so please convince me.)

Ok. Does pwm hardware always work on a linear scale?

> Note that with round-nearest there is another complication: Assume a PWM
> that can implement period = 500 µs and period = 1000 µs (and nothing
> inbetween). That corresponds to the frequencies 2000 Hz and 1000 Hz.
> round_nearest for state with period = 700 µs (corresponding to 1428.5714
> Hz) would then pick 500 µs (corresponding to 2000 Hz), right? So is
> round-nearest really what you prefer?

That is an interesting point. So, I guess the question is: do you want the
nearest period or the nearest frequency.

> > > and for consumers like the IR stuff we need to provide some more
> > > functions to allow it selecting a better suited state. Something like:
> > > 
> > > 	pwm_round_state_nearest(pwm, { .period = 2198, .. }, &state)
> > > 
> > > which queries the hardwares capabilities and then assigns state.period =
> > > 2200 instead of 2100.
> > 
> > This is very elaborate and surely not "easier to implement". Why not just
> > do the right thing in the first place and round-closest?
> 
> I looked through the history of drivers/pwm for commits changing the
> rounding behaviour. I found:
> 
>  - 11fc4edc483 which changes bcm2835 from round-down to round-closest
>    (I didn't check but given that the driver divides by the result of a
>    division the rounding might not always be round-closest.)
>  - 12f9ce4a519 which changes pwm-rockchip from round-down to
>    round-closest
>    (The motivation described in the commit log is wrong today as
>    pwm_get_state() gives the last set value, not the result of the
>    lowlevel driver's .get_state callback. Also this problem can be fixed
>    with drivers implementing round-down by just letting .get_state round
>    up. (Which by the way is how I recommend how to implement it when
>    reviewing new drivers.))
> 
> Did I miss something?
> 
> For a quick (and maybe unreliable) overview:
> 
> 	$ git grep -l _CLOSEST drivers/pwm/ | wc -l
> 	15
> 
> so we might have 15 drivers that round to nearest and the remaining 40
> round down. (I checked a few and didn't find a false diagnose.)
> 
> For me this isn't a clear indication that round-nearest is
> unconditionally better.

Just because some drivers don't use DIV_ROUND_CLOSEST() doesn't mean
it was considered by the driver author.

I think some drivers use DIV_ROUND_UP, e.g. pwm-sl28cpld.c.

So there is no concensus between the pwm drivers as to what should be the
default.

> What is the fact that convinces you that
> round-nearest is better in general?

Surely the general use-case is match frequency (or period!) as closely
as possible. What is the use-case for round-period-down and how common
is this? What about round-period-up? Why would you want to do round up/down
at all?


Thanks

Sean
