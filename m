Return-Path: <linux-pwm+bounces-4764-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFFFA26709
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 23:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321D83A5810
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 22:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FC3211464;
	Mon,  3 Feb 2025 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f+6XVLDT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA521147B
	for <linux-pwm@vger.kernel.org>; Mon,  3 Feb 2025 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622534; cv=none; b=rN7/GvStUYDgl6iaTPvV0Fh/1mAV3bTsZb0zV5Bszq6+KYDD9ZF0IAjJSlGeleSLVf5K1sXJDYKG3cHQQnnrMSn4s6uHgdvTsVvn6+mj/17cfQ9mbNKLTVQEvrfkQjEplj/3xzWoXWFbspLiZRJWbx7EY6p2bPLXzaKzQP5fOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622534; c=relaxed/simple;
	bh=SXY/ut4HPZGjQfV0TdHI+owQ/8IPFSL6uBL1jYm5kIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Uemp0wrRREHQkAuO0gQO+Fdps3pDOR4+zgCfAsuewHlqaJs48aDCxNXZqGpZUb/rvDIZxD8vguyaGWyASowqWtGa1Z/HjE1Y6DVsavpnkQylwmUIUGAjo2ZfqhP1YouFkscR2ZQkwvPCkNaKP8Ywoc42zGF2+p1nFMouiN7sd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f+6XVLDT; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ebadbb14dcso2098570b6e.3
        for <linux-pwm@vger.kernel.org>; Mon, 03 Feb 2025 14:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738622530; x=1739227330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJnIfOP7+jSlUs29FECy5//ffpMPbLe/6pSEbA38u3M=;
        b=f+6XVLDTnechdqBluVSaw5ZSyuaeMkrWSCzOIU0YoBMQyd87gOtCjssN32aN+ldeTf
         Pqh8ZBTqzNfmbgqz8hLrf9IbtyuDBZUxTWVY+fqhFSHs5igqV7RjkcH7Y5SfBThQ1NTt
         SzNIzm6rbA39f7faGwOlb9dJlqlzH741aSKQE3djTpu4XuWwdeeO/UYTHQ1H+J2WM+js
         ThAahDQZCxFRBTEMnq3hBwH0xepC+q9gT3cezWS2iVYCsDliAiqK/tP2BwYEnLqCp5y+
         Z4GnsPhmf3k+bEox8ce/qAQWKkQ+E0UGsmCcpAGFrm5FZPiB85WjnAW9bnFJr2PiSY1h
         VYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622530; x=1739227330;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJnIfOP7+jSlUs29FECy5//ffpMPbLe/6pSEbA38u3M=;
        b=a/f4KTlME7zzyl1RoskUh5nlTm6FvdmculQUL9X2rA9sQGkbPwCUnjl2bLlF8Zn6YV
         UHOCAoLtVKioIGghfHwHdtGqf67uTUg9i46dde7LmYfUI5LeFb/wZKNOxr0JCBy10YeS
         lNmddU6j7CJhJNeu5Hn6OifKo9LHYTko/sS+D3V/JSqiQ9CJROBV6UzDlIjXiZCsuEtC
         STuWXHlOhzaGxMaceAmcjL8TIapngArphLFyelq58c9O9IkSJlPFeLaS2LybKKVT3WL5
         wx+1HQCY8rKmFuC1Z4AsgYRGk8cFTph8qDwD6/zVp/hIKnsckbgChKLu8H+CFwQhYW1a
         YZww==
X-Forwarded-Encrypted: i=1; AJvYcCUbGK5mqqqT4CTJYMXJkf7bAX8kFVqX1lpVoIwN9o+sRm9WdzdBbFpjAXGpmU/4MOcJz0uqvSwQXBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcgBq1I+8Zd3KCoVP/Y/p+2Biiuu5ok5i3NvXLmqcR1NY3tr6M
	yrXseG0gxDme8GbudNeMyAnfglb2vF4h3vAqEziapUBFGFQFR8Qj/b+Hw+CIg8c=
