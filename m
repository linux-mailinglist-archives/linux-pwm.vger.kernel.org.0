Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC82813BD
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Oct 2020 15:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgJBNIw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Oct 2020 09:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBNIw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Oct 2020 09:08:52 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7112C0613D0;
        Fri,  2 Oct 2020 06:08:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 786B223F1E7;
        Fri,  2 Oct 2020 15:08:50 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.986
X-Spam-Level: 
X-Spam-Status: No, score=-2.986 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.086, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yx2oadCAFhM1; Fri,  2 Oct 2020 15:08:49 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPSA id F1D1923F180;
        Fri,  2 Oct 2020 15:08:48 +0200 (CEST)
Date:   Fri, 2 Oct 2020 15:08:44 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] pwm: sysfs: Set class on pwm devices
Message-ID: <20201002130844.udikqwzspp6zlyhh@lem-wkst-02.lemonage>
References: <20201002123048.3073128-1-poeschel@lemonage.de>
 <20201002124616.GB3348424@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002124616.GB3348424@kroah.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 02, 2020 at 02:46:16PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 02, 2020 at 02:30:47PM +0200, poeschel@lemonage.de wrote:
> > From: Lars Poeschel <poeschel@lemonage.de>
> > 
> > This adds a class to exported pwm devices.
> > Exporting a pwm through sysfs did not yield udev events. The
> > dev_uevent_filter function does filter-out devices without a bus or
> > class.
> > This was already addressed in commit
> > commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sysfs")
> > but this did cause problems and the commit got reverted with
> > commit c289d6625237 ("Revert "pwm: Set class for exported channels in
> > sysfs"")
> > Problem with the previous approach was, that there is a clash if we have
> > multiple pwmchips:
> > 	echo 0 > pwmchip0/export
> > 	echo 0 > pwmchip1/export
> > would both export /sys/class/pwm/pwm0 .
> > 
> > Now this patch changes the sysfs interface. We do include the pwmchip
> > number into the pwm directory that gets exported.
> > With the example above we get:
> > 	/sys/class/pwm/pwm-0-0
> > 	/sys/class/pwm/pwm-1-0
> > We maintain ABI backward compatibility through symlinks.
> > 	/sys/class/pwm/pwmchip0/pwm0
> > 	/sys/class/pwm/pwmchip1/pwm0
> > are now symbolic links to the new names.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> > ---
> >  drivers/pwm/sysfs.c | 57 +++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 47 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> > index 449dbc0f49ed..c708da17a857 100644
> > --- a/drivers/pwm/sysfs.c
> > +++ b/drivers/pwm/sysfs.c
> > @@ -240,8 +240,10 @@ static void pwm_export_release(struct device *child)
> >  
> >  static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
> >  {
> > +	struct pwm_chip *chip = dev_get_drvdata(parent);
> >  	struct pwm_export *export;
> >  	char *pwm_prop[2];
> > +	char *link_name;
> >  	int ret;
> >  
> >  	if (test_and_set_bit(PWMF_EXPORTED, &pwm->flags))
> > @@ -256,25 +258,39 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
> >  	export->pwm = pwm;
> >  	mutex_init(&export->lock);
> >  
> > +	export->child.class = parent->class;
> >  	export->child.release = pwm_export_release;
> >  	export->child.parent = parent;
> >  	export->child.devt = MKDEV(0, 0);
> >  	export->child.groups = pwm_groups;
> > -	dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
> > +	dev_set_name(&export->child, "pwm-%u-%u", chip->base, pwm->hwpwm);
> >  
> >  	ret = device_register(&export->child);
> > -	if (ret) {
> > -		clear_bit(PWMF_EXPORTED, &pwm->flags);
> > -		put_device(&export->child);
> > -		export = NULL;
> > -		return ret;
> > +	if (ret)
> > +		goto error;
> > +
> > +	link_name = kasprintf(GFP_KERNEL, "pwm%u", pwm->hwpwm);
> > +	if (link_name == NULL) {
> > +		ret = -ENOMEM;
> > +		goto dev_unregister;
> >  	}
> > -	pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=pwm%u", pwm->hwpwm);
> > +
> > +	pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=%s",
> > +			export->child.kobj.name);
> >  	pwm_prop[1] = NULL;
> >  	kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
> 
> Do you still need to do this by hand?  Why can't this uevent field
> belong to the class and have it create this for you automatically when
> the device is added?

I did not add this with my patch, it was there before and I wonder, what
purpose it served, since the uevent was filtered because there was no
class there.
Now we have a class and now it works and this is what happens:

/sys/class/pwm# echo 0 > pwmchip1/export 
KERNEL[2111.952725] add      /devices/platform/ocp/48302000.epwmss/48302200.pwm/pwm/pwmchip1/pwm-1-0 (pwm)
ACTION=add
DEVPATH=/devices/platform/ocp/48302000.epwmss/48302200.pwm/pwm/pwmchip1/pwm-1-0
SEQNUM=1546
SUBSYSTEM=pwm

KERNEL[2111.955155] change   /devices/platform/ocp/48302000.epwmss/48302200.pwm/pwm/pwmchip1 (pwm)
ACTION=change
DEVPATH=/devices/platform/ocp/48302000.epwmss/48302200.pwm/pwm/pwmchip1
EXPORT=pwm-1-0
SEQNUM=1547
SUBSYSTEM=pwm

The first event is the event from device_register. It informs us that we
now have a new pwm-1-0. Nice.
The second is the event done here "by hand". It informs us, that
pwmchip1 changed. It has a new export now. For me personally this is not
needed, but also I don't think it is wrong.
You decide!

> >  	kfree(pwm_prop[0]);
> >  
> > -	return 0;
> > +	ret = sysfs_create_link(&parent->kobj, &export->child.kobj, link_name);
> 
> You create the link _after_ you told userspace it was there, you raced
> and lost :(

Are you sure ?
We inform userspace that there is a "pwm-1-0" now available. We do not say
anything about "pwm0". "pwm0" is the name of our symlink. This should
not be a problem.

> > +	return ret;
> > +
> > +dev_unregister:
> > +	device_unregister(&export->child);
> > +error:
> > +	clear_bit(PWMF_EXPORTED, &pwm->flags);
> > +	put_device(&export->child);
> > +	export = NULL;
> > +	return ret;
> >  }
> >  
> >  static int pwm_unexport_match(struct device *child, void *data)
> > @@ -286,6 +302,7 @@ static int pwm_unexport_child(struct device *parent, struct pwm_device *pwm)
> >  {
> >  	struct device *child;
> >  	char *pwm_prop[2];
> > +	char *link_name;
> >  
> >  	if (!test_and_clear_bit(PWMF_EXPORTED, &pwm->flags))
> >  		return -ENODEV;
> > @@ -294,7 +311,11 @@ static int pwm_unexport_child(struct device *parent, struct pwm_device *pwm)
> >  	if (!child)
> >  		return -ENODEV;
> >  
> > -	pwm_prop[0] = kasprintf(GFP_KERNEL, "UNEXPORT=pwm%u", pwm->hwpwm);
> > +	link_name = kasprintf(GFP_KERNEL, "pwm%u", pwm->hwpwm);
> > +	if (link_name)
> > +		sysfs_delete_link(&parent->kobj, &child->kobj, link_name);
> > +
> > +	pwm_prop[0] = kasprintf(GFP_KERNEL, "UNEXPORT=%s", child->kobj.name);
> >  	pwm_prop[1] = NULL;
> >  	kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
> 
> Same uevent question here.
> 
> Otherwise, this looks good, nice work in figuring out the is_visable
> stuff and everything.

Thanks! :-)
And thank you for your help so far.

Regards,
Lars
