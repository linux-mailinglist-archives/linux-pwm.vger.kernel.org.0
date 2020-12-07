Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D712D1E2B
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 00:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgLGXO2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 18:14:28 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:36924 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbgLGXO2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Dec 2020 18:14:28 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id D6851C89267;
        Tue,  8 Dec 2020 00:13:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1607382826;
        bh=bval0ZHQCjvevq9TbYQlvh+Mg28E3XwHRGLYW8SRBDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sp6pfa1uU7xXPlqzVIRlcfftxJR75yvOPvGfWOAmlJwqLTSMv/dznlwlZI57NRlC0
         QaOdP9TkhxvTmPAFaWhZlzgYXouTbsHO5VX8EMuc1FM7ijDVoJwaA5rSZXGkNx9XcO
         BrzPNAy14Kn69z5zw9SiLXDt/zQ18XWEwzBn6V7k=
Date:   Tue, 8 Dec 2020 00:13:44 +0100
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
Message-ID: <X863KNo0IaekkU7q@workstation.tuxnet>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Dec 07, 2020 at 11:00:25PM +0100, Uwe Kleine-König wrote:
> On Mon, Dec 07, 2020 at 08:36:27PM +0100, Clemens Gruber wrote:
> > The switch to the atomic API goes hand in hand with a few fixes to
> > previously experienced issues:
> > - The duty cycle is no longer lost after disable/enable (previously the
> >   OFF registers were cleared in disable and the user was required to
> >   call config to restore the duty cycle settings)
> > - If one sets a period resulting in the same prescale register value,
> >   the sleep and write to the register is now skipped
> > - The prescale register is now set to the default value in probe. On
> >   systems without CONFIG_PM, the chip is woken up at probe time.
> > 
> > The hardware readout may return slightly different values than those
> > that were set in apply due to the limited range of possible prescale and
> > counter register values. If one channel is reconfigured with new duty
> > cycle and period, the others will keep the same relative duty cycle to
> > period ratio as they had before, even though the per-chip / global
> > frequency changed. (The PCA9685 has only one prescaler!)
> 
> This is not acceptable, if you have two PWM outputs and a consumer
> modifies one of them the other must change. So if this chip only
> supports a single period length of all channels, the first consumer
> enabling a channel defines the period to be used. All later consumers
> must live with that. (Also the first must be denied modifying the period
> if a second consumer has enabled its PWM.)

Good idea, but is it OK to potentially break users relying on the old
behavior ("the last one who changes the period wins") ?

> 
> > Note that although the datasheet mentions 200 Hz as default frequency
> > when using the internal 25 MHz oscillator, the calculated period from
> > the default prescaler register setting of 30 is 5079040ns.
> 
> That means the datasheet is lax because 5079040ns corresponds to
> 196.88760080645162 Hz but it calls that 200 Hz, right?

Yes, it calls prescale setting 0x1E 200 Hz, but calculating the
period from that prescaler setting leads to 5079040ns (196.9 Hz) as you
mentioned.
Also, the datasheet does not specify frequency accuracy / internal
oscillator specifications. I measured about 207 Hz on one chip and about
205 Hz on another with the scope today, when configuring a 5079040ns
period.

> 
> I didn't look in the patch in detail, but get the impression it is more
> complicated than necessary. For example adding improved PM behaviour
> should probably go into a separate patch, also adding the .get_state
> callback should be split out.

Agreed. I'll split it up more in the next revision!

Thanks,
Clemens
