Return-Path: <linux-pwm+bounces-6344-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC533AD928C
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 18:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C073B4BAF
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C9220DD63;
	Fri, 13 Jun 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rwv58qo4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86101F4725
	for <linux-pwm@vger.kernel.org>; Fri, 13 Jun 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830611; cv=none; b=HMhfRC+roGmWp5O/ANlfYK2+vUshLswqaDJtO2dHhov/CjnbH1RyCCaswN3tveDrWQtaaY0SL/nWL/l94az8p+RP4uCPCWyUZA3RbpQI1HcR21pHQ6bzvajKyofUhtBQovb5M7LuhxJz/LL/dtGSEj1Bux8rO4aKsweCU9vvKas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830611; c=relaxed/simple;
	bh=gF8fryLDgUE7R04Y9/mL18frQKys+kanlKjViPMBr2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4aFh4NlE/kXkBrMrNcG+l4PgFxJPwxEiv32DY7dKd9pXsntUyTKE0WIfZdKRksns1DhCkhZqjY65gruFimlYVMNBZTMlACuzuJm0ia1trH5VP8312LtpCtFxkBUe3GocDSZmHfWmbAqNGyCNwNMd/4ewJDdq6+fRB+I+wbnLCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rwv58qo4; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-610db3f3f90so1129157eaf.2
        for <linux-pwm@vger.kernel.org>; Fri, 13 Jun 2025 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749830608; x=1750435408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3w4DwQ7UKG+tZltk5EBs0uLUOBu/ZiYws0KL7s9WN3A=;
        b=rwv58qo4n83JoPsWhczCiGTdjd7Yw91HumehZvkXWYVkebCdV3LCSp+SoJaDWT/t7A
         YTlfr/vV6eOBYsmqfak8xLZkm3Ue4FeogKx4z14+Ap01MH+96O1bNp2rq96K1gx17Qiy
         MsoXOHVfFkWcFem287dleU7p4Y0mHt5YZyK1ckgJNqiqUPCxVFIqQRdyokd2t6aS07kg
         iYfodVce04X8SCzARZV3XO7Ms7PqrNX3QY8j65TQOtAOYMyVkulqj1cMLFm+0DR+oqU/
         IRwLpacH45uN8GBdk/Y2XhKel6qhH3zx0CFhQkhcF+B4ajVjKQhMH/MqekO0X7JTZA72
         Pl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749830608; x=1750435408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3w4DwQ7UKG+tZltk5EBs0uLUOBu/ZiYws0KL7s9WN3A=;
        b=UAy90Z/F7aY0itE2XgE97tsbqHSjXF/YK8PYozSIXB0BS/ou7n0I66GyCn4abB6jSJ
         3tVW9Tgy1POi01EwFOriHZEOF9f7wgmR9TWbNOqL4sn4f2ppHxb7Fklcy7DpZwOo8wYc
         LA3RLGtxoVBFWVQej9yPkppotMtAJwZWAU+bm38OlTIVmjh3H2+XgIiBdqHgYbgD/I4K
         57pT0JS4Q6d/M5BGgVG0jHxHzCPDtLEWDpOKa/D7DPkLVXzwEGWxFcgyTC2abN6WLJyi
         uud5eBIQm4KNZsg9mogwh5mVDMLTuegyvmufI42dQF084egC7rKU2NTHfOzOEA35GiSc
         f3wg==
X-Forwarded-Encrypted: i=1; AJvYcCWJFu2MWLBQGZMlNhBEviXTB7hMAODaCZx1VwlvADkF/3LvdL8ev2bg6iKzVyp4eeXsfdNGDl5ju4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVXqbcwWwK0DjaY+u5GOIuZW4kd63Q3/i+nwGxX792AyevCVta
	5BYMmyvlq+csDwmGixMuvFyWjupqMmU06A6gtDI3nsBY/Qg5uzxseQSIg/L6jVOuS38=
X-Gm-Gg: ASbGnctdqiTvPt+o2GIVK8HD2r9vLaaMlSxpXOBRjUW6uaxCbtPZ6sKQsiwqLD+Qqj3
	8ieTEcgEw93tHkvdySOi+mHSh7QmXRFIkBYomjtO1HO7WErtMlNLMBL5nXXS84sPJf8d2c9MNEF
	Re28lcc1YNhBB6GVtF+AEfq6THKO9nB96KRWi6c5+67vpiQI6otNq27pXnXHg71DsEjOUXW5w8m
	0GzBcJG6kn7JQXkfGY+AMHs8h4Co+0Z0nQLoviAn3iF9MPIwCll2NeGLjOeml4irGGXGUgmhC5Q
	TcFa9dMtxlaM9zYKhykTdn6XFlQNF0s4OBNYI2RbVEGGEacTqpdVRYjp+lmslNgqiwoEdXkjY8L
	I1ElHSrXwJzpBjK58bAgBD9KYfznimlQAA6b/
