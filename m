Return-Path: <linux-pwm+bounces-4670-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A22A15925
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 22:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDB8188A5F0
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 21:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708F1AA1EC;
	Fri, 17 Jan 2025 21:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FinCwFGn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140841A9B4C
	for <linux-pwm@vger.kernel.org>; Fri, 17 Jan 2025 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737150343; cv=none; b=mdpON/hs7Qg6/myDzSO8sHhFL/6bOSvrEnYDKppHR2xn/4LIrssmgOzdfWmf5pIbsks5KAWfuKQ7xnVizh5X2slWtt1KZrY5cm9ZQJCzzfT1PpB0/rY0O7PnBH9c1+l5fzNl8s+zaqImP9GbnucALkgOcOjHDmTfUHRLJSexIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737150343; c=relaxed/simple;
	bh=42ZclBCmMMxfREeBFX3MvxJLMXEmuRt6Y4lAfcNMvCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tKiesoCupwWRs13WGwEFbqGQKV5hLB24uuKSMNUNeym2UUJAw53vxh1Sbd+SefFHJLmDxahu/TRvKg06Nk5pknps370oGrSdMflSefejaKQquoAEpeZsLftPgkqrvYHMZPRcHMEz/BX+e7PnwXJa9a3cOIa+irkKY8jWGJCgnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FinCwFGn; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29e842cb9b4so812336fac.2
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jan 2025 13:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737150340; x=1737755140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HEHgvB4+/pUa8EYaY3HZEDkJbWxXbz1BDJZaymb+qzM=;
        b=FinCwFGnQneopHSd9QXRpynldYDKG8aGCPeHfBskUQf12qm+UBhDKC597nliwmgaAs
         +TiUbp6ced1jj6QAhjmpZc1nLVFCx0LZouUlhc46fsb8ppuh5MRW9mxrd1fHkK+Q90R4
         hZ3mugN9yhQinZeZ11z2maXiUDItnDGa2sXuZJvGHtzQRDedSeBvtVAWljPr/OLUIskB
         IGyrnWZmBfPfnpZkGxKgAMGcdrXIjHxEbfJAE4yf8R8XpwHnjpNQs0Qc4C3plPpQVVav
         BP6RhJzwJIwK7QwSb3sjdJdAElsG85IS/VEkAPtSD4DpMd4ZRuwXbr0zf5pNKUysRAvl
         Wq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737150340; x=1737755140;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEHgvB4+/pUa8EYaY3HZEDkJbWxXbz1BDJZaymb+qzM=;
        b=D53WHWhq+yTLGfYPeCXWgPN+eICZNqEIqIXWTCdXTG24TwztrM/+GQTiJHazVMyLTM
         ItUonBor6rDvWnYtxGhjdePLAd8l2NIqi3JbxrrfmCn3HASz4iOMVL6gcYHC3i5vTFdJ
         q2uOykmeNJIvwlG3tzel1SAbMONoUWsPabMY8h+0d7ix1ldUEPr9MWowcyPmia2L8UZR
         gzwvijUH4WXhgn1Qkb1r8/EwLW1MtGNDCkMQyy4N1Tl+XrI3dINQ/XYVjcuSX3juJ7sO
         eNpVgI77fRWpDq6xjg0xETWxS1UxrWuiQoniCdb061i+AidixqduS8IRulJcqa6Ui+3V
         5hxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVywZEDvb/xNZWxyYstbD9yQ2PvxRKwsy17v7CnJxbKPSTj/Hzoyis7MvmkjO2wZPeeqVeKtdYKGS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/me1gcrpQUYWQ1EZEPivef5M7bnSqg9QclRyWm9PYDCeWvCmH
	PVqJMSAyYIptKTY/Tab9Tj2GOPGZFw/6ZSesg5IB9cHyDgDrlxd+Hs4l1gqZWRA=
X-Gm-Gg: ASbGncsBE3U8Xa0Qn+fIay3VfbE8Fwsp79hr0QDCsEpoz/n8vPiXU6f5Ygb5nfk6Lpy
	zIIR37UFcub5hKLpicHTFo8mfrFBl1hJUbq6daK4Pw8idkExn+pfVsie/Ai0IWWfWYJVv3IXMzT
	WHcNinYkghwH4o42Ax2CeA8yleiOMClJXfq49q7BHv0edPOxqFM5eMP6xq4du6aNcB69kJ0Cogn
	DjAubxkzqOPZU9t8jyj0w+w4oPlomA66HlrcmWEo0ovfWij5GdIvT7pqaihLifAz/bCfe/1JsJF
	SCFmJwUvpd3v2EcKVg==
X-Google-Smtp-Source: AGHT+IHrWZAfY+N1YltqPls1oooCUeyySmDXIao13oIEZyC3bZ7RXj+c/hOWdD0RPsOMElf8sT7uvw==
X-Received: by 2002:a05:6871:d307:b0:278:1f2:a23f with SMTP id 586e51a60fabf-2b1c0a2db12mr2432720fac.13.1737150338630;
        Fri, 17 Jan 2025 13:45:38 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b1b8f773cdsm1341030fac.32.2025.01.17.13.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 13:45:37 -0800 (PST)
Message-ID: <d4b9d6e9-745c-4c35-a62d-18e0a36f30c4@baylibre.com>
Date: Fri, 17 Jan 2025 15:45:35 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 8/8] iio: adc: ad4851: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
 <20250117130702.22588-9-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250117130702.22588-9-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/25 7:07 AM, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +static void __ad4851_get_scale(struct iio_dev *indio_dev, int scale_tbl,
> +			       unsigned int *val, unsigned int *val2)
> +{
> +	const struct iio_scan_type *scan_type;
> +	unsigned int tmp;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);

