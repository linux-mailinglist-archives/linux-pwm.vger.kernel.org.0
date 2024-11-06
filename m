Return-Path: <linux-pwm+bounces-4036-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88C89BE300
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 10:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FE41C20CEF
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA171DBB37;
	Wed,  6 Nov 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnFj+2tk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BF01DB362
	for <linux-pwm@vger.kernel.org>; Wed,  6 Nov 2024 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886386; cv=none; b=Hxnx/o0IcODe56NJh2LE2LMawx3wZI0afK2Kzk7E+khR7zOQkhdyFFMK4QPRTF4dywYqEwAYCx7ELUb3N75HGt4OSHu0/nGxGTFqaSDuWUcFtALIw9Na2qa/vxEBreugPjzyagFnC5m27DyDrESrzeHHhGDxY+Sg2gW5h6XB5qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886386; c=relaxed/simple;
	bh=qPhDzYzPTaI8y5EdMQJmzv+wSTcFTzdufQdPTN9ge7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co8eIQ8rI0m0ivbnuL/nMkYRsbyhN+8f7qEOShZPUaHxWeFwlmVoqeFxjOIALzPSIL+uKziY8oNHecNqHfL9/STPBUrGJa+uBwrtbmN57EC2Phxp+RCvu+qlQAGV6nhbZQ/Jy81rWh5opfNvtORphYfwsYZWUFXG8EMLW28r6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnFj+2tk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314c452180so3689325e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 06 Nov 2024 01:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730886382; x=1731491182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ETsj6CBD1oNVWYwvIdk3TXaWSjlDgvHW6bPSsd+ZIWQ=;
        b=VnFj+2tkLA0TTY3jbJxKE0tEPlPtTzNfFnvFqcE9vWh0gxrLimDlQLIkrKRbNAzLha
         0RTgz+B3P5Q94+2yB97QtHy8Gy+wL1wWPeF/wI1ra0eoeF4bHCDw7D4fAQnpSb5FMeKO
         Hiu4qpdRYfcvz6VjusVjrbHVotZvUuVKu9GcoAlIujqraGvPpJCaqToWpZwKg1XqNcyw
         R/H8EL3R8hKCNFkoEwmdIHr9Umu7hA2+Xd/JLjWWr+70ZQmrXdfeOd3O2qsR6h62rfFB
         3Uk711aaoRTGK86PMuVCeoHo7G022NKBlIH0LVSEhouKdtOc8VLVxi7wM87if4/MTUN+
         VHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730886382; x=1731491182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETsj6CBD1oNVWYwvIdk3TXaWSjlDgvHW6bPSsd+ZIWQ=;
        b=FbL3uHxjYJi/tS3qo3G6zReUmPhzgYo6itd5nS6OJBw+dVs1nIKqMF60Kcb5DQ3rQE
         w+ms9raCSpV8SMFuJgteXexudbL1TPkToYlUwDOgacgrYzNdyHgUUuVhbq8AjYFACoFA
         CpNmyHkQgUoGoRxrMq4t1r/Cugj7aLVHnFF1fgJSQvA7YbXnRqaQVw0xNTj1LN6xkfFV
         ZQeucuD/IpArJsms8+8fbgnKFl//GDE+VzvASPbMbkRTbIaoEFv73zTAPfFH6zLaI5au
         4QlOdtAuHJim7ssgxwDyMXDDE+KvxrjEdYh7fFcnyCHBdQhVGHogiyaUjqTmUg8Cvv6f
         94RQ==
X-Gm-Message-State: AOJu0YzHtjU5PBHSXSZVkINv6PsQqnHIplBJCeGrYqWfLIEWRgNWBkuZ
	+E1IpWsqA1ESlnsVc7qKjhU++pZTapBEnxS5PVz6udIEu17wbIuL
X-Google-Smtp-Source: AGHT+IG0amO5DHbJ3uZK6ijuCzIUHBWw4bBORe6/umkIm+sGsaV7Rc+fLsoujxo10mqhU/cpUI5LcQ==
X-Received: by 2002:a05:600c:1c9c:b0:42c:b697:a62c with SMTP id 5b1f17b1804b1-432a9a85113mr16263415e9.5.1730886382376;
        Wed, 06 Nov 2024 01:46:22 -0800 (PST)
Received: from debian ([2a00:79c0:618:5900:224:9bff:fe22:6dd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c0414sm15870285e9.23.2024.11.06.01.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:46:20 -0800 (PST)
Date: Wed, 6 Nov 2024 10:46:18 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Assume a disabled PWM to emit a constant inactive
 output
Message-ID: <20241106094618.GA306258@debian>
References: <20241105153521.1001864-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105153521.1001864-2-u.kleine-koenig@baylibre.com>

Am Tue, Nov 05, 2024 at 04:35:22PM +0100 schrieb Uwe Kleine-König:
> Some PWM hardwares (e.g. MC33XS2410) cannot implement a zero duty cycle
> but can instead disable the hardware which also results in a constant
> inactive output.
> 
> There are some checks (enabled with CONFIG_PWM_DEBUG) to help
> implementing a driver without violating the normal rounding rules. Make
> them less strict to let above described hardware pass without warning.
> 
> Reported-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> Link: https://lore.kernel.org/r/20241103205215.GA509903@debian
> Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> in the context of discussing the implementation of an MC33XS2410 driver
> Dimitri reported this (unjustified) warning. With this patch the
> reported warning should go away when applying the optimisation I
> suggested.
> 
> Best regards
> Uwe
> 
>  drivers/pwm/core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 6e752e148b98..210368099a06 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -75,7 +75,7 @@ static void pwm_apply_debug(struct pwm_device *pwm,
>  	    state->duty_cycle < state->period)
>  		dev_warn(pwmchip_parent(chip), ".apply ignored .polarity\n");
>  
> -	if (state->enabled &&
> +	if (state->enabled && s2.enabled &&
>  	    last->polarity == state->polarity &&
>  	    last->period > s2.period &&
>  	    last->period <= state->period)
> @@ -83,7 +83,11 @@ static void pwm_apply_debug(struct pwm_device *pwm,
>  			 ".apply didn't pick the best available period (requested: %llu, applied: %llu, possible: %llu)\n",
>  			 state->period, s2.period, last->period);
>  
> -	if (state->enabled && state->period < s2.period)
> +	/*
> +	 * Rounding period up is fine only if duty_cycle is 0 then, because a
> +	 * flat line doesn't have a characteristic period.
> +	 */
> +	if (state->enabled && s2.enabled && state->period < s2.period && s2.duty_cycle)
>  		dev_warn(pwmchip_parent(chip),
>  			 ".apply is supposed to round down period (requested: %llu, applied: %llu)\n",
>  			 state->period, s2.period);
> @@ -99,7 +103,7 @@ static void pwm_apply_debug(struct pwm_device *pwm,
>  			 s2.duty_cycle, s2.period,
>  			 last->duty_cycle, last->period);
>  
> -	if (state->enabled && state->duty_cycle < s2.duty_cycle)
> +	if (state->enabled && s2.enabled && state->duty_cycle < s2.duty_cycle)
>  		dev_warn(pwmchip_parent(chip),
>  			 ".apply is supposed to round down duty_cycle (requested: %llu/%llu, applied: %llu/%llu)\n",
>  			 state->duty_cycle, state->period,
> 
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> -- 
> 2.45.2
> 
Hello Uwe,

works for me. Unjustified reported warnings are gone.
Thanks for the patch.

Reviewed-by: Dimitri Fedrau <dima.fedrau@gmail.com>
Tested-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Best regards,
Dimitri