X-Google-Smtp-Source: AGHT+IG1cpKE0bia+SjE3FQwyZTQRUfn6nnKjTjoQlx5gtEmca7DeH8NU/jmjN2PD3CGmwwp8AHo0Q==
X-Received: by 2002:a05:6820:221a:b0:60f:3ed8:3984 with SMTP id 006d021491bc7-61110efe2acmr49835eaf.3.1749830607445;
        Fri, 13 Jun 2025 09:03:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4647:c57:a73c:39d8? ([2600:8803:e7e4:1d00:4647:c57:a73c:39d8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61108f07e08sm214090eaf.27.2025.06.13.09.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 09:03:25 -0700 (PDT)
Message-ID: <fa403d19-13c5-4845-9364-58eea1b62e61@baylibre.com>
Date: Fri, 13 Jun 2025 11:03:24 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] iio: adc: Add events support to ad4052
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
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
 <20250610-iio-driver-ad4052-v3-8-cf1e44c516d4@analog.com>
 <afc85a4b-1535-406d-ad14-143049267b98@baylibre.com>
 <gvigk6helnl3yeouy636dgvay7tqux7lnxns3256fivzz4l3er@7ts7fz7vitff>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <gvigk6helnl3yeouy636dgvay7tqux7lnxns3256fivzz4l3er@7ts7fz7vitff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/25 5:02 AM, Jorge Marques wrote:
> Hi David,
> On Thu, Jun 12, 2025 at 02:38:45PM -0500, David Lechner wrote:
>> On 6/10/25 2:34 AM, Jorge Marques wrote:
>>> The AD4052 family supports autonomous monitoring readings for threshold
>>> crossings. Add support for catching the GPIO interrupt and expose as an IIO
>>> event. The device allows to set either, rising and falling directions. Only
>>> either threshold crossing is implemented.
>>>
>>> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
>>> ---
>>
>> ...
>>
>>> +
>>> +static ssize_t ad4052_events_frequency_store(struct device *dev,
>>> +					     struct device_attribute *attr,
>>> +					     const char *buf,
>>> +					     size_t len)
>>> +{
>>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> +	struct ad4052_state *st = iio_priv(indio_dev);
>>> +	int ret;
>>> +
>>> +	if (!iio_device_claim_direct(indio_dev))
>>> +		return -EBUSY;
>>> +	if (st->wait_event) {
>>> +		ret = -EBUSY;
>>> +		goto out_release;
>>> +	}
>>
>> I'm wondering if we should instead have some kind of iio_device_claim_monitor_mode()
>> so that we don't have to implement this manually everywhere. If monitor mode was
>> claimed, then iio_device_claim_direct() and iio_device_claim_buffer_mode() would
>> both return -EBUSY. If buffer mode was claimed, iio_device_claim_monitor_mode()
>> would fail. If direct mode was claimed, iio_device_claim_monitor_mode() would wait.
>>
> I don't think this would scale with other vendors and devices, it is a

Why not? I've seen lots of devices that have some sort of monitor mode
where they are internally continuously comparing measurements to something
and only signal an interrupt when some condition is met.

> limitation of ADI:ADC:SPI requiring to enter configuration mode to read

I don't see how it could be a limitiation exclusive to this combination of
vendor, sensor type and bus type.

> registers. A deep dive into the other drivers that use IIO Events is
> needed.
>>> +

...

>>> +
>>> +static int ad4052_monitor_mode_disable(struct ad4052_state *st)
>>> +{
>>> +	int ret;
>>> +
>>> +	pm_runtime_mark_last_busy(&st->spi->dev);
>>> +	pm_runtime_put_autosuspend(&st->spi->dev);
>>> +
>>> +	ret = ad4052_exit_command(st);
>>> +	if (ret)
>>> +		return ret;
>>> +	return regmap_write(st->regmap, AD4052_REG_DEVICE_STATUS,
>>> +			    AD4052_REG_DEVICE_STATUS_MAX_FLAG |
>>> +			    AD4052_REG_DEVICE_STATUS_MIN_FLAG);
>>> +}
>>> +
>>
>> It seems like we need to make sure monitor mode is disabled when the
>> driver is removed. Otherwise we could end up with unbalanced calls to
>> the pm_runtime stuff and leave the chip running.
>>
>>
> When monitor mode is enabled, pm is already disabled (won't enter low
> power). I expect the pm to handle the clean-up properly since devm is
> used.
> The .remove() I suggest is reg access to:
> 
> * Put in configuration mode, if not.
> * Put on low power mode, if not.
> 
I was just thinking something like:

	if (st->wait_event)
		ad4052_monitor_mode_disable(st);

Also might need to use devm_add_action_or_reset() instead of .remove
to get correct ordering.

