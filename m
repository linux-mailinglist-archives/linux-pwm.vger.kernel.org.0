Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95CE2834C6
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Oct 2020 13:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgJELQx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Oct 2020 07:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgJELQx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 5 Oct 2020 07:16:53 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78D1A20774;
        Mon,  5 Oct 2020 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601896612;
        bh=Uccl5Nm1ZajLQ0TeZ2f06aGfK3thXV/ZGpiAw3a2Twg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twh5Y5Zleu8c6pDwNuF8K6yERw6tFJVcNCjRcukj/vv+naTOoCECBNT3Oz8In9BP7
         bxIvk7TtcY6jG0WzaRfLi6UTxQgscHMheqLqBz9c+VkMc2znj5M6Zb4g3tPOo2jlbr
         E/W0yaEz3raxKB5TCtZl+7MLvVSJOz/KvNtXZYiE=
Date:   Mon, 5 Oct 2020 13:17:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20201005111738.GA367715@kroah.com>
References: <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
 <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
 <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
 <20201001090531.gubfwmznlto2ng6l@lem-wkst-02.lemonage>
 <20201001112449.GA2364834@kroah.com>
 <20201005093016.GD425362@ulmo>
 <20201005094530.GA154185@kroah.com>
 <20201005101721.GL425362@ulmo>
 <20201005104023.GB245520@kroah.com>
 <20201005110819.GP425362@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201005110819.GP425362@ulmo>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Oct 05, 2020 at 01:08:19PM +0200, Thierry Reding wrote:
