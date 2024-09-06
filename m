Return-Path: <linux-pwm+bounces-3143-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EBB96FCCD
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 22:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D13D1C20B75
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 20:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A2161FF2;
	Fri,  6 Sep 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T1lvNzk4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D511B85DA
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654818; cv=none; b=kPnh6d0MuxZ7qnHBq32XqCHS/7/4PIy+VSxhuO6QMjUG/m5JbUdUiEvjyCVIxJD+0hWTPhKfprgB3OLDpkv9rzPiKSx9CuRquD8/LZdHUM0fSvkZBtpZMfsbyuigZInCpM08DmaLsXegRUsIIINATqsIcYuCksv4RUGmG9yHJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654818; c=relaxed/simple;
	bh=ikebeBcz5cSIYCBQ8PjKQKNEo8OA1g5B2dw8kly33eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKGJppNyuwSdo1hxl6u3trDjKPH3z61BZ/b3iFBPkvg/vC6gnzX1hiDRKbRt4wuzBe7k+QdfCURN3Ug83XJFizYBc6DHgmcnXVyE/dtOtyABcxYI04z6BAxdl7yKAiAwXBcEcwyvqiLOOL8URa++VwYD6UalTjxgGZvMFEQxITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T1lvNzk4; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70f79f1e1fbso1318479a34.1
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725654813; x=1726259613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qIgCTq+obJzkF+tjNT+7z0riDYSgMnAHsLTd+VQSHlw=;
        b=T1lvNzk4HStfkirZBJt9qoQcc/oluJqNVj3h8r99dv82JEYlw6X6XUXS5RlvCNjH43
         TtkFzOphlM9YmjTDMM2ju1hweT83BrE93di9wpwyixmuL3OPVkD3JMFIy345s/onmDrd
         LvN28Meih5bQDUtt97vF8Z1KS7o27CBJyoOtUs/8aN8Ro+fggIACP8j8tytHPSw+sR0+
         Xo/S/wFmef2E+2SFJPst1gqIOdjT04zPvD4HeerciNCvyBsforRVlQza4FsN+PV/yQ04
         o6nt3jomulFHgjXlK/aw9AkHWQHxiPvglZuH3MMLjqC7X2cAoTLGPkB7fyxW1ddzW5YK
         UE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654813; x=1726259613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIgCTq+obJzkF+tjNT+7z0riDYSgMnAHsLTd+VQSHlw=;
        b=HpA0QKZWl27z+6/RrZYpZBWEXW4r+4s0pY/THtyoC/ZnSw8SZo75sIAzhA/awAJbNt
         /9bAvGehVXrv6QiXcURNWAKskE4IFWGuEzSkYfKzwa7p/zQsA+S0SSO0lqnktQtcta4r
         RNaLlIwj8fZX6t0pmEbHK2cDyo0S+/Ym2gRlPM5WNslCMew6Xar29ZYEgum5pn62HIrL
         IqkIlwreLK3/lJ7z8zZaelPOSTp+uJwbOKST9O0QvWxRH+fxCkTdr/gnvNnXq6M7WRkD
         eBJKQnSyrmSCFt1ez9ubq6uYwJgSIkR4mE6weLnYaLZ78hSPBlfLMCSHDLeGyqs1P8gK
         B3yw==
X-Forwarded-Encrypted: i=1; AJvYcCW2lvGH+B8L9txiz8U2Va86+HkscZ+K8DLLuRXiMNrl1QiJFUIOhONGpTBdGDIlK+VH4faCJy8GS1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4QDEiAFQPR1O0DcNj6izjeBtNgaPc3FTdSFS7nQhKRQPi27Mq
	hooVEr7UZw0eu57aoccRC9MTTTsXdkKq6om0Y42yGQiBCiaWar2WjDRsArhVuOyM2D0UlEE/cGL
	1
X-Google-Smtp-Source: AGHT+IHsku5LQdLIIJo1Ylm1eegbZJUmAB6SAXAOd9TABLS1yCcVVLOa6Sv3yGaD54stKGkeyAPh8g==
X-Received: by 2002:a05:6830:498e:b0:70b:2999:2d7e with SMTP id 46e09a7af769-710d5b45f14mr1628367a34.1.1725654813623;
        Fri, 06 Sep 2024 13:33:33 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f671c3ea0sm3842601a34.77.2024.09.06.13.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 13:33:33 -0700 (PDT)
Message-ID: <9a3f2249-ecfb-44f3-9564-d4e8ee36ab33@baylibre.com>
Date: Fri, 6 Sep 2024 15:33:32 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] pwm: New abstraction for PWM waveforms
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Kent Gibson <warthog618@gmail.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <88d66bf04e90c21bde1b48baba9bf23446b7e701.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <88d66bf04e90c21bde1b48baba9bf23446b7e701.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/6/24 10:42 AM, Uwe Kleine-König wrote:
> Up to now the configuration of a PWM setting is described exclusively by
> a struct pwm_state which contains information about period, duty_cycle,
> polarity and if the PWM is enabled. (There is another member usage_power
> which doesn't completely fit into pwm_state, I ignore it here for
> simplicity.)
> 

...

> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 3ea73e075abe..6a26a5210dab 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -49,6 +49,31 @@ enum {
>  	PWMF_EXPORTED = 1,
>  };
>  
> +/*

Should this be /** for kernel-doc?

> + * struct pwm_waveform - description of a PWM waveform
> + * @period_length_ns: PWM period
> + * @duty_length_ns: PWM duty cycle
> + * @duty_offset_ns: offset of the rising edge from the period's start
> + *
> + * This is a representation of a PWM waveform alternative to struct pwm_state
> + * below. It's more expressive than struct pwm_state as it contains a
> + * duty_offset_ns and so can represent offsets other than $period - $duty_cycle

According to [1], "$" is generally used for environment variables. It
suggests that &struct_name.member should be preferred. I don't have any
strong opinions on what is best, but $ jumped out at me as unusual.

[1]: https://docs.kernel.org/doc-guide/kernel-doc.html

> + * which is done using .polarity = PWM_POLARITY_INVERSED. Note there is no
> + * explicit bool for enabled. A "disabled" PWM is represented by
> + * .period_length_ns = 0.
> + *
> + * Note that the behaviour of a "disabled" PWM is undefined. Depending on the
> + * hardware's capabilities it might drive the active or inactive level, go
> + * high-z or even continue to toggle.
> + *
> + * The unit for all three members is nanoseconds.
> + */
> +struct pwm_waveform {
> +	u64 period_length_ns;
> +	u64 duty_length_ns;
> +	u64 duty_offset_ns;
> +};

