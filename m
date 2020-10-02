Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60D5281315
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Oct 2020 14:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbgJBMqU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Oct 2020 08:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgJBMqT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 2 Oct 2020 08:46:19 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17FC6206CD;
        Fri,  2 Oct 2020 12:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601642777;
        bh=fa8+43VJW2CwRdhfgbeNrekJyH+rurDoEBlBYSP/trc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2VEvdYSLvOPfnBqOn4Q6cikgVNV1LQbv90343MmGSySe7NW8IBMDkVme5w3nwPo7q
         p4Ki3cwQH32pVivcjB33LzoCCexBqmXNkZpdDpXq/BnW4UHOhdCvGCpzZTa4LA9s+O
         jCWB41vHzizZAhhZMJPLc3uebduLtGInPTtWceNI=
Date:   Fri, 2 Oct 2020 14:46:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     poeschel@lemonage.de
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] pwm: sysfs: Set class on pwm devices
Message-ID: <20201002124616.GB3348424@kroah.com>
References: <20201002123048.3073128-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002123048.3073128-1-poeschel@lemonage.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 02, 2020 at 02:30:47PM +0200, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> This adds a class to exported pwm devices.
> Exporting a pwm through sysfs did not yield udev events. The
> dev_uevent_filter function does filter-out devices without a bus or
> class.
> This was already addressed in commit
> commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sysfs")
> but this did cause problems and the commit got reverted with
> commit c289d6625237 ("Revert "pwm: Set class for exported channels in
> sysfs"")
> Problem with the previous approach was, that there is a clash if we have
> multiple pwmchips:
> 	echo 0 > pwmchip0/export
> 	echo 0 > pwmchip1/export
> would both export /sys/class/pwm/pwm0 .
> 
> Now this patch changes the sysfs interface. We do include the pwmchip
> number into the pwm directory that gets exported.
> With the example above we get:
> 	/sys/class/pwm/pwm-0-0
> 	/sys/class/pwm/pwm-1-0
> We maintain ABI backward compatibility through symlinks.
> 	/sys/class/pwm/pwmchip0/pwm0
> 	/sys/class/pwm/pwmchip1/pwm0
> are now symbolic links to the new names.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
>  drivers/pwm/sysfs.c | 57 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 449dbc0f49ed..c708da17a857 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -240,8 +240,10 @@ static void pwm_export_release(struct device *child)
>  
>  static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
>  {
> +	struct pwm_chip *chip = dev_get_drvdata(parent);
>  	struct pwm_export *export;
>  	char *pwm_prop[2];
> +	char *link_name;
>  	int ret;
>  
>  	if (test_and_set_bit(PWMF_EXPORTED, &pwm->flags))
> @@ -256,25 +258,39 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
>  	export->pwm = pwm;
>  	mutex_init(&export->lock);
>  
> +	export->child.class = parent->class;
>  	export->child.release = pwm_export_release;
>  	export->child.parent = parent;
>  	export->child.devt = MKDEV(0, 0);
>  	export->child.groups = pwm_groups;
> -	dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
> +	dev_set_name(&export->child, "pwm-%u-%u", chip->base, pwm->hwpwm);
>  
>  	ret = device_register(&export->child);
> -	if (ret) {
> -		clear_bit(PWMF_EXPORTED, &pwm->flags);
> -		put_device(&export->child);
> -		export = NULL;
> -		return ret;
> +	if (ret)
> +		goto error;
> +
> +	link_name = kasprintf(GFP_KERNEL, "pwm%u", pwm->hwpwm);
> +	if (link_name == NULL) {
> +		ret = -ENOMEM;
> +		goto dev_unregister;
>  	}
> -	pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=pwm%u", pwm->hwpwm);
> +
> +	pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=%s",
> +			export->child.kobj.name);
>  	pwm_prop[1] = NULL;
>  	kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);

Do you still need to do this by hand?  Why can't this uevent field
belong to the class and have it create this for you automatically when
the device is added?

>  	kfree(pwm_prop[0]);
>  
> -	return 0;
> +	ret = sysfs_create_link(&parent->kobj, &export->child.kobj, link_name);

You create the link _after_ you told userspace it was there, you raced
and lost :(



> +	return ret;
> +
> +dev_unregister:
> +	device_unregister(&export->child);
> +error:
> +	clear_bit(PWMF_EXPORTED, &pwm->flags);
> +	put_device(&export->child);
> +	export = NULL;
> +	return ret;
>  }
>  
>  static int pwm_unexport_match(struct device *child, void *data)
> @@ -286,6 +302,7 @@ static int pwm_unexport_child(struct device *parent, struct pwm_device *pwm)
>  {
>  	struct device *child;
>  	char *pwm_prop[2];
> +	char *link_name;
>  
>  	if (!test_and_clear_bit(PWMF_EXPORTED, &pwm->flags))
>  		return -ENODEV;
> @@ -294,7 +311,11 @@ static int pwm_unexport_child(struct device *parent, struct pwm_device *pwm)
>  	if (!child)
>  		return -ENODEV;
>  
> -	pwm_prop[0] = kasprintf(GFP_KERNEL, "UNEXPORT=pwm%u", pwm->hwpwm);
> +	link_name = kasprintf(GFP_KERNEL, "pwm%u", pwm->hwpwm);
> +	if (link_name)
> +		sysfs_delete_link(&parent->kobj, &child->kobj, link_name);
> +
> +	pwm_prop[0] = kasprintf(GFP_KERNEL, "UNEXPORT=%s", child->kobj.name);
>  	pwm_prop[1] = NULL;
>  	kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);

Same uevent question here.

Otherwise, this looks good, nice work in figuring out the is_visable
stuff and everything.

thanks,

greg k-h
