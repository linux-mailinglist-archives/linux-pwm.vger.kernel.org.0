Return-Path: <linux-pwm+bounces-5772-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6695AA10B5
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 17:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDC09214FE
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD16F22A7E2;
	Tue, 29 Apr 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YcjTq8pj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8E227E92
	for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941220; cv=none; b=uknRQk3QmoM4VJjDcsuqgCHyALJ03HPrJlE8zdqUVvAvCAbJBhn1rqCNx0H/ILGcXpxl5eTLqeT3YY1VJfrxTZ64FDC5LenzmPbL8DeE4WPPgy34Pg7eXe4bROxC/cdp+Ranikr7S0UEokjNMbGoFv6A8LhqTeT16tyTVugQ4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941220; c=relaxed/simple;
	bh=ZSlaSOOnAD2Cp1tBIlvme8AqpEDC6hlg0gqvRaVTa9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9hc4A/eEIfT06ClLehsI6/pdHXDHcyBFTOMbArcxut9dwPDhfYEcTe2MAO0oJ89BGzoJVSDLUV5j+ovdYwIqZsoeTYFNOi2bV5crJ483pfGM3ynn7w0EKnhXt1D6LQkMzpolktOZVsEx0v/UuUQFpFChNk8SvL6EGnzk2l8x7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YcjTq8pj; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3fea0363284so4130334b6e.1
        for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745941217; x=1746546017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKHZLFnrfagn8Gc44g2MZTpXJ9t5oidezhlrUDWVs0Y=;
        b=YcjTq8pjS1P3iyQIQa+y+f0PTT18kC5URqpqC9eSdoczJ6mSQCMKAsI7zZbclH4vdV
         HqaQfHUEd7ZmdewTEWlob4/Yo7EF5XyM8iH2A4SKgdq/Der4dxzrXCW3zsXwDofH2gHj
         3+gBjYxeR3a2bCKBoKBdhdY+hU++Cvw32RsEZ/x6ZmbGygg1VyCTEyNzKp0r+EDN6drJ
         jjYYPGdxTvwkPHX6c5FAZ0D7+2jhC9wQLn1z5mw0SJTVzYcyzXmGZm7e1QEMOf/IIPkj
         CTcD37u/Qmw9ggMLLHLLW7v41et1kE4yrw33wtRjv7LA17ZtgYwBPY6G5jJ9WdrBg74H
         pSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745941217; x=1746546017;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKHZLFnrfagn8Gc44g2MZTpXJ9t5oidezhlrUDWVs0Y=;
        b=gwijVTxVnluJnr5PEpMv5ocs4MwhIQ0Uv4adICUe/okI0GNbBRrHg11g/KJyQqvnmx
         JA8J3blGEkIhVyje/ymSkoNK6z8mVyrJHX0qwsEMNBab4bPFlQlNPuTQFMI5DUdlDkGA
         HdLm0NAbVrMdY1yirFLoDf2MwNAE0GY8Yw1wATuvVjQfPfhJTbVUiDe/JqH1EImUJyiF
         nLFyQq28Ircsl+CVpwuaynd7z5MVowIhuCkbxYbHIFtXbT7onpRdj3YGB0VPi2hZQwdq
         KHwOLtgS72wM2FDwAlEGJntnIi+SdXN8NnLVFf7kQoRcON/YlelBf2HU9SLA4y9U8snY
         jLWg==
X-Forwarded-Encrypted: i=1; AJvYcCVUIQpyslZ/p3bvuj/MuL/ooHrRoGT3YOi+UuX8GZNuSfKzKo6imebRJAtVSvuIpRG6HcyPxK4Vbf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvvX3qpmBNIreRGj3/k5LN5noRtPWzy+AfGZCeUYXyAd4j0hUU
	e9NwPxkn5mjSeWbY4+RrDJndFd/H33VvQ9T5a4+1atfkr4ZXVr/Et8uGo2xrqCE=
X-Gm-Gg: ASbGncuPBQ2xi9jefu2g2G5/O9obbof6FINf3+14ubTM7U73TJdwUPXV/E6ixMo+7dj
	QMt79iXLBS0hd4ndu/Yi0x0o6rT3viJ8zz5k788qK3dhFoyANu9l9zceoGZkHawW+ob1NYO0okt
	srp7koPAYdfuzYOzltI5hSfbLB56aLn/dPRsLQykvyXxsUx/ZeqBJ5oUyeVMDNYPwvsRF+V5puF
	RgHAyF/R7stUTnRsPchEAqFaK5LAyJPlcds6/KTEcR7tpgZCne5RcYaTKR2GQbC8tm6ehjQotmt
	3s/X7Lck7F9/iSYWaRBcf9nMNMujm5I8a6FU2vitf0VF4NIly+JxHzmjpnaCZH4etwduU5jdGz2
	oU9MBBZ0RJHakJUe/DnR0eWfEbHLF
X-Google-Smtp-Source: AGHT+IEoUSoJwOEaMAzGJzx8g+iEjy8VILrk9/hm7FHFKGMS1oJnNn7zWdRkCw1+SUiqaiAkTKDS6w==
X-Received: by 2002:a05:6808:2214:b0:400:7dd3:2dbe with SMTP id 5614622812f47-402110303f0mr1770338b6e.14.1745941216954;
        Tue, 29 Apr 2025 08:40:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6? ([2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40212c4d567sm293636b6e.43.2025.04.29.08.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 08:40:16 -0700 (PDT)
Message-ID: <5aa4d76f-6f16-40ae-9dbf-767c63aa0a3d@baylibre.com>
Date: Tue, 29 Apr 2025 10:40:14 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
To: Jorge Marques <gastmaier@gmail.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-1-638af47e9eb3@analog.com>
 <aAe6u6NhAsgjaL5_@smile.fi.intel.com>
 <c3i7g273lgvx7rpihzq6r7exxxnglbwrqwfryyz6ciqo52tszf@cvi7pz4bmkvq>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <c3i7g273lgvx7rpihzq6r7exxxnglbwrqwfryyz6ciqo52tszf@cvi7pz4bmkvq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 8:47 AM, Jorge Marques wrote:
> 
> Hi Andy,
> 
> I agree with your suggestion, and in this case the appropriate kernel
> version is 3.10.
> 
>>
>>> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
>>> +KernelVersion:	6.15
>>
>> Then why don't you put the real version of the first release that has it?
>>
>>> +Contact:	linux-iio@vger.kernel.org
>>> +Description:
>>> +		Some devices have internal clocks for oversampling.
>>> +		Sets the resulting frequency in Hz to trigger a conversion used by
>>> +		the oversampling filter.
>>> +		If the device has a fixed internal clock or is computed based on
>>> +		the sampling frequency parameter, the parameter is read only.
>>> +
>>> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
>>> +KernelVersion:	6.15
>>
>> Ditto.
>>
>>> +Contact:	linux-iio@vger.kernel.org
>>> +Description:
>>> +		Hardware dependent values supported by the oversampling
>>> +		frequency.


I don't see oversampling_frequency used in any existing driver, so how could
it be introduced in kernel 3.10? I think you confuse it with
events/sampling_frequency.

oversampling_frequency is new and so 6.16 should be correct if Jonathan picks
this up in the next few weeks, otherwise it will be 6.17.


