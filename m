Return-Path: <linux-pwm+bounces-5391-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 195BAA8123B
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 18:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8803B9294
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 16:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528FF22D4E7;
	Tue,  8 Apr 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xrrudmE0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79F22AE59
	for <linux-pwm@vger.kernel.org>; Tue,  8 Apr 2025 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129227; cv=none; b=nddKjSnmWE+k3Vzj5qfk+FoB9LWk2kpsqHWGdjNkZvysvT678ywcq2brJ5625fyef3ELEHdBQPm9CyCSxxYZwdkFpecQTrF9HpIPKeRdxiTevjsDHjAVNfnaxaw3z4XL3sh32GtTEHK8qw+MHtBoXaP5eOY/c1MNckKT03acwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129227; c=relaxed/simple;
	bh=mbX5iwHkGGvS23LhN/nABDzgdlnt+gfQgAEQpklHqLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npVAFP3CjkTHROvX4RZ7tfbSAt5Bi8b/HNjp0ypQb9zFMwJhWCIJyu/iZljQ3354ChdFFjHTWGsG4q1otDgoiNQF71rQlZEF3QnANU4doSSHUtmFgYnWlOBpZDWItva9LtJT5XtREXik24byCUidQGN/LdkQiUCf+13IGT+Nrxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xrrudmE0; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-60219a77334so2921076eaf.1
        for <linux-pwm@vger.kernel.org>; Tue, 08 Apr 2025 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744129221; x=1744734021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mEOOr1sWCtshA5MI12i9aWOP7q5n2OO6W/itEz8Mug=;
        b=xrrudmE0cN8SH/PJz7jK4pJZqsXnVaISIxYuLHXMRVBxFiK4oajUPCb9NJVBGhmTPt
         OsjCZlWafcpiMNVgqIloVJ4rrIqfL3gUI6FyEPnJ+PJbqFHENfzbxw1cYlh1+2qlsQAP
         HM/iYPL8Tch4lBJZVAfZh4B9o7+4kQIecBH/BThRfZMixarSoluA9xy6zze/HyuVQA6X
         9wQ/LMnCA+AIBiN5XfDnjhZ9J0kiXMxTWkgpCvsVTRpGIju2bPr+IALYkf81WkHyjQog
         K2tjZ8jPmEvjEHoaqX6ZCkOHMJ5kuR04Cn78L4qupNfNJhjCNjMsFABwz0GNSNnAd51c
         3ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744129221; x=1744734021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mEOOr1sWCtshA5MI12i9aWOP7q5n2OO6W/itEz8Mug=;
        b=denVbUG+ru+A8ARF2wNGnbv+kz9U87Rq4c3Eq1mlCFtlEixWD/wyb80kFA9Z3yr4Ui
         uD9WlDU1niFuZDff1G0F+L98yOhSzkem3NttbEtG5NhWG+u7boF6XTtwdyQPJWcb/9Mm
         sxXfTTyYbh0hYhWt2yBJdF7V15DGf0ArESrJFWSejfju5lbSramieN0nCeAgxH2ToDXF
         b/RkdAuyxUBkh/THcI89pp1ddus2FiJzolkN3M6+DtpOtXBv7Qkq7uupuOLAVlFReNxT
         2wnqiC9cC4ZhwNs5MB6h729MKw1cbg98ENMsJozxlcfDXq5VjTqsXOLyWh2yVGU9Ymht
         UhpA==
X-Forwarded-Encrypted: i=1; AJvYcCXkrFOKl5yIIXqsFqUgHxRdv+D8klFbV4Ti+RK8YK0dK/YiuKdAYLLpFt4DIvQkB0kGOtmqoEp9XcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6mLmlqUyaalFncf5T9WxsrjKmfcG5IEKyzY47+eq8cSaQjLCM
	DraN9tig1sUH7LQFRF0rWP9ylgpXCcqlCXgTlLGhnk1+KPkIziBZaelBhmVqAo4=
X-Gm-Gg: ASbGncv61FZFXE3R49HAZN5pq3F1Tkw2GKVEYYOwND6SBj/u+21skNWx/nzi/FaQDrA
	zWjK92PY5su1TnYm79+SDOL1EPmrhRuooYI/mpwKnOtyeDTyWDgQpkpt++2OITW7pTJQ+leLDGu
	BykcSvkDmJRBoCQDcA/0R3iAN5dQQecefOwrFAxWz+rEEWxvp9PJC1MC1V35nvCXK/XV6TRs7kO
	kBVAzd7ERuMCVvS0YbT79Mn9eNqpEjxNxCRaqGtp9eaZhD9bZD9TNF8knPH6Eu+7WSuVPzng/j3
	fucPnYqU2Xfck8sTrLmYodI4wWJadp6SGOVoo+LMSl8h7A2Yn519xtLmSNsE2Xbs9uvnIgLdidG
	bUha00UNY5J/hR9CV
