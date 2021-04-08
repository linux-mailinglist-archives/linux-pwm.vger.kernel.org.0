Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11906358BF8
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Apr 2021 20:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhDHSOX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Apr 2021 14:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhDHSOX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Apr 2021 14:14:23 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6EEC061760;
        Thu,  8 Apr 2021 11:14:11 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id A092AC725C7;
        Thu,  8 Apr 2021 20:14:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617905649;
        bh=bqq+6Ua6gjCE1d4qctGpoLs9LGXr1awDHysmE+XtkwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1G+vlnAkRYmKGPKs3Spm9nAkUs7fBssKaYLh8Lr2hfgtHkh0iz9LB3aKBtsWtkbMO
         IKbZg4JguOYSnDK0xR8FDTqEBfA25zTaghX0Sr9AVqtJ3ao5bolI905JBKp9IxNXQx
         XCClDPIAgXdKSoZ1qbB4Y8aZ1dV56c4Bm4j/it80=
Date:   Thu, 8 Apr 2021 20:14:08 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/8] pwm: core: Support new PWM_STAGGERING_ALLOWED flag
Message-ID: <YG9H8D5YW0KEtaoG@workstation.tuxnet>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-5-clemens.gruber@pqgruber.com>
 <20210407054658.qdsjkstqwynxeuxj@pengutronix.de>
 <YG4UNoBCQJkEEfwi@workstation.tuxnet>
 <20210407213403.h6n6l2t7vqoalceu@pengutronix.de>
 <YG78IHIMGtl8Pokp@orome.fritz.box>
 <YG8miEOZXsH0NTcA@workstation.tuxnet>
 <20210408173637.w26njwystfuyrgan@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210408173637.w26njwystfuyrgan@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 08, 2021 at 07:36:37PM +0200, Uwe Kleine-König wrote:
> On Thu, Apr 08, 2021 at 05:51:36PM +0200, Clemens Gruber wrote:
> > On Thu, Apr 08, 2021 at 02:50:40PM +0200, Thierry Reding wrote:
> > > Yes, I think that's basically what this is saying. I think we're perhaps
> > > getting hung up on the terminology here. PWM_STAGGERING_ALLOWED gives
> > > the impression that we're dealing with some provider-specific feature,
> > > whereas what we really want to express is that the PWM doesn't care
> > > exactly when the active cycle starts and based on that a provider that
> > > can support it may optimize the EMI behavior.
> > > 
> > > Maybe we can find a better name for this? Ultimately what this means is
> > > that the consumer is primarily interested in the power output of the PWM
> > > rather than the exact shape of the signal. So perhaps something like
> > > PWM_USAGE_POWER would be more appropriate.
> > 
> > Yes, although it would then no longer be obvious that this feature leads
> > to improved EMI behavior, as long as we mention that in the docs, I
> > think it's a good idea
> > 
> > Maybe document it as follows?
> > PWM_USAGE_POWER - Allow the driver to delay the start of the cycle
> > for EMI improvements, as long as the power output stays the same
> 
> I don't like both names, because for someone who is only halfway into
> PWM stuff it is not understandable. Maybe ALLOW_PHASE_SHIFT?

Sounds good to me.

> When a consumer is only interested in the power output than
> 
> 	.period = 20
> 	.duty_cycle = 5
> 
> would also be an allowed response for the request
> 
> 	.period = 200
> 	.duty_cycle = 50
> 
> and this is not what is in the focus here.

Right.

If Thierry agrees, I can spin up a new revision.

Maybe we can get it into 5.13 after all.

Thanks,
Clemens
