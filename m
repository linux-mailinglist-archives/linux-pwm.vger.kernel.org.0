Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC127E4FE
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Sep 2020 11:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgI3JVG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Sep 2020 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgI3JVG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Sep 2020 05:21:06 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E213C061755;
        Wed, 30 Sep 2020 02:21:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 9BEED23F11A;
        Wed, 30 Sep 2020 11:21:02 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.989
X-Spam-Level: 
X-Spam-Status: No, score=-2.989 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.089, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4AnRcm7mO10H; Wed, 30 Sep 2020 11:21:01 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPSA id 487A123F15A;
        Wed, 30 Sep 2020 11:21:01 +0200 (CEST)
Date:   Wed, 30 Sep 2020 11:20:56 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
References: <20200929121953.2817843-1-poeschel@lemonage.de>
 <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

thank you for your review!

On Wed, Sep 30, 2020 at 08:57:26AM +0200, Uwe Kleine-König wrote:
> Hello Lars,
> 
> On Tue, Sep 29, 2020 at 02:19:53PM +0200, poeschel@lemonage.de wrote:
> > From: Lars Poeschel <poeschel@lemonage.de>
> > 
> > This adds a class to exported pwm devices.
> > Exporting a pwm through sysfs did not yield udev events. The
> 
> I wonder what is your use-case here. This for sure also has a place to
> be mentioned in the commit log. I suspect there is a better way to
> accomplish you way.

Use-case is to be able to use a pwm from a non-root userspace process.
I use udev rules to adjust permissions.

> > dev_uevent_filter function does filter-out devices without a bus or
> > class.
> > This was already addressed in commit
> > commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sysfs")
> > but this did cause problems and the commit got reverted with
> > commit c289d6625237 ("Revert "pwm: Set class for exported channels in
> > sysfs"")
> > 
> > pwm's have to be local to its pwmchip, so we create an individual class
> > for each pwmchip
> 
> This sounds conceptually wrong. 

I suspect you mean the second part is wrong and we agree on the first
part, that pwm's have to be local to its pwmchip.

There seems to be a need for this as 7e5d1fd75c3d tried this already.
Problem with this approach was, that the pwms where not local to their
pwmchip and if you then have the same pwm number exported from different
pwmchips this did collide.

Ok, now the uevent_ops filter function blocks the uevent I want to see
based on if device has a bus or a class set.

Can you recommend a better solution ?
Write a different filter function for this case ?

> > and assign this class to the pwm belonging to the
> > pwmchip. This does better map to structure that is also visible in
> > sysfs.
> > 
> > Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> > ---
> >  drivers/pwm/sysfs.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> > index 449dbc0f49ed..e2dfbc335366 100644
> > --- a/drivers/pwm/sysfs.c
> > +++ b/drivers/pwm/sysfs.c
> > @@ -259,7 +259,7 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
> >  	export->child.release = pwm_export_release;
> >  	export->child.parent = parent;
> >  	export->child.devt = MKDEV(0, 0);
> > -	export->child.groups = pwm_groups;
> > +	export->child.class = parent->class;
> >  	dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
> >  
> >  	ret = device_register(&export->child);
> > @@ -499,6 +499,9 @@ void pwmchip_sysfs_export(struct pwm_chip *chip)
> >  		dev_warn(chip->dev,
> >  			 "device_create failed for pwm_chip sysfs export\n");
> >  	}
> > +
> > +	parent->class = class_create(THIS_MODULE, parent->kobj.name);
> 
> This needs error handling.

If this concept has a chance after discussion, I will change this.

Thanks again,
Lars
