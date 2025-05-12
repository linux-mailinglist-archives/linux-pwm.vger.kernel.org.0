Return-Path: <linux-pwm+bounces-5919-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE9FAB3809
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 15:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877D616B9CF
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 13:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA37B292925;
	Mon, 12 May 2025 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enxGZekW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2028D857;
	Mon, 12 May 2025 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055078; cv=none; b=Qt7c6jGndD/DyL4C0IVXp0x7sxeZg04FmnQoUVwNb+CiY9mUcI5LGM48mrDfvvraGxDom1zZE68Q9kFwGGYA6IEPmmGO7mphczIY+ET895ZRNUIoZ3k3p1lNV30L5siZkc13PqmXNr4blr60aW+ZLi/qosKxSKszpkNmLkLhDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055078; c=relaxed/simple;
	bh=iLFgRRCO39Q3JxxWL8w5P9PLXG/ljboEiy5Wwh+FfG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itNlG6HOIjqsXQBcpJSawjAZglZYs1Gk2V+22b1yZjBDcIMGjMnwyVS04sVBfl5vlqxwWjd2BSHkP75+miCFPsiKkYbAWIUF5JrucX7ouc2xRTaTjcAmYiHu4Nx4Z1blwTIdVUG0Dp5FnXJrflimxT9GmNSa7qih2mmTafJLljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enxGZekW; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b200047a6a5so3181431a12.0;
        Mon, 12 May 2025 06:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747055076; x=1747659876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bcZBEPLgYelBgurqIkIwecDbVtaz0AyfAL2PfCIE6TE=;
        b=enxGZekW+b0dtXjR6L85dOPle+cQfTGzvcAVvh5hUdlMEHorGwGyWkUW9K7ZDOeEfQ
         F2aEREK/O4Z8ceKhVK7hii4H801fubk2etqBg1DCpHDnS17q8k+/PccqWZHslBQEwAcG
         96gzYJVw7hhcqoTjo5TX6dpoGrt6qgPLXA/pIQta8Lx+w4TAZQS0LSUdPlUzcP1gkSIQ
         cu4tcjw5jsMAJ+LZg7gBRvj5paicXzeY9XrHXlB5b5ztDbb5otX5NTpFWFaZmA1F/rgD
         Tp/2Lgeal0/jA8OC/uWdbaRV6UcO5IIJbYWqcgmwSTEmjVj+2izNTdE6uQ3Co9Ra1rK2
         cvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055076; x=1747659876;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcZBEPLgYelBgurqIkIwecDbVtaz0AyfAL2PfCIE6TE=;
        b=WF+LDnqBgl7LgqTb0x8LBSl97Lc/FXZyKCYLUR7EqjR0oah3Uf+bW03FsnOJhw1Bxz
         rm0fFRWS0/6nhVlj3/RonoxsiqSAkbr5AxPOyHs93ipItgtp3Bepg3Dv78l/0QaNV9aX
         qj4687pKKktmPltHs7RNBOXiMbI/YSCekBwB2KLmjM9gdtrkCxKdDM5W6zyokCiP1ZVb
         GT6FGV0AsvffETdX7QTGaArOi11MCfU1nqD/8zUhtevpRFc0w3zTFzUMnESW0iOje3d9
         XgN9WGzVJG+MgVzEOFbppjJxDiVdDQrTA3ki7Xh9tzAn6MUZmMZZONPQZeeuLGEjEECJ
         GXEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP/ji6KvSrrJYFne1NOdKcN4pL/yUgTugdEcNq0YgZgx0sA4sf+p//BOu/BTrQGY4g+VGp08eEmsk/RMxV@vger.kernel.org, AJvYcCVZebdIUS6O1eB+zXgKjRgwOrpsDEb3DQZSi5WOx3MF9NTqfOWnBKrpPwNVk6GD2f1tbTywsBRi8/f7uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5HpbC6meXIHYB3qNYEkTvT2IyG3u+u7sDKSqm0bqZQVemgNN
	6AyJfc0Zv6Ghd26QWRwBxMymb1SOQQdRkFzqC/1i8BqbWBdPGeK1
X-Gm-Gg: ASbGnctfCljtNzUy4zVgyFpG8K9zWHoY0NZ6TeTghM/YHtzUbZM2o7VteJGOPQJGoc0
	x2xipLEH/atPXPQZO+IqQICMno1wyWcyS3Wi8LxUOvMSPNsaOsn58w7rKJKnCeF9+IQ/i9lioE2
	R5CUr7AxHR8nsv1BTa3r5pKKxlzH5HShfn1sUifI7Lamq4exiujLzu2Az9UD5Zq8uCzqG8FE/el
	pCDYDqZv/YssEOm/jHWBJg1dXBIMQLjUUhBA/7pq2rBYv8VvjUPYzXqdtVTr+vwl6F1aha/6LN4
	R+rClUoX7FJiX3QE5MN6tNWC2m73HTAUKq7DBWNMZSnKanBD6VpTa78q7epjI009janc1P5O1Wg
	QtOjbBqEQvYSlSachGzRc/Eaiaw8nTXyYuZo=
X-Google-Smtp-Source: AGHT+IEh4n7WUIlN4lBRkc4MY6FOslGRlNjCYuvS48v9F/yGyB3Mgvl5H8BHCvZh0GQqsYJfqVtv8A==
X-Received: by 2002:a17:90b:2d8e:b0:2fa:6793:e860 with SMTP id 98e67ed59e1d1-30adb0eb0bamr25415489a91.0.1747055075879;
        Mon, 12 May 2025 06:04:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4ffb6f1sm8823525a91.47.2025.05.12.06.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:04:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1bd48694-9760-4e6b-9138-4651d42ff032@roeck-us.net>
Date: Mon, 12 May 2025 06:04:33 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: mc33xs2410: add support for temperature sensors
To: dimitri.fedrau@liebherr.com, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Jean Delvare <jdelvare@suse.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Dimitri Fedrau <dima.fedrau@gmail.com>
References: <20250512-mc33xs2410-hwmon-v1-1-addba77c78f9@liebherr.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250512-mc33xs2410-hwmon-v1-1-addba77c78f9@liebherr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/25 04:26, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> The MC33XS2410 provides temperature sensors for the central die temperature
> and the four outputs. Additionally a common temperature warning threshold
> can be configured for the outputs. Add hwmon support for the sensors.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---

> +
> +static int mc33xs2410_hwmon_read_out_status(struct spi_device *spi,
> +					    int channel, u16 *val)
> +{
> +	int ret;
> +
> +	ret = mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel), val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Bits latches high */
> +	return mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel), val);

Is that double read of the same register needed ? If so, you'll probably
need a lock to prevent it from being executed from multiple threads at the
same time.

The comment "Bit latches high" doesn't really mean anything to me and doesn't
explain why the register needs to be read twice.

Thanks,
Guenter


