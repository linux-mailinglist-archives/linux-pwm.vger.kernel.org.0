Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8A727E7DF
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Sep 2020 13:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgI3LvD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Sep 2020 07:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3LvD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 30 Sep 2020 07:51:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AA062076B;
        Wed, 30 Sep 2020 11:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601466662;
        bh=Rph12rkPGMYsgVf8hQ7uVrlwk5Hrr5aRGDcoCNiMOAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uGaRvxCjjJkQB5egryX3YLnhH/hxduSMU7MO9MnHEGkdy1fpWMoPuH6wK/0yDHUFB
         12OCren5YTBdc/s65ZziTyKxVfsh7Wye0uZSrGVR6gofem0lvTKu0Drb1GI6UpEGs5
         60CnmyQxiF6WucCNa6zvvR+jOCuxceher0Zfd96g=
Date:   Wed, 30 Sep 2020 13:51:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20200930115106.GB1603625@kroah.com>
References: <20200929121953.2817843-1-poeschel@lemonage.de>
 <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
 <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
 <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
 <20200930095204.GA1585476@kroah.com>
 <20200930100126.rtjfnmbc54m7vrwd@pengutronix.de>
 <20200930105238.GA1592367@kroah.com>
 <20200930112720.xiff3xwmfu3gjypk@lem-wkst-02.lemonage>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930112720.xiff3xwmfu3gjypk@lem-wkst-02.lemonage>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 30, 2020 at 01:27:20PM +0200, Lars Poeschel wrote:
> On Wed, Sep 30, 2020 at 12:52:38PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 30, 2020 at 12:01:26PM +0200, Uwe Kleine-König wrote:
> > > On Wed, Sep 30, 2020 at 11:52:04AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Sep 30, 2020 at 11:41:46AM +0200, Uwe Kleine-König wrote:
> > > > > Hello,
> > > > > 
> > > > > I added Greg Kroah-Hartman who I discussed this with via irc a bit to
> > > > > Cc:.
> > > > > 
> > > > > On Wed, Sep 30, 2020 at 11:20:56AM +0200, Lars Poeschel wrote:
> > > > > > thank you for your review!
> > > > > > 
> > > > > > On Wed, Sep 30, 2020 at 08:57:26AM +0200, Uwe Kleine-König wrote:
> > > > > > > On Tue, Sep 29, 2020 at 02:19:53PM +0200, poeschel@lemonage.de wrote:
> > > > > > > > From: Lars Poeschel <poeschel@lemonage.de>
> > > > > > > > 
> > > > > > > > This adds a class to exported pwm devices.
> > > > > > > > Exporting a pwm through sysfs did not yield udev events. The
> > > > > > > 
> > > > > > > I wonder what is your use-case here. This for sure also has a place to
> > > > > > > be mentioned in the commit log. I suspect there is a better way to
> > > > > > > accomplish you way.
> > > > > > 
> > > > > > Use-case is to be able to use a pwm from a non-root userspace process.
> > > > > > I use udev rules to adjust permissions.
> > > > > 
> > > > > Hmm, how do you trigger the export? Without being aware of all the
> > > > > details in the sysfs code I would expect that the exported stuff is
> > > > > available instantly once the write used to export the PWM is completed.
> > > > > So changing the permissions can be done directly after triggering the
> > > > > export in the same process.
> > > > 
> > > > It looks like userspace wants to see when a pwmX device shows up, right?
> > > > 
> > > > And it's not because those devices do not belong to any class or bus, so
> > > > they are just "floating" out there (they might show up under
> > > > /sys/bus/virtual, if you set things up right, which I don't think is
> > > > happening here...)
> > > > 
> > > > So yes, you need to create a class, or assign this to a bus, which is
> > > > fine, but it looks like no one is doing that.  Don't create new classes
> > > > dynamically, but rather, just assign this to the existing pwm class.
> > > > What's wrong with that?  I saw an older patch that did that, what did
> > > > that break?
> > > 
> > > Are you refering to 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00? Did you
> > > read the reverting commit's log message? (i.e.
> > > c289d6625237aa785b484b4e94c23b3b91ea7e60)
> > > 
> > > I guess the breakage is that the resulting name then is:
> > > 
> > > 	"pwm%d", pwm->id
> > > 
> > > where pwm->id is a number unique to the pwmchip. So doing
> > > 
> > > 	echo 0 > pwmchip1/export
> > > 	echo 0 > pwmchip2/export
> > > 
> > > breaks because both want to create pwm0 in the class directory.
> > 
> > Ah, that makes more sense why that didn't work.
> > 
> > Ok, can the "name" of the new export chip be changed?  Is that
> > hard-coded somewhere in userspace tools already?  Depending on that, the
> > solution for this will change...
> 
> I know that back then, when sysfs for pwm was created, Thierry didn't
> want to have one global namespace like gpio sysfs has. What you ask for
> is something like:
> 	pwm-{chipnumber}-{pwmnumber}
> Right ? Can that be considered non-global ?

Yes, and that's just "global" for the pwm class namespace.

> Thierry's mail from back then is here:
> https://lore.kernel.org/lkml/20130408081745.GA21392@avionic-0098.mockup.avionic-design.de/
> 
> A short search on github I found this:
> https://github.com/vsergeev/c-periphery/blob/d34077d7ee45fa7d1947cc0174919452fac31597/src/pwm.c#L74
> 
> Seems to match your hardcoded criteria ?

Yes, ugh :(

Ok, now I see why the "lots of pwm classes!" patch was proposed.

And maybe that's really the only way forward here, as the chip namespace
is the only unique thing.

But wow, it feels wrong...

greg k-h
