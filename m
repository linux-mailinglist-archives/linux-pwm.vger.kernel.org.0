Return-Path: <linux-pwm+bounces-4045-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846449C0B17
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Nov 2024 17:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D15C1C2336B
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Nov 2024 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31698216459;
	Thu,  7 Nov 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eeItI3X2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3700216201
	for <linux-pwm@vger.kernel.org>; Thu,  7 Nov 2024 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996020; cv=none; b=hkd91Q3PJugT/1sKhgTIy/fikQusi0G7Y+054TQi5Hbnu/Qm+RgMlspdX1l5uM9tGsYP3dma1lhGB3betZgUXpkOn5F+rl/hmNGGR+j/HDMMdExR4n8+PFw/bcynbCnCA3wywdNcChVZU9APpEEXzCpaUmUSVjNssnR4eqcI+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996020; c=relaxed/simple;
	bh=fZtlm0N810hvKG9POajy9/CaNR0d3dDfZY8f70Q54QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HgrWToSPPNEk3jE8sGFOoGa1sC6LElTU5mADFEXqeCMwTuKdM5rhVDbkFRRxKVj48mvU2c2gboBaJH37JWYtaNa+qY8dbx/1Lm27gLT/5varbe0rb/5liAIFkR1hhvYsF0ACzy7jIPrfJEKsu0YQM9MCOjUzDXv5h1hkSkXvafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eeItI3X2; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2891055c448so596751fac.0
        for <linux-pwm@vger.kernel.org>; Thu, 07 Nov 2024 08:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730996017; x=1731600817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evTfMuO8wFTUeT/j8A+HLrTii7N17uHiCOM6i73+FmY=;
        b=eeItI3X2PGxsruNFJRa8QrVp6v6LCRq30xmCmzf9fmhSyhIckECq5YptbNiwGY5z6J
         PES/PRDzjDOned8qSFklc4GMkv15K2QWqKcGOR4Ysc8lowNqsb/1lLKTN72zAVCp1fsU
         cGZvlm6UdDntdrKLhWQ1RIKHTV1U+XoLXDfZ0doGm4uHi5Eb/Xlp7Fl3yv7o1EOeKJQK
         a6C2DdTQEqLZtprNNBvZJoMhFs/MlBf5jsb6wdjWao0L3VoIhqNovXOfnr/fmq1DWjEl
         2S0fd1SgsCAX8g4TwPgGQCgWjvXbwPByiWHPMQT5hIJnicQWqYu7SrxCypUH3FXIcSVi
         c7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996017; x=1731600817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evTfMuO8wFTUeT/j8A+HLrTii7N17uHiCOM6i73+FmY=;
        b=Ud+soBqZ0X6dp+YNSTHM67TXQ3tUVp+Bjme55u0MjqNLWJuQSInwceu9CLIXTlUJ3e
         BgdGB1KfnrudspAWlwrvHnFvEFga2t/P+d55zJLbQUX61DKJWjq0ztOAR7ddhBaYYH52
         GSf6pUsMaS08vrYU4FmQBt2XrGoLwpPRirH/HkBh0sR1TGafwtvRYYJq4uNnzUN2Bip9
         mfB6nurhlfM0Vrin8eLuCVKQcBsZHNnegvWQ1G39dgznpJOpTi5ypzAaTwRFe181NcBm
         HEwt7b5unC0rC4YGL6gaTCUTBqviEXTCqJLPsaYSTR75Yrl09IdebrERuFNXKwRO7OY1
         Z/qg==
X-Forwarded-Encrypted: i=1; AJvYcCVgNIZW6nfxm24/Xg7NZCInBuNTQv5nf83L8Khu2hAWDkkCqRvqB5JoEljimFDZWV+PpZTB7qf5kVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEHO5X/wiLhg5PBeCdYLXRnKU7WhSSxJ+zqmNAMxAF5BwQ6AAi
	H6nhKrw+wF9liFSXAaWdpWYDVmQvt836cfjSP4NuSK500xuxJ9fDUquy416Axos=
X-Google-Smtp-Source: AGHT+IEST/nlAEK8PXt9lv0scc/mxN6rLDixAgAczzs8cEbzgjkkRhrZiroyqyVBE0xMREgTqRxK4g==
X-Received: by 2002:a05:6870:a905:b0:277:e039:7aef with SMTP id 586e51a60fabf-2949ed306cdmr23875108fac.8.1730996016905;
        Thu, 07 Nov 2024 08:13:36 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a108374casm315010a34.40.2024.11.07.08.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 08:13:35 -0800 (PST)
Message-ID: <1f2b8d91-19be-46b7-9202-824aa177dff6@baylibre.com>
Date: Thu, 7 Nov 2024 10:13:34 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] iio: adc: ad4851: add ad485x driver
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 "jic23@kernel.org" <jic23@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
 <20241101112358.22996-7-antoniu.miclaus@analog.com>
 <de120709-b60b-4e85-912e-b60ca18a8001@baylibre.com>
 <CY4PR03MB339993CDE9BA8DD3976CF2F29B5C2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CY4PR03MB339993CDE9BA8DD3976CF2F29B5C2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/24 4:51 AM, Miclaus, Antoniu wrote:
