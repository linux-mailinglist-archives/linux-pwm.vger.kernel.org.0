Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76DC2D2898
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 11:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgLHKNC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 05:13:02 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:42064 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728623AbgLHKNC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 8 Dec 2020 05:13:02 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 10EDCC81EEA;
        Tue,  8 Dec 2020 11:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1607422340;
        bh=9sTNjQjtWbr4N0B4GN2Kw1dncJZBpW6+Za2GoBgyLO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZBEcD4EV639kI/UJ0mgGuObYNkkXGo0Vh8H385stpao1hF8YQwmOb7XRJ5ON6uSU
         OKVhRY8A+80zui50EoLUObG5KGFo0iwHApWg9w21xiD1GiKr1wIKpjgc5kDT+wZgQs
         7P/Zut6rhZPXeKOGhtNbKeRzJKjij00HuB1o8ZrE=
Date:   Tue, 8 Dec 2020 11:12:18 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <X89RgpTb3sBBI++w@workstation.tuxnet>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
 <X863KNo0IaekkU7q@workstation.tuxnet>
 <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

On Tue, Dec 08, 2020 at 10:10:33AM +0100, Uwe Kleine-König wrote:
> Hello Clemens,
> 
> On Tue, Dec 08, 2020 at 12:13:44AM +0100, Clemens Gruber wrote:
> > On Mon, Dec 07, 2020 at 11:00:25PM +0100, Uwe Kleine-König wrote:
> > > On Mon, Dec 07, 2020 at 08:36:27PM +0100, Clemens Gruber wrote:
> > > > The hardware readout may return slightly different values than those
> > > > that were set in apply due to the limited range of possible prescale and
> > > > counter register values. If one channel is reconfigured with new duty
> > > > cycle and period, the others will keep the same relative duty cycle to
> > > > period ratio as they had before, even though the per-chip / global
> > > > frequency changed. (The PCA9685 has only one prescaler!)
> > > 
> > > This is not acceptable, if you have two PWM outputs and a consumer
> > > modifies one of them the other must change. So if this chip only
> > > supports a single period length of all channels, the first consumer
> > > enabling a channel defines the period to be used. All later consumers
> > > must live with that. (Also the first must be denied modifying the period
> > > if a second consumer has enabled its PWM.)
> > 
> > Good idea, but is it OK to potentially break users relying on the old
> > behavior ("the last one who changes the period wins") ?
> 
> If this is already in the old code, this probably warrants a separate
> fix, and yes, I consider this a severe bug. (Consider one channel
> driving a motor and reconfiguring an LED modifies the motor's speed.)

Yes, but a user could also be relying on the old behavior as follows:
1. Requests & enables pwm 0 for a backlight, using a period of 5000000ns
   (does not care about the frequency as long as it does not flicker)
2. Requests & enables pwm 1 for a motor, using a period of 1000000ns
   (does care about the frequency)

In the previous kernel versions, this would work, but with your
suggested change, (2) would fail and the motor would no longer work.

We are basically changing "the last one to set the period wins" to "the
first one to set the period wins".

If we do it like this, I'll split it out so we can at least revert it if
someone complains that it breaks his application, without reverting the
whole series.

Thanks,
Clemens
