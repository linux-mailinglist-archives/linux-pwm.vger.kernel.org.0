Return-Path: <linux-pwm+bounces-4069-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14629C4397
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 18:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F6E280DF0
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 17:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B32B8F77;
	Mon, 11 Nov 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nv3BNhJ0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC71BF58
	for <linux-pwm@vger.kernel.org>; Mon, 11 Nov 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346284; cv=none; b=fl+4RzmOUcDFpBFfQAG3EjPYuPB5+J4HHqY2wvLJzceCnm1rII0ynwpA1PXKmJyiSyjRkf+AalcDjhEUCsRIGPhOvkgtsoHPuhScMMsurIObwXY7K65RlfYX71PY5r78fE8RZYLXR5LRia2QkLI/2o6yDyPXwgGlJ9tUy07cPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346284; c=relaxed/simple;
	bh=no6utlaUo8IqI95oo1SieP0lTqSLpd42ACLhWsFiniQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJwpvZYZDzgUnHPcOgGeuFFlDSEFRWhjefnqMj0IHBjvDyR60J82a6CH3yIPioJPgEsCagdXJI6lFw3VuvFkTjxXQBAWbUpf0y1XMAWDV14DoqzeG+uMeo6OUMUck/UQgVXVXLU/ZR9kOPtjui7mcJRnoe14DlrMyGYmatHl7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nv3BNhJ0; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-718123ec383so2720081a34.3
        for <linux-pwm@vger.kernel.org>; Mon, 11 Nov 2024 09:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731346281; x=1731951081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuSsWHn2ff5l9owETtFoLNN0jA+fFMGgVGlBbiasasg=;
        b=nv3BNhJ06f793JxCO1SPcproX2X3UwxFYjcjQQcs3lqO4p1KYBD9bMjgxKj2kct4fI
         zmlCJSXUkhsWcBhe9K5z0Oef0g7SzggAbkzmUSqctI3hiSibkPd2MddiCoQANUin9IYd
         nTiye998G4X5ibPC+mBKB4+Mw/7pDr3RHkR1EeHryExLsAH0LjoWGcVEGrrIcoCvoRMh
         ZFRzoKW8cT8bv6jA3HTZBbaY1QpQpwEK9AOgOQlHJ131hpu5AVJeQYMgBS2OgxpKv/tM
         8OsuUzMM3wn6YrsTWq2qhOvVwiM5PXkXGiVY/ptMcxlQUeoN76bCF0/KDn/vjSxSRnhm
         5arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346281; x=1731951081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuSsWHn2ff5l9owETtFoLNN0jA+fFMGgVGlBbiasasg=;
        b=AGv+xnZBc7vQZ+b8RChgsp0sy1bMHYePqk8asdBzbI52HNeuJpcaOpRIba0deBxvY+
         4y67f8Xhs+QOhAaoKS5l9VpshFTsi7LUWruJXjxJRs7IVaAm4/NuMaUWdPFd9P9VBw9a
         54/pyG9Lu1017mfz2IfHF3XHHGc7sPCuoyzG0YctMXpevoE22cPoknxVBB88mOzGvH1B
         22ZvUCUyHGZIPlCorUx07WCGhdQ86X3P6plue2RYm/qx+uJ1ditGm3y98DOYc4nHdZsC
         BPQrgYnDvWUZDmuS1tYad0Mh+6IRsOlbNbV90CvXXGtQw0874Kx0l+1p4UXFvZ0ie3cS
         vWrw==
X-Forwarded-Encrypted: i=1; AJvYcCV/iJPqoxn6PK+5YJO9imcOMUrZoAjmjk/umc0E8o47A9FtnPINGVX1T3UzpVm0ROUX/qVIppRJEfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1WhIFpIWpD+WG1sxQiCtnR0KN0lD994J0wFa+gg9mSNqyUFGr
	NDHI6ZI9yhGjDU0Sm/8BI/CAXKz5AZxEBfSadFR8259ZmumfkqKW9gUzhnV4WMk=
X-Google-Smtp-Source: AGHT+IGRdrBzCWSSfPAcX4Vxj99n1yVXL/woQZRbbmn5mQvuBjtOMPeyNbb23XZ5dnczUrH/J0S9wg==
X-Received: by 2002:a05:6830:2aa0:b0:710:f74c:1b2d with SMTP id 46e09a7af769-71a1c1c9613mr12811226a34.2.1731346281359;
        Mon, 11 Nov 2024 09:31:21 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a108e3235sm2283754a34.53.2024.11.11.09.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:31:20 -0800 (PST)
Message-ID: <1f176b63-5904-49bf-9b63-6db440493773@baylibre.com>
Date: Mon, 11 Nov 2024 11:31:20 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 05/15] spi: dt-bindings: add PWM SPI offload
 trigger
To: Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-5-f8125b99f5a1@baylibre.com>
 <20241026161837.30a56ae1@jic23-huawei>
 <20241031-croon-boss-3b30ff9e9333@spud>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241031-croon-boss-3b30ff9e9333@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 1:16 PM, Conor Dooley wrote:
> On Sat, Oct 26, 2024 at 04:18:37PM +0100, Jonathan Cameron wrote:
>> On Wed, 23 Oct 2024 15:59:12 -0500
>> David Lechner <dlechner@baylibre.com> wrote:
>>
>>> Add a new binding for using a PWM signal as a trigger for SPI offloads.
>>
>> I don't have a better suggestion for this, but it does smell rather like
>> other bridge binding (iio-hwmon for example) where we have had push back on
>> representing something that doesn't really exist but is just a way to
>> tie two bits of hardware together. Those kind of exist because we snuck
>> them in a long time back when no one was paying attention.
> 
> I dunno. iio-hwmon to me is a particularly strange one, because it is
> the exact same device being used in different subsystems. Like that
> voltage monitoring device with 10000 compatibles that I CCed you and
> Peter on the other day feels like it should really in your subsytem. A
> "hwmon" isn't a class of device at all.
> 
> This however, I think is more like pwm-clock (or clk-pwm, they both
> exist and are opposites) where the node is used to change the type of
> device rather than the subsystem using it.

Yes, this is the key reason for the binding. When I was looking at
the trigger bindings in the leds subsystem, I came to the realization
that we need some way to get the underlying type of the trigger. In the
leds bindings, I don't think this was intentional, but effectively this
is done with the linux,default-trigger property.

So unless there is a reason why copying the clk-pwm/pwm-clock style
bindings is not a good idea, that seems the preferable way to do it
to me and I'll stick with that.

> 
>> So this one may need more explanation and justification and I'd definitely
>> like some DT maintainer review on this at a fairly early stage!
> 
> Ye, /shrug. Maybe the others have dissenting opinions. I'd like to hear
> from them, but I don't personally have a problem with this.



