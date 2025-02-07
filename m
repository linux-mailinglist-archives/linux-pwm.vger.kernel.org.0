Return-Path: <linux-pwm+bounces-4824-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12997A2CE71
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 21:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD353A4239
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 20:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393FC1AB6D8;
	Fri,  7 Feb 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HHF9C7Tv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F31A5BA0
	for <linux-pwm@vger.kernel.org>; Fri,  7 Feb 2025 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961505; cv=none; b=BQ/ZOipWI9XNpEpcoN86Kk7l/chv1unhOsdDix8sTj6+A5OpdzN7lBdSUaznbXDfc7jZyphhZf4Gdwrr+GVorJvD4ipH/veC1dPqOJ8RYBMZxRtI07yEZBLHwXvKRMCZp5mS+gUGR1X8juqAtmZfNbdsypdHhCwBNLJqiu50I68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961505; c=relaxed/simple;
	bh=j0K3veYgNs9ITuGH6rfEbzVZGYKqSl9G/AaRQDM6RO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BcDl43PYcrAh4ji6yjrkwT7RsLZ90xNAR2ZhSR79ZyT/z19XaxT3lU4OV+lRQTV3sRiVWjZBKqzClElgenCGlPqpMbzglpPtMJ9+X0Uob81M6zM++iEjhEwFWR9sPf73moK93Sjb+osfKfXx0MaZY1meSr41r8w2lrjBCIt+lIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HHF9C7Tv; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e1e051e50so669921a34.0
        for <linux-pwm@vger.kernel.org>; Fri, 07 Feb 2025 12:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738961502; x=1739566302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQGQcdGFinvFOpfGuSYGng0xGWMSfOVhvommmb2mfPo=;
        b=HHF9C7TvC5v3O5qwMl077YKeKLExv/7juTO/sfK/IO9KN6nXmt935uSSPkBheIBR0a
         xGQv9RnuYT509ER2xjN4t5gmuGU0dNEebvg6BB4H0SuP4nRo1Rl8OUYHopu4TbiPH8rk
         2tXRGmIKGMu95eCN7gX+XJ9LMoHr0x2Fc/WCdAx348jQifRZz8GRkKE1re0iUyoS7tJ/
         WrzIhMCoW17SIGvj1g/0n5Zf0aZzpAdCRIIE+5TFVrFdFN32kXobFFbf2Djb/dYHapHn
         A6YMgBSRnmz7S0yFO7ZMeuQir1XEGSm1iyruTzkyUSkV98Lit1494ANl2exYhiNK8dYQ
         lzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738961502; x=1739566302;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQGQcdGFinvFOpfGuSYGng0xGWMSfOVhvommmb2mfPo=;
        b=eOdD0v+s11D6slrWOIh8EG5sEnLjpIVQrbPyJCc6u7NtZRzDa0qNAzpncPUtaYnwFS
         M5YVejgFiXDb953cOrjcYZ5qzunkXLMJUa7xHw8WrZzCP23kbHKKBlyp1Yi8+hHnSeJ8
         bIAr/9PhV6tjKj+oiKc8PP00BI2d1JElPSRvLSjgjgCMlQ8xIZYCmkrSBmxED5vBQ4wg
         CgjCKLFMYmayYwysEuefb8YL215gxJCIsRsUSq9YQUmi7MlSWuT+R+22zGBl7yWHZJV0
         kfUEY6WUF3NTHNMhCZ28rZWNZEwIWyV0f5S2AHwuTh1zclEyPueRpGlOALk4FaiRtEit
         nI+g==
X-Forwarded-Encrypted: i=1; AJvYcCWVWvhx8Cl7h7SgodamELAGr0zb6OrY9YVXc4vdeyDSLy2vSwJIAuUll8OZQHdoovh+qwpSAnliCR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSzzQauoqHSVcTPCfDaXl7X0wNDjr360+SPpl1M3vFY5hx72+q
	cWSXUV0N4zZao9fNL89iMDO7wuzLyedIHIgW3sy81Y35jwH3QpsGSI7ovOpygXc=
X-Gm-Gg: ASbGncviXr+sIFfoByyAuiH206GfCa/DbFVXjcIDKn0vq0diiCDnC37ZDnjR/KmRXc5
	+4FWIrsTRELJ3qmH/eYG+rcdAIU/9Cu2WhiPnPikzHXW64frgCJ7PgtlYyzCWFtOO69VUAJbFwv
	pYVDoqDCBtZnLhmy55+DDFJsDppPPWzhJvNzIiYiVYojnHCExy8XUOVO/SDA5DvjoKlYNpWbsH7
	RIzWwr/G0KbvYQdpDFRT0yfEgH/Fxgtsj28sRDxYhc75fObLFyvmRo4tfg+uDPqT/QFnQY5SJIT
	b9G0XdYB5bqZhci3PiZKijJ/hV7CXCqP2o/R/7VhF8o7mS7D4381
X-Google-Smtp-Source: AGHT+IG7PscmiUU5iaoZJFTzcARWpAGODDHZRUMCO99df9PiCQJBs76r9w1AoVJ5tFHypQESPlOSMA==
X-Received: by 2002:a05:6830:438a:b0:71d:f343:5f5b with SMTP id 46e09a7af769-726b8829061mr3412971a34.12.1738961501979;
        Fri, 07 Feb 2025 12:51:41 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726afa4d2b7sm1006099a34.63.2025.02.07.12.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 12:51:41 -0800 (PST)
Message-ID: <dd263ac6-1843-493c-90ea-d303eae561e5@baylibre.com>
Date: Fri, 7 Feb 2025 14:51:40 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 9/9] iio: adc: ad4851: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20250207140918.7814-1-antoniu.miclaus@analog.com>
 <20250207140918.7814-10-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250207140918.7814-10-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 8:09 AM, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +static int ad4851_parse_channels_common(struct iio_dev *indio_dev,
> +					struct iio_chan_spec **chans,
> +					const struct iio_chan_spec ad4851_chan)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *channels, *chan_start;
> +	unsigned int num_channels, reg;
> +	unsigned int index = 0;
> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (num_channels > AD4851_MAX_CH_NR)
> +		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n",
> +				     num_channels);
> +
> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	chan_start = channels;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing channel number\n");
> +		if (reg >= AD4851_MAX_CH_NR)
> +			return dev_err_probe(dev, ret,

ret will be == 0 here, so need to replace with -EINVAL.

> +					     "Invalid channel number\n");

