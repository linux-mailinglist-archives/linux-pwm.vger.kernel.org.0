Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354D827FC2E
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Oct 2020 11:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgJAJFn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Oct 2020 05:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgJAJFm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Oct 2020 05:05:42 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D62C0613D0;
        Thu,  1 Oct 2020 02:05:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id F395E23F0F3;
        Thu,  1 Oct 2020 11:05:38 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.958
X-Spam-Level: 
X-Spam-Status: No, score=-2.958 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.058, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jn13Cqk_puzT; Thu,  1 Oct 2020 11:05:37 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 1EEF22402AE;
        Thu,  1 Oct 2020 11:05:37 +0200 (CEST)
Date:   Thu, 1 Oct 2020 11:05:31 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20201001090531.gubfwmznlto2ng6l@lem-wkst-02.lemonage>
References: <20200929121953.2817843-1-poeschel@lemonage.de>
 <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
 <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
 <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 30, 2020 at 11:41:46AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> I added Greg Kroah-Hartman who I discussed this with via irc a bit to
> Cc:.
> 
> On Wed, Sep 30, 2020 at 11:20:56AM +0200, Lars Poeschel wrote:
> > thank you for your review!
> > 
> > On Wed, Sep 30, 2020 at 08:57:26AM +0200, Uwe Kleine-König wrote:
> > > On Tue, Sep 29, 2020 at 02:19:53PM +0200, poeschel@lemonage.de wrote:
> > > > From: Lars Poeschel <poeschel@lemonage.de>
> > > > 
> > > > This adds a class to exported pwm devices.
> > > > Exporting a pwm through sysfs did not yield udev events. The
> > > 
> > > I wonder what is your use-case here. This for sure also has a place to
> > > be mentioned in the commit log. I suspect there is a better way to
> > > accomplish you way.
> > 
> > Use-case is to be able to use a pwm from a non-root userspace process.
> > I use udev rules to adjust permissions.
> 
> Hmm, how do you trigger the export? Without being aware of all the
> details in the sysfs code I would expect that the exported stuff is
> available instantly once the write used to export the PWM is completed.
> So changing the permissions can be done directly after triggering the
> export in the same process.

The export is triggered through the userspace process itself. Why can it
do this ? Because there is another udev rule, that changes permissions
when a pwmchip appears.
Then I'd like to have the second udev rule, that changes permissions on
the freshly exported pwm. The userspace process can't do this.
You are right I could propably do everything from within udev: If a
pwmchip appears, export certain pwms and right away change their
permissions. It does not also not feel right. It'd require knowledge
from the userspace application to be mapped to udev.

> Out of interest: What do you use the pwm for? Isn't there a suitable
> kernel driver that can do the required stuff? Compared to the kernel-API
> the sysfs interface isn't atomic. Is this an annoyance?

Use-case is generating a voltage from the pwm. This voltage is used to
signal different states and does not change very often. This is
absolutely not annoying that this is not atomic. We just change the duty
cycle on the fly. Everything else is configured one time at startup.
I'd call what I need pwm-dac. I could not find a ready to use driver.
Maybe I could misuse some kernel driver for this. Maybe I could use
pwm-led or pwm-brightness or pwm-fan. Propably pwm-regulator could work,
there is even a userspace facing part for this, but this is not
devicetree ready.
...and the worst, please don't blame me: The application is java, so
ioctl is a problem.
So, sysfs was quite a good choice for me.

Regards,
Lars
