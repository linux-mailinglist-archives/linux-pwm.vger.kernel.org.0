Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D896D376841
	for <lists+linux-pwm@lfdr.de>; Fri,  7 May 2021 17:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhEGPtB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 May 2021 11:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhEGPtB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 May 2021 11:49:01 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182FAC061574;
        Fri,  7 May 2021 08:48:00 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 83B16C7C83F;
        Fri,  7 May 2021 17:47:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1620402479;
        bh=D78XQuP9OmKTktvVwykbFr4BP1uaTHL4s+99yRdIE0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lsXeHsM1DFRUM6MB4n48XeOl470Vi59GlqpwGEf7/wjatHf5xhlpErJgVIuBbvSS/
         98JVtRL7oUl8kZd33r8Xt+gEdcFPU7Qa2oXshAN139IiZw/sbSBT5bCIKuZSFZZHmM
         J+u/A6+//+qFxfqb+ndtY9gDFbraNpBUr47374xE=
Date:   Fri, 7 May 2021 17:47:58 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/4] pwm: core: Support new usage_power setting in PWM
 state
Message-ID: <YJVhLrkeNXBp6M1p@workstation.tuxnet>
References: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
 <20210507150317.bnluhqrqepde4xjm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210507150317.bnluhqrqepde4xjm@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Fri, May 07, 2021 at 05:03:17PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, May 07, 2021 at 03:18:42PM +0200, Clemens Gruber wrote:
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index 5bb90af4997e..5a73251d28e3 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -54,12 +54,17 @@ enum {
> >   * @duty_cycle: PWM duty cycle (in nanoseconds)
> >   * @polarity: PWM polarity
> >   * @enabled: PWM enabled status
> > + * @usage_power: If set, the PWM driver is only required to maintain the power
> > + *               output but has more freedom regarding signal form.
> > + *               If supported, the signal can be optimized, for example to
> > + *               improve EMI by phase shifting individual channels.
> >   */
> >  struct pwm_state {
> >  	u64 period;
> >  	u64 duty_cycle;
> >  	enum pwm_polarity polarity;
> >  	bool enabled;
> > +	bool usage_power;
> >  };
> >  
> >  /**
> 
> If we really want to support this usecase, I would prefer to not have it
> in pwm_state because this concept is not a property of the wave form. So
> for a driver it doesn't really make sense to set this flag in
> .get_state().

It is related to the wave form in so far as it allows the driver to
change the wave form as long as the power output remains the same.

> Maybe it makes more sense to put this in a separate argument for a
> variant of pwm_apply_state? something like:
> 
> 	int pwm_apply_state_transition(struct pwm_device *pwm, const struct pwm_state *state, const struct pwm_state_transition *transition);
> 
> and pwm_state_transition can then contain something like this usage
> power concept and maybe also a sync flag that requests that the call
> should only return when the new setting is active and maybe also a
> complete_period flag that requests that the currently running period
> must be completed before the requested setting is implemented.
> 
> OTOH the information "I only care about the relative duty cycle" is
> relevant longer than during the transition to a new setting. (So if
> there are two consumers and one specified to be only interested in the
> relative duty cycle, the other might be allowed to change the common
> period.)

As you said, usage_power does not only apply to one state transition.


> Having said that, I don't like the proposed names. Neither "usage_power"
> nor "pwm_apply_state_transition".
> 
> In a non-representative survey among two hardware engineers and one
> software engineer who already contributed to PWM (!= me) I found out
> that these three have an intuitive right understanding of
> "allow-phase-shift" but have no idea what "usage-power" could mean.

One advantage of usage_power is that it is not limited to phase
shifting. Drivers could do other optimizations as long as the power
output remains the same.


> On a side note: The hardware guys noted that it might make sense to
> align the shifted phases. i.e. instead of shifting channel i by i *
> period/16, it might be better to let the 2nd channel get active when the
> first gets inactive. (i.e. try to keep the count of active channels
> constant).

I am not sure what you mean exactly, because the duty cycles of the
16 outputs are not necessarily the same and can all be active at the
same time. The idea is to spread the edges out as evenly as possible.
Shifting them by period/16 is the best way to smoothen the current
spikes in my opinion and the implementation is also very simple.


> And as already mentioned earlier I still think we should define the
> concept of "usage power" better. It should be clearly defined for a
> driver author which setting they should pick for a given request. This
> removes surprises for consumers and guessing for lowlevel driver
> authors. Also a uniform policy brings conflicts better to light.
> (Something like driver A does the right thing for consumer C and driver
> B makes it right for D. But once D tries to use A things break. (And
> then maybe A is changed to fit D, and C doesn't object because they
> don't read the pwm list resulting in a breakage for C later.))

I added documentation and comments to the header file as a first step
but we can always improve them.

Thanks,
Clemens
