Return-Path: <linux-pwm+bounces-4555-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0749A062FE
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2025 18:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B909167547
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2025 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0981FFC70;
	Wed,  8 Jan 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WsJnBZQF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543151FFC52
	for <linux-pwm@vger.kernel.org>; Wed,  8 Jan 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355975; cv=none; b=SI2ShwJoWpxotnfbAPDyhTFb59IDEoXe9lsOHopVIocT7mbRFawc6OvBcV60cqzhp6LlzUT/R9vZ9iVg3nwz7wTctLRjHkGus1F+X8mQ18lgo/VPQUW180tSpV4KJD9l8C5RImIUbxFp6m5V/uQ2PeqgYkm4ZxjKm1GFMm7WPdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355975; c=relaxed/simple;
	bh=jCamsfLpcBDv0KT7qF02it6Id78FDWwVeoi+mD41IZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um5BdAZWvln9W8XluO2/PEYCss3t39fDmW6jq6y/mye3rME/+BB6z3Ntbwcy680FKgv6a1TEsJpOcjUTrBqCroRgq3a3AuhxhbZct3RreOzlKd4Bv3I19WmgqN2K6f+1YoHLhXlvbwWj1fhFkabZcTKKE5FikNky+ZWQpzW8b2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WsJnBZQF; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb6b16f1a0so4881394b6e.3
        for <linux-pwm@vger.kernel.org>; Wed, 08 Jan 2025 09:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736355972; x=1736960772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/b4Xzx1xkuwA/wx5BhKWtA/mjZMQ0mArLR9j53cJLo=;
        b=WsJnBZQFZnH1CSsoN9fIHXN5k800U4yja6SiLWiBRwNgBxjwMCzcYinOUwsyMxE0fr
         lElSqVqS2KOC35bk8BJJrhi9DnFlBOkTkeS/p192FqfJHFoUEglhpXs2amTo+mW4V7g1
         r/dK89OLsP4oQAElb554Z23uNObr/VrzEzH7wibOWGlxRSHgfnCD9eHAig1eNkB6lIhk
         kVJSDvGgGYQDd6TMS5G6vQkaI01p3quOqigX7hwh75/H+TkBlFwHUBo8MOo7dmmzb/aa
         J+PpYlzIDbFv0L8H8iWZKFrqm1P8z/WwsnU0MDE6f1RwIDRJzpZhnAzLJtJ1D3m3kx+j
         SkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736355972; x=1736960772;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/b4Xzx1xkuwA/wx5BhKWtA/mjZMQ0mArLR9j53cJLo=;
        b=jdjZJYEeJeHg/n2heQtGH/323v0Hma8FqjK/2osLjK+heTnLqerEzRCWtb18nr/sM7
         C4Rzhh0zTQRHWW1pwKhlAGYasPfGaEFMN16OrqlHfD6vhxSYA+VZx/4fuvSIYDiqOVyf
         UT5410HSg8dQq3m6fuZPnyI1QPqAmb2KXaV87PdtuLDv1zHQIDvRh739yARHBnL+gjpA
         Wo6Y/0D8lOv4DMLc73Png+Q8NRO/RqY1hWQuFvtWoWSf0DTifbdG2GV2ACU0VjFBeSaT
         e+wp9yuUo3keweIhE2Isajr1QYKI0gN2rXCrFFGTZEV0b1yXEf5wNQI/6RoeT6x+nu5K
         lIrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8+OlZAgZDaA4TktLsb4vXpSJHTttF/Lcnc/5NI76JCk9ZW6DO2Bm4IxSu2ciPF1qURvvRkmnwlbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7LM0+GJ775gzLNwsX6+Gcx52aQ1YFMUvyrqgvZeRrZYGYeApl
	8W72TPOUhlO2+JWavQa7XnUfEisUb3gk540cYPQZ8u1D5TJLWyI52U/rAtmwqcceUu+oT7KONQo
	w
X-Gm-Gg: ASbGncufQQcB41GNIyMlWBEttV8Cf4SwzhoInv6FBNLdZvCpOs5Hxt2ld4hWD6jwxbt
	Lmb5URBG4YsmBUjJfyugltmg7RgrGqiEWk+MWRhVYUNMOB+b8TF8dthqEio5k/9Oo/D/fynfbL/
	/OZp1p5J6uq5a6uhKMfIRwVaNFMLKOg7kh0AXZBy4Rf8PbGnjmE7yp+6GZ0Zx9em5faUhrd35jK
	+pTF2VNNVbrREYErkS0mCTZ1AH1pxu1Sb5lWGF38ocNhL/9/KGn7UZYgE4XLRRbt7Qrdoq2Kr7V
	lQxgboASZmVi739fWQ==
X-Google-Smtp-Source: AGHT+IEWotvyiUKl/k0KXLMw0knOeNaJYVLSpncNojbcFb3g/TMcabu1SuBV0WZUGqsskizMdV4GPA==
X-Received: by 2002:a05:6808:913:b0:3eb:5d13:f688 with SMTP id 5614622812f47-3ef2edd34d7mr1881257b6e.26.1736355972541;
        Wed, 08 Jan 2025 09:06:12 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece244e86asm11434861b6e.5.2025.01.08.09.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 09:06:11 -0800 (PST)
Message-ID: <b650f023-19f6-4f84-ae07-4383376268e6@baylibre.com>
Date: Wed, 8 Jan 2025 11:06:09 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 8/8] iio: adc: ad4851: add ad485x driver
To: Jonathan Cameron <jic23@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241220120134.42760-1-antoniu.miclaus@analog.com>
 <20241220120134.42760-8-antoniu.miclaus@analog.com>
 <20241223120005.1bc9a208@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20241223120005.1bc9a208@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/24 6:00 AM, Jonathan Cameron wrote:
> On Fri, 20 Dec 2024 14:01:34 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 

...

>> +	ret = devm_regulator_get_enable_optional(dev, "vddh");
>> +	if (ret < 0 && ret != -ENODEV)
>> +		return dev_err_probe(dev, ret, "failed to enable vddh voltage\n");
>> +
>> +	ret = devm_regulator_get_enable_optional(dev, "vddl");
>> +	if (ret < 0 && ret != -ENODEV)
>> +		return dev_err_probe(dev, ret, "failed to enable vddl voltage\n");
>> +
>> +	ret = devm_regulator_get_enable_optional(dev, "vrefbuf");
>> +	if (ret < 0 && ret != -ENODEV)
>> +		return dev_err_probe(dev, ret, "failed to enable vrefbuf voltage\n");
>> +
>> +	if (ret > 0)
> 
> I'm fairly sure that call never returns a positive.  Will return 0 for success so I think this
> should be if (ret == 0)

Even better, make it 1 line instead of 4 and use the specific error code we are
checking for:

		st->vrefbuf_en = ret != -ENODEV;
> 
>> +		st->vrefbuf_en = true;
>> +	else
>> +		st->vrefbuf_en = false;
>> +
>> +	ret = devm_regulator_get_enable_optional(dev, "vrefio");
>> +	if (ret < 0 && ret != -ENODEV)
>> +		return dev_err_probe(dev, ret, "failed to enable vrefio voltage\n");
>> +
>> +	if (ret > 0)
> 
> Same here.
  ^
> 
>> +		st->vrefio_en = true;
>> +	else
>> +		st->vrefio_en = false;
>> +
> ...
> 
>> +}
> 