X-Google-Smtp-Source: AGHT+IEtIHNWf7PL8ZRpSL0EGx2wcIgJ6x//JY/kbHPt0Fscfk2vCj0zJavGPocpsXg/DSXd5ewYkQ==
X-Received: by 2002:a05:6820:811a:b0:604:2ac:840a with SMTP id 006d021491bc7-604166fd0e3mr9060132eaf.6.1744129221451;
        Tue, 08 Apr 2025 09:20:21 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6044f951c3bsm512743eaf.29.2025.04.08.09.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 09:20:20 -0700 (PDT)
Message-ID: <6779558a-3ebd-4fab-a0fb-95f2936b726c@baylibre.com>
Date: Tue, 8 Apr 2025 11:20:19 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] pwm: Add support for pwmchip devices for faster
 and easier userspace access
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org
References: <cover.1744120697.git.ukleinek@kernel.org>
 <f31fea4002d62ba5c1f9f95ca58a182ecc5bc3a6.1744120697.git.ukleinek@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <f31fea4002d62ba5c1f9f95ca58a182ecc5bc3a6.1744120697.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/8/25 9:23 AM, Uwe Kleine-König wrote:
> With this change each pwmchip defining the new-style waveform callbacks
> can be accessed from userspace via a character device. Compared to the
> sysfs-API this is faster (on a stm32mp157 applying a new configuration
> takes approx 25% only) and allows to pass the whole configuration in a
> single ioctl allowing atomic application.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---

...

> +static int pwm_cdev_request(struct pwm_cdev_data *cdata, unsigned int hwpwm)
> +{
> +	struct pwm_chip *chip = cdata->chip;
> +
> +	if (hwpwm >= chip->npwm)
> +		return -EINVAL;
> +
> +	if (!cdata->pwm[hwpwm]) {
> +		struct pwm_device *pwm = &chip->pwms[hwpwm];
> +		const char *label;
> +		int ret;
> +
> +		label = kasprintf(GFP_KERNEL, "pwm-cdev (pid=%d)", current->pid);
> +		if (!label)
> +			return -ENOMEM;
> +
> +		ret = pwm_device_request(pwm, label);
> +		if (ret < 0)

Should kfree(label) before error return?

> +			return ret;
> +
> +		cdata->pwm[hwpwm] = pwm;
> +	}
> +
> +	return 0;
> +}
> +

...

