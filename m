Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24342D1860
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 19:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgLGSSs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 13:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLGSSr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 13:18:47 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D00C061749;
        Mon,  7 Dec 2020 10:18:07 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 7AFADC638E; Mon,  7 Dec 2020 18:18:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1607365083; bh=aTSDI8UqWPGA6F2iy6N5PWwkwrk6VMgzATi9jVD/WNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GI8vmkvI1DBeRKhC57wPyvnLU6musqd5kvAq1Zl5RKoyoi9e27aT/whYI4W56Gs8b
         6EPgv0e9UkLz5xVRuqeJiBSDObvKaxoaU9L9P+OhCtxRT35B+o4HpMS/n8RINQsF3o
         3ylyefqK6ds7O8zulImV220psCcopEcbddDhg5tQ/7gufd4iu9BFxW+9jpGkbTFH7N
         BnJ4qbBEGizs6u+TOI5ptifIXzVVYCh0ls9OuibKUxD+1fYFkCCCNPRq0spkaxG75F
         RkLMrn+tYfx15eGtT49xgmZxXGQnwaEwCMne1cdux/a5H755m3IHlpQY3qV+msr6nK
         GMVerLzy5n0MQ==
Date:   Mon, 7 Dec 2020 18:18:03 +0000
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
Message-ID: <20201207181803.GA18865@gofer.mess.org>
References: <20201204084417.GA2154@gofer.mess.org>
 <20201204111326.qjux6k2472dmukot@pengutronix.de>
 <20201204113846.GA6547@gofer.mess.org>
 <20201204232834.xzsafkzfmfpw7pqz@pengutronix.de>
 <20201205173444.GA1265@gofer.mess.org>
 <20201205192510.o76pjs3yc524nwvm@pengutronix.de>
 <20201206141941.GA24807@gofer.mess.org>
 <20201207081628.tm3yg7az5k5sbivu@pengutronix.de>
 <20201207094320.GA10460@gofer.mess.org>
 <20201207135209.htp7plyotjxp37q2@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201207135209.htp7plyotjxp37q2@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Dec 07, 2020 at 02:52:09PM +0100, Uwe Kleine-König wrote:
> On Mon, Dec 07, 2020 at 09:43:20AM +0000, Sean Young wrote:
> > On Mon, Dec 07, 2020 at 09:16:28AM +0100, Uwe Kleine-König wrote:
> > > On Sun, Dec 06, 2020 at 02:19:41PM +0000, Sean Young wrote:
> > > > On Sat, Dec 05, 2020 at 08:25:10PM +0100, Uwe Kleine-König wrote:
> > > > > On Sat, Dec 05, 2020 at 05:34:44PM +0000, Sean Young wrote:
> > > > > > What real life uses-cases are there for round down? If you want to round
> > > > > > down, is there any need for round up?
> > > > > 
> > > > > The scenario I have in mind is for driving a motor. I have to admit
> > > > > however that usually the period doesn't matter much and it's the
> > > > > duty_cycle that defines the motor's speed. So for this case the
> > > > > conservative behaviour is round-down to not make the motor run faster
> > > > > than expected.
> > > > 
> > > > I am reading here that for driving motors, only the duty cycle matters,
> > > > not the period.
> > > 
> > > There is an upper limit (usually around 1 ms) for the period, but if you
> > > choose 0.1 ms or 0.001 ms doesn't matter much AFAICT.
> > > 
> > > @Thierry: Do you have further use cases in mind?
> 
> I asked in the hardware department of the company I work for and they
> had another usecase: Motors where for example a 1 ms pulse means "move
> forwards" and 2 ms means "move backwards". They had the same idea as I
> had: You want to know beforehand the result of a given
> pwm_apply_state().

That sounds good, that would be nice.

> > > > > For other usecases (fan, backlight, LED) exactness typically doesn't
> > > > > matter that much.
> > > > 
> > > > So, the use-cases you have are driving motor, fan, backlight, and led.
> > > > And in all these cases the exact Hz does not matter.
> > > > 
> > > > The only uses case where the exact Hz does matter is pwm-ir-tx. 
> > > > 
> > > > So, I gather there are no use-cases for round-down. Yes, should round-down
> > > > be needed, then this is more difficult to implement if the driver always
> > > > does a round-closest. But, since there is no reason to have round-down,
> > > > this is all academic.
> > > > 
> > > > Your policy of forcing new pwm drivers to use round-down is breaking
> > > > pwm-ir-tx.
> > > 
> > > So you're indeed suggesting that the "right" rounding strategy for
> > > lowlevel drivers should be:
> > > 
> > >  - Use the period length closest to the requested period (in doubt round
> > >    down?)
> > >  - With the chosen period length use the biggest duty_cycle not bigger
> > >    than the requested duty_cycle.
> > > 
> > > While this seems technically fine I think for maintenance this is a
> > > nightmare.
> > > 
> > > My preference would be to stick to the rounding strategy we used so far
> > > (i.e.:
> > > 
> > >  - Use the biggest period length not bigger than the requested period
> > >  - With the chosen period length use the biggest duty_cycle not bigger
> > >    than the requested duty_cycle.
> > > 
> > > ) and for pwm-ir-tx add support to the PWM API to still make it possible
> > > (and easy) to select the best setting.
> > > 
> > > The reasons why I think that this rounding-down strategy is the best
> > > are (in order of importance):
> > > 
> > >  - It is easier to implement correctly [1]
> > 
> > Yes, you are right. You have given a great example where a simple
> > DIV_ROUND_CLOSEST() does not give the result you want.
> > 
> > >  - Same rounding method for period and duty cycle
> > >  - most drivers already do this (I think)
> > > 
> > > The (IMHO nice) result would then mean:
> > > 
> > >  - All consumers can get the setting they want; and
> > 
> > Once there is a nice pwm api for selecting round-nearest, then yes.
> > 
> > For the uses cases you've given, fan, backlight, and led a round-nearest
> > is the rounding they would want, I would expect.
> 
> maybe, yes. Maybe it is also not important enough to spend the extra
> cycles getting round nearest and so sticking to round-down is good
> enough.
> 
> > >  - Code in lowlevel drivers is simple and the complexity is in common
> > >    code and so a single place.
> > > 
> > > And it would also allow the pwm-ir-tx driver to notice if the PWM to be
> > > used can for example only support frequencies under 400 kHz.
> > 
> > I doubt pwm-ir-tx cares about this, however it is a nice-to-have. It would
> > also be nice if the rounding could be used with atomic configuration
> > as well.
> 
> I cannot follow, you created 11fc4edc483bea8bf0efa0cc726886d2342f6fa6
> because 476.2 Mhz was too bad. So you seem to be interested in
> deviations and part of the problem is that you don't get feedback about
> how your request is fulfilled.

Right, that's true.

> > Please let me know when/if this new API exists for pwm so that pwm-ir-tx
> > can select the right rounding.
> 
> Given that the bcm2835 driver is quite trivial I would be happy to
> create a series that "fixes" the driver to round down and provide a
> prototype for pwm_round_nearest for you to test on pwm-ir-tx. A willing
> tester and a real use-case were the single two things that stopped me
> investing time here.

pwm-ir-tx does not just use the bcm2845 driver/rpi. There is the
Firefly ROC-RK3308-CC board which uses pwm-ir-tx with a different pwm
dirver.

Also all you need is a infrared led, and a resistor to stop the led from
burning out, to create your own infrared emitter. So, users can easily
add pwm-ir-tx to their systems.

Having said that I'm happy to test the rpi. I would attach a logic analyser
and check the period.


Sean
