Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D552D0D40
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 10:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgLGJoD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 04:44:03 -0500
Received: from gofer.mess.org ([88.97.38.141]:45065 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgLGJoC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Dec 2020 04:44:02 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 3F95FC63E5; Mon,  7 Dec 2020 09:43:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1607334200; bh=DZlMLoq4qsBnYniUp6Q77rn7ISx5VdIDUqFrvh/AOEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+xHZ+8qF17KHekNtmRqS2tbivtDM9fWuBXML8c90oFI1R3OhmOl06zuZnP5dtimq
         mc2xtpGxcjOFVeBFBU8vvm5oGnYb/XgXL+br2Zgo04nYiVvsKta64Xb6qMHodaq8oE
         dULjdVMELCLHys+VpxUJj99GUhMrg+NLTgW2Qsao8nAw+ICop+BQWTKEFEn5zYw0eg
         USwlhTI1zPwyLeqYABhGjrY4hdS8VBgmfXH0ydYG3ZmpwyAaVcURYMge9kgszs84vU
         EKulVtGWYjdKgLuke56HXNPknrRAVXnD50bQeWLPpgJaprX2bJlXLLbAWjxpRQIlho
         NOSnPBMfVBdKw==
Date:   Mon, 7 Dec 2020 09:43:20 +0000
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
Message-ID: <20201207094320.GA10460@gofer.mess.org>
References: <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204084417.GA2154@gofer.mess.org>
 <20201204111326.qjux6k2472dmukot@pengutronix.de>
 <20201204113846.GA6547@gofer.mess.org>
 <20201204232834.xzsafkzfmfpw7pqz@pengutronix.de>
 <20201205173444.GA1265@gofer.mess.org>
 <20201205192510.o76pjs3yc524nwvm@pengutronix.de>
 <20201206141941.GA24807@gofer.mess.org>
 <20201207081628.tm3yg7az5k5sbivu@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201207081628.tm3yg7az5k5sbivu@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hello Uwe,

Thank you for taking the time to explain your thinking.

On Mon, Dec 07, 2020 at 09:16:28AM +0100, Uwe Kleine-König wrote:
> On Sun, Dec 06, 2020 at 02:19:41PM +0000, Sean Young wrote:
> > On Sat, Dec 05, 2020 at 08:25:10PM +0100, Uwe Kleine-König wrote:
> > > On Sat, Dec 05, 2020 at 05:34:44PM +0000, Sean Young wrote:
> > > > What real life uses-cases are there for round down? If you want to round
> > > > down, is there any need for round up?
> > > 
> > > The scenario I have in mind is for driving a motor. I have to admit
> > > however that usually the period doesn't matter much and it's the
> > > duty_cycle that defines the motor's speed. So for this case the
> > > conservative behaviour is round-down to not make the motor run faster
> > > than expected.
> > 
> > I am reading here that for driving motors, only the duty cycle matters,
> > not the period.
> 
> There is an upper limit (usually around 1 ms) for the period, but if you
> choose 0.1 ms or 0.001 ms doesn't matter much AFAICT.
> 
> @Thierry: Do you have further use cases in mind?
> 
> > > For other usecases (fan, backlight, LED) exactness typically doesn't
> > > matter that much.
> > 
> > So, the use-cases you have are driving motor, fan, backlight, and led.
> > And in all these cases the exact Hz does not matter.
> > 
> > The only uses case where the exact Hz does matter is pwm-ir-tx. 
> > 
> > So, I gather there are no use-cases for round-down. Yes, should round-down
> > be needed, then this is more difficult to implement if the driver always
> > does a round-closest. But, since there is no reason to have round-down,
> > this is all academic.
> > 
> > Your policy of forcing new pwm drivers to use round-down is breaking
> > pwm-ir-tx.
> 
> So you're indeed suggesting that the "right" rounding strategy for
> lowlevel drivers should be:
> 
>  - Use the period length closest to the requested period (in doubt round
>    down?)
>  - With the chosen period length use the biggest duty_cycle not bigger
>    than the requested duty_cycle.
> 
> While this seems technically fine I think for maintenance this is a
> nightmare.
> 
> My preference would be to stick to the rounding strategy we used so far
> (i.e.:
> 
>  - Use the biggest period length not bigger than the requested period
>  - With the chosen period length use the biggest duty_cycle not bigger
>    than the requested duty_cycle.
> 
> ) and for pwm-ir-tx add support to the PWM API to still make it possible
> (and easy) to select the best setting.
> 
> The reasons why I think that this rounding-down strategy is the best
> are (in order of importance):
> 
>  - It is easier to implement correctly [1]

Yes, you are right. You have given a great example where a simple
DIV_ROUND_CLOSEST() does not give the result you want.

>  - Same rounding method for period and duty cycle
>  - most drivers already do this (I think)
> 
> The (IMHO nice) result would then mean:
> 
>  - All consumers can get the setting they want; and

Once there is a nice pwm api for selecting round-nearest, then yes.

For the uses cases you've given, fan, backlight, and led a round-nearest
is the rounding they would want, I would expect.

>  - Code in lowlevel drivers is simple and the complexity is in common
>    code and so a single place.
> 
> And it would also allow the pwm-ir-tx driver to notice if the PWM to be
> used can for example only support frequencies under 400 kHz.

I doubt pwm-ir-tx cares about this, however it is a nice-to-have. It would
also be nice if the rounding could be used with atomic configuration
as well.

Please let me know when/if this new API exists for pwm so that pwm-ir-tx
can select the right rounding.

> [1] Consider a PWM with a parent frequency of 66 MHz, to select the
>     period you can pick an integer divider "div" resulting in the period
>     4096 / (pclk * d). So the obvious implementation for round-nearest
>     would be:
> 
>     	pclk = clk_get_rate(myclk);
> 	div = DIV_ROUND_CLOSEST(NSEC_PER_SEC * 4096, targetperiod * pclk);

Note NSEC_PER_SEC * 4096 >> 2^32 so this would need to be
DIV_ROUND_CLOSEST_ULL.

>     , right?
> 
>     With targetperiod = 2641 ns this picks div = 23 and so a period of
>     2698.2872200263505 ns (delta = 57.2872200263505 ns).
>     The optimal divider however is div = 24. (implemented period =
>     2585.8585858585857 ns, delta = 55.14141414141448 ns)
> 
>     For round-down the correct implementation is:
> 
>     	pclk = clk_get_rate(myclk);
> 	div = DIV_ROUND_UP(NSEC_PER_SEC * 4096, targetperiod * pclk);
> 
>     Exercise for the reader: Come up with a correct implementation for
>     "round-nearest" and compare its complexity to the round-down code.

To be fair, I haven't been been able to come up with a solution without
control flow.

Thank you for an interesting conversation about this.

 
Sean
