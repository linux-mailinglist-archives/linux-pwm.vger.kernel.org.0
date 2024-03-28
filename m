Return-Path: <linux-pwm+bounces-1829-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E8589087B
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Mar 2024 19:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C88B229EF
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Mar 2024 18:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0161369AC;
	Thu, 28 Mar 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hph8jACk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4713667F
	for <linux-pwm@vger.kernel.org>; Thu, 28 Mar 2024 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651491; cv=none; b=QKiU02HppMnVk1bGwocnLSChqJFfVPLb7jM29Fq/7lp8geYWbnADAaI+/dw5w/Ck6fQwM5etm0NbQm/IMWhkr+exFSPFhE39mIOE/t/7YesokfR2cAgWcNe8OLjjArj+ct6eAtbu8dUyn8IX0D04lyIQMK7Z01YGp516JmeaxGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651491; c=relaxed/simple;
	bh=kpqMq3eCAuoFdHZIONRVJyvi5rmdSCxH9DFNtWEwvzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjVm/eDGbWIY53suylYHyekCCGYfM/lSXQnjF8d2N7OuSsgynWfW0qOmoolbIfUg7PKCAuQqvlIl8nm90Wo6cX6Lyb+6PTUXyAUZE0dH0kLdIPZCkN5w3cRXIAX0UMzDqMg7H+6MORDMCnCAC4r3INemvUlQz3M7MDZaehWopJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hph8jACk; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a522ae3747so550948eaf.1
        for <linux-pwm@vger.kernel.org>; Thu, 28 Mar 2024 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711651487; x=1712256287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=na3eLPmgHG6mwR2vC6vwmSyjNkrIwTvx3r++aBE0FCM=;
        b=hph8jACk7+dZEh8o4JvRCjmuTunK4BKy1QM4lHkJvSkM2yw6AHI00TP7sk0/u3WFan
         EssxjF6UyVodKQCHucSllKOczMG5CMNXMzcOx6FLpFvhOdXbLA76yZFrMXIrmgJqCR6y
         GYBIuIvIXLhRy2kTou08uNtYOYqXt466IhsSXpG/TC+u8Z/OuyUXRiWT7YxnEiCbx3U2
         FDYj4uNCCxWoGMbsjpzhLkXbt3UCRWaBBJRYo/XtIr2ShANRrbOdHoQ9e6rP5b9n0+KX
         YN/OR2jGgRVRc/drWPeNMv3qW4C4L3HBDblnYgj8RIQiLY53KyIvWxhwyU7CXcfv5Lz0
         YZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711651487; x=1712256287;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=na3eLPmgHG6mwR2vC6vwmSyjNkrIwTvx3r++aBE0FCM=;
        b=sI2SuihqkEvWq4m0g+FRSPY8omjnlBdv3c1fiMRRoq4cAPSYf5mpO8QZdfBJwDmhVG
         zBrUEH0cElQis57Gbyn7zXQnkEdKBH7I6ko+Pmo/hD4K2tDRmhr2TcDQAAekhiPDNvgx
         FtwispGHKXazulEtmX99L42sJ0SiUa1cSgSsWKvqjfL7GbJGUmuoDdULAF1ctSwSgYOG
         1J4o05q39mi8OXUUxyBVOXaj3m4nhfHHnJxFq3xKxDlsHnSFr2gqIAnc3fdlEwKwvGw2
         WfAX6V4H6M50QjRR7jTStiX4K1wE2UbX/AvLJu8yhxOq2A3MTVCCE+1Z6XDrxQEYBbYT
         1E1A==
X-Forwarded-Encrypted: i=1; AJvYcCUjF22Zl2LawkBhcTsLxz64ILLaOVmmBLntCZVgnB4KQEv38+c3k0KWG6ekHzPxBRGjc4dzks9fcv2oUFujCv7qaz6AfBqscq6k
X-Gm-Message-State: AOJu0YyXhbSf60GTbw1Ws1zzrglZ3UDkkvL+yB2yVn0uR7g1h1WVi/2p
	0H0MzR8LP9jivueXEEJqA3VreGhas5J4ncW+55wRWlN0at+/ktNpct2njUoR9thanZnSJf7ApOj
	t
X-Google-Smtp-Source: AGHT+IF2+BDXg5vrZkPbbVhKLBf++luinIgO7kxMDuATkjuvsu+bMlQ/t9fWmLNNnKh3gj5QGyJUrA==
X-Received: by 2002:a05:6820:2707:b0:5a4:e30e:8e88 with SMTP id db7-20020a056820270700b005a4e30e8e88mr136933oob.1.1711651487207;
        Thu, 28 Mar 2024 11:44:47 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id o1-20020a9d7641000000b006e6fffdb7d0sm282856otl.51.2024.03.28.11.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 11:44:46 -0700 (PDT)
Message-ID: <66a6f562-1fdd-4e45-995a-e7995432aa0c@baylibre.com>
Date: Thu, 28 Mar 2024 13:44:45 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] pwm: Add a struct device to struct pwm_chip
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
References: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
 <35c65ea7f6de789a568ff39d7b6b4ce80de4b7dc.1710670958.git.u.kleine-koenig@pengutronix.de>
From: David Lechner <dlechner@baylibre.com>
Autocrypt: addr=david@lechnology.com; keydata=
 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
In-Reply-To: <35c65ea7f6de789a568ff39d7b6b4ce80de4b7dc.1710670958.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/17/24 5:40 AM, Uwe Kleine-König wrote:

...

> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 8ed4c93cd0ce..09ff6ef0b634 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c

...

> @@ -1520,6 +1525,8 @@ EXPORT_SYMBOL_GPL(pwm_get);
>   */
>  void pwm_put(struct pwm_device *pwm)
>  {
> +	struct pwm_chip *chip = pwm->chip;
> +

Should this be moved after the !pwm check to avoid potential null
dereference or is it safe to remove the !pwm check now?

>  	if (!pwm)
>  		return;
>  


