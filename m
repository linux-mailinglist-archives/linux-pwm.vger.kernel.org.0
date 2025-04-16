Return-Path: <linux-pwm+bounces-5535-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A166A90917
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 18:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8358446E76
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A29E2135C5;
	Wed, 16 Apr 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z7Pi2DNg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4642135BC
	for <linux-pwm@vger.kernel.org>; Wed, 16 Apr 2025 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820995; cv=none; b=Hv+O+F8TPjGTjyu7xR913hcTE94Ps/kikDV5FuOIGj0gJyAegu9LCFXyfgzduJ747HVt7sL5gNbSRLYgf2oI+Qyqq1QqH2rt9R7jed4LmuiJtXqZwfDjoTEdNjCcSbNSPLJiDG7QNV6B5X9JoTyBP7VrYFINYBqRE8t+6AWK2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820995; c=relaxed/simple;
	bh=XjDWExc7aCtKdBEsMDk+FwHQrVvKiy//tx9TxHhcszI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZwpQixJnJGCMBXt9EavaoWI5IytLcsIBNnrvZex4oMEZea4Jb8NGzHvpOzcPP60pu8URPJu8PXU0OkNWo93Tl2CTgO6jM0tdbpbo+dETcX1NEIoL0l7a4YV9lsXkArX/hqLEbWvVV0aTIJcJEyhJIsY/4isSAIfV5+bTLxVfTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z7Pi2DNg; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3fea0363284so535544b6e.1
        for <linux-pwm@vger.kernel.org>; Wed, 16 Apr 2025 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744820992; x=1745425792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/JMFCzdAj9xuXRdhWt8/x0fkEDuPnXUetQjhrJIECU=;
        b=z7Pi2DNgf02OIrV0jhGaWn+l9mmLuoPugpehNM68BclbOl7qO6VWQ7cXXfIq0UYDOm
         fh3h0jsBJBel91i//rJn4vyQJXJOUAnpQ9IpPJGNyyHr9PQFsNOTR/zgwU0ZequlEm5H
         sNZELp/eraZEV3fzfCe1c/ze7Ke8yXK0jGaxZOyzktvMt5GTYHVF9U5A6oUk8KMCWQQw
         TJJ1/mH6vcUTh2zwW/X/fIRdwTdKpLKKi9A59XOwR+73Yccq2Mzki1HsVhSjjskKBuUx
         ysJYMBS2wjP1FK6wzPqvBcOhCa0J2XeS3y6khGDspHF7xSEvi9WpQG/IX1xAvAz9xSZn
         9Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744820992; x=1745425792;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/JMFCzdAj9xuXRdhWt8/x0fkEDuPnXUetQjhrJIECU=;
        b=Yf1JIjMBeUb1dcrco2TWemO9JWytzA08ZJmL1Wzy7vV8lVRNuYw1T948cXUgR4Ghiw
         QVgKpVzr8GZqGdGp4hAAyadxsJjNH6CKQ9fgfa2Z08eUhTM65D27M8fI8ooApEn8pXcw
         1h0xwFXtvrMIhnQH2pRIiao2A30NEB3lQAeL6LKAJvcrBjZuOe0OzN0IFiLezlw8SKRk
         T5k5JYmK30acYcTtA8oQDVvy21jdv3dYoD3wGfCshAc3RvngBn/0dyCvJ5b9Z7xPJjbe
         1PsOpZxwOsPUslQMFauWKd7/BWxt2ZzM5B16Js2zTwQj+lDcCHF+BIQ2bG3YrRN/fmXY
         h9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPd7BVKh8V+Wg/lZOW4J5iroM2MNiZrJzOuu6vBcoXonLwINHrnTCviKtC3aNoxdibAQ/rg5HXdTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkpOMHUBczdB97x1xO+b4wmCRwqzchbEiJ+zVqktfxoDD+i/QD
	U67A8Bqt5/HV6vTNfaQzSx00GfyOFZ4cAQoDttsozLDqKsjRGiBHy4UP+J1fhX8v34kDQpFUtC5
	S3nE=