> +static long pwm_cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	int ret = 0;
> +	struct pwm_cdev_data *cdata = file->private_data;
> +	struct pwm_chip *chip = cdata->chip;
> +
> +	guard(mutex)(&pwm_lock);
> +
> +	if (!chip->operational)
> +		return -ENODEV;
> +
> +	switch (cmd) {
> +	case PWM_IOCTL_REQUEST:
> +		{
> +			unsigned int hwpwm = arg;
> +
> +			return pwm_cdev_request(cdata, hwpwm);
> +		}
> +		break;

Unreachable code? Should be able to removed all of the breaks without any
compiler complaining - otherwise it would already be complaining about no
return at the end of the funtion where the break jumps to.

> +
> +	case PWM_IOCTL_FREE:
> +		{
> +			unsigned int hwpwm = arg;
> +
> +			return pwm_cdev_free(cdata, hwpwm);
> +		}
> +		break;
> +
> +	case PWM_IOCTL_ROUNDWF:
> +		{
> +			struct pwmchip_waveform cwf;
> +			struct pwm_waveform wf;
> +			struct pwm_device *pwm;
> +
> +			ret = copy_from_user(&cwf,
> +					     (struct pwmchip_waveform __user *)arg,
> +					     sizeof(cwf));
> +			if (ret)
> +				return -EFAULT;
> +
> +			if (cwf.__pad != 0)
> +				return -EINVAL;
> +
> +			pwm = pwm_cdev_get_requested_pwm(cdata, cwf.hwpwm);
> +			if (IS_ERR(pwm))
> +				return PTR_ERR(pwm);
> +
> +			wf = (struct pwm_waveform) {
> +				.period_length_ns = cwf.period_length_ns,
> +				.duty_length_ns = cwf.duty_length_ns,
> +				.duty_offset_ns = cwf.duty_offset_ns,
> +			};
> +
> +			ret = pwm_round_waveform_might_sleep(pwm, &wf);
> +			if (ret < 0)
> +				return ret;
> +
> +			cwf = (struct pwmchip_waveform) {
> +				.hwpwm = cwf.hwpwm,
> +				.period_length_ns = wf.period_length_ns,
> +				.duty_length_ns = wf.duty_length_ns,
> +				.duty_offset_ns = wf.duty_offset_ns,
> +			};
> +
> +			return copy_to_user((struct pwmchip_waveform __user *)arg,
> +					    &cwf, sizeof(cwf));
> +		}
> +		break;
> +
> +	case PWM_IOCTL_GETWF:
> +		{
> +			struct pwmchip_waveform cwf;
> +			struct pwm_waveform wf;
> +			struct pwm_device *pwm;
> +
> +			ret = copy_from_user(&cwf,
> +					     (struct pwmchip_waveform __user *)arg,
> +					     sizeof(cwf));
> +			if (ret)
> +				return -EFAULT;
> +
> +			if (cwf.__pad != 0)
> +				return -EINVAL;

Since this is get-only (argument is purly output), should we not check this
to allow userspace to be able to pass an unintialized struct without error?

> +
> +			pwm = pwm_cdev_get_requested_pwm(cdata, cwf.hwpwm);
> +			if (IS_ERR(pwm))
> +				return PTR_ERR(pwm);
> +
> +			ret = pwm_get_waveform_might_sleep(pwm, &wf);
> +			if (ret)
> +				return ret;
> +
> +			cwf.period_length_ns = wf.period_length_ns;
> +			cwf.duty_length_ns = wf.duty_length_ns;
> +			cwf.duty_offset_ns = wf.duty_offset_ns;

Odd to use different style for setting struct here compared to the other cases.
(I prefer this one since it is less lines of code to read and less indent.)

> +
> +			return copy_to_user((struct pwmchip_waveform __user *)arg,
> +					    &cwf, sizeof(cwf));
> +		}
> +		break;
> +
> +	case PWM_IOCTL_SETROUNDEDWF:
> +	case PWM_IOCTL_SETEXACTWF:
> +		{
> +			struct pwmchip_waveform cwf;
> +			struct pwm_waveform wf;
> +			struct pwm_device *pwm;
> +
> +			ret = copy_from_user(&cwf,
> +					     (struct pwmchip_waveform __user *)arg,
> +					     sizeof(cwf));
> +			if (ret)
> +				return -EFAULT;
> +
> +			if (cwf.__pad != 0)
> +				return -EINVAL;
> +
> +			wf = (struct pwm_waveform){
> +				.period_length_ns = cwf.period_length_ns,
> +				.duty_length_ns = cwf.duty_length_ns,
> +				.duty_offset_ns = cwf.duty_offset_ns,
> +			};
> +
> +			if (!pwm_wf_valid(&wf))
> +				return -EINVAL;
> +
> +			pwm = pwm_cdev_get_requested_pwm(cdata, cwf.hwpwm);
> +			if (IS_ERR(pwm))
> +				return PTR_ERR(pwm);
> +
> +			return pwm_set_waveform_might_sleep(pwm, &wf,
> +							    cmd == PWM_IOCTL_SETEXACTWF);

For PWM_IOCTL_SETROUNDEDWF case, should we be copying the modifed waveform back
to userspace so that it can know what rounding what actually applied without having
to call PWM_IOCTL_GETWF?

> +		}
> +		break;> +
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
> +static const struct file_operations pwm_cdev_fileops = {
> +	.open = pwm_cdev_open,
> +	.release = pwm_cdev_release,
> +	.owner = THIS_MODULE,
> +	.unlocked_ioctl = pwm_cdev_ioctl,
> +};
> +
> +static dev_t pwm_devt;
> +
>  /**
>   * __pwmchip_add() - register a new PWM chip
>   * @chip: the PWM chip to add
> @@ -2115,7 +2376,13 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
>  	scoped_guard(pwmchip, chip)
>  		chip->operational = true;
>  
> -	ret = device_add(&chip->dev);
> +	if (chip->id < 256 && chip->ops->write_waveform)
> +		chip->dev.devt = MKDEV(MAJOR(pwm_devt), chip->id);

if (chip->id >= 256 && chip->ops->write_waveform)
dev_warn("too many PWM devices, chardev will not be created for ...") ?

> +
> +	cdev_init(&chip->cdev, &pwm_cdev_fileops);
> +	chip->cdev.owner = owner;
> +
> +	ret = cdev_device_add(&chip->cdev, &chip->dev);
>  	if (ret)
>  		goto err_device_add;
>  
> @@ -2166,7 +2433,7 @@ void pwmchip_remove(struct pwm_chip *chip)
>  		idr_remove(&pwm_chips, chip->id);
>  	}
>  
> -	device_del(&chip->dev);
> +	cdev_device_del(&chip->cdev, &chip->dev);
>  }
>  EXPORT_SYMBOL_GPL(pwmchip_remove);
>  
> @@ -2310,9 +2577,16 @@ static int __init pwm_init(void)
>  {
>  	int ret;
>  
> +	ret = alloc_chrdev_region(&pwm_devt, 0, 256, "pwm");
> +	if (ret) {
> +		pr_warn("Failed to initialize chrdev region for PWM usage\n");

Why warn and not err?

> +		return ret;
> +	}
> +
>  	ret = class_register(&pwm_class);
>  	if (ret) {
>  		pr_err("Failed to initialize PWM class (%pe)\n", ERR_PTR(ret));
> +		unregister_chrdev_region(pwm_devt, 256);
>  		return ret;
>  	}
>  
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index bf0469b2201d..d8817afe95dc 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -2,6 +2,7 @@
>  #ifndef __LINUX_PWM_H
>  #define __LINUX_PWM_H
>  
> +#include <linux/cdev.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> @@ -309,6 +310,7 @@ struct pwm_ops {
>  /**
>   * struct pwm_chip - abstract a PWM controller
>   * @dev: device providing the PWMs
> + * @cdev: &struct cdev for this device
>   * @ops: callbacks for this PWM controller
>   * @owner: module providing this chip
>   * @id: unique number of this PWM chip
> @@ -323,6 +325,7 @@ struct pwm_ops {
>   */
>  struct pwm_chip {
>  	struct device dev;
> +	struct cdev cdev;
>  	const struct pwm_ops *ops;
>  	struct module *owner;
>  	unsigned int id;
> diff --git a/include/uapi/linux/pwm.h b/include/uapi/linux/pwm.h
> new file mode 100644
> index 000000000000..3d2c3cefc090
> --- /dev/null
> +++ b/include/uapi/linux/pwm.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_PWM_H_
> +#define _UAPI_PWM_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/**
> + * struct pwmchip_waveform - Describe a PWM waveform for a pwm_chip's PWM channel
> + * @hwpwm: per-chip relative index of the PWM device
> + * @__pad: padding, must be zero
> + * @period_length_ns: duration of the repeating period.
> + *    A value of 0 represents a disabled PWM.
> + * @duty_length_ns: duration of the active part in each period
> + * @duty_offset_ns: offset of the rising edge from a period's start
> + */
> +struct pwmchip_waveform {
> +	__u32 hwpwm;
> +	__u32 __pad;
> +	__u64 period_length_ns;
> +	__u64 duty_length_ns;
> +	__u64 duty_offset_ns;
> +};
> +
> +/* Reserves the passed hwpwm for exclusive control. */
> +#define PWM_IOCTL_REQUEST	_IO(0x75, 1)
> +
> +/* counter part to PWM_IOCTL_REQUEST */
> +#define PWM_IOCTL_FREE		_IO(0x75, 2)
> +
> +/*
> + * Modifies the passed wf according to hardware constraints. All parameters are
> + * rounded down to the next possible value, unless there is no such value, then

Technically, isn't 0 a possible value (at least for duty length/offset)?

So maybe more clear to say that if the requested value is non-zero then the
value will be rounded down unless the result would be zero in which case
the resulting value will the be smallest possible non-zero value.

> + * values are rounded up.
> + */
> +#define PWM_IOCTL_ROUNDWF	_IOWR(0x75, 3, struct pwmchip_waveform)
> +
> +/* Get the currently implemented waveform */
> +#define PWM_IOCTL_GETWF		_IOWR(0x75, 4, struct pwmchip_waveform)
> +
> +/* Like PWM_IOCTL_GETWF + PWM_IOCTL_SETROUNDEDWF in one go. */

Is this supposed to say "Like PWM_IOCTL_ROUNDWF + PWM_IOCTL_SETEXACTWF in one go"?

> +#define PWM_IOCTL_SETROUNDEDWF	_IOW(0x75, 5, struct pwmchip_waveform)
> +
> +/*
> + * Program the PWM to emit exactly the passed waveform, subject only to rounding
> + * down each value less than 1 ns.

Otherwise returns and error? What error codes could we expect?

> + */
> +#define PWM_IOCTL_SETEXACTWF	_IOW(0x75, 6, struct pwmchip_waveform)
> +
> +#endif /* _UAPI_PWM_H_ */


