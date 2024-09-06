Return-Path: <linux-pwm+bounces-3145-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A8796FDF1
	for <lists+linux-pwm@lfdr.de>; Sat,  7 Sep 2024 00:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC80283029
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 22:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D5A1B85DD;
	Fri,  6 Sep 2024 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JqunivQb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD710158D92
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661612; cv=none; b=ALQiZW8eXu7pWL7VPLnswjXtBlj5cZRNuQ8qurvVe+jTOq3MUs+3RyB8xPcaYU4omMZ49OwQXns2tBkYJQ7gIdcD9zYtp/Y1U5U3dnv41wUK8L6XnZuPE1DWUq3fJbOfIIWeDf2VqBJIvmHSzSzWu3YqGWe+Jswe0CajdQv29Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661612; c=relaxed/simple;
	bh=+Gltk+kcSjjGkf22Pr/QZa+dYwt+hSe4G9WCbHSzLRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wn5DIhPVbrSZYQZSzB2CWRXeakBWHbuBMCpinKj4DXYHupp0mv4v9TVTwVYsKeV0heZM25K+eTvuouhlCPKXvjGZQfS+itUhgoqpcoCXTNP+F9iI5m7yaPINNocZfPrzcw9AULtRTCytBtodxegl/R7ILo6KRGZZE/W+D5r2gfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JqunivQb; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-710d5d9aac1so340926a34.3
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 15:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725661608; x=1726266408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/ZTU0OcrSEvnBC+blkQAW4m7uMlQdJcRp7BfNG21nM=;
        b=JqunivQbmxsI75JaLh9jUbB2T9cQYSLZQMkEZQtJyrx38lGE3yFs3neISldAQKPKfS
         raPhUQjDo93yzdgswrTOYFWxxfrUqdZ30FHMtJN7V05oI2KlpvQDoPymGsbwmW2sxKuD
         m5VEY0zUmV7uavIHLM9m26eqmp5hdXSe5H48ZqWswO4Gm++M/T0MUk7YZFVsC+BKT5T+
         PTN/tEAbkFhpF6aL4EbMiqpawmonuezWhkh0Q25JZ9/q66ntp6o0m0TnPmtXvDPeHtQi
         EE49y+2EWuQhdI+i2Cx0VyFFJ0D8f6vkuUM6zLIYGTqoNN+6sgGZe14Ce2mqc3cEDXQp
         t+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725661608; x=1726266408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/ZTU0OcrSEvnBC+blkQAW4m7uMlQdJcRp7BfNG21nM=;
        b=i0sq5cXrOuC1gjRoPftwTDNg0bbfO8sdF1LbrfwsqPLPfx6C1BYbBxKp/0ujBOFA1Q
         erj8azBglNUY8zJoZAWDCckGsZIU8GtNVR5CSqIPKcu/4P4ENlLpfZfd/JnL96DJdJ54
         riGPGiTEGeMLakOc3jnvSSjR+f8AQ0X+7KlNGJtmaafQxdxzP9UorN/yMWd43aHv4Unw
         lAWOrD3wUPYGyNKYOxNbmt6dK5QAYU8Ro82wNdtz+7F1nlKm64E5+20CcZse9vZkufxl
         YAPlMh2V9MPPR1m/NvWT2HgYH6zvcazmfxzwq4JTg+Ud6g25/+N0b5tav+RDpaZTR9Cx
         E5hg==
X-Forwarded-Encrypted: i=1; AJvYcCW1GrC2D+h/agfGHRpkoZMHkVbX5IxOItFcWCsuKRQu+uV3M2Pkwee5ZnYq8396l5jEYG/IocPMPro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPhA+mY5lNLEvEduwf2vrSSrfZ048QjpIevLNfm7do3jBp3ig
	koNe/egwdBBCk75C2wJkoHtuKxOu9SC0ussEfxkKzroUjUYnRvG30wjv8SKemsw=
X-Google-Smtp-Source: AGHT+IEkajHsM3/kXbpAm6vJm3I/zkIsauwNXQyce49B9k+VfIysl13IHnST1FI10TnpttJvnKOXlw==
X-Received: by 2002:a05:6830:3c81:b0:710:bd1f:6ca9 with SMTP id 46e09a7af769-710cc218f96mr5398853a34.2.1725661607751;
        Fri, 06 Sep 2024 15:26:47 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710d9dd6933sm18894a34.65.2024.09.06.15.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 15:26:47 -0700 (PDT)
