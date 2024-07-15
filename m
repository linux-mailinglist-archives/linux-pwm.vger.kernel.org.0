Return-Path: <linux-pwm+bounces-2812-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 443959318DE
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 18:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B459BB2240C
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EC3219ED;
	Mon, 15 Jul 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3Pw/oKxM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79831CAB8
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062573; cv=none; b=Sws1afGciQQvArUqsXyfgIMw/7FV8Y6yJfPrQZ4VXpF5FDB0E372lz+5k8jLJkju66tOTh+VAhPICLqRcdIJhuDAwUxkxdhsAWePAAV+IFE+pJXrzBd0QC3FdR0qD3f7oxyxG+Nx5sTLwUEMy2CURS6qeEpvZw12I8ZBnpY4NTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062573; c=relaxed/simple;
	bh=2EiXBV81eDIfaAnYxc8HvONF9XiLoT1pqGOLuKnRTI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5YcE+TbXdMSZVZQBEn3yXmPmMSZ2VtHOdppCr8HNRrhIBKVOm6iQctZTe+L880kVbqTttax+7G1G+SyEjoGgGOqwsMy/xP/nScdeYUTr5dItXp6Bnwu4+MfXVOcsHJ3bRGuHG+KSJs+jWKroRWuurbR6qcV3A6y794DCxkwdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3Pw/oKxM; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70368b53cc0so2337166a34.1
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721062567; x=1721667367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vxT3neTNj61d8fHzZAJLgUjgea5Hb8cUNStUssbHJZ0=;
        b=3Pw/oKxMoQMf91zkKwoFpYUPVDfkYGF6vOrA6CXrgTN4TZ0e/StkrkJOdxNqlXq2dh
         83NRFS6zaCjM9oMnGAN6PxEoQuvoo2kN5rdnitqswatCBEy+Bo7DL/ZHxNM3R9jMBp98
         dHe7DDeBipmol145tBzcJqWaYhFqOHc0QPEuGeILY20XIzky3YH7sQrIQX3l95mYpa1U
         3cXJq/GLU4bZluf4l0zjpICu/u5qq3n2KFbXix7QIoR05Ni6aJkPpp14WBKVyegmELMU
         WkRu1u6m2epS5Vl4374AVNjTod1tXbSjm05Sc852bTbY9+H1nKasbgPOQdxjicqcLAgi
         ujUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721062567; x=1721667367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vxT3neTNj61d8fHzZAJLgUjgea5Hb8cUNStUssbHJZ0=;
        b=gnXMhEDUTi8QFFuOeJziNxkGlDyvbu5wNk4GB6ZFbTLqyPqWpSLklg5etcQc2OMa6+
         2iZg47Hl6CvBdMRPtZYMgjNURzZiDS4mWdlYO+dowtXFXRu1Nr0GIx1R05PvSb9EK6n7
         6bd5lGk0xbUzJ2stGZB1/9QERvLzijPu+5BXDBJ9OApR9z8RFsyYjx3Eo/I5ZLFbQ/Ky
         8/vPPH3XTJ9ohftc+swBV1pV3I2M4IP2X68ixruQxzrMvYg+LC6gLdKL87gFumMwwuzn
         fJ/2C1vzIKfRGOACJdMNVGABkYsZPUoeimxwoGS411M+REhfnM9TYpTUAWaHeFKi2B1Z
         OBdg==
X-Forwarded-Encrypted: i=1; AJvYcCXLjN0zIH2UvKSbdG9ucAJggDJoeuOEb9xk6gq4xGCDvotiN3/vnR011AddBr01/OtayYJr7tXmAX08ME5ifejrbrd8LsFTyJ5u
X-Gm-Message-State: AOJu0Yz23adH7072BRwlgO2knG7+XZYrOYzi1seeTmTjIKtEXyzCcdPe
	p0cFewFUfF0uDggVg+seuNEdMvXQJEbz1PqHzPXiurovxTs7SbBRR/Re5o9pWt33jkaoWd5pEpQ
	3
X-Google-Smtp-Source: AGHT+IGJShom5rq4wsY5wjcF6Qfddl2EUDVDsGxgXgRjf8UbA1mcLceQ0SA8vdFiOOyhMtm3bBbuWQ==
X-Received: by 2002:a05:6830:6681:b0:708:b083:86c8 with SMTP id 46e09a7af769-708d8352540mr353463a34.21.1721062566735;
        Mon, 15 Jul 2024 09:56:06 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708c0d2fcc2sm1012738a34.77.2024.07.15.09.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 09:56:06 -0700 (PDT)
Message-ID: <c4d00e3b-3a8e-445f-882f-7fd9305a989f@baylibre.com>
Date: Mon, 15 Jul 2024 11:56:05 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] pwm: Add more locking
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
 <54ae3f1b9b8f07a84fa1a1c9a5ca2b815cea3b20.1721040875.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <54ae3f1b9b8f07a84fa1a1c9a5ca2b815cea3b20.1721040875.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/15/24 6:16 AM, Uwe Kleine-König wrote:
> This ensures that a pwm_chip that has no corresponding driver isn't used
> and that a driver doesn't go away while a callback is still running.
> 
> In the presence of device links this isn't necessary yet (so this is no
> fix) but for pwm character device support this is needed.
> 
> To not serialize all pwm_apply_state() calls, this introduces a per chip
> lock. An additional complication is that for atomic chips a mutex cannot
> be used (as pwm_apply_atomic() must not sleep) and a spinlock cannot be
> held while calling an operation for a sleeping chip. So depending on the
> chip being atomic or not a spinlock or a mutex is used.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/pwm/core.c  | 95 +++++++++++++++++++++++++++++++++++++++++----
>  include/linux/pwm.h | 13 +++++++
>  2 files changed, 100 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 6e752e148b98..b97e2ea0691d 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c

...

> @@ -1138,6 +1190,9 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
>  	if (IS_ENABLED(CONFIG_OF))
>  		of_pwmchip_add(chip);
>  
> +	scoped_guard(pwmchip, chip)
> +		chip->operational = true;

Strictly speaking, is the pwmchip lock actually needed here since nothing else
can access the chip until device_add() is called?

I guess it doesn't hurt to take it anyway though.

> +
>  	ret = device_add(&chip->dev);
>  	if (ret)
>  		goto err_device_add;
> @@ -1145,6 +1200,9 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
>  	return 0;
>  
>  err_device_add:
> +	scoped_guard(pwmchip, chip)
> +		chip->operational = false;
> +
>  	if (IS_ENABLED(CONFIG_OF))
>  		of_pwmchip_remove(chip);
>  
> @@ -1164,11 +1222,27 @@ void pwmchip_remove(struct pwm_chip *chip)
>  {
>  	pwmchip_sysfs_unexport(chip);
>  
> -	if (IS_ENABLED(CONFIG_OF))
> -		of_pwmchip_remove(chip);
> +	scoped_guard(mutex, &pwm_lock) {
> +		unsigned int i;
> +
> +		scoped_guard(pwmchip, chip)
> +			chip->operational = false;
> +
> +		for (i = 0; i < chip->npwm; ++i) {
> +			struct pwm_device *pwm = &chip->pwms[i];
> +
> +			if (test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
> +				dev_alert(&chip->dev, "Freeing requested PWM #%u\n", i);

Is it really so serious that dev_alert() is needed? dev_warn() or
dev_err() seems more appropriate IMHO.

> +				if (pwm->chip->ops->free)
> +					pwm->chip->ops->free(pwm->chip, pwm);
> +			}
> +		}
> +
> +		if (IS_ENABLED(CONFIG_OF))
> +			of_pwmchip_remove(chip);
>  
> -	scoped_guard(mutex, &pwm_lock)
>  		idr_remove(&pwm_chips, chip->id);
> +	}
>  
>  	device_del(&chip->dev);
>  }
> @@ -1538,12 +1612,17 @@ void pwm_put(struct pwm_device *pwm)
>  
>  	guard(mutex)(&pwm_lock);
>  
> -	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
> +	/*
> +	 * If the chip isn't operational, PWMF_REQUESTED was already cleared. So
> +	 * don't warn in this case. This can only happen if a consumer called
> +	 * pwm_put() twice.
> +	 */
> +	if (chip->operational && !test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
>  		pr_warn("PWM device already freed\n");
>  		return;
>  	}
>  
> -	if (chip->ops->free)
> +	if (chip->operational && chip->ops->free)
>  		pwm->chip->ops->free(pwm->chip, pwm);
>  
>  	pwm->label = NULL;
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 8acd60b53f58..464054a45e57 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -275,6 +275,9 @@ struct pwm_ops {
>   * @of_xlate: request a PWM device given a device tree PWM specifier
>   * @atomic: can the driver's ->apply() be called in atomic context
>   * @uses_pwmchip_alloc: signals if pwmchip_allow was used to allocate this chip
> + * @operational: signals if the chip can be used (or is already deregistered)
> + * @nonatomic_lock: mutex for nonatomic chips
> + * @atomic_lock: mutex for atomic chips
>   * @pwms: array of PWM devices allocated by the framework
>   */
>  struct pwm_chip {
> @@ -290,6 +293,16 @@ struct pwm_chip {
>  
>  	/* only used internally by the PWM framework */
>  	bool uses_pwmchip_alloc;
> +	bool operational;
> +	union {
> +		/*
> +		 * depending on the chip being atomic or not either the mutex or
> +		 * the spinlock is used. It protects .operational and
> +		 * synchronizes calls to the .ops->apply and .ops->get_state()

nit: inconsistent use of (), and also synchronizes calls to .ops->capture()

> +		 */
> +		struct mutex nonatomic_lock;
> +		struct spinlock atomic_lock;
> +	};
>  	struct pwm_device pwms[] __counted_by(npwm);
>  };
>  