This is ignoring possible error return.

> +
> +	tmp = ((u64)scale_tbl * MICRO) >> scan_type->realbits;
> +	*val = tmp / MICRO;
> +	*val2 = tmp % MICRO;
> +}
> +...

> +static int ad4851_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->cnv_trigger_rate_hz / st->osr;

Needs to be:

		*val = st->cnv_trigger_rate_hz;
		*val2 = st->osr;

for IIO_VAL_FRACTIONAL.

> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad4851_get_calibscale(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4851_get_scale(indio_dev, chan, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad4851_get_calibbias(st, chan->channel, val);
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad4851_get_oversampling_ratio(st, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4851_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4851_set_sampling_freq(st, val * st->osr);

Since we are using IIO_VAL_FRACTIONAL on read, we should handle val2 here to
allow for a decimal component.

	val * st->osr + val2 * st->osr / MICRO


Also, should return -EINVAL if (val < 0 || val2 < 0) to avoid negative values
being turned into large numbers when casting to unsigned.


> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4851_set_scale(indio_dev, chan, val, val2);
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad4851_set_calibscale(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad4851_set_calibbias(st, chan->channel, val);
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad4851_set_oversampling_ratio(indio_dev, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

...

> +
> +#define AD4851_IIO_CHANNEL(index, ch, diff)					\
> +	.type = IIO_VOLTAGE,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS) |					\
> +		BIT(IIO_CHAN_INFO_SCALE),					\
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
> +	.info_mask_shared_by_all_available =					\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
> +	.indexed = 1,								\
> +	.differential = diff,							\
> +	.channel = ch,								\
> +	.channel2 = ch,								\
> +	.scan_index = index,

channel, channel2 and scan_index get written over in ad4851_parse_channels()
so can be omitted here.

> +
> +/*
> + * In case of AD4858_IIO_CHANNEL the scan_type is handled dynamically during the
> + * parse_channels function.
> + */
> +#define AD4858_IIO_CHANNEL(index, ch, diff)					\
> +{										\
> +	AD4851_IIO_CHANNEL(index, ch, diff)					\
> +}
> +
> +#define AD4857_IIO_CHANNEL(index, ch, diff)					\
> +{										\
> +	AD4851_IIO_CHANNEL(index, ch, diff)					\
> +	.scan_type = {								\
> +		.sign = 'u',							\
> +		.realbits = 16,							\
> +		.storagebits = 16,						\
> +	},									\
> +}
> +
> +static int ad4851_parse_channels(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec **ad4851_channels,
> +				 const struct iio_chan_spec ad4851_chan,
> +				 const struct iio_chan_spec ad4851_chan_diff)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *channels;
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
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret || reg >= AD4851_MAX_CH_NR)
> +			return dev_err_probe(dev, ret,
> +					     "Missing/Invalid channel number\n");

This allows returning 0 on error which will lead to an invalid state. Probably
best to split this into two messages/returns.

> +		if (fwnode_property_present(child, "diff-channels")) {
> +			*channels = ad4851_chan_diff;
> +			channels->scan_index = index++;
> +			channels->channel = reg;
> +			channels->channel2 = reg;

Typically we don't set channel == channel2 for differential channels.

> +
> +		} else {
> +			*channels = ad4851_chan;
> +			channels->scan_index = index++;
> +			channels->channel = reg;

These two lines are the same in each branch, so can be pulled out of the if
statement to avoid duplicating them.

> +		}
> +		channels++;
> +
> +		st->bipolar_ch[reg] = fwnode_property_read_bool(child, "bipolar");
> +
> +		if (st->bipolar_ch[reg]) {
> +			channels->scan_type.sign = 's';
> +		} else {
> +			ret = regmap_write(st->regmap, AD4851_REG_CHX_SOFTSPAN(reg),
> +					   AD4851_SOFTSPAN_0V_40V);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	*ad4851_channels = channels;

At this point, channels is pointing to memory we didn't allocate (because of
channels++). As in the previous review, I suggest we just get rid of the output
parameter since indio_dev->channels already has the correct pointer.

It's less chance for mistakes like this and avoids needing to provide an unused
arg in ad4857_parse_channels().

> +
> +	return 0;
> +}
> +
> +static int ad4857_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct iio_chan_spec *ad4851_channels;
> +	const struct iio_chan_spec ad4851_chan = AD4857_IIO_CHANNEL(0, 0, 0);
> +	const struct iio_chan_spec ad4851_chan_diff = AD4857_IIO_CHANNEL(0, 0, 1);

The only difference between these is the diff bit, so seems simpler to just
have one template and dynamically set the bit instead.

> +
> +	return ad4851_parse_channels(indio_dev, &ad4851_channels, ad4851_chan,
> +				     ad4851_chan_diff);
> +}
> +...

> +static const struct iio_info ad4851_iio_info = {
> +	.debugfs_reg_access = ad4851_reg_access,
> +	.read_raw = ad4851_read_raw,
> +	.write_raw = ad4851_write_raw,
> +	.update_scan_mode = ad4851_update_scan_mode,
> +	.get_current_scan_type = &ad4851_get_current_scan_type,

Inconsistent use of & on function pointer.

> +	.read_avail = ad4851_read_avail,
> +};
> +