> On Mon, Oct 05, 2020 at 12:40:23PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Oct 05, 2020 at 12:17:21PM +0200, Thierry Reding wrote:
> > > On Mon, Oct 05, 2020 at 11:45:30AM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Oct 05, 2020 at 11:30:16AM +0200, Thierry Reding wrote:
> > > > > On Thu, Oct 01, 2020 at 01:24:49PM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Thu, Oct 01, 2020 at 11:05:31AM +0200, Lars Poeschel wrote:
> > > > > > > On Wed, Sep 30, 2020 at 11:41:46AM +0200, Uwe Kleine-König wrote:
> > > > > > > > Hello,
> > > > > > > > 
> > > > > > > > I added Greg Kroah-Hartman who I discussed this with via irc a bit to
> > > > > > > > Cc:.
> > > > > > > > 
> > > > > > > > On Wed, Sep 30, 2020 at 11:20:56AM +0200, Lars Poeschel wrote:
> > > > > > > > > thank you for your review!
> > > > > > > > > 
> > > > > > > > > On Wed, Sep 30, 2020 at 08:57:26AM +0200, Uwe Kleine-König wrote:
> > > > > > > > > > On Tue, Sep 29, 2020 at 02:19:53PM +0200, poeschel@lemonage.de wrote:
> > > > > > > > > > > From: Lars Poeschel <poeschel@lemonage.de>
> > > > > > > > > > > 
> > > > > > > > > > > This adds a class to exported pwm devices.
> > > > > > > > > > > Exporting a pwm through sysfs did not yield udev events. The
> > > > > > > > > > 
> > > > > > > > > > I wonder what is your use-case here. This for sure also has a place to
> > > > > > > > > > be mentioned in the commit log. I suspect there is a better way to
> > > > > > > > > > accomplish you way.
> > > > > > > > > 
> > > > > > > > > Use-case is to be able to use a pwm from a non-root userspace process.
> > > > > > > > > I use udev rules to adjust permissions.
> > > > > > > > 
> > > > > > > > Hmm, how do you trigger the export? Without being aware of all the
> > > > > > > > details in the sysfs code I would expect that the exported stuff is
> > > > > > > > available instantly once the write used to export the PWM is completed.
> > > > > > > > So changing the permissions can be done directly after triggering the
> > > > > > > > export in the same process.
> > > > > > > 
> > > > > > > The export is triggered through the userspace process itself. Why can it
> > > > > > > do this ? Because there is another udev rule, that changes permissions
> > > > > > > when a pwmchip appears.
> > > > > > > Then I'd like to have the second udev rule, that changes permissions on
> > > > > > > the freshly exported pwm. The userspace process can't do this.
> > > > > > > You are right I could propably do everything from within udev: If a
> > > > > > > pwmchip appears, export certain pwms and right away change their
> > > > > > > permissions. It does not also not feel right. It'd require knowledge
> > > > > > > from the userspace application to be mapped to udev.
> > > > > > 
> > > > > > The way the kernel code is now, yes, you will not have any way to
> > > > > > trigger it by userspace as the kernel is creating a "raw" struct device
> > > > > > that isn't assigned to anything.  That is what needs to be fixed here.
> > > > > > 
> > > > > > > > Out of interest: What do you use the pwm for? Isn't there a suitable
> > > > > > > > kernel driver that can do the required stuff? Compared to the kernel-API
> > > > > > > > the sysfs interface isn't atomic. Is this an annoyance?
> > > > > > > 
> > > > > > > Use-case is generating a voltage from the pwm. This voltage is used to
> > > > > > > signal different states and does not change very often. This is
> > > > > > > absolutely not annoying that this is not atomic. We just change the duty
> > > > > > > cycle on the fly. Everything else is configured one time at startup.
> > > > > > > I'd call what I need pwm-dac. I could not find a ready to use driver.
> > > > > > > Maybe I could misuse some kernel driver for this. Maybe I could use
> > > > > > > pwm-led or pwm-brightness or pwm-fan. Propably pwm-regulator could work,
> > > > > > > there is even a userspace facing part for this, but this is not
> > > > > > > devicetree ready.
> > > > > > > ...and the worst, please don't blame me: The application is java, so
> > > > > > > ioctl is a problem.
> > > > > > 
> > > > > > I thought java could do ioctls, otherwise how would it ever be able to
> > > > > > talk to serial ports?
> > > > > > 
> > > > > > Anyway, this needs to be fixed in the kernel...
> > > > > 
> > > > > If atomicity was a problem, we could potentially add a mechanism to the
> > > > > sysfs interface to enable that. I don't see a good way of doing that in
> > > > > a single file, since that works against how sysfs is designed. But one
> > > > > thing I could imagine is adding a file ("lock", or whatever you want to
> > > > > call it) that you can use for atomic fencing:
> > > > > 
> > > > > 	$ echo 1 > lock # locks the hardware state
> > > > > 	$ echo 100 > period
> > > > > 	$ echo 50 > duty_cycle
> > > > > 	$ echo 0 > lock # flushes state to hardware
> > > > > 
> > > > > But it sounds like that's not even a big issue.
> > > > 
> > > > That is exactly what configfs was designed for :)
> > > 
> > > Interesting... for some reason I had never thought about configfs in
> > > this context. But it does indeed sound like it could solve this problem
> > > in a better way.
> > > 
> > > My memory is a bit sketchy, but I think for USB device controllers this
> > > works by exposing each controller in configfs and then configuring
> > > things like endpoints within the controller's directory. So I wonder if
> > > instead of requesting PWMs via sysfs, we should rather expose them via
> > > configfs items.
> > > 
> > > Something like:
> > > 
> > > 	# mkdir /configfs/7000a000.pwm/0
> > > 
> > > could then be the equivalent of exporting PWM channel 0 of the given PWM
> > > chip in sysfs, except that now you get a configfs directory with
> > > attributes that you can use to inspect and reconfigure the PWM channel
> > > and ultimately apply the changes atomically.
> > > 
> > > How does that work from a permissions point of view? How do we ensure
> > > that people don't need root privileges to access these?
> > 
> > To change things in configfs, yes, I'm pretty sure you need root access.
> > But to read things, sysfs is fine.  I don't really know what you are
> > wanting to do here, both create a device and change the options over
> > time?
> 
> Yes, I'm wondering if we should replace the write usages in sysfs with a
> better configfs implementation. We obviously can't remove the existing
> sysfs ABI, but for anything that's meant to be atomic we could point
> people at the configfs interface.

How about fixing the sysfs interface so that it's usable, like the
proposed patch does?  What you all have now is not working.

When the revised version is sent, not this version...

thanks,

greg k-h
