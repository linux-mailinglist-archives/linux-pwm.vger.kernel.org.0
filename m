Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDE727E5AA
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Sep 2020 11:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgI3JwC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Sep 2020 05:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgI3JwB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 30 Sep 2020 05:52:01 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B0732074A;
        Wed, 30 Sep 2020 09:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601459521;
        bh=sc+AQYG1RYfRu1GfD0zZ2JdLkx36ONLoOSKxzRGYl+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHevHf2ZIyWvAhviCcNO55bnfgd3PWWLS4IM5QDsNQptwb5yVfs3UBqH94RksgG/M
         ejK2dCh9w93TmYYKlpIiZuoHr4ZkAI19oHVti/kLS+zEV0lzmvEQnjtQqWKqJARHtE
         Y0zqD9CWTpDxGNJKY/mtjFih/iK/31Std6MpAGjE=
Date:   Wed, 30 Sep 2020 11:52:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20200930095204.GA1585476@kroah.com>
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

It looks like userspace wants to see when a pwmX device shows up, right?

And it's not because those devices do not belong to any class or bus, so
they are just "floating" out there (they might show up under
/sys/bus/virtual, if you set things up right, which I don't think is
happening here...)

So yes, you need to create a class, or assign this to a bus, which is
fine, but it looks like no one is doing that.  Don't create new classes
dynamically, but rather, just assign this to the existing pwm class.
What's wrong with that?  I saw an older patch that did that, what did
that break?

thanks,

greg k-h
