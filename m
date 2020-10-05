Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42953283430
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Oct 2020 12:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJEKtq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Oct 2020 06:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgJEKtl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2020 06:49:41 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F77C0613CE;
        Mon,  5 Oct 2020 03:49:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 5A95123F400;
        Mon,  5 Oct 2020 12:49:37 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.958
X-Spam-Level: 
X-Spam-Status: No, score=-2.958 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.058, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9kTFrZCK9q1Q; Mon,  5 Oct 2020 12:49:35 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 6D49223FF12;
        Mon,  5 Oct 2020 12:49:35 +0200 (CEST)
Date:   Mon, 5 Oct 2020 12:49:31 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20201005104931.zm6ygp22bnjrleod@lem-wkst-02.lemonage>
References: <20200929121953.2817843-1-poeschel@lemonage.de>
 <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
 <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
 <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
 <20201001090531.gubfwmznlto2ng6l@lem-wkst-02.lemonage>
 <20201001112449.GA2364834@kroah.com>
 <20201005093016.GD425362@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201005093016.GD425362@ulmo>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Oct 05, 2020 at 11:30:16AM +0200, Thierry Reding wrote:
> On Thu, Oct 01, 2020 at 01:24:49PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Oct 01, 2020 at 11:05:31AM +0200, Lars Poeschel wrote:
> > > On Wed, Sep 30, 2020 at 11:41:46AM +0200, Uwe Kleine-König wrote:
> > > > Hello,
> > > > 
> > > > I added Greg Kroah-Hartman who I discussed this with via irc a bit to
> > > > Cc:.
> > > > 
> > > > On Wed, Sep 30, 2020 at 11:20:56AM +0200, Lars Poeschel wrote:
> > > > > thank you for your review!
> > > > > 
> > > > > On Wed, Sep 30, 2020 at 08:57:26AM +0200, Uwe Kleine-König wrote:
> > > > > > On Tue, Sep 29, 2020 at 02:19:53PM +0200, poeschel@lemonage.de wrote:
> > > > > > > From: Lars Poeschel <poeschel@lemonage.de>
> > > > > > > 
> > > > > > > This adds a class to exported pwm devices.
> > > > > > > Exporting a pwm through sysfs did not yield udev events. The
> > > > > > 
> > > > > > I wonder what is your use-case here. This for sure also has a place to
> > > > > > be mentioned in the commit log. I suspect there is a better way to
> > > > > > accomplish you way.
> > > > > 
> > > > > Use-case is to be able to use a pwm from a non-root userspace process.
> > > > > I use udev rules to adjust permissions.
> > > > 
> > > > Hmm, how do you trigger the export? Without being aware of all the
> > > > details in the sysfs code I would expect that the exported stuff is
> > > > available instantly once the write used to export the PWM is completed.
> > > > So changing the permissions can be done directly after triggering the
> > > > export in the same process.
> > > 
> > > The export is triggered through the userspace process itself. Why can it
> > > do this ? Because there is another udev rule, that changes permissions
> > > when a pwmchip appears.
> > > Then I'd like to have the second udev rule, that changes permissions on
> > > the freshly exported pwm. The userspace process can't do this.
> > > You are right I could propably do everything from within udev: If a
> > > pwmchip appears, export certain pwms and right away change their
> > > permissions. It does not also not feel right. It'd require knowledge
> > > from the userspace application to be mapped to udev.
> > 
> > The way the kernel code is now, yes, you will not have any way to
> > trigger it by userspace as the kernel is creating a "raw" struct device
> > that isn't assigned to anything.  That is what needs to be fixed here.
> > 
> > > > Out of interest: What do you use the pwm for? Isn't there a suitable
> > > > kernel driver that can do the required stuff? Compared to the kernel-API
> > > > the sysfs interface isn't atomic. Is this an annoyance?
> > > 
> > > Use-case is generating a voltage from the pwm. This voltage is used to
> > > signal different states and does not change very often. This is
> > > absolutely not annoying that this is not atomic. We just change the duty
> > > cycle on the fly. Everything else is configured one time at startup.
> > > I'd call what I need pwm-dac. I could not find a ready to use driver.
> > > Maybe I could misuse some kernel driver for this. Maybe I could use
> > > pwm-led or pwm-brightness or pwm-fan. Propably pwm-regulator could work,
> > > there is even a userspace facing part for this, but this is not
> > > devicetree ready.
> > > ...and the worst, please don't blame me: The application is java, so
> > > ioctl is a problem.
> > 
> > I thought java could do ioctls, otherwise how would it ever be able to
> > talk to serial ports?
> > 
> > Anyway, this needs to be fixed in the kernel...
> 
> If atomicity was a problem, we could potentially add a mechanism to the
> sysfs interface to enable that. I don't see a good way of doing that in
> a single file, since that works against how sysfs is designed. But one
> thing I could imagine is adding a file ("lock", or whatever you want to
> call it) that you can use for atomic fencing:
> 
> 	$ echo 1 > lock # locks the hardware state
> 	$ echo 100 > period
> 	$ echo 50 > duty_cycle
> 	$ echo 0 > lock # flushes state to hardware
> 
> But it sounds like that's not even a big issue.

For my use case atomicity is absolutely not a problem, but of course
things should be solved in a generic way.

> However, given the use-case description, it sounds to me like
> pwm-regulator would be a better candidate to solve this, because it's
> purpose is literally to generate a voltage using a PWM. There is a
> device tree binding for pwm-regulator, so this should work there as
> well.
> 
> Lars, what exactly are the problems that you're running into when trying
> to use pwm-regulator with device tree?

The problem is not to use pwm-regulator from device tree. But I have no
userspace facing part then. pwm-regulator is for kernel drivers only (as
far as I can see). I can not do anything with it from userspace.
I found that "userspace-consumer" solves this, but this thing does not
have a device tree binding. I could add this of course, but pwm sysfs
was there ready to be used.

Regards,
Lars
