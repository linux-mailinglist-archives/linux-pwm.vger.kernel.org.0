Return-Path: <linux-pwm+bounces-1799-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02F987EDC3
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 17:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E59D281C40
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CFA548EE;
	Mon, 18 Mar 2024 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBRIaBfp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E494CE00;
	Mon, 18 Mar 2024 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780279; cv=none; b=k2S1xN8tyohAOYeIy1wuv5FNvDnWkelbJDTj7x57yKrw25cY28DxkBu5lrqD9pXG2l+inylu/+X1PVTmp2iZdWxJqGmlAmwY5osdy/mJonw1hTsU75aJ6Pv20ZfftAuYGS/VlBSkI4A8v6oLOHXXSMbA3DxmV7mfDWBe6F2R0q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780279; c=relaxed/simple;
	bh=M/QjtTb9ZDztymjaQgk+600kIb78TifSaCxpgc86lPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvLq0lcMcEg9/cnNevbYK4u8DJ7ZHTyw48x9i81xn6bUB714dNWbhOXsLUpLlzEscrBwfoQgnJIRyV3fsyEDQjG5hguU9uFeEk7YI6hm4NxJocNsm2tUNNXAvFaMIT97NgR7hxrfWr100N5cn3EEWoLklw43kFPMKEk2v+JUG8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBRIaBfp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso3541076a12.3;
        Mon, 18 Mar 2024 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710780277; x=1711385077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gmB3Z9jgqq5Gui7RzOB9q1GAbvUMfntQMdwWF65GjFQ=;
        b=kBRIaBfpt+CD8+TFhxSrkBQCgmXknv13dL9WdsVymShn5XZYJVT1gKpaRgEAWp9Xwz
         ooucpJZ1wamldxsRhYedYPHwfrWAsZyTfwGizpxlFkmKp1rG8cv9hwkBye+nn7ASjS7x
         165Q5XqdAVBX8WBGGH3HEADICKFaleUZ9+NQkQghvGe2oK86NSfFg+UyFIpMbZKNiqR6
         1UO2vbxi/2L4J/6n3vsoyGrKNQy9MktZrKUJFySr6qfh0t1jPkfqCASG9chsy3mTfEu/
         s4RGT+8VkHnivzR8Kmon2kiX28VVm2OOEaVTnvT2xN3LfZTDGFLhGuWorYCoXb7jw14g
         Sp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710780277; x=1711385077;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmB3Z9jgqq5Gui7RzOB9q1GAbvUMfntQMdwWF65GjFQ=;
        b=G+u8pXTs26r8Zs1vxMZkmOWPS9UNMkZYxD2X4gN7vb8cgQLCxkMzIsxJmCiU3WUWgJ
         VbSgyUt7xgxoFntnBocQ8xO7d1CCn29/Ba4bPG+oHXdH9SPFt8u1KluFX8iNhgcvIw5G
         PD4iOOmju/ft5Uva4wgCwCN4Pw8HrgO6oQYPGPnzY2YZUoPXMaFwFrJOWyyajGFelaWZ
         wJSxxn5vn0MHpf/CZrSmJ/4pMNc6+2e7/6hw+4MrM/wxQuyFhNMVURpYXqKIxCtLc10d
         YcHLzdinIsvQ3xC7A0aHYVggolmo0rVCVBnRWz7gsO7TFx8CGCV0QnMDwFwBp1PlLG30
         F5og==
X-Forwarded-Encrypted: i=1; AJvYcCXLu5rIMZ2/mUq5KhNmEfIxFnVm7QMQx7Smm0rq8zVRM8SjdM3y4W1UZMJJEz50Ssu//NFW6CEGdCjWOy7kBusx04qy47d+rCv5JsWrXp6fb2L59yr+3ENt8oL/c5dxi2TA5bCvMbQ=
X-Gm-Message-State: AOJu0YzequeQg3ie5GpSj3d17SNPf52vmvojlJZ3zWbXX7n65VzHxRQ+
	XSe27tBYHcMDxqdi162zs8/Hci3laeCXj2yjJjBPpX+4dgnE0SyBUIukpUqD
X-Google-Smtp-Source: AGHT+IEYUzujeTm+Tgdcd4136nkMI+53tgP33ArKeVAGzdmL8vWfFS4lOYsHtJ6Dmh44LdogVWxZ8w==
X-Received: by 2002:a17:90a:f009:b0:29c:30b7:3617 with SMTP id bt9-20020a17090af00900b0029c30b73617mr9618816pjb.11.1710780277515;
        Mon, 18 Mar 2024 09:44:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r91-20020a17090a43e400b0029c14758eb4sm8859430pjg.8.2024.03.18.09.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 09:44:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c38c4226-e67d-462f-b930-8d9413863bf5@roeck-us.net>
Date: Mon, 18 Mar 2024 09:44:35 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hwmon: (aspeed-g6-pwm-tacho): Make use of
 pwmchip_parent() accessor
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-pwm@vger.kernel.org,
 kernel@pengutronix.de
References: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
 <5c6a11dd10cd29e0f7bfaa1fdef145523347cb58.1710777536.git.u.kleine-koenig@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <5c6a11dd10cd29e0f7bfaa1fdef145523347cb58.1710777536.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/24 09:09, Uwe Kleine-König wrote:
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, use the accessor
> function provided for exactly this purpose.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/aspeed-g6-pwm-tach.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
> index 597b3b019d49..64def5e4cdf6 100644
> --- a/drivers/hwmon/aspeed-g6-pwm-tach.c
> +++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
> @@ -195,7 +195,7 @@ static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   
>   	expect_period = div64_u64(ULLONG_MAX, (u64)priv->clk_rate);
>   	expect_period = min(expect_period, state->period);
> -	dev_dbg(chip->dev, "expect period: %lldns, duty_cycle: %lldns",
> +	dev_dbg(pwmchip_parent(chip), "expect period: %lldns, duty_cycle: %lldns",
>   		expect_period, state->duty_cycle);
>   	/*
>   	 * Pick the smallest value for div_h so that div_l can be the biggest
> @@ -218,12 +218,12 @@ static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (div_l > 255)
>   		div_l = 255;
>   
> -	dev_dbg(chip->dev, "clk source: %ld div_h %lld, div_l : %lld\n",
> +	dev_dbg(pwmchip_parent(chip), "clk source: %ld div_h %lld, div_l : %lld\n",
>   		priv->clk_rate, div_h, div_l);
>   	/* duty_pt = duty_cycle * (PERIOD + 1) / period */
>   	duty_pt = div64_u64(state->duty_cycle * priv->clk_rate,
>   			    (u64)NSEC_PER_SEC * (div_l + 1) << div_h);
> -	dev_dbg(chip->dev, "duty_cycle = %lld, duty_pt = %d\n",
> +	dev_dbg(pwmchip_parent(chip), "duty_cycle = %lld, duty_pt = %d\n",
>   		state->duty_cycle, duty_pt);
>   
>   	/*


