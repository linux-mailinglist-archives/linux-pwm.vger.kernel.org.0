Return-Path: <linux-pwm+bounces-2734-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C8292A8CB
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 20:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F97B20D12
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A00514388F;
	Mon,  8 Jul 2024 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KyNkzBIH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECD21474A8
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jul 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462389; cv=none; b=TSrdzWiebycgwhc9oS1CaaqrTIh6c1GqHCa1+BMDNTtJNa4qFjmaxEow9BLiRwLHqFwjvMITf2TiyGTPaiDBRSCPXsu1zsFtPIt3uBwaO63TBCJ3Ckpr0OS519XUeg+6Tx5HwGDBkM0Ffh9PRj0VbS5PD9UjlA8ev6q9T0mM6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462389; c=relaxed/simple;
	bh=jivdMOcQmOWJwYtOj+8z9g2awLY74w5nILv7i1mVPQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N3Nz8SzNHXXT2Ad8goUDlEOd+h2QPdsJOuW23LYWfi7z+n4TFjHBKGqpne64fH3Ttc/n6H7mBY2olbLMIWbn11Wxo3INPbALontykD3qcc2y3HNxH0hULy1ZnZW6F+7D+pJh3X6HuWmQZlupVzBMWK3p38OlwpAk296ZQBi9AoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KyNkzBIH; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79f178e62d1so40027685a.1
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 11:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720462382; x=1721067182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Op020+ioRcwROlJHbbz31fEmAmdD7sMKCVmFmVrEWb0=;
        b=KyNkzBIH6HABS8d4vQkuL7jorok6NqR3r8HzV/gTyKH9ToT8GueSBQ4ifCyfkpes0U
         Yh0iFUAp0zSWo0qOCAP8Nvd7E7PRsVsnOykN8of8NaPeKbrukBxvxtqL4BiV46QVbnhl
         oJqRMZAatGAS4lWLVrdgagkSP98SFOKOoSSpAVIeF6anJH+wKpX2HzXr2EJJiqXD14A7
         UriTcIIKUy/bpveLtkW6vLb4eDneHlJKFMy4Em+WtWbWSp372siP1A6Yg7RVe7aOvBad
         ws7DaVAeX4+0ioGpxNGVnhdDMVLdoDT3Ugn/mI0UlR2lGYkZYo3YYMeMYkKZ2wv1uA3R
         SNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462382; x=1721067182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Op020+ioRcwROlJHbbz31fEmAmdD7sMKCVmFmVrEWb0=;
        b=apwrVFd9u/GYHwT77M37DxzwpcY3MnTQ0xVrxNBAskxxy+aWp1k1EFKpiK+Fp3zJhD
         OvP7RngoE6MKZdW0dm9YDg/pUn71MMpA6zKvcea+KXmmXAvepMAsAJL5mzTmWGriIpum
         GZGdFY/w6kdkK8lh4vgSJvwXvVTRuTxtyXGEHetFm5fZGiAXmLp+rr+lHlCialuyk+d5
         5usioQ/oJTBvCjghsR0XA+iGgN+9t+mkhfJb85ajYI3nbP0KSCv93nA8sOd/v6Hgc+Pb
         OzQ4OhvwnaaRgDTNv7z9ceLhfjQUpSIFGLVhdQ3czntV7BJetfPPxZymZK6kjF9EuZtj
         1C8w==
X-Forwarded-Encrypted: i=1; AJvYcCWwSNBWTWpDX3hUtl63CpSOxQZPUmE1Bubr9yUGEeYzZbqnEfsTAnbJttep7/7imTCnzapHXwwf7B/By5aQ1JBjESteF1ldC57P
X-Gm-Message-State: AOJu0YzrfjIVLSP9agIoPp+tWjrCACF4mHZZw28ZhvNYKXVqnjqrJpay
	5olZ+WLkPLGTPBk75dfs5ePbDIybxZhWLoGBfAMoeuAFtn6Cogev6n+8qts4yWWnflEom8+4/28
	x
