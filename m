Return-Path: <linux-pwm+bounces-3176-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CCE9723F7
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 22:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EFC28340D
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 20:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7DC189F57;
	Mon,  9 Sep 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U/I1S33j"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10F17D34D
	for <linux-pwm@vger.kernel.org>; Mon,  9 Sep 2024 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915198; cv=none; b=nIAbGRhuuAAFq8NFFyw+RCWWikAFuf586ygGSYHnVmNz2iAo281iVfJrh5Vh6Hv/WAllJiOYR8UhzAjia8XeYF6FGGZeyo0uOHW3elwJrVWegLk/GlwvXJPJFcM0gC37FL6bvO8oXIKCMjmPhRLHHk/HsiO7oQmeCy+/M2CtfVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915198; c=relaxed/simple;
	bh=z9TJzK/mhEXGWyHZDko97el1VUMAzuDN5oQkP9lPXCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQbrPNmm8gI/5kwkf8KmCgJNQ4YIZiEECAPel2b5pTI/WxilWEoGYGNnTD+xE1NpxjoY0aL/m/NIVdDWHGkGDL8qjj49PIl6XY51aUFsrMRiY8leOhWhUVUGUF7VCWuC5EBVt8oF+7bHdOq3am2Gq5C8YMgD1VgZ0Tkv6hJud3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U/I1S33j; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5e174925b7bso2998429eaf.0
        for <linux-pwm@vger.kernel.org>; Mon, 09 Sep 2024 13:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725915192; x=1726519992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eq9LZNAAzNozt0Xf8G7izLb5pSM2YCS4iaekRTUtGkc=;
        b=U/I1S33jc5FlRRebV++Kx//D9If0ATiouplB8VHsf0siJkjbB1qTRfCivi4nY/gxfG
         rRHPhvyuQK6QFh7vzMp9rgSDC2wdJKa5Os/1EB9J+Ao6j8VXHCDEaAU8aAkTOH7XMT6X
         f+MO3rvyuYeZnUgHni+5r46UbHPvyY3b4BPrx7262EB03WL9YhNh5AlYdivNLNC/q2tG
         LRDk8QgQnCEer5gsZOasSTyzyL0fI4iW4kSrrreqz89tQjpw/Qqme13Vkwa31KTk0d0S
         TE+sC6O55eZOfz0uHFZZq7EEsrd2DNtp07BOXSSc5yKCjr3pAbI2UCOAXQi4YFIWMAR4
         7FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725915192; x=1726519992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eq9LZNAAzNozt0Xf8G7izLb5pSM2YCS4iaekRTUtGkc=;
        b=a9O7iZ+wFUkPPpZqNtvCecvLGNUKF1TmmfXq+bAzm36RZ18DdYu9s55rxzpsP0lQ5s
         iC634hxZdenneTNTg25yWvJrKu93Jaj1P3JwOZ94NIFac1iploEp4CO/x1+jr04feQ1T
         F/l2+qzsET08sVwt4boa4qW26sV4gOxHFxSkfbhHfMCgMrG/grms0d6HMzNk5TS3n1ci
         cv9jc0zBZbCSRBvOrjySJ8UWlb2p8DPhyF8zdJ+++6kYOnB1NLQ1cB4P34Yoq81omG2q
         Banh8YY88uc2YjuX0h7HcJlCRvMPlrcO4FBm9QJaWCvENkSnWmRw77+o1sKi4zCw9TS3
         1brQ==
X-Gm-Message-State: AOJu0YyVlVNNW3hJgMT3yqqnRPbRKzhuIgBhOnvcorA8Fj8E7z1CSdA4
	msFvvYUzw50wiXWjpxaezTIU1zMlbKnGtAR8c+upTbwETJb6InGQ9+NppdwGcDVFipdVdk+YUQG
	V