X-Gm-Gg: ASbGncuXu+dNDMnn7xZhSA52MQ3zYy/XRPm1iewFTBfdZLcp3vfh9rnypV6VgdYVs2C
	m+5a+CIe4h7lEe8oHUJVx50KzVv8ps7hJvo2UseGZ9mdkdMHQ5B4ll1JAdsJQ9ZxCde+91K4GKb
	BIuQJWH0RWjAum1H0coFEdHIS6ury1+oy+1oReFb5X2yGgyghJnd2eYJApI18zEreAz78kOaWZl
	UtQpKn2ppRD0mQIG8f8PfHViEP5YtpSaiQ80Qvbc0io5zG0mKI+e/P7PXw3y/uN4r0q4c+aegLb
	28fwhvHPcgm07w+mB9q4mMaKSHqadhRzE/bNt34sxPhDvCMSdsftSamsaTwVwMj72KMKLsICWvi
	lCRNT8TfLgLQhFO94izJF3jjL/Gqo
X-Google-Smtp-Source: AGHT+IG5a3+ymiiWxKzRh04gy0UrhiigEm9Xin7Ki5RT8tk8J+n0rFy4NL9QG5oedDe4BhHkRZmCdw==
X-Received: by 2002:a05:6808:2217:b0:3f9:28b9:7021 with SMTP id 5614622812f47-400b7efa942mr109910b6e.5.1744820991792;
        Wed, 16 Apr 2025 09:29:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:58f0:670c:6b15:7fd3? ([2600:8803:e7e4:1d00:58f0:670c:6b15:7fd3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73e4db34sm2882860a34.49.2025.04.16.09.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 09:29:51 -0700 (PDT)
Message-ID: <147fa354-e1fe-46ec-9c47-59794f37bfb7@baylibre.com>
Date: Wed, 16 Apr 2025 11:29:50 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] pwm: Add support for pwmchip devices for faster and
 easier userspace access
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org
References: <20250416094316.2494767-2-u.kleine-koenig@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250416094316.2494767-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/16/25 4:43 AM, Uwe Kleine-König wrote:
> With this change each pwmchip defining the new-style waveform callbacks
> can be accessed from userspace via a character device. Compared to the
> sysfs-API this is faster and allows to pass the whole configuration in a
> single ioctl allowing atomic application and thus reducing glitches.

Didn't do a full review yet, but I have some confusion on when 1 should actually
be returned from ioctl calls...

> +/*
> + * Modifies the passed wf according to hardware constraints. All parameters are
> + * rounded down to the next possible value, unless there is no such value, then
> + * values are rounded up. Note that zero isn't considered for rounding down
> + * period_length_ns.
> + */
> +#define PWM_IOCTL_ROUNDWF	_IOWR(0x75, 3, struct pwmchip_waveform)

Should this return 1 if exact could not be met to match the other functions?

> +
> +/* Get the currently implemented waveform */
> +#define PWM_IOCTL_GETWF		_IOWR(0x75, 4, struct pwmchip_waveform)
> +
> +/* Like PWM_IOCTL_ROUNDWF + PWM_IOCTL_SETEXACTWF in one go. */
> +#define PWM_IOCTL_SETROUNDEDWF	_IOW(0x75, 5, struct pwmchip_waveform)
> +
> +/*
> + * Program the PWM to emit exactly the passed waveform, subject only to rounding
> + * down each value less than 1 ns. Returns 0 on success, 1 if the waveform
> + * cannot be implemented exactly, or other negative error codes.

It doesn't make sense to me that PWM_IOCTL_SETEXACTWF could return 1 meaning
that the exact request could not be met. Isn't that the point of
PWM_IOCTL_SETEXACTWF? To either do exactly as requested (with 1 ns precision)
or return negative error code without changing the output state?

It seems like only PWM_IOCTL_SETROUNDEDWF should be able to return 1. My natural
expectation is that negative error would mean that the hardware output was not
modified and non-negative value means that hardware output was modified.

> + */
> +#define PWM_IOCTL_SETEXACTWF	_IOW(0x75, 6, struct pwmchip_waveform)
> +
> +#endif /* _UAPI_PWM_H_ */
> 
> base-commit: bde5547f2e87e6c71db79dc41e56aff3061e39a9

