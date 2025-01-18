Return-Path: <linux-pwm+bounces-4676-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB70A15E3C
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137D0166329
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 17:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F3319E7F9;
	Sat, 18 Jan 2025 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yLGe/uX/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF919ABB6
	for <linux-pwm@vger.kernel.org>; Sat, 18 Jan 2025 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220158; cv=none; b=NMFKddjJleWzRhDKFGjZJMq3fqxB33kZe0PExTUjs07Zsb8emwzW4V3+lowCtDpsmyMuS5GWuj0dhmDiSSUb+zNDHhObQJ0ws6IlRV8SyhVluOPbirB4YuZikVj9U28R/8t4St8xoPnxubiu/U0uEvd12I2VLIQY6V5U9VY8KoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220158; c=relaxed/simple;
	bh=kZrCpn6iY8XtGJTKSSIuBQiF03IUSPNKK/CSIsfxi+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ud9DGdXRnN2TbfhyqR0D+Q8qZcOKEBiijurRpss+QIXeiFgJRMGt0DOoVgDF3qsYEdZVlam9MZgwzukZvBw6QXToa28djypyrztq6453YpPSVp8O2M7/YyndKQTln2VgYTms/9Xj2s9FEPo+kb1BeEEsPNB9aJG1xh9JWRorcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yLGe/uX/; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2a7ccb2c618so1750037fac.2
        for <linux-pwm@vger.kernel.org>; Sat, 18 Jan 2025 09:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737220155; x=1737824955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBzJX3Q/fcfCDTYZ+q6Yetl/p7poSDSwPoWKQfNelcU=;
        b=yLGe/uX/ABgCFPU8DAbUvToy2Y/qgHGH6VB5pk+eOarvVH+8DbYV2fpDtq8qisqATF
         XUpKoVnjjsg/fKARVzO11PcvM56uxoJ7si2zTqlXCsebG2qBQam4HDmh1AvC/YosneZa
         Vw7g/PE+uhn8KTpeWQPHM+ZnMi3fyjPuM1wCDHShUJOuXBVvhBO9ZnqfabuqYsOGcfvs
         daC4y0BhVew7F3eAhDqRyBpFAlW3zd8n37jaCY8Q1XYBgVUkIuLFR1HdB/Ik4DvH6gbd
         +blyP0mVJrP18VIIVfRoYP2sTwxLOqojhzpkL8udL3tPa6Z0Y/UVgllHbHZFxh7SwTsR
         M/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737220155; x=1737824955;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBzJX3Q/fcfCDTYZ+q6Yetl/p7poSDSwPoWKQfNelcU=;
        b=HQd7CTZOzq3Wy0N2mFzqNGwCOeu7xJnawoq4KWoKGWIi47Y8UF9Bx8jnMSEXhz8Psi
         RuG8iDupgVk3Pt4JgcrR1ogwCgc4D5uTVXcPj7GOWFTKyLMYFLY/ZEbHbKqhGDCanm2F
         DMu1VfTIvNiV0QugpoTh/iMfh28pvG5K/lOCVZLv/mMBIu7mUU6uzBuvbBf9ijqqzbuv
         zgXiKZ9Vl7picL4mT0andtKI8bUnR5uV6wV062zflfoQaeLHd50mfqL/trl6BOUW0Lck
         7TZ/wSzP5am/7WJFwroNprZBT90Oz9zLAtqhd/tqD/4kG5/xCamMWvqqyOg3NNRKEOJ8
         2xtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmlvTfrk6HzYXyZjCq/o2BRjOpjWNTd9k3/FqOU8rXwGa9FFfx8dFkmhbGWSLzRRrzXgHm0x5RX5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi9sB5/g+ler6DKMwIDZ7rjZWQn9cAwz69uNjQ6nIqV91M8mzb
	Q47pXdBYurs1DnqNcFYO09IrpumntzKmHna00rbJAuIfIspH5FDXKlRN7i3iMBY=
X-Gm-Gg: ASbGncsgGzqHJa4LohGZkOeuJbbodUjkq0ph7v9nZj9zLadKHVZiixZV417xmuGMc+o
	Yl+k1o1hkvrSb7ZAz0Vmd12sssNsPLDxAAdLdeXaAuY/1L3FVBPjX7zcbX0M6ZwafFLYMdWAXN7
	OppwnMs4MfypbMmjhI4mRUaxAiZNgJMa7R9YbVuy9EkZtueOZgBZi3BpywhLlpvexFiy49pJdIg
	LUgRaNAksvoXMgEorAVk4H1fSbIZerYaJxDbCeSPBMONzDWPoZY0+H2pHjndwQS/2axp0ORtpqZ
	hBtEbtsGL/EkuWr+BmLewE3miaYZPHA=
X-Google-Smtp-Source: AGHT+IGodFluwpk4HXpxuTQ4CaYwnD6yRgyO51ig2CiRhLaGAjJBxBcCjfP1Uw9hFIL9zJCC5XXkUA==
X-Received: by 2002:a05:6871:8112:b0:29e:69d9:8847 with SMTP id 586e51a60fabf-2b1c05b3854mr3348215fac.0.1737220155396;
        Sat, 18 Jan 2025 09:09:15 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b1b903c5f0sm1818089fac.49.2025.01.18.09.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 09:09:14 -0800 (PST)
Message-ID: <134bd7b9-f659-4010-9c78-48eee1dc901a@baylibre.com>
Date: Sat, 18 Jan 2025 11:09:12 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 8/8] iio: adc: ad4851: add ad485x driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
 <20250117130702.22588-9-antoniu.miclaus@analog.com>
 <d4b9d6e9-745c-4c35-a62d-18e0a36f30c4@baylibre.com>
 <20250118165751.334fe37b@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250118165751.334fe37b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/25 10:57 AM, Jonathan Cameron wrote:
> On Fri, 17 Jan 2025 15:45:35 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 1/17/25 7:07 AM, Antoniu Miclaus wrote:

...

>>> +		if (fwnode_property_present(child, "diff-channels")) {
>>> +			*channels = ad4851_chan_diff;
>>> +			channels->scan_index = index++;
>>> +			channels->channel = reg;
>>> +			channels->channel2 = reg;  
>>
>> Typically we don't set channel == channel2 for differential channels.
> So i guess this is tripping up on these being dedicated pairs labelled
> +IN1,-IN1 on the datasheet.  The binding documents those as matching
> the diff-channels - hence both channels and reg are the same.
> So maybe best bet is to enforce that in the driver by checking it is
> true.

Are you saying that in_voltage0-voltage0_raw in userspace is OK?

> 
> It is a slightly weird description but only alternative would be to
> invent some more channel numbers for the negative sides which is
> less than ideal.  We could go that way though.
> 
> Some comments alongside a sanity check is probably the best way to
> handle this and no surprise us in the future.
> 

