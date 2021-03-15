Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F0333A96D
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Mar 2021 02:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhCOByP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Mar 2021 21:54:15 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:31985 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229679AbhCOBxl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Mar 2021 21:53:41 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Mar 2021 18:53:41 -0700
X-QCInternal: smtphost
Received: from gurus-linux.qualcomm.com (HELO gurus-linux.localdomain) ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 14 Mar 2021 18:53:41 -0700
Received: by gurus-linux.localdomain (Postfix, from userid 383780)
        id 33C0E19B3; Sun, 14 Mar 2021 18:53:41 -0700 (PDT)
Date:   Sun, 14 Mar 2021 18:53:41 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: soften potential loss of precision in compat code
Message-ID: <20210315015340.GA6138@codeaurora.org>
References: <20210308092322.24502-1-u.kleine-koenig@pengutronix.de>
 <20210311210639.GA29363@codeaurora.org>
 <20210312071233.wgd2fkeznh7xjv7y@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210312071233.wgd2fkeznh7xjv7y@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Mar 12, 2021 at 08:12:33AM +0100, Uwe Kleine-König wrote:
> On Thu, Mar 11, 2021 at 01:06:39PM -0800, Guru Das Srinagesh wrote:
> > On Mon, Mar 08, 2021 at 10:23:22AM +0100, Uwe Kleine-König wrote:
> > >  		if (state->period != pwm->state.period ||
> > >  		    state->duty_cycle != pwm->state.duty_cycle) {
> > > +			int duty_cycle, period;
> > > +
> > > +			if (state->period < INT_MAX)
> > > +				period = state->period;
> > > +			else
> > > +				period = INT_MAX;
> > 
> > Using a MIN() macro here might improve readability:
> > 	period = MIN(state->period, INT_MAX);
> 
> Which MIN macro. There are 17 defined in the kernel and none of them in
> a header that could be sensibly included by this code.
> 
> There are some helpers in <linux/minmax.h> which would result in:
> 
> 	period = min_t(u64, state->period, INT_MAX)
> 
> or
> 
> 	period = min(state->period, (u64)INT_MAX);
> 
> . I don't feel strong here, my initial variant needs more vertical space
> but might be a tad easier to understand. In retrospect I'd say that
> adding a comment would be more imporant than how to actually calculate
> the value, something like:
> 
> 	/*
> 	 * The legacy callbacks use only (signed!) int for period and
> 	 * duty_cycle compared to u64 in struct pwm_state. So clamp the
> 	 * values to INT_MAX.
> 	 */
> 
> Sounds sensible?

Yes, I agree.

Guru Das.
