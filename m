Return-Path: <linux-pwm+bounces-3142-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFC496FC63
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 21:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B42EB257A5
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8878613C3F2;
	Fri,  6 Sep 2024 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dsWj/MVz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372A13C9A6
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652475; cv=none; b=uN7BUXRU+13OfLx3myH1Dlm4fCzu8cMuPfjZ7+Lv+Lb2AXKJ9ROSZQAH/IAgrvysaHQGirZeK/smRg07CE/MG2bfplR6QBVWe7YravGSs0qTRrhh2XCcO/CxJ6eVa9KrmtWK12SWBiFmAEx1pPu24qo9j7fYY/U2g6OqxKTEe2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652475; c=relaxed/simple;
	bh=V21m3/mbchmTW6eixMT+0bHRsheyK1NxK+8IBqt6UNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkAJBECRtXOMa+IhheDQ7YcqwvioBT33jqFbcmZUEGaWOwt3S5fCKAFpvvGGGsICYo3KFdeB+lE92zJoK/6Zl9e6FiPQxhra9Q3277Qs8UMIz+P5NBi05vbeBwXIr4R0SgYKZdwTsFtBCi1bp3ZzrTpuNHvXB8HQluyrU+OQUSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dsWj/MVz; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5dfa27571d0so1804458eaf.1
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 12:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725652471; x=1726257271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xqUMaTsTvvfsMC+2dl/NDxU3L7RsyvVSeI9oz2c5DPc=;
        b=dsWj/MVzkxtjD+966ExrHgzgb4ULx60rdhI7dIAE2W4obKXZc/e8Ds04xCS9cZr8rJ
         /yuHedwlqQOe7X8NVUeAyXyiRaYskBpw8Ciwq3E5wv8iq0FwrXVkyL6z2VoVr+Vw9QRn
         b91vvTwrJ7ylGw3nfDQ8oadkLX6luAFxIhkaqzaiy/uQURcjB6V0IZelXg5FPon6CyXF
         ppAL+8zTSoOaeXUXe7Tn/1yH74lc1obFrL/pUzVCvfi0waEgppxLs6MRyU3HpZZjlkiP
         fWdJ+xAKgRrQeHvOjY67ZQidqHdi8AHKeHWPRvy/lOZmwdhGIuVvEGWtW8iSQ/10YTlv
         sW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652471; x=1726257271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqUMaTsTvvfsMC+2dl/NDxU3L7RsyvVSeI9oz2c5DPc=;
        b=cvC4Aqy/Yz+t9ULy2+b5ygy2/r/7wgkprrFxMi1rfgRcXvxnNs7qfMzBz+o2GJTK9K
         lUvR/n64b/io/NOaPQfTAWkpdrzB3dFBxmAP0wrR2dcSGywmIO8Rii8e0Ef2G23jXTBP
         5BVnQp0aHBwX9Lm9LzdK95pKpVgdNv0yJwsKVfHEQYW/gGqSOASq4UKqWLGMQmFX3nts
         q3Y5rJpfbd9ewf5vYTiz1fY6PQznpfpCEQSfw8KubrG8WuKBMjwntJHcPPjoS2oRVLH5
         NQAVzP7QIX3buv91pTzaM7RbX9nNqGITdNa6+wOh4dZ6zgs8ua4xafG5Z9LoXHjUAX4t
         XsIA==
X-Forwarded-Encrypted: i=1; AJvYcCU4v0yDySWR1hi3Co+XmA7fx7kgt6qXAfdWOZ9lOWaaRgeLp+3f0j8A5/AzarAjpbfkxju4++MwrBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRPj6PT20GxDh73tLWXXlJtYWElRqkn70bFgpGnkgUTa+CvTn6
	2r3EuAr7ys2faFZo9z4sxUNMs6R3rSWJmqQOq/A6wyTiLfvdOv5+LtlhO/YkAWA=
X-Google-Smtp-Source: AGHT+IHS9HJnedJFTJIFnbzg91xbE9+SEeJ+tf24ymYvfhZaaSffnOIrK0gcB1BGxX4lFXrzQjB4+A==
X-Received: by 2002:a05:6870:d24b:b0:277:f3f6:8c3b with SMTP id 586e51a60fabf-27b4a00d7b7mr4573883fac.12.1725652470737;
        Fri, 06 Sep 2024 12:54:30 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e1ba3aa035sm79399eaf.46.2024.09.06.12.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 12:54:30 -0700 (PDT)
Message-ID: <561434b8-c13d-48a0-86ea-026f83dfc98f@baylibre.com>
Date: Fri, 6 Sep 2024 14:54:29 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] pwm: Add more locking
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <a519af534a6670fdb0c3ee9c2aa80106c35ff489.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a519af534a6670fdb0c3ee9c2aa80106c35ff489.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/6/24 10:42 AM, Uwe Kleine-König wrote:
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

...

> @@ -336,6 +367,11 @@ static int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
>  
>  	guard(mutex)(&pwm_lock);

Do we still need to hold pwm_lock here? Maybe we can remove it?
Or add a comment about why it is still necessary even though we
also hold pwmchip lock.

>  
> +	guard(pwmchip)(chip);
> +
> +	if (!chip->operational)
> +		return -ENODEV;
> +
>  	return ops->capture(chip, pwm, result, timeout);
>  }
>  

