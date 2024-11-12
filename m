Return-Path: <linux-pwm+bounces-4074-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 876A09C6462
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Nov 2024 23:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8081DB308C9
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Nov 2024 20:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E8320B7F2;
	Tue, 12 Nov 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ts/mEbFx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B11A76D2
	for <linux-pwm@vger.kernel.org>; Tue, 12 Nov 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441734; cv=none; b=PzcIKZdJJU9+bD+Qw3pdI4hyhTkoyK9e0VO/alDmWwM1IC3Gpcr5HUI1JXakvfqgyDj5mpJhIiZX8hYH6+3qVZScD/QitRWIQQIy9q2Qee2BXHNxKHCPf4qE+/jnhhah8EUhD30LF71gj6hxtd84Pccuq0a/HtYLhyoSg2MIl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441734; c=relaxed/simple;
	bh=DsjL5XWtMu7LOlZcx8scvAGiiIKiZ9tDUiuwStI2eok=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pQG+MYUiYzTdj5MxY8SbVWu9nyhr/k+Hb+adExCR3hsoVN9fgLYmWue9/USV52LKNT7Hq/YxVEZA8s/31q9GNvPF1yOLQQ1KUPSy0oiM/6vLFkrnGiyrGb3MXH6nHB+wQdnghpZM5BuzGA3Udk9o6vC4Kr5WuRm7kdmJJ3Mmaz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ts/mEbFx; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ebc27fdc30so3045793eaf.2
        for <linux-pwm@vger.kernel.org>; Tue, 12 Nov 2024 12:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731441730; x=1732046530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sig4extPJZ96lJvrKPLyrOLWEJSmKbg3dopfHgQP/c=;
        b=ts/mEbFxY8PajthwxUh0SHvXAjC9tAF3NkrqRnP0XeLjkumrBKov8OYfg6+Rz76+C3
         gq2QcSd+T4V905cGYxU1wlMsaXIlTXgXSJT9tcv3nX1BOdhnZQrLpwOIp5C3kvIQhauH
         Q/Y+bMo/fV9SnWxH3TUiTRetqIUgjnG4Bag9n/iXNNc+gPgqqtW2SR2xb7365Kn1A7bt
         iiziYyv2LXIw19KIUMRFWPBeqBQ8gv6l8uKtwCfxy6vy8S+jdq7+9CTiVqjuUd5iGyLm
         ZyPBcQwV0+PABObdLkMVqy5R5sc0MyufZeQpxERWhyRRqCzc7goyPhLDDg2XFMltHhbP
         HfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731441730; x=1732046530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sig4extPJZ96lJvrKPLyrOLWEJSmKbg3dopfHgQP/c=;
        b=NRiEjSUeHh939Yy9oMjU838HLqf2MPnIAgzqE+UrTrBc+AeVvtgty8ekNvXw6RjwID
         JYj1wtyswK+76KO3xG8wZk2Sdzb6xUhOxbU0WmlODQznO8BWK/+UBf0fB5jv/eYkz6we
         IeotD0rSn4xQXZzm5/EfnGDb/A0tWjYmxz/OCpMsLz0OECgDL/7EXY75CdHDiQVUeplY
         +n+UilCQZVDDax1+l0IkF4GQ+COhmFptZcHmY2iv+bHgKmKjnWwlV3YygOEqUFPCCgvR
         Da1ygZTkpTH73hQMVIxpnOxIe6VwAuvigVA5YEngwmZr0WdAlsl7E+yuI25aSU2FNLgI
         22Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXSw69yqeIUVbVJCV03dxSG7FA9UgHnM+0Jha/wzZMAODDuk3p6oYN2rhutOlj9VqZwyuq0iLNVfAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1UGlKFdTtcU4cXWhIBT+5Nh2fJGE6ex+H8V8hFud3qDegx9V
	P/AUiJZ71PjD2JUGLCwFV51lUj5UsueKlhKiWZtp/NcZ0B/G/ewAKHrxQmBEK3A=
X-Google-Smtp-Source: AGHT+IHvgnmHiHHXULfY05GGiY7fOLLPMb5a5l/JeZR/daEqHCvkzI6U/0uYYnu+Fc6sEEFJ3gXDJw==
X-Received: by 2002:a05:6820:4c89:b0:5eb:821c:df23 with SMTP id 006d021491bc7-5ee57b96a9bmr12114816eaf.2.1731441730645;
        Tue, 12 Nov 2024 12:02:10 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee494fb9a2sm2503376eaf.1.2024.11.12.12.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 12:02:09 -0800 (PST)
Message-ID: <4b48ae8e-4eba-4d86-af8b-2b749c53639f@baylibre.com>
Date: Tue, 12 Nov 2024 14:02:07 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] iio: adc: ad4851: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
 <20241111121203.3699-9-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241111121203.3699-9-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 6:12 AM, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v6 (implemented most of the review comments in v5):
What is the plan for addressing the rest of the comments?

I don't want to keep making the same comments over and over again.