>>> +	if (osr == 1) {
>>> +		ret = regmap_update_bits(st->regmap, AD4851_REG_PACKET,
>>> +					 AD4851_PACKET_FORMAT_MASK,
>> 0);
>>
>> regmap_clear_bits()
>>
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		st->resolution_boost_enabled = false;
>>> +	} else {
>>> +		ret = regmap_update_bits(st->regmap, AD4851_REG_PACKET,
>>> +					 AD4851_PACKET_FORMAT_MASK,
>> 1);
>>
>> regmap_set_bits()
> Packet format is 2 bits wide. Not sure how can I write 1 if I use regmap set_bits
> Should I do 2 separate masks?

Sorry, I missed that detail. In that case, using FIELD_PREP() here would
make that clear (even if it isn't technically required).


>>> +static int ad4851_set_calibscale(struct ad4851_state *st, int ch, int val,
>>> +				 int val2)
>>> +{
>>> +	u64 gain;
>>> +	u8 buf[0];
>>> +	int ret;
>>> +
>>> +	if (val < 0 || val2 < 0)
>>> +		return -EINVAL;
>>> +
>>> +	gain = val * MICRO + val2;
>>> +	gain = DIV_U64_ROUND_CLOSEST(gain * 32768, MICRO);
>>> +
>>> +	put_unaligned_be16(gain, buf);
>>> +
>>> +	guard(mutex)(&st->lock);
>>> +
>>> +	ret = regmap_write(st->regmap, AD4851_REG_CHX_GAIN_MSB(ch),
>>> +			   buf[0]);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return regmap_write(st->regmap, AD4851_REG_CHX_GAIN_LSB(ch),
>>> +			    buf[1]);
>>> +}
>>> +
>>
>> I'm pretty sure that calibscale and calibbias also need to take into
>> account if resolution boost is enabled or not.
> 
> Can you please detail a bit on this topic? I am not sure what I should do.
> 

We haven't implemented oversampling yet in ad4695 yet, so I don't know
exactly what we need to do either. ;-)

But this is how I would test it to see if it is working correctly or
not. We will need to test this with a 20-bit chip since that is the
only one that will change the _scale attribute when oversampling is
enabled.

First, with oversampling disabled (_oversampling_ratio = 1), generate
a constant voltage of 1V for the input. Read the _raw attribute. Let's
call this value raw0. Read the _scale attribute, call it scale0 and
the _offset attribute, call it offset0.

Then we should have (raw0 + offset0) * scale0 = 1000 mV (+/- some
noise).

Then change the offset calibrate to 100 mV. To do this, we reverse
the calculation 100 mV / scale0 = calibbias (raw units). Write the
raw value to the _calibbias attribute. Then read the _raw
attribute again, call it raw0_with_calibbias.

This time, we should have (raw0_with_calibbias + offset0) * scale0
= 1100 mV (+/- some noise).

Then set _calibbias back to 0 and repeat the above by setting the
_calibscale attribute to 0.90909 (this is 1 / 1.1, which should
add 10% to the measured raw value). Read, the _raw attribute again,
call it raw0_with_caliscale.

This time, we should have (raw0_with_caliscale + offset0) * scale0
= 1100 mV (+/- some noise).

Set _calibscale back to 0. Then set _oversampling_ratio to 2. Read
_scale and _offset again, call these scale1 and offset1.

Then repeat the steps above using scale1 and offset1 in the
calculations. The raw values will be different but the resulting
processed values (mV) should all be the same if the attributes
are implemented correctly.

>>> +static const unsigned int ad4851_scale_table[][2] = {
>>> +	{ 2500, 0x0 },
>>> +	{ 5000, 0x1 },
>>> +	{ 5000, 0x2 },
>>> +	{ 10000, 0x3 },
>>> +	{ 6250, 0x04 },
>>> +	{ 12500, 0x5 },
>>> +	{ 10000, 0x6 },
>>> +	{ 20000, 0x7 },
>>> +	{ 12500, 0x8 },
>>> +	{ 25000, 0x9 },
>>> +	{ 20000, 0xA },
>>> +	{ 40000, 0xB },
>>> +	{ 25000, 0xC },
>>> +	{ 50000, 0xD },
>>> +	{ 40000, 0xE },
>>> +	{ 80000, 0xF },
>>> +};
>>
>> I'm not sure how this table is supposed to work since there are
>> multiple entries with the same voltage value. Probably better
>> would be to just have the entries for the unipolar/unsigned ranges.
>> Then if applying this to a differential/signed channel, just add
>> 1 to resulting register value before writing it to the register.
>> Or make two different tables, one for unsigned and one for signed
>> channels.
> 
> It is stated in the set_scale function comment how this table works.
> This table contains range-register value pair.
> Always the second value corresponds to the single ended mode.
>>

Yes, I understand that part. The problem is that values like 10000
are listed twice in the table, so if we have a softspan of 0..+10V
or -10V..+10V, how do we know which 10000 to use to get the right
register value? This is why I think it needs to be 2 different
tables.

>>> +
>>> +static const struct iio_chan_spec ad4858_channels[] = {
>>> +	AD4851_IIO_CHANNEL(0, 0, 20),
>>> +	AD4851_IIO_CHANNEL(1, 0, 20),
>>> +	AD4851_IIO_CHANNEL(2, 0, 20),
>>> +	AD4851_IIO_CHANNEL(3, 0, 20),
>>> +	AD4851_IIO_CHANNEL(4, 0, 20),
>>> +	AD4851_IIO_CHANNEL(5, 0, 20),
>>> +	AD4851_IIO_CHANNEL(6, 0, 20),
>>> +	AD4851_IIO_CHANNEL(7, 0, 20),
>>> +	AD4851_IIO_CHANNEL(0, 1, 20),
>>> +	AD4851_IIO_CHANNEL(1, 1, 20),
>>> +	AD4851_IIO_CHANNEL(2, 1, 20),
>>> +	AD4851_IIO_CHANNEL(3, 1, 20),
>>> +	AD4851_IIO_CHANNEL(4, 1, 20),
>>> +	AD4851_IIO_CHANNEL(5, 1, 20),
>>> +	AD4851_IIO_CHANNEL(6, 1, 20),
>>> +	AD4851_IIO_CHANNEL(7, 1, 20),
>>> +};
>>> +
>>> +static const struct iio_chan_spec ad4857_channels[] = {
>>> +	AD4851_IIO_CHANNEL(0, 0, 16),
>>> +	AD4851_IIO_CHANNEL(1, 0, 16),
>>> +	AD4851_IIO_CHANNEL(2, 0, 16),
>>> +	AD4851_IIO_CHANNEL(3, 0, 16),
>>> +	AD4851_IIO_CHANNEL(4, 0, 16),
>>> +	AD4851_IIO_CHANNEL(5, 0, 16),
>>> +	AD4851_IIO_CHANNEL(6, 0, 16),
>>> +	AD4851_IIO_CHANNEL(7, 0, 16),
>>> +	AD4851_IIO_CHANNEL(0, 1, 16),
>>> +	AD4851_IIO_CHANNEL(1, 1, 16),
>>> +	AD4851_IIO_CHANNEL(2, 1, 16),
>>> +	AD4851_IIO_CHANNEL(3, 1, 16),
>>> +	AD4851_IIO_CHANNEL(4, 1, 16),
>>> +	AD4851_IIO_CHANNEL(5, 1, 16),
>>> +	AD4851_IIO_CHANNEL(6, 1, 16),
>>> +	AD4851_IIO_CHANNEL(7, 1, 16),
>>> +};
>>
>> I don't think it is valid for two channels to have the same scan_index.
>> And since this is simultaneous sampling and we don't have control over
>> the order in which the data is received from the backend, to get the
>> ordering correct, we will likely have to make this:
>>
> I am not sure which of these channels have the same index.
> scan_index is index + diff * 8 in the channel definition.
> 

scan_index indicates the order in which a data value for a channel
will appear in the buffer when doing a buffered read. So all scan_index
for any channel 0 need to be less than all scan_index for all
channel 1, and so on.

So in the suggestion quoted below, the scan_index parameter
just gets assigned directly to .scan_index without any
additional calculations.

>> #define AD4851_IIO_CHANNEL(scan_index, channel, diff, bits) \
>> ...
>>
>> 	AD4851_IIO_CHANNEL(0, 0, 0, 16),
>> 	AD4851_IIO_CHANNEL(1, 0, 1, 16),
>> 	AD4851_IIO_CHANNEL(2, 1, 0, 16),
>> 	AD4851_IIO_CHANNEL(3, 1, 1, 16),
>> 	AD4851_IIO_CHANNEL(4, 2, 0, 16),
>> 	AD4851_IIO_CHANNEL(5, 2, 1, 16),
>> 	AD4851_IIO_CHANNEL(6, 3, 0, 16),
>> 	AD4851_IIO_CHANNEL(7, 3, 1, 16),
>> 	AD4851_IIO_CHANNEL(8, 4, 0, 16),
>> 	AD4851_IIO_CHANNEL(9, 4, 1, 16),
>> 	AD4851_IIO_CHANNEL(10, 5, 0, 16),
>> 	AD4851_IIO_CHANNEL(11, 5, 1, 16),
>> 	AD4851_IIO_CHANNEL(12, 6, 0, 16),
>> 	AD4851_IIO_CHANNEL(13, 6, 1, 16),
>> 	AD4851_IIO_CHANNEL(14, 7, 0, 16),
>> 	AD4851_IIO_CHANNEL(15, 7, 1, 16),
>>
>>

