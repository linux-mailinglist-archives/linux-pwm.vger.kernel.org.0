Return-Path: <linux-pwm+bounces-6218-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B507ACB8D0
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 17:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309EC1894866
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 15:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BB7219E8C;
	Mon,  2 Jun 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jymCDRw8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A491A2547
	for <linux-pwm@vger.kernel.org>; Mon,  2 Jun 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878432; cv=none; b=otztWys3dfizb53rSlWSHqxRXyWMwy+8RPQaDRN1sJs0OdLtY98yL3ba+OtsoZleI0+GYQi/CBD4AuKEzl7k48hc+tAFx3bwSvZOgYMS6EQwasTjj8aiLG2wxiJCzBhzHt61tHT68yP6XCqabTtHAyse5+hb7ABWYWP8fJ18jlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878432; c=relaxed/simple;
	bh=8tOtsQM+x4oiZCMtV4+BcU+eJaqF5wDJFxyrlOBUziE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8480axM+lcNw/HM0jswP9KzUWqDp/joRks6KMiCJ2BWakpsRdz49nPsfUo5oYR9S8Ri+5tH/4MzY10M3MdA8R6MIoEO0ArSLi+tiD5zm/ITZWGMS2Tt8YfxwWQ82ogfJWE1XRhoBRHLFAvNsVBm/s5flwm+qDtxo3uAznTUI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jymCDRw8; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a3db0666f2so96242581cf.1
        for <linux-pwm@vger.kernel.org>; Mon, 02 Jun 2025 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748878430; x=1749483230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNfa+WaZFsZmSiE6Z+4+/C3YChzz471UVxFf3Euk8Ps=;
        b=jymCDRw8K7sjpTSSwhlXygPKhHkqYCPdilde28Pp5ZeBHnQnIkdHaCOJAy8yjnTHU9
         XUKIpmrBC6uXWnpOFA7Q0kNvIfBJMAIOVXZT5dkKyNRCqi1Pape5ZZp+/KcrPayyCkJM
         YTT7cS67IOxJj/uZMsb9KsIRQgEVLOpuNJjw4x/VvBeCfKcUqcVKuHknIfg7k59VpiYa
         YKv9HG0amompCXmQpmOoozSNN1eDCA7svtyVjXNu4uVelWjboJgNrFWmXt4Fj4PK+QMl
         orKjbDSSOKd4I/qxX91HAVmJ3FKkonhmkd12oaL/GawekTOJ1Bz6ots6vQXKGmuUtOOQ
         hTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748878430; x=1749483230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNfa+WaZFsZmSiE6Z+4+/C3YChzz471UVxFf3Euk8Ps=;
        b=Z5cxDQ6UlC95FZ9ctFDegqVqK9GcB3IqNK+CL1G+eCfL4X6ryWqEdMTeNNktTME6c+
         bjoQBLyiOfWgTpJWju8TMjL//7vjDL1pBoimnmOJ9Y59WVbMmKQtpXx3Lzy5VfLEbYNB
         t14m14RnhmAiW9Rdd4Ab/vkCG8VHfwMbgKMcJPYZ8f0C1ba2RilWygdOIoCTvrsueKLt
         99znAbcY6iwUG5bJY6aeuHlfU391q+6enAT/gXpMl52uKg3tzmUma08ChjfremwVTh0b
         tEVapI9gpRbhNICOxn5mRGmv/HTuw4b2gbydvNjz7nXURg4k83b9T24leuaeDjBor+Yo
         n8jw==
X-Forwarded-Encrypted: i=1; AJvYcCX8sxmFp9gIFlHL9Jb7IRGyocP6oGpKCA+omSQ8q69mbmGbFCHyrmldHSw0RjbJR5o1uLXrfZtwvIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDrpwgYEv8GvQQeoSHZEg6I2QaVVbtYpgmbVdLhB8wIRnyXTXj
	jpvmjczw620hUZuuPfL+Ge8jUqQRZLOWXSCuL+SJtr7jHv6+8HlHqv68bC8SX/OytO6hIv0SfCM
	Guawo
