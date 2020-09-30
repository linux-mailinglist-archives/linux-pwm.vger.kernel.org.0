Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D7B27E7A0
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Sep 2020 13:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgI3L1b (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Sep 2020 07:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgI3L1b (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Sep 2020 07:27:31 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41DAC061755;
        Wed, 30 Sep 2020 04:27:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id E092223EF77;
        Wed, 30 Sep 2020 13:27:26 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.959
X-Spam-Level: 
X-Spam-Status: No, score=-2.959 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.059, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id llZp6sPGOpxR; Wed, 30 Sep 2020 13:27:25 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPSA id D8BA223F7B0;
        Wed, 30 Sep 2020 13:27:24 +0200 (CEST)
Date:   Wed, 30 Sep 2020 13:27:20 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20200930112720.xiff3xwmfu3gjypk@lem-wkst-02.lemonage>
References: <20200929121953.2817843-1-poeschel@lemonage.de>
 <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
 <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
 <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
 <20200930095204.GA1585476@kroah.com>
 <20200930100126.rtjfnmbc54m7vrwd@pengutronix.de>
 <20200930105238.GA1592367@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930105238.GA1592367@kroah.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 30, 2020 at 12:52:38PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 30, 2020 at 12:01:26PM +0200, Uwe Kleine-König wrote:
> > On Wed, Sep 30, 2020 at 11:52:04AM +0200, Greg Kroah-Hartman wrote:
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
> > > It looks like userspace wants to see when a pwmX device shows up, right?
> > > 
> > > And it's not because those devices do not belong to any class or bus, so
> > > they are just "floating" out there (they might show up under
> > > /sys/bus/virtual, if you set things up right, which I don't think is
> > > happening here...)
> > > 
> > > So yes, you need to create a class, or assign this to a bus, which is
> > > fine, but it looks like no one is doing that.  Don't create new classes
> > > dynamically, but rather, just assign this to the existing pwm class.
> > > What's wrong with that?  I saw an older patch that did that, what did
> > > that break?
> > 
> > Are you refering to 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00? Did you
> > read the reverting commit's log message? (i.e.
> > c289d6625237aa785b484b4e94c23b3b91ea7e60)
> > 
> > I guess the breakage is that the resulting name then is:
> > 
> > 	"pwm%d", pwm->id
> > 
> > where pwm->id is a number unique to the pwmchip. So doing
> > 
> > 	echo 0 > pwmchip1/export
> > 	echo 0 > pwmchip2/export
> > 
> > breaks because both want to create pwm0 in the class directory.
> 
> Ah, that makes more sense why that didn't work.
> 
> Ok, can the "name" of the new export chip be changed?  Is that
> hard-coded somewhere in userspace tools already?  Depending on that, the
> solution for this will change...

I know that back then, when sysfs for pwm was created, Thierry didn't
want to have one global namespace like gpio sysfs has. What you ask for
is something like:
	pwm-{chipnumber}-{pwmnumber}
Right ? Can that be considered non-global ?

Thierry's mail from back then is here:
https://lore.kernel.org/lkml/20130408081745.GA21392@avionic-0098.mockup.avionic-design.de/

A short search on github I found this:
https://github.com/vsergeev/c-periphery/blob/d34077d7ee45fa7d1947cc0174919452fac31597/src/pwm.c#L74

Seems to match your hardcoded criteria ?

Regards,
Lars
