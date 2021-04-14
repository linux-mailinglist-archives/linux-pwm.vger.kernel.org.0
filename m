Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A597535FBD1
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Apr 2021 21:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353460AbhDNTp7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Apr 2021 15:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347936AbhDNTp6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Apr 2021 15:45:58 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A347C061574;
        Wed, 14 Apr 2021 12:45:35 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 56B9FC725CF;
        Wed, 14 Apr 2021 21:45:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618429534;
        bh=NcyhMGkK4f3s6Jb75I3zSLqjm8FszWSB9VvtZQdYA3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INppUTN2R41mVczgBPa/SGaLm4kMSUW/fkHjLuCQy8DdAGjP1F0Oi0y0493qiBvyq
         LRWYeFvSQ7JBCfMiQxaL3JMJlcSvw1bHeXRRKto+25h47bjQ+XJTMqin9Wrr8Mnn6M
         UHU9V5yd1/scDbBE2aMGNlHkS65az6/QRYyoe6hM=
Date:   Wed, 14 Apr 2021 21:45:32 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <YHdGXG3PbsmicK7U@workstation.tuxnet>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412161808.lp2amdfopw74lvz7@pengutronix.de>
 <YHR3wP4Fk3jidnri@workstation.tuxnet>
 <20210412201019.vouxx4daumusrcvr@pengutronix.de>
 <YHWKehtYFSaHt1hC@workstation.tuxnet>
 <20210413193818.r7oqzdzbxqf5sjj3@pengutronix.de>
 <YHbbaiwK9Tasb7NF@workstation.tuxnet>
 <20210414192131.2o4c2eia6jnjatp2@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210414192131.2o4c2eia6jnjatp2@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 14, 2021 at 09:21:31PM +0200, Uwe Kleine-König wrote:
> On Wed, Apr 14, 2021 at 02:09:14PM +0200, Clemens Gruber wrote:
> > Hi Uwe,
> > 
> > On Tue, Apr 13, 2021 at 09:38:18PM +0200, Uwe Kleine-König wrote:
> > > Hello Clemens,
> > > 
> > > On Tue, Apr 13, 2021 at 02:11:38PM +0200, Clemens Gruber wrote:
> > > > On Mon, Apr 12, 2021 at 10:10:19PM +0200, Uwe Kleine-König wrote:
> > > > > On Mon, Apr 12, 2021 at 06:39:28PM +0200, Clemens Gruber wrote:
> > > > > > With your suggested round-down, the example with frequency of 200 Hz
> > > > > > would no longer result in 30 but 29 and that contradicts the datasheet.
> > > > > 
> > > > > Well, with PRESCALE = 30 we get a frequency of 196.88 Hz and with
> > > > > PRESCALE = 29 we get a frequency of 203.45 Hz. So no matter if you pick
> > > > > 29 or 30, you don't get 200 Hz. And which of the two possible values is
> > > > > the better one depends on the consumer, no matter what rounding
> > > > > algorithm the data sheet suggests. Also note that the math here contains
> > > > > surprises you don't expect at first. For example, what PRESCALE value
> > > > > would you pick to get 284 Hz? [If my mail was a video, I'd suggest to
> > > > > press Space now to pause and let you think first :-)] The data sheet's
> > > > > formula suggests:
> > > > > 
> > > > > 	round(25 MHz / (4096 * 284)) - 1 = 20
> > > > > 
> > > > > The resulting frequency when picking PRESCALE = 20 is 290.644 Hz (so an
> > > > > error of 6.644 Hz). If instead you pick PRESCALE = 21 you get 277.433 Hz
> > > > > (error = 6.567 Hz), so 21 is the better choice.
> > > > > 
> > > > > Exercise for the reader:
> > > > >  What is the correct formula to really determine the PRESCALE value that
> > > > >  yields the best approximation (i.e. minimizing
> > > > >  abs(real_freq - target_freq)) for a given target_freq?
> > > 
> > > I wonder if you tried this.
> > 
> > We could calculate both round-up and round-down and decide which one is
> > closer to "real freq" (even though that is not the actual frequency but
> > just our backwards-calculated frequency).
> 
> Yeah, the backwards-calculated frequency is the best assumption we
> have.
> 
> > But I can't give you a formula with minimized abs(real_freq-target_freq)
> > Is it a different round point than 0.5 and maybe relative to f ?
> > 
> > Please enlighten us :-)
> 
> Sorry, I cannot. I spend ~20 min today after lunch with pencil and
> paper, but without success. I was aware that it isn't trivial and this
> is the main reason I established round-down as default for new drivers
> instead of round-nearest.

Oh, I thought you already solved it. I tried too for a while but was
unsuccessful. Not trivial indeed!

But regarding you establishing round-down: Wouldn't it be even better if
the driver did what I suggested above, namely calculate backwards from
both the rounded-up as well as the rounded-down prescale value and then
write the one with the smallest abs(f_target - f_real) to the register?

Clemens
