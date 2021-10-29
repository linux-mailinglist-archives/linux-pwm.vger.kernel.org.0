Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADBB43F7B8
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Oct 2021 09:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhJ2HSk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Oct 2021 03:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhJ2HSk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Oct 2021 03:18:40 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491BBC061570;
        Fri, 29 Oct 2021 00:16:12 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 22D1FC638B; Fri, 29 Oct 2021 08:16:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1635491769; bh=0hcZKmtu7PJUxwvXsC29IbArA/3wXyA66Belfuc1NNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhFS2YllEGHiULTrWdVSZs/+edGr3zfikpVgZA78QOionCLvVbbyUH9SZ+NuUpxct
         OHDkCIbhSuHpwPCTxNdQ62fPd7hkihjKEwNw0T24QhGvent4mQeV4H+EkYxdlP62z6
         vuTi+h8tRa7d0Qt7kePoi1XewypPznPdBXw044YY8DiHa5rZY8cfOZcfI4HQ4lQQN5
         RGC+S6XHEJMptEo8ae/Sl6dJAP47kP6z90+LRYluWojvtgJ4t6WqNR6nLq8mI/tGU8
         mirHat8Iuo6rcZY8WfSPLpn1cpw388ArGpRexMBqSsdDKl9nUZ1zdXSfD8A31lETkB
         f8ygS7HEPoIFA==
Date:   Fri, 29 Oct 2021 08:16:08 +0100
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>, lkp@intel.com,
        mchehab@kernel.org, thierry.reding@gmail.com, lee.jones@linaro.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211029071608.GA28997@gofer.mess.org>
References: <YXlxhpZWf2mxJaMi@fedora>
 <20211028064513.guziv6uaivzlk6ki@pengutronix.de>
 <20211028091442.GA16514@gofer.mess.org>
 <20211028111535.x7xgz7domx2lpyfh@pengutronix.de>
 <20211028122610.GA18767@gofer.mess.org>
 <20211028180516.t2tpfbzztm7s6cqm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028180516.t2tpfbzztm7s6cqm@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 28, 2021 at 08:05:16PM +0200, Uwe Kleine-König wrote:
> On Thu, Oct 28, 2021 at 01:26:10PM +0100, Sean Young wrote:
> > > bloat-o-meter reports (for an arm allmodconfig build)
> > > 
> > > 	add/remove: 0/0 grow/shrink: 3/1 up/down: 644/-396 (248)
> > > 	Function                                     old     new   delta
> > > 	pwm_ir_probe                                 372     676    +304
> > > 	pwm_ir_set_carrier                           108     292    +184
> > > 	pwm_ir_set_duty_cycle                         68     224    +156
> > > 	pwm_ir_tx                                    908     512    -396
> > > 	Total: Before=2302, After=2550, chg +10.77%
> > 
> > So 248 bytes more after your changes.
> 
> ack. This is because the compiler inlines the division which accounts
> for > 100 bytes.

I'm surprised it's that large. This is on 32 bit?

> > > struct pwm_ir increases from 12 bytes to 40 bytes.
> > > 
> > > The stack space required by pwm_ir_tx decreases from 60 to 36
> > > 
> > > I don't know exactly how kmalloc works internally. Maybe allocating a
> > > structure of size 40 bytes doesn't need more memory than a structure of
> > > size 12?
> > > 
> > > I didn't check how runtimes change, but the size decrease of pwm_ir_tx()
> > > is nice and might save a bit of runtime.
> > 
> > I'm not following, how is this decreasing runtime? 
> 
> With my changes pwm_ir_tx got smaller and { pwm_ir_probe,
> pwm_ir_set_carrier, pwm_ir_set_duty_cycle } got bigger. Now if for a
> typical runtime pattern pwm_ir_probe and pwm_ir_set_carrier run once and
> pwm_ir_set_duty_cycle 100 times and pwm_ir_tx 1000 times (no idea if
> that is realistic) it might be a net win in sum.

The two most common programs for sending IR are

ir-ctl: https://git.linuxtv.org/v4l-utils.git/tree/utils/ir-ctl/ir-ctl.c#n1041
lircd: https://sourceforge.net/p/lirc/git/ci/master/tree/lib/transmit.c

For each transmission, the carrier is set. If the duty cyle is specified,
then that is set too. Then the transmit itself is done. Both of them
set the carrier and duty cycle (if required) for every transmission: setting
the carrier and duty cycle is a cheap operation, and it is device property
which can be overriden by another process. 

This means with your changes, if the carrier and duty cycle are both set
for each transmission, then we're doing more work. If only the carrier
is set for each transmission, then there is no net gain/loss (I think),
but the code size has increased.


Thanks for prototyping this.

Sean
