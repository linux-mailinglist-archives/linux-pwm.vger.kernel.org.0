Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5F919807B
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 18:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgC3QHr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 12:07:47 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:57710 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgC3QHr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Mar 2020 12:07:47 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 750DEC72753;
        Mon, 30 Mar 2020 18:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1585584465;
        bh=q0R/eIdBiL04ZzaNH27/H9PSTVwoRPsiin/dQgKMXBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYhulaBINJV3XGmYtogjp34DSdxijcK/aLu0zp+G4renddGunWyY89jKOksGTJZWL
         gE5/ejFEhNBXZuJmH2ZkNp7K+3nuOg9WCutaXNF1w0Zd1RM80UYeo2IVHjwtjg421F
         Zit/gN3vCO1IE9Lb9eyCA8vxQB0dRWx2JBSSm9WI=
Date:   Mon, 30 Mar 2020 18:07:44 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Message-ID: <20200330160744.GA777@workstation.tuxnet>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
 <20200330130757.GC2431644@ulmo>
 <20200330133450.GA1530@workstation.tuxnet>
 <20200330154036.GB2817345@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330154036.GB2817345@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 30, 2020 at 05:40:36PM +0200, Thierry Reding wrote:
> On Mon, Mar 30, 2020 at 03:34:50PM +0200, Clemens Gruber wrote:
> > Hi,
> > 
> > On Mon, Mar 30, 2020 at 03:07:57PM +0200, Thierry Reding wrote:
> > > On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> > > > The interaction of the ALL_LED PWM channel with the other channels was
> > > > not well-defined. As the ALL_LED feature does not seem very useful and
> > > > it was making the code significantly more complex, simply remove it.
> > > > 
> > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > > ---
> > > >  drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------------------
> > > >  1 file changed, 17 insertions(+), 98 deletions(-)
> > > 
> > > Applied, thanks.
> > > 
> > > Thierry
> > 
> > I was not reading the mailing list in the last weeks, so I only saw the
> > patch today.
> > 
> > We are using the ALL_LED channel in production to reduce the delay when
> > all 16 PWM outputs need to be set to the same duty cycle.
> > 
> > I am not sure it is a good idea to remove this feature.
> 
> Can you specify what platform this is and where the code is that does
> this. I can't really find any device tree users of this and I don't know
> if there's a good way to find out what other users there are, but this
> isn't the first time this driver has created confusion, so please help
> collect some more information about it's use so we can avoid this in the
> future.

The platform is ARM, it's a custom board with an NXP i.MX6. The device
tree is not upstreamed. As there are multiple companies involved
in changes to this driver, I assume that it is in use, even though there
are no in-tree users.
Also: As you can set the ALL channel from userspace, it will be very
difficult to find out how often the ALL feature is being used somewhere.

> 
> I'll back out this particular patch since you're using it. Can you give
> the other three patches a try to see if they work for you?

Thanks! I saw your other mail. Patch 1 looks good to me. I will look at
the new version of patches 3 and 4 and test them when they appear on the
list.

Clemens