X-Google-Smtp-Source: AGHT+IHJch6TnFQQvXVybbDBmCu5PO9OD533egSlbD4e2BfeYTiwFXTw2T94UfD2u0oQuTIcd52y6Q==
X-Received: by 2002:a05:620a:410a:b0:79d:6d4a:a958 with SMTP id af79cd13be357-79f19a9c7b4mr38821285a.53.1720462381578;
        Mon, 08 Jul 2024 11:13:01 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff834csm15233885a.5.2024.07.08.11.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 11:13:01 -0700 (PDT)
Message-ID: <e545c493-c199-4b37-a0d1-5a6d4c386168@baylibre.com>
Date: Mon, 8 Jul 2024 14:13:00 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] pwm: Add support for pwmchip devices for faster and
 easier userspace access
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
 <7490e64bbe12e2046d92716dadef7070881592e6.1720435656.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <7490e64bbe12e2046d92716dadef7070881592e6.1720435656.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-07-08 6:52 a.m., Uwe Kleine-König wrote:
> With this change each pwmchip can be accessed from userspace via a
> character device. Compared to the sysfs-API this is faster (on a
> stm32mp157 applying a new configuration takes approx 25% only) and
> allows to pass the whole configuration in a single ioctl allowing atomic
> application.
>
> Thanks to Randy Dunlap for pointing out a missing kernel-doc
> description.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   drivers/pwm/core.c       | 367 +++++++++++++++++++++++++++++++++++++--
>   include/linux/pwm.h      |   3 +
>   include/uapi/linux/pwm.h |  24 +++
>   3 files changed, 379 insertions(+), 15 deletions(-)
>   create mode 100644 include/uapi/linux/pwm.h
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 8e68481a7b33..d64c033c4cb2 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -23,6 +23,8 @@
>   
>   #include <dt-bindings/pwm/pwm.h>
>   
> +#include <uapi/linux/pwm.h>
> +
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/pwm.h>
>   
> @@ -95,6 +97,29 @@ static void pwm_state2wf(const struct pwm_state *state, struct pwm_waveform *wf)
>   	}
>   }
>   
> +static int pwmwfcmp(const struct pwm_waveform *a, const struct pwm_waveform *b)
> +{
> +	if (a->period_length > b->period_length)
> +		return 1;
> +
> +	if (a->period_length < b->period_length)
> +		return -1;
> +
> +	if (a->duty_length > b->duty_length)
> +		return 1;
> +
> +	if (a->duty_length < b->duty_length)
> +		return -1;
> +
> +	if (a->duty_offset > b->duty_offset)
> +		return 1;
> +
> +	if (a->duty_offset < b->duty_offset)
> +		return -1;
> +
> +	return 0;
> +}
> +
>   static int pwm_check_rounding(const struct pwm_waveform *wf,
>   			      const struct pwm_waveform *wf_rounded)
>   {
> @@ -115,6 +140,127 @@ static int pwm_check_rounding(const struct pwm_waveform *wf,
>   
>   #define WFHWSIZE 20
>   
> +static int pwm_get_waveform(struct pwm_device *pwm,
> +			    struct pwm_waveform *wf)
> +{
> +	struct pwm_chip *chip = pwm->chip;
> +	const struct pwm_ops *ops = chip->ops;
> +	char wfhw[WFHWSIZE];
> +	int err;
> +
> +	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
> +
> +	guard(pwmchip)(chip);
> +
> +	if (!chip->operational)
> +		return -ENODEV;
> +
> +	err = ops->read_waveform(chip, pwm, &wfhw);
> +	if (err)
> +		return err;
> +
> +	return ops->round_waveform_fromhw(chip, pwm, &wfhw, wf);
> +}
> +
> +/* Called with the pwmchip lock held */
> +static int __pwm_set_waveform(struct pwm_device *pwm,
> +			      const struct pwm_waveform *wf,
> +			      bool exact)
> +{
> +	struct pwm_chip *chip = pwm->chip;
> +	const struct pwm_ops *ops = chip->ops;
> +	char wfhw[WFHWSIZE];
> +	struct pwm_waveform wf_rounded;
> +	int err;
> +
> +	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
> +
> +	if (wf->period_length &&
> +	    (wf->duty_length > wf->period_length ||
> +	     wf->duty_offset >= wf->period_length))
> +		return -EINVAL;
> +
> +	err = ops->round_waveform_tohw(chip, pwm, wf, &wfhw);
> +	if (err)
> +		return err;
> +
> +	if ((IS_ENABLED(CONFIG_PWM_DEBUG) || exact) && wf->period_length) {
> +		err = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
> +		if (err)
> +			return err;
> +
> +		if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm_check_rounding(wf, &wf_rounded))
> +			dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
> +				wf->duty_length, wf->period_length, wf->duty_offset,
> +				wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset);
> +
> +		if (exact && pwmwfcmp(wf, &wf_rounded)) {
> +			dev_dbg(&chip->dev, "Requested no rounding, but %llu/%llu [+%llu] -> %llu/%llu [+%llu]\n",
> +				wf->duty_length, wf->period_length, wf->duty_offset,
> +				wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset);
> +
> +			return 1;
> +		}
> +	}
> +
> +	err = ops->write_waveform(chip, pwm, &wfhw);
> +	if (err)
> +		return err;
> +
> +	/* update .state */
> +	pwm_wf2state(wf, &pwm->state);
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && ops->read_waveform && wf->period_length) {
> +		struct pwm_waveform wf_set;
> +
> +		err = ops->read_waveform(chip, pwm, &wfhw);
> +		if (err)
> +			/* maybe ignore? */
> +			return err;
> +
> +		err = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf_set);
> +		if (err)
> +			/* maybe ignore? */
> +			return err;
> +
> +		if (pwmwfcmp(&wf_set, &wf_rounded) != 0)
> +			dev_err(&chip->dev,
> +				"Unexpected setting: requested %llu/%llu [+%llu], expected %llu/%llu [+%llu], set %llu/%llu [+%llu]\n",
> +				wf->duty_length, wf->period_length, wf->duty_offset,
> +				wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset,
> +				wf_set.duty_length, wf_set.period_length, wf_set.duty_offset);
> +	}
> +	return 0;
> +}
> +
> +static int pwm_set_waveform_might_sleep(struct pwm_device *pwm,
> +					struct pwm_waveform *wf, bool exact)
> +{
> +	struct pwm_chip *chip = pwm->chip;
> +	int err;
> +
> +	might_sleep();
> +
> +	guard(pwmchip)(chip);
> +
> +        if (!chip->operational)
> +                return -ENODEV;
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && chip->atomic) {
> +		/*
> +		 * Catch any drivers that have been marked as atomic but
> +		 * that will sleep anyway.
> +		 */
> +		non_block_start();
> +		err = __pwm_set_waveform(pwm, wf, exact);
> +		non_block_end();
> +	} else {
> +		err = __pwm_set_waveform(pwm, wf, exact);
> +	}
> +
> +	return err;
> +}
> +
>   static void pwm_apply_debug(struct pwm_device *pwm,
>   			    const struct pwm_state *state)
>   {
> @@ -301,19 +447,6 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
>   		if (err)
>   			return err;
>   
> -		if (IS_ENABLED(PWM_DEBUG)) {
> -			struct pwm_waveform wf_rounded;
> -
> -			err = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
> -			if (err)
> -				return err;
> -
> -			if (pwm_check_rounding(&wf, &wf_rounded))
> -				dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
> -					wf.duty_length, wf.period_length, wf.duty_offset,
> -					wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset);
> -		}
> -
>   		err = ops->write_waveform(chip, pwm, &wfhw);
>   		if (err)
>   			return err;
> @@ -1296,6 +1429,197 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
>   	return true;
>   }
>   
> +struct pwm_cdev_data {
> +	struct pwm_chip *chip;
> +	struct pwm_device *pwm[];
> +};
> +
> +static int pwm_cdev_open(struct inode *inode, struct file *file)
> +{
> +	struct pwm_chip *chip = container_of(inode->i_cdev, struct pwm_chip, cdev);
> +	struct pwm_cdev_data *cdata;
> +
> +	guard(mutex)(&pwm_lock);
> +
> +	if (!chip->operational)
> +		return -ENXIO;
> +
> +	cdata = kzalloc(struct_size(cdata, pwm, chip->npwm), GFP_KERNEL);
> +	if (!cdata)
> +		return -ENOMEM;
> +
> +	cdata->chip = chip;
> +
> +	file->private_data = cdata;
> +
> +	return nonseekable_open(inode, file);
> +}
> +
> +static int pwm_cdev_release(struct inode *inode, struct file *file)
> +{
> +	struct pwm_cdev_data *cdata = file->private_data;
> +	unsigned int i;
> +
> +	for (i = 0; i < cdata->chip->npwm; ++i) {
> +		if (cdata->pwm[i])
> +			pwm_put(cdata->pwm[i]);
> +	}
> +	kfree(cdata);
> +
> +	return 0;
> +}
> +
> +static int pwm_cdev_request(struct pwm_cdev_data *cdata, unsigned int hwpwm)
> +{
> +	struct pwm_chip *chip = cdata->chip;
> +
> +	if (hwpwm >= chip->npwm)
> +		return -EINVAL;
> +
> +	if (!cdata->pwm[hwpwm]) {
> +		struct pwm_device *pwm = &chip->pwms[hwpwm];
> +		int ret;
> +
> +		ret = pwm_device_request(pwm, "pwm-cdev");
> +		if (ret < 0)
> +			return ret;
> +
> +		cdata->pwm[hwpwm] = pwm;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pwm_cdev_free(struct pwm_cdev_data *cdata, unsigned int hwpwm)
> +{
> +	struct pwm_chip *chip = cdata->chip;
> +
> +	if (hwpwm >= chip->npwm)
> +		return -EINVAL;
> +
> +	if (cdata->pwm[hwpwm]) {
> +		struct pwm_device *pwm = cdata->pwm[hwpwm];
> +
> +		pwm_put(pwm);
> +
> +		cdata->pwm[hwpwm] = NULL;
> +	}
> +
> +	return 0;
> +}
> +
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
> +	case PWM_IOCTL_GET_NUM_PWMS:
> +		return chip->npwm;
> +
> +	case PWM_IOCTL_REQUEST:
> +		{
> +			unsigned int hwpwm;
> +
> +			ret = get_user(hwpwm, (unsigned int __user *)arg);
> +			if (ret)
> +				return ret;
> +
> +			return pwm_cdev_request(cdata, hwpwm);
> +		}
> +
> +	case PWM_IOCTL_FREE:
> +		{
> +			unsigned int hwpwm;
> +
> +			ret = get_user(hwpwm, (unsigned int __user *)arg);
> +			if (ret)
> +				return ret;
> +
> +			return pwm_cdev_free(cdata, hwpwm);
> +		}
> +
> +	case PWM_IOCTL_GETWF:
> +		{
> +			struct pwmchip_waveform cwf;
> +			struct pwm_waveform wf;
> +			struct pwm_device *pwm;
> +
> +			ret = copy_from_user(&cwf, (struct pwmchip_waveform __user *)arg, sizeof(cwf));
> +			if (ret)
> +				return -EFAULT;
> +
> +			ret = pwm_cdev_request(cdata, cwf.hwpwm);
> +			if (ret)
> +				return ret;
> +
> +			pwm = cdata->pwm[cwf.hwpwm];
> +
> +			ret = pwm_get_waveform(pwm, &wf);
> +			if (ret)
> +				return ret;
> +
> +			cwf.period_length = wf.period_length;
> +			cwf.duty_length = wf.duty_length;
> +			cwf.duty_offset = wf.duty_offset;
> +
> +			return copy_to_user((struct pwmchip_waveform __user *)arg, &cwf, sizeof(cwf));
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
> +			ret = copy_from_user(&cwf, (struct pwmchip_waveform __user *)arg, sizeof(cwf));
> +			if (ret)
> +				return -EFAULT;
> +
> +			if (cwf.period_length > 0 &&
> +			    (cwf.duty_length > cwf.period_length ||
> +			     cwf.duty_offset >= cwf.period_length))
> +				return -EINVAL;
> +
> +			ret = pwm_cdev_request(cdata, cwf.hwpwm);
> +			if (ret)
> +				return ret;
> +
> +			pwm = cdata->pwm[cwf.hwpwm];
> +
> +			wf = (struct pwm_waveform){
> +				.period_length = cwf.period_length,
> +				.duty_length = cwf.duty_length,
> +				.duty_offset = cwf.duty_offset,
> +			};
> +
> +			return pwm_set_waveform_might_sleep(pwm, &wf, cmd == PWM_IOCTL_SETEXACTWF);
> +		}
> +		break;
> +
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
> +static const struct file_operations pwm_cdev_fileops = {
> +	.open = pwm_cdev_open,
> +	.release = pwm_cdev_release,
> +	.owner = THIS_MODULE,
> +	.llseek = no_llseek,
> +	.unlocked_ioctl = pwm_cdev_ioctl,
> +};
> +
> +static dev_t pwm_devt;
> +
>   /**
>    * __pwmchip_add() - register a new PWM chip
>    * @chip: the PWM chip to add
> @@ -1348,7 +1672,13 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
>   	scoped_guard(pwmchip, chip)
>   		chip->operational = true;
>   
> -	ret = device_add(&chip->dev);
> +	if (chip->id < 256 && chip->ops->write_waveform)
> +		chip->dev.devt = MKDEV(MAJOR(pwm_devt), chip->id);
> +
> +	cdev_init(&chip->cdev, &pwm_cdev_fileops);
> +	chip->cdev.owner = owner;
> +
> +	ret = cdev_device_add(&chip->cdev, &chip->dev);
>   	if (ret)
>   		goto err_device_add;
>   
> @@ -1399,7 +1729,7 @@ void pwmchip_remove(struct pwm_chip *chip)
>   		idr_remove(&pwm_chips, chip->id);
>   	}
>   
> -	device_del(&chip->dev);
> +	cdev_device_del(&chip->cdev, &chip->dev);
>   }
>   EXPORT_SYMBOL_GPL(pwmchip_remove);
>   
> @@ -1943,9 +2273,16 @@ static int __init pwm_init(void)
>   {
>   	int ret;
>   
> +	ret = alloc_chrdev_region(&pwm_devt, 0, 256, "pwm");
> +	if (ret) {
> +		pr_warn("Failed to initialize chrdev region for PWM usage\n");
> +		return ret;
> +	}
> +
>   	ret = class_register(&pwm_class);
>   	if (ret) {
>   		pr_err("Failed to initialize PWM class (%pe)\n", ERR_PTR(ret));
> +		unregister_chrdev_region(pwm_devt, 256);
>   		return ret;
>   	}
>   
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index b5dff2a99038..3e503a28f5f7 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -2,6 +2,7 @@
>   #ifndef __LINUX_PWM_H
>   #define __LINUX_PWM_H
>   
> +#include <linux/cdev.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
>   #include <linux/module.h>
> @@ -303,6 +304,7 @@ struct pwm_ops {
>   /**
>    * struct pwm_chip - abstract a PWM controller
>    * @dev: device providing the PWMs
> + * @cdev: &struct cdev for this device
>    * @ops: callbacks for this PWM controller
>    * @owner: module providing this chip
>    * @id: unique number of this PWM chip
> @@ -317,6 +319,7 @@ struct pwm_ops {
>    */
>   struct pwm_chip {
>   	struct device dev;
> +	struct cdev cdev;
>   	const struct pwm_ops *ops;
>   	struct module *owner;
>   	unsigned int id;
> diff --git a/include/uapi/linux/pwm.h b/include/uapi/linux/pwm.h
> new file mode 100644
> index 000000000000..1ecf2e033b62
> --- /dev/null
> +++ b/include/uapi/linux/pwm.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_PWM_H_
> +#define _UAPI_PWM_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +struct pwmchip_waveform {
> +	unsigned int hwpwm;
> +	__u64 period_length;
> +	__u64 duty_length;
> +	__u64 duty_offset;
> +};
> +
> +#define PWM_IOCTL_GET_NUM_PWMS	_IO(0x75, 0)
> +#define PWM_IOCTL_REQUEST	_IOW(0x75, 1, unsigned int)
> +#define PWM_IOCTL_FREE		_IOW(0x75, 2, unsigned int)
> +#define PWM_IOCTL_ROUNDWF	_IOWR(0x75, 3, struct pwmchip_waveform)
> +#define PWM_IOCTL_GETWF		_IOWR(0x75, 4, struct pwmchip_waveform)
> +#define PWM_IOCTL_SETROUNDEDWF	_IOW(0x75, 5, struct pwmchip_waveform)
> +#define PWM_IOCTL_SETEXACTWF	_IOW(0x75, 6, struct pwmchip_waveform)
> +
> +#endif /* _UAPI_PWM_H_ */

