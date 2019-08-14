Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C38D8D7D5
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 18:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHNQRe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 12:17:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53053 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbfHNQRe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 12:17:34 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxvxo-0007I3-Ko; Wed, 14 Aug 2019 18:17:28 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxvxn-0003CC-LB; Wed, 14 Aug 2019 18:17:27 +0200
Date:   Wed, 14 Aug 2019 18:17:27 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Subject: Are the requirements of the PWM API sensible?
Message-ID: <20190814161727.ahfh6mlcbaozle3v@pengutronix.de>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <4f6e3110b4d7e0a2f7ab317bba98a933de12e5da.1565703607.git.baolin.wang@linaro.org>
 <20190813151612.v6x6e6kzxflkpu7b@pengutronix.de>
 <CAMz4kuJURx=fPE6+0gP4ukzMcXr_z3t1ZH0K3Gv6=o4Od4uc7w@mail.gmail.com>
 <20190814092339.73ybj5mycklvpnrq@pengutronix.de>
 <3181509c-a167-28c8-fb8b-947b7c72a65c@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3181509c-a167-28c8-fb8b-947b7c72a65c@ysoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Michal,

[adapted the Subject to the actual topic of this mail]

On Wed, Aug 14, 2019 at 04:07:21PM +0200, Michal Vokáč wrote:
> > Honestly I think most pwm users won't mind and they should get the
> > possibility to tell they prefer pwm_apply_state to return immediately
> > even if this could result in a spike. But we're not there yet.
> > (Actually there are three things a PWM consumer might want:
> > 
> >   a) stop immediately;
> >   b) complete the currently running period, then stop and return
> >   only
> >      when the period is completed; or
> >   c) complete the currently running period and then stop, return
> >   immediately if
> >      possible.
> > 
> > Currently the expected semantic is b).
> 
> I am sorry for interrupting your discussion. From my (last year or so)
> observation of the PWM mailing list I see this as a common pattern in
> almost every submission of a new PWM driver. That is PWM driver authors
> keep submitting solution a) and you tell them the expected behavior
> is b).

The history is that there was a discussion about something related to
the pwm-imx27 or the pwm-mxs driver between Thierry and me. I don't
remember the exact issue though. My impression back then was that
Thierry had a conception of how a PWM should work that was idealised and
hard to implement with a big part of the actually available hardware
implementations. In the end Thierry ended the discussion saying
something like: "I'm not aware that the available drivers don't fulfill
the requirements so I must assume they are right. If you know otherwise,
please tell us. I'm not willing to change the API's requirements just
because of one or two drivers having problems." (I didn't look up the
mail thread, so this is not an exact quote.)

One of these requirements was b) from above. So if you notice a common
pattern here on the list that most new drivers have problems to
implement b) I'm happy. I let you decide what this probably means for
the existing drivers.

> Why is that? I hope that the fact that implementing a) is simpler
> than b) is not the main reason. I believe that people think a)
> is the correct solution.

Honestly I think people are not aware of the requirements and/or don't
care enough about these details instead of actively being convinced that
a) is right. Their test cases are most of the time quite limited and if
the LED's brightness reacts according to the expectations the driver is
considered done.

And I agree with Thierry that in some situations it is sane to require
that periods are completed to prevent spikes. (I'm not a hardware guy,
but I think controlling a step motor is such a situation where you'd want
to prevent spikes.)

> I agree that smooth transition from one period/duty setting to
> different setting makes sense. But I also believe the expected
> behavior of setting enabled=0 is different. That is to stop
> immediately the technology that is fed by the PWM signal.
> Otherwise the concept of enabled/disabled does not make sense
> because setting duty=0 would have the same effect.

That's approximately my argumentation from back then. I asked several
times what was the difference between duty=0 and enabled=0. Thierry was
unable to come up with a better explanation but insisted there was a
difference. (Later I became aware that there is a difference, i.e. with
duty=0 the inactive time still has to be a multiple of the configured
period. So disabled is actually equivalent to duty=0 with an
infinitesimal period. Unless I missed something of course.)

I even questioned if consumers really care about a PWM going to it's
inactive level on disable and suggested to introduce something to the
PWM API to let consumers express they don't care. But the discussion
led nowhere. In my eyes the PWM framework would become better if
consumers were able to specify their intentions in a more detailed way.
Thierry didn't agree.

I think allowing lowlevel drivers to act immediately on enabled=0 would
be fine. Consumers who'd want to disable only after completion of the
currently running period could then do:

	pwm_apply(pwm, duty=0, period=dontcare, enabled=1);
	pwm_apply(pwm, duty=0, period=dontcare, enabled=0);

to achieve this completion. So after all consumers are converted the API
is more powerful than before because consumers have the choice between
the above and a single

	pwm_apply(pwm, duty=0, period=dontcare, enabled=0);

The net benefit is that consumers don't have to wait if they don't
actually care about completing the period. The downside is that all
consumers must be reviewed and maybe fixed and maybe that people's
expectations are not met anymore. (But I doubt the latter a bit because
I'm not sure that most people actually expect that pwm_apply() blocks
until the output reached its disabled state.)

And we could even go further and tell consumers who care about the
output's level should not disable the pwm but instead do

	pwm_apply(pwm, duty=0, period=1, enabled=1);

which has effectively the same semantic as enabled=0 today. This would
give at least two (probably more) PWM drivers the freedom to really
disable the hardware which might result in something different than
"inactive level" without taking the possibility from consumers to
actually request what they want.

> So I still wonder where the expectation for b) is coming from.
> What would be the physical/electrical reasoning for b)?
> Why/how it can be dangerous/harmful for any device to stop the
> PWM signal immediately?

Maybe you can get Thierry to answer this. He is the source of this
requirement.

> Would be great to finally reach consensus on that so the expected
> behavior can be documented. I know you already attempted that [1].
> I think you have done a great job but I still consider the part
> about state changes little controversial and unresolved.

I'm completely open to document the expectations. I'm also open to shift
the expectations to something that is saner and/or gives consumers more
possibilities. But it's Thierry's responsibility to go forward here or
at least stop the blockade.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