X-Gm-Gg: ASbGnctZR5DsfM1gQ5bAH45M91VjDnijsKRGEbYLlneB4uy5Jl21x9hQZewemT91Rb2
	leqvv9ZqM6CQweo0OLUtiTVoRS1nAP09BgZDi8TAFrSs3VaUGjJbCNT/AbW6rYbm6B526xIUTlb
	4AoDBMqGBEjXClotJtIBfHEmgRSFPVNGcnzqv55ZPE9Xf5leOPTi9Uan5R5p55hXcmf5J8CRiCL
	rvQBnH2g7drmcVlYTYTMOZxizI3y9fhntepn3Sn+M/x1aSBr4JSyXorIU9fFJSvIDyAoo0s7oce
	Cb/0ClmllMKz4PqzGc0xFvsfxlwr2WKRrZ8kYzdyZMXjt37G04LnDoLYavogEHEX0FZUzkB+Ysm
	4uNCVgZ8iC0JyOo29cD1+5mPOBJxf5wb6mg5ZPlU=
X-Google-Smtp-Source: AGHT+IF57uQxHGgOlzBwzxJo2Ni/WLdwC/o2d4xhErwQ5I03YvinhZUc+GTLgNq4seyU6RFMT+NPuQ==
X-Received: by 2002:a4a:ee08:0:b0:60d:63fe:2472 with SMTP id 006d021491bc7-60d63fe2755mr6583332eaf.1.1748878418793;
        Mon, 02 Jun 2025 08:33:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf? ([2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60c1ebb00f9sm1488625eaf.40.2025.06.02.08.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 08:33:37 -0700 (PDT)
Message-ID: <008ea5d1-52f1-44dc-8576-d8bdd5c5beda@baylibre.com>
Date: Mon, 2 Jun 2025 10:33:36 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iio: adc: add support for ad4052
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>
 <c82b8c53-e653-4cd3-80ef-37c5daf9314c@baylibre.com>
 <zofjbh4yvtz4sfj2t6cpdohqqlrgwqdqtiahpvalbbfv2tdqqi@g5zpdp3zn4gb>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <zofjbh4yvtz4sfj2t6cpdohqqlrgwqdqtiahpvalbbfv2tdqqi@g5zpdp3zn4gb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/25 6:16 AM, Jorge Marques wrote:
> Hi David,
> 
> On Fri, Apr 25, 2025 at 06:13:48PM -0500, David Lechner wrote:
>> On 4/22/25 6:34 AM, Jorge Marques wrote:

...

>>> +static int ad4052_probe(struct spi_device *spi)
>>> +{
>>> +	const struct ad4052_chip_info *chip;
>>> +	struct device *dev = &spi->dev;
>>> +	struct iio_dev *indio_dev;
>>> +	struct ad4052_state *st;
>>> +	int ret = 0;
>>> +
>>> +	chip = spi_get_device_match_data(spi);
>>> +	if (!chip)
>>> +		return dev_err_probe(dev, -ENODEV,
>>> +				     "Could not find chip info data\n");
>>> +
>>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>>> +	if (!indio_dev)
>>> +		return -ENOMEM;
>>> +
>>> +	st = iio_priv(indio_dev);
>>> +	st->spi = spi;
>>> +	spi_set_drvdata(spi, st);
>>> +	init_completion(&st->completion);
>>> +
>>> +	st->regmap = devm_regmap_init_spi(spi, &ad4052_regmap_config);
>>> +	if (IS_ERR(st->regmap))
>>> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
>>> +				     "Failed to initialize regmap\n");
>>> +
>>> +	st->mode = AD4052_SAMPLE_MODE;
>>> +	st->wait_event = false;
>>> +	st->chip = chip;
>>> +	st->grade = chip->prod_id <= 0x75 ? AD4052_2MSPS : AD4052_500KSPS;
>>> +	st->oversampling_frequency = AD4052_FS_OFFSET(st->grade);
>>> +	st->events_frequency = AD4052_FS_OFFSET(st->grade);
>>
>> Somewhere around here, we should be turning on the power supplies. Also, it
>> looks like we need some special handling to get the reference voltage. If there
>> is a supply connected to REF, use that, if not, use VDD which requires writing
>> to a register to let the chip know.
>>
> Yes, v3 will add regulators.
> Vref can be sourced from either REF (default) or VDD.
> So the idea is, if REF node not provided, set VDD as REF?
> 
Yes, you can do this with devm_regulator_get_enable_read_voltage() if it
returns -ENODEV, for the REF supply, then call it again on the VDD supply.

