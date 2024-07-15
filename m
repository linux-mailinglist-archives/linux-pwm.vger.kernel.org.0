Return-Path: <linux-pwm+bounces-2823-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D13B2931D25
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 00:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCF5282862
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 22:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433BF61FFA;
	Mon, 15 Jul 2024 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uCaLHjqT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439013B791
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721082231; cv=none; b=XZx0sPkVCZweynAPE+IDjgVVLu9XAyeO8l89j9RyEXYjgBupeEo1kPme23i1iG4/Chyy6AEaIUkRDvuKIuvcIjSbefnS4F0YyUNDG/ewE8j2V/ks8//g/4U8TpKPhsG8LB1Y4x1TA5KLdMJVdu+cpZ2nczjgbSV34c+Uv0uVnS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721082231; c=relaxed/simple;
	bh=Lxo2DbSxIPU/rZ3o8zoNU40Ll8hymHjxnvPrZ3ZSmNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sM16Va+EJ3pjxUv0xk7rDCr4U7O72Ndk4PIluBwnZyeG000FfCv4uatMjvlKwE5AhPbDaC1d+wjex+SYpHaVOCWkqiMhm5/LMripr10/NvJlgOwAfsRlq+qIcBbitYzsbPdb/mHR9RqeRIdWFdMTSqNCt2LaZEuVrtSr6Fd3Fds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uCaLHjqT; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-703631c4930so2504889a34.1
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 15:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721082227; x=1721687027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6zj9CkC9wdCJqXFTbj5YW/fEVhw0yWFIxOAfhAjZpN8=;
        b=uCaLHjqTg4H2cMChtPRtmcVi7HAZMRuRj0okpd+Vae2LkFCJ6folN1VsDxP/+R8aIO
         +/MJFnYjHnjomtuaqHZginRFUVuQca6bAecFdJ3c6wXd2C9/GkkuIvcfAidALyXQuhgm
         IjLuKmgEUwdfS3S1oOyFBjPFnmwQjsudho0Iv16qHHeNd0J2tEU0YyEVoXk64YbOLBhv
         BrUlHoW6fTX4UoTFgAs0eg/zja7N0M8ubT2um/onY5xYar4QZT5qonVKJhR/Z+f5n4x/
         B62oZueHug5DGxLZte+T6qpK7q167yDpAi12njOIkRu60mu/HAxTJ39zQX27CJNaRxDF
         Gd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721082227; x=1721687027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zj9CkC9wdCJqXFTbj5YW/fEVhw0yWFIxOAfhAjZpN8=;
        b=aFv5BYH42dymrYQx29mjCf8wCWElThp6DSk6P3YxvufPQuZM1glsP0b+9BnPKYudO+
         1QmO0pkRmYqfQaYAVao9cayeThz6f+3X4wqLGCDKQzISSi2BU15ehhnP0O4Btis5exWS
         UVGxnaYkcxsbq4m2hJOsQFwN4rNY00V7FEiTNvJcerTJN4OtZi9gNqLE3BQWdKDhZT1Q
         pf+Cb53fNN4ooGnq+fmRfJxaGKPifJ+KifoCcVAR7tHXei7vZ24XCwLrJY97Lpy2hP3J
         /q37mNslyQcl0DD7VVngZFGvcF8FTn5UVZ1/Yk3AMsuOoR0q4Cx0BoXI1/I2kWxz9qa+
         1xrA==
X-Forwarded-Encrypted: i=1; AJvYcCXm1Ajz9S19gniKWyT0dxH+a2GJ5BHqO+CfO4IZ5/vnrBFz5Pp8PiYdPQbk/rQayGmcmbXG7NDm6oFIc/9U6fqYnwX551tfZO/Q
X-Gm-Message-State: AOJu0YyMDr7EC+8K05ph1rRBa4nwNR5dl3LftMoDotQWTmfuhUSxmMT/
	qSR6o2ODssCgID+3lDcy5LI4CeE8vxigZW6McOd92kwEQYihXPkx6RF2rmgccLI=
X-Google-Smtp-Source: AGHT+IHZ0cBsVhv4lb549P34qxbN70kr0Prh/+6Rx+vks4ZbYdDkRB3ylvC6bO74wGwGpLSEedIYHQ==
X-Received: by 2002:a05:6830:660b:b0:703:680a:6e91 with SMTP id 46e09a7af769-708d99e9119mr491423a34.36.1721082226972;
        Mon, 15 Jul 2024 15:23:46 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708c0d29022sm1104229a34.73.2024.07.15.15.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 15:23:46 -0700 (PDT)
Message-ID: <ff628d7e-bd87-48e7-b80c-aff2d4e61f2c@baylibre.com>
Date: Mon, 15 Jul 2024 17:23:45 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] pwm: Provide new consumer API functions for
 waveforms
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
 <8db2c6f239b9e101f85d556d9e203935c2da2570.1721040875.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <8db2c6f239b9e101f85d556d9e203935c2da2570.1721040875.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/15/24 6:16 AM, Uwe Kleine-König wrote:
> Provide API functions for consumers to work with waveforms.
> 
> Note that one relevant difference between pwm_get_state() and
> pwm_get_waveform*() is that the latter yields the actually configured
> hardware state, while the former yields the last state passed to
> pwm_apply*() and so doesn't account for hardware specific rounding.
> 

...

> +
> +/* PWM consumer APIs */
> +int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf);
> +int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf);
> +int pwm_set_waveform_might_sleep(struct pwm_device *pwm, const struct pwm_waveform *wf, bool exact);
>  int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state);
>  int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state);
>  int pwm_adjust_config(struct pwm_device *pwm);


It seems like there could be a potential race condition between rounding
and setting a PWM.

Consider two PWM devices that share the same clock and the driver can
set the clock rate to accommodate a wider range of periods or get a
more accurate duty length.

Thread 1				Thread 2
--------				--------
PWM consumer A calls round_waveform()
a few times, e.g. to round up or round
closest. Clock is not exclusive so
rounding assumes the rate can be
changed to get the best rate.
					PWM consumer B call set_waveform().
					clk_set_rate_exclusive() is called
					on the clock so the rate can no
					longer be changed and the rate is
					not the one PWM consumer A selected
					in the rounding operation.
PWM consumer A calls set_waveform().
This will either fail or will
not get the same results that
was returned by round_waveform().

---

If it wasn't for the userspace cdev interface, I would suggest
to drop pwm_round_waveform_might_sleep() and pass an optional
function pointer to pwm_set_waveform_might_sleep() instead of
the `bool exact` argument so that the full operation of rounding
and setting could be performed with the pwmchip lock held without
consumer drivers having to worry about getting it right. Consumer
drivers would then just have to implement functions to suit their
needs, or there could even be standard ones like round_closest().

But that still might not fix it in all cases e.g. if two pwmchips
share the same clock as opposed to one pwmchip with two outputs.
If this is possible, then then "pwm: Add more locking" patch
might already cause some problems with race conditions in the
existing PWM apply() ops. Although, I suppose this kind of
clock coordination between pwm chips (and potentially other
devices) should be handled outside of the PWM subsystem.