X-Google-Smtp-Source: AGHT+IFtPU40TofYS2uPCB0nwxGNAAwHUHNul5lKX9aOHczjEo4ZIvWNeRb6gjNwUiRuCVM+S63nzw==
X-Received: by 2002:a05:6870:b14a:b0:277:fb50:5f64 with SMTP id 586e51a60fabf-27b82e88af6mr11978641fac.24.1725915192519;
        Mon, 09 Sep 2024 13:53:12 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710d9dd6feesm1522484a34.70.2024.09.09.13.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 13:53:12 -0700 (PDT)
Message-ID: <37e84d8f-f7bf-47e6-811f-50a6e71f8810@baylibre.com>
Date: Mon, 9 Sep 2024 15:53:11 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] pwm: Add support for pwmchip devices for faster
 and easier userspace access
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Kent Gibson <warthog618@gmail.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <00c9f1181dc351e1e6041ba6e41e4c30b12b6a27.1725635013.git.u.kleine-koenig@baylibre.com>
 <7acc85f6-69e9-4e44-ab04-88eaf2ffa291@baylibre.com>
 <5qrct3wt2e544vfoxaaacdifxcc7k243hnlrs7rki5nkbki4os@vfss2f2g4hvu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <5qrct3wt2e544vfoxaaacdifxcc7k243hnlrs7rki5nkbki4os@vfss2f2g4hvu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/8/24 9:59 AM, Uwe Kleine-König wrote:
> Hello David,
> 
> On Fri, Sep 06, 2024 at 05:26:46PM -0500, David Lechner wrote:
>> Maybe a potential problem here with multiple requests.
>>
>> Suppose an applications does:
>>
>> // main thread
>> fd = open("/dev/pwm0", ...);
>>
>> // start some threads
>>
>> // thread A
>>
>> ioctl(fd, PWM_IOCTL_REQUEST, 0);
>> // in kernel, pwm_device_request() is called and
>> // cdata->pwm[0] is assigned
>>
>> // does some stuff - OK
>>
>> 	// thread B
>>
>> 	ioctl(fd, PWM_IOCTL_REQUEST, 0);
>> 	// succeeds since cdata->pwm[0] is assigned
>>
>> 	// does some stuff - messes up thread A
>>
>> // does some stuff - messes up thread B
> 
> If two threads share a single fd for a given pwmchip char device, it's
> in the responsibility of the application to not shoot in its own foot.
> There are similar problems if two threads write to the same fd
> corresponding to an ordinary file or directory. I think behaving
> differently here isn't a good idea.

Yes, applications should absolutely not be doing what I did in this
bad example. :-) So, that is why it would make more sense to me if a
second call of the REQUEST ioctl using the same fd would return an
error instead of succeeding without actually doing anything.

>  
>> 	// cleans up after itself
>> 	ioctl(fd, PWM_IOCTL_FREE, 0);
>> 	// pwm_put() is called and
>> 	// cdata->pwm[0] is set to NULL
>> 	
>> // does some stuff - kernel has to call pwm_device_request()
>> // again, which may fail? e.g. if sysfs stole it in the meantime
>>
>> // cleans up after itself
>> ioctl(fd, PWM_IOCTL_FREE, 0);
>>
>> Maybe we should be more strict and only allow one requester at a time?
> 
> From the POV of the kernel code, there is only one requestor, identified
> by the opened file. Handling that in a different way isn't a good idea I
> think.
> 
>> Or maybe we just don't need the REQUEST and FREE ioctls?
> 
> The idea of the REQUEST ioctl is that an application can make sure it
> can access all PWMs it needs before starting to change the
> configuration.
> 
Ah, I had not considered that case.

But if it is required in some cases, I feel like it would be better
to just make it required in all cases. Otherwise, it feels like there
are too many ways to do the same thing if all of the other GET/SET
ioctls implicitly call the equivalent of REQUEST if it was not
explicitly called. It is one less decision to make for me as a user
if there is only one "right" way to use this interface.