X-Gm-Gg: ASbGnctyBRw8cOPbG4Y0HXG0yJKoJ3tXqjeSYKg8QE1rFPVHyxAyyDiGgHjTV5P/Oyl
	z+DcqQCugNXvvQy1yjWCIHXq5mtGCnzla1pvmU9f3mo3Lw1OujBhKqFNraqgYwe5KUWcS2IIHjy
	8qMNzWEm8ArJjEHEyuvp0En/+WzqVQ28RNViXynmpEroZlsnbGEfwSDX34hAIOx26wZW48owkiv
	U8mrxt4C/KMeGbcP/xytCsFQPr110pBzkzTaAFKC6BYUseHgyhdysA67dzjb7CryFH9ja9FakAm
	iRVSoGAOqsCw0ImdrOAG8amYdLVeMRCOzhqCO/zpLBONXEjai9HI
X-Google-Smtp-Source: AGHT+IGPg3Ki4+QlI+PnxMX8N884nW9RTygynBG8qVyReXZuEsEhrg1HOrCB1+xLT/4DE7U7CBVGQQ==
X-Received: by 2002:a05:6808:2f16:b0:3e7:df63:15bc with SMTP id 5614622812f47-3f323a184cdmr15101787b6e.12.1738622530456;
        Mon, 03 Feb 2025 14:42:10 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f333523efcsm2731729b6e.8.2025.02.03.14.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 14:42:09 -0800 (PST)
Message-ID: <c5722215-b720-49ab-9f0e-00b01eb4679d@baylibre.com>
Date: Mon, 3 Feb 2025 16:42:08 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] iio: adc: ad4851: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20250127105726.6314-1-antoniu.miclaus@analog.com>
 <20250127105726.6314-9-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250127105726.6314-9-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 4:57 AM, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

I think we have the important bits sorted now (i.e. userspace-facing stuff).
Just noticed a few minor things in the latest revision.


> +static int ad4851_setup(struct ad4851_state *st)
> +{
> +	unsigned int product_id;
> +	int ret;
> +
> +	if (st->pd_gpio) {
> +		/* To initiate a global reset, bring the PD pin high twice */
> +		gpiod_set_value(st->pd_gpio, 1);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, 0);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, 1);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, 0);
> +		fsleep(1000);
> +	} else {
> +		ret = regmap_set_bits(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
> +				      AD4851_SW_RESET);
> +		if (ret)
> +			return ret;

Do we also need fsleep() after software reset?

> +	}
> +

...

> +static int ad4851_parse_channels(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec ad4851_chan)
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
> +		if (reg >= AD4851_MAX_CH_NR)
> +			return dev_err_probe(dev, ret,
> +					     "Invalid channel number\n");

Need to check ret first, otherwise reg may be unintialized.

> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing channel number\n");
> +		*channels = ad4851_chan;
> +		channels->scan_index = index++;
> +		channels->channel = reg;
> +
> +		if (fwnode_property_present(child, "diff-channels")) {
> +			channels->channel2 = reg + st->info->max_channels;
> +			channels->differential = 1;
> +		}
> +
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
> +	return 0;
> +}
> +
> +static int ad4857_parse_channels(struct iio_dev *indio_dev)
> +{
> +	const struct iio_chan_spec ad4851_chan = AD4857_IIO_CHANNEL;
> +
> +	return ad4851_parse_channels(indio_dev, ad4851_chan);
> +}
> +
> +static int ad4858_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *ad4851_channels;
> +	const struct iio_chan_spec ad4851_chan = AD4858_IIO_CHANNEL;
> +	int ret;
> +
> +	ad4851_channels = (struct iio_chan_spec *)indio_dev->channels;
> +
> +	ret = ad4851_parse_channels(indio_dev, ad4851_chan);
> +	if (ret)
> +		return ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ad4851_channels->has_ext_scan_type = 1;
> +		if (fwnode_property_present(child, "bipolar")) {

fwnode_property_read_bool() 

(to be consistent with same check in ad4851_parse_channels())

> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_b;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_b);
> +
> +		} else {
> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_u;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_u);
> +		}
> +		ad4851_channels++;
> +	}
> +
> +	return 0;
> +}
> +

