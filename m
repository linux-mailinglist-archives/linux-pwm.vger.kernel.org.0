Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62B3575CD
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 22:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356062AbhDGUVX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 16:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbhDGUVX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 16:21:23 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C54CC061760;
        Wed,  7 Apr 2021 13:21:13 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 7951DC759B8;
        Wed,  7 Apr 2021 22:21:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617826871;
        bh=6FOoXDFvJhzROR5qW6KYw+A/3BsMIFWHmnC3Vtj6XKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqavCxfBN60NiNnt5TF7D7Lfb3mDVJe+VZ+oceCPTTMXWW11U+Csz6Z43emiOhXAw
         U9fDbu7nlCkRe+p8ePB4w+A3HFujhGyJGdhuiLPaw8VgZHh04uvKlGsMEtn9t3qYR7
         71HJreEYtyoQQRNHFgciNtw4NhpsZiD91Wh2q6oI=
Date:   Wed, 7 Apr 2021 22:21:10 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/8] pwm: core: Support new PWM_STAGGERING_ALLOWED flag
Message-ID: <YG4UNoBCQJkEEfwi@workstation.tuxnet>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-5-clemens.gruber@pqgruber.com>
 <20210407054658.qdsjkstqwynxeuxj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210407054658.qdsjkstqwynxeuxj@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 07, 2021 at 07:46:58AM +0200, Uwe Kleine-König wrote:
> On Tue, Apr 06, 2021 at 06:41:37PM +0200, Clemens Gruber wrote:
> > If the flag PWM_STAGGERING_ALLOWED is set on a channel, the PWM driver
> > may (if supported by the HW) delay the ON time of the channel relative
> > to the channel number.
> > This does not alter the duty cycle ratio and is only relevant for PWM
> > chips with less prescalers than channels, which would otherwise assert
> > multiple or even all enabled channels at the same time.
> > 
> > If this feature is supported by the driver and the flag is set on
> > multiple channels, their ON times are spread out to improve EMI and
> > reduce current spikes.
> 
> As said in reply to patch 4/8 already: I don't like this idea and
> think this should be made explicit using a new offset member in struct
> pwm_state instead. That's because I think that the wave form a PWM
> generates should be (completely) defined by the consumer and not by a
> mix between consumer and device tree. Also the consumer has no (sane)
> way to determine if staggering is in use or not.

I don't think offsets are ideal for this feature: It makes it more
cumbersome for the user, because he has to allocate the offsets
himself instead of a simple on/off switch.
The envisioned usecase is: "I want better EMI behavior and don't care
about the individual channels no longer being asserted at the exact same
time".

> One side effect (at least for the pca9685) is that when programming a
> new duty cycle it takes a bit longer than without staggering until the
> new setting is active. 

Yes, but it can be turned off if this is a problem, now even per-PWM.

> Another objection I have is that we already have some technical debt
> because there are already two different types of drivers (.apply vs
> .config+.set_polarity+.enable+.disable) and I would like to unify this
> first before introducing new stuff.

But there is already PWM_POLARITY_INVERTED, which can be set in the DT.
I am only adding another flag.

Thierry: What's your take on this?

Thanks,
Clemens
