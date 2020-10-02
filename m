Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5A6280E5F
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Oct 2020 09:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgJBH6f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Oct 2020 03:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgJBH6f (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 2 Oct 2020 03:58:35 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B73C4206A5;
        Fri,  2 Oct 2020 07:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601625513;
        bh=VC5t7PYyhQ3yPcf8lwkEP8Aq1I28TaT7zlaw1h6RBQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLeBRUFcZ40SPhOzyBOIzhK52CPt5FGDeNSRgEi4qZAJ8M8TEVNB6c96A/uj4jcKe
         iFK2zJLEFMHg3VFLF7n55f9pULbUpzbkuLv31a/UIwoLijroTPPkhNxEhlrWO5OdrM
         dwi6oVXKTpvNZrVn4ixQQiWB8ICKXewvmfWaMASc=
Date:   Fri, 2 Oct 2020 09:58:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20201002075832.GA1184016@kroah.com>
References: <20200929121953.2817843-1-poeschel@lemonage.de>
 <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
 <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
 <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
 <20201001090531.gubfwmznlto2ng6l@lem-wkst-02.lemonage>
 <20201001112449.GA2364834@kroah.com>
 <20201001135009.2dpgojasd3fm5phh@lem-wkst-02.lemonage>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201001135009.2dpgojasd3fm5phh@lem-wkst-02.lemonage>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 01, 2020 at 03:50:09PM +0200, Lars Poeschel wrote:
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
> 
> I did a first try with our approach.
> I set the class of the child to its parent class. This does work and
> create the directories right under /sys/pwm but because the child now
> also inherits the dev_groups from the parent its directory also contain
> export, unexport and npwm files, that don't apply for pwm's as soon a I
> register the device to driver core.
> 
> Did we miss something or is there a way to avoid that ? I had a look at
> device_add and saw that as soon as a class it set it's dev_groups get
> exported through device_add_attrs.

Ah, you need to tweak that group to only show up for a specific "type"
of device.  There is a is_visable callback for a group that should be
used for this, and you can check the type of device being affected here,
try messing with that.  And make sure you set a new type for the new
devices you are creating.

I know that's vague, if you need more help I can work on it next week.

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
> 
> It is not impossible but it is horrible. java itself can access the
> ports through normal file I/O, but it can not set control lines or
> baudrate or anything. You need some C-code for this, that is not part of
> the java vm itself and has to be called through something called JNI -
> java native interface.

Ah, ok, yeah, that's not ok, sorry to hear you are stuck with Java :(

greg k-h
