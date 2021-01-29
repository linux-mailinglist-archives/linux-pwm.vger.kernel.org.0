Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5356308A49
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Jan 2021 17:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhA2Qdy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Jan 2021 11:33:54 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:55744 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231452AbhA2Qcb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 29 Jan 2021 11:32:31 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id B31B0C6B26F;
        Fri, 29 Jan 2021 17:31:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1611937908;
        bh=DyVjiqkvwtlqI4o3EcQtV2h3pSbBneM1WDytITBk7RI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QvmqkrRHoO8OTWpUz6Mk8rhaDh2GYebv8JjCP4MzmIpHbNvim7sdHMXdvdxdk1WV6
         wh8DkbdtjnGeJljhSaUYGVmhqJNmnOmqZQycOFhkEvCq+/twNMF7ojFC9pl5EukbN9
         gOerXCtBQV58ahmyweGooFaqHbEaj7t/MRYb2SFw=
Date:   Fri, 29 Jan 2021 17:31:47 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sven,

On Fri, Jan 29, 2021 at 08:42:13AM -0500, Sven Van Asbroeck wrote:
> On Mon, Jan 11, 2021 at 3:35 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > My position here is: A consumer should disable a PWM before calling
> > pwm_put. The driver should however not enforce this and so should not
> > modify the hardware state in .free().
> >
> > Also .probe should not change the PWM configuration.
> 
> I agree that this is the most user-friendly behaviour.
> 
> The problem however with the pca9685 is that it has many degrees of
> freedom: there are many possible register values which produce the same
> physical chip outputs.
> 
> This could lead to a situation where, if .probe() does not reset the register
> values, subsequent writes may lead to different outputs than expected.
> 
> One possible solution is to write .get_state() so that it always reads the
> correct state, even if "unconventional" register settings are present, i.e.
> those written by an outside entity, e.g. a bootloader. Then write that
> state back using driver conventions.
> 
> This may be trickier than it sounds - after all we've learnt that the pca9685
> looks simple on the surface, but is actually quite challenging to get right.
> 
> Clemens, Uwe, what do you think?

Ok, so you suggest we extend our get_state logic to deal with cases
like the following:
If neither full OFF nor full ON is set && ON == OFF, we should probably
set the full OFF bit to disable the PWM and log a warning message?
(e.g. "invalid register setting detected: pwm disabled" ?)
If the ON registers are set and the nxp,staggered-outputs property is
not, I'd calculate (off - on) & 4095, set the OFF register to that value
and clear the ON register.

And then call our get_state in .probe, followed by a write of the
resulting / fixed-up state?

This would definitely solve the problem of invalid/unconventional values
set by the bootloader and avoid inconsistencies.
Sounds good to me!

If Thierry and Uwe have no objections, I can send out a new round of
patches in the upcoming weeks.

My current goal is to get the changes into 5.13.

Thanks,
Clemens