Message-ID: <7acc85f6-69e9-4e44-ab04-88eaf2ffa291@baylibre.com>
Date: Fri, 6 Sep 2024 17:26:46 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] pwm: Add support for pwmchip devices for faster
 and easier userspace access
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <00c9f1181dc351e1e6041ba6e41e4c30b12b6a27.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <00c9f1181dc351e1e6041ba6e41e4c30b12b6a27.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/6/24 10:43 AM, Uwe Kleine-König wrote:
> With this change each pwmchip defining the new-style waveform callbacks
> can be accessed from userspace via a character device. Compared to the
> sysfs-API this is faster (on a stm32mp157 applying a new configuration
> takes approx 25% only) and allows to pass the whole configuration in a
> single ioctl allowing atomic application.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/pwm/core.c       | 267 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/pwm.h      |   3 +
>  include/uapi/linux/pwm.h |  24 ++++
>  3 files changed, 292 insertions(+), 2 deletions(-)
>  create mode 100644 include/uapi/linux/pwm.h
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index c7f39f9f4bcf..16615a4673ef 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -23,6 +23,8 @@
>  
>  #include <dt-bindings/pwm/pwm.h>
>  
> +#include <uapi/linux/pwm.h>
> +
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/pwm.h>
>  
> @@ -1594,6 +1596,254 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
>  	return true;
>  }
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

Maybe a potential problem here with multiple requests.

Suppose an applications does:

// main thread
fd = open("/dev/pwm0", ...);

// start some threads

// thread A

ioctl(fd, PWM_IOCTL_REQUEST, 0);
// in kernel, pwm_device_request() is called and
// cdata->pwm[0] is assigned

// does some stuff - OK

	// thread B

	ioctl(fd, PWM_IOCTL_REQUEST, 0);
	// succeeds since cdata->pwm[0] is assigned

	// does some stuff - messes up thread A

// does some stuff - messes up thread B

	// cleans up after itself
	ioctl(fd, PWM_IOCTL_FREE, 0);
	// pwm_put() is called and
	// cdata->pwm[0] is set to NULL
	
// does some stuff - kernel has to call pwm_device_request()
// again, which may fail? e.g. if sysfs stole it in the meantime

// cleans up after itself
ioctl(fd, PWM_IOCTL_FREE, 0);

Maybe we should be more strict and only allow one requester at a time?

Or is it a documentation problem that this isn't the intended way to
use these ioctls?

Or maybe we just don't need the REQUEST and FREE ioctls?

To me, the most intuitive is that REQUEST would gain exclusive
access until FREE is called and other ioctls should fail if
you don't have exclusive access.

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
> +		break;
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
> +			ret = pwm_cdev_request(cdata, cwf.hwpwm);
> +			if (ret)
> +				return ret;
> +
> +			pwm = cdata->pwm[cwf.hwpwm];
> +
> +			wf = (struct pwm_waveform) {
> +				.period_length_ns = cwf.period_length_ns,
> +				.duty_length_ns = cwf.duty_length_ns,
> +				.duty_offset_ns = cwf.duty_offset_ns,
> +			};
> +
> +			ret = pwm_round_waveform_might_sleep(pwm, &wf);
> +			if (ret)
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
> +			if (cwf.__pad != 0) {
> +				pr_warn("huh\n");

This is what I will say when I see this in the kernel log. :-p

> +				return -EINVAL;
> +			}
> +
> +			ret = pwm_cdev_request(cdata, cwf.hwpwm);
> +			if (ret)
> +				return ret;
> +
> +			pwm = cdata->pwm[cwf.hwpwm];
> +
> +			ret = pwm_get_waveform_might_sleep(pwm, &wf);
> +			if (ret)
> +				return ret;
> +
> +			cwf.period_length_ns = wf.period_length_ns;
> +			cwf.duty_length_ns = wf.duty_length_ns;
> +			cwf.duty_offset_ns = wf.duty_offset_ns;
> +
> +			return copy_to_user((struct pwmchip_waveform __user *)arg,
> +					    &cwf, sizeof(cwf));
> +		}
> +		break;


