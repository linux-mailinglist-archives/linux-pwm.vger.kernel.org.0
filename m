Return-Path: <linux-pwm+bounces-8259-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDqcLKpAtWlIyQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8259-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 12:04:10 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 590A728CCF8
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 12:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EFD230265B8
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 11:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E175320CCDC;
	Sat, 14 Mar 2026 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpMW/PtT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14231E5018
	for <linux-pwm@vger.kernel.org>; Sat, 14 Mar 2026 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773486237; cv=none; b=FaPw2gta00sRytDyNbNs7rkk08DX5QQ2wDJhBQbekG7yGzrzCF2GKpix4ezQL9JyT8nuqzBGC1dKnhvKN+lytRUfNwiXZ9NlPwDjGPV/IQeh/iIxv4OkUgAetzZ3R/FsbHKH+5VukM+XR66KUIpLQoRQt52d3Tnd6rGuAxEvbBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773486237; c=relaxed/simple;
	bh=XUirMjiBAIwWShDoNuPxSak5Z0/baRZcCYbX/CSaILo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eRmj+VXVOQkHZYNOL1rsqGntTqf2pRWuu1rs3M47tERJX6Y7vSMjk46K1XsJ0RkgYidLC3SLsMZKa4wmenzKGNj4eeB1XJVm1MOiCvk0mUIGNJfMyh+50eG3o0zoT1hcCcu7CaYDdGicz8Fmx7fcneFSG9L3p6KGkLrs3sqfmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpMW/PtT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439ac15f35fso2595447f8f.0
        for <linux-pwm@vger.kernel.org>; Sat, 14 Mar 2026 04:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773486234; x=1774091034; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R/S4gFBAuBiiJ6Z3W0EpaXp0wYnIyCtKjLNSIKNehlA=;
        b=YpMW/PtTwU0H29BDcJwgKPAz0FHBshirUzVs1o8bKwotknmDBtI+V32lr15oKX6kgz
         fLO+emR82/N19heLgiV7P8PPFWt2gQ2wVOA7+tDnJGIAGcb3VZA+RGxwoPT8fhYlcIq9
         T9PyDUquN8ZggXQFNi+c0DXHzr5drECy68K0vxPMEu1dFxqzZlc+FwGnG0951GlH1lh8
         DxlXAO6vAr24aDBDEQd/0a0pLEbZv/jOfUywuTyRjNzuX9W4udI351xHv+m9OsihVB16
         97M+fCKyeF+EabSNrJ0/JcWZ3oIdnwwCd2806JVoRyC7/vw80Aq14IuHV1UOLXIHpBP7
         ONyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773486234; x=1774091034;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/S4gFBAuBiiJ6Z3W0EpaXp0wYnIyCtKjLNSIKNehlA=;
        b=jyAxg27DUr9Rui/H8FjOvmnfVue8j9uzhKOOOZJACa8DeZzYd+k+Hke2B2DxHyovqo
         oMsaWOmuUkE6Qur5MMU/MKZKpuVYeyGQEn3AA7U7MDMe9iVEg29C7eBEYh5jqM7JRS5r
         Vs7GMAzKiYeffPoFzQtnuJ3x+VY8R6LWqkfBzN5Vf2VWdWIN+J9Ukm8etMhS++nK8zGr
         w2g6EwXEo6V1jU/jpJWkQpv+Z+DbbFTQ7EKvdvAAIMxMCVaKmCWK2cG2hTniTyO/9Ptr
         1qViblt6+JX4kzYX5bWFb9k7IZAlsrOEAC78I+aw64l3VA8A11PEB6F3tn2MBKXk5CWP
         DPUw==
X-Forwarded-Encrypted: i=1; AJvYcCVtdPCt53hf0R7Ni6saYOuW0+G2UodQYBALeMI5+oiZeceqbT1OH8yS8B1C3I+DBQwwBm8/vwU0Pvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4xxUNP3zBWhraDTHaPlDOCIEch/QfgvBQTOXLbYHjkkKc+fD
	KXoKlcIAanD2hvikD/kq7bfW5B0WplmD1PE4+7t7HUnMQ7L/dsXvoiJQ
X-Gm-Gg: ATEYQzxs1v5kpgaw68nM+oXJZcCZ2JbReNqzjyVlc1AaC5X0g2UDU2D/wghRQGFxTU0
	ErEUuDebE/oy4mqW1uJ6iq4iQGkmmw4fcXy/2RrQHk2it45wcafpHl9j/6demKvS4t9cUBnXNtL
	6Lgk//3RksomIwBtJZXE8t9nYbNmewh0/Hr5SVcueJ+SFJCKjCg5z1mWUMR4ElIJESw6G3KcAoZ
	jTKfQqwpK8KvcGZgEhqC1Vzc4AWGAzYcGAfN1QzRNEonYFAWlJhY/ql7VL6retntNuhETGWcZVB
	RBjzoZsM48reoO9KMRly1JhBQ9zmFFTsZxzKM7WO7wfDNU3xqrKRaTYdZdZZF0JX1XIEA2jGXCr
	BD3XPU0tx3inMeV9+QCniTzSXmMv8UCFfHCFUe5p2wUtjM37K8i6FHij09Hjh9qa5iU1eVdUT2F
	zX8olwSjJ2D1BQHW/eAAAVcb0bUq7nQZoHMZ1GwoAUaUVg19isvPGWopONwqhudI7g5F7hayQ=
X-Received: by 2002:a05:6000:40cb:b0:439:beba:300 with SMTP id ffacd0b85a97d-43a04d7555amr11673982f8f.1.1773486234022;
        Sat, 14 Mar 2026 04:03:54 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19ac34sm25535647f8f.3.2026.03.14.04.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 04:03:53 -0700 (PDT)
Message-ID: <ccba355fd43585a9b0a2ae4a54ffa4beaeb3bc71.camel@gmail.com>
Subject: Re: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner	 <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  Andy Shevchenko	
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown	 <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski	 <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Date: Sat, 14 Mar 2026 11:04:59 +0000
In-Reply-To: <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
References: 
	<20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
	 <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8259-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,baylibre.com,gmail.com,pengutronix.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 590A728CCF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Radu,

Some comments from me. Unfortunately, only have time for the first patch :)

On Fri, 2026-03-13 at 12:07 +0200, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
>=20
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
>=20
> Two buffered operating modes are supported, auto-detected from the
> device tree:
>=20
> =C2=A0=C2=A0=C2=A0 - CNV Clock Mode:=C2=A0 an external PWM drives the CNV=
 pin; the sampling
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rate is contro=
lled via the PWM period. Requires a
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reference cloc=
k and a DATA_READY interrupt.
>=20
> =C2=A0=C2=A0=C2=A0 - Manual Mode:=C2=A0=C2=A0=C2=A0=C2=A0 CNV is tied to =
SPI CS; each SPI transfer triggers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a conversion a=
nd returns the previous result
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (pipelined). N=
o external clock or interrupt needed.
>=20
> In both modes the chip idles in Autonomous Mode so that single-shot
> read_raw can use the internal oscillator without disturbing the
> hardware configuration.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---

...

>=20
> +
> +static int ad4691_single_shot_read(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *val)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	u16 mask =3D ~BIT(chan->channel);
> +	u32 acc_mask[2] =3D { mask & 0xFF, mask >> 8 };
> +	unsigned int reg_val;
> +	int ret;
> +
> +	/*
> +	 * Always use AUTONOMOUS mode for single-shot reads, regardless
> +	 * of the buffer mode (CNV_CLOCK or MANUAL). The chip is kept
> +	 * in AUTONOMOUS mode during idle; enter_conversion_mode() and
> +	 * exit_conversion_mode() handle the switch for buffer operation.
> +	 */
> +	ret =3D regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +			=C2=A0=C2=A0 AD4691_STATE_RESET_ALL);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			=C2=A0=C2=A0 BIT(chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_bulk_write(st->regmap, AD4691_ACC_MASK1_REG, acc_mask, 2=
);
> +	if (ret)
> +		return ret;

Not DMA safe... Not sure if things changed in regmap_bulk_write() but befor=
e it was
not guaranteed that a safe buffer was going to be used.

> +
> +	ret =3D regmap_write(st->regmap, AD4691_OSC_EN_REG, 1);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Wait for conversion to complete using a timed delay.
> +	 * A single read needs 2 internal oscillator periods.
> +	 * OSC_FREQ_REG is never modified by the driver, so the
> +	 * oscillator runs at reset-default speed. Use chip->max_rate
> +	 * as a conservative proxy: it is always <=3D the OSC frequency,
> +	 * so the computed delay is >=3D the actual conversion time.
> +	 */
> +	unsigned long conv_us =3D DIV_ROUND_UP(2 * USEC_PER_SEC,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 st->chip->max_rate);
> +	fsleep(conv_us);
> +
> +	ret =3D regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4691_AVG_IN(chan->channel), &reg_val)=
;
> +	if (ret)
> +		return ret;
> +
> +	*val =3D reg_val;
> +	regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_RESET_ALL=
);
> +

No error handling.

> +	return IIO_VAL_INT;
> +}
> +
> +static int ad4691_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *val,
> +			=C2=A0=C2=A0 int *val2, long info)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +

Side note. The above turned out to be a cool addition!

> +		return ad4691_single_shot_read(indio_dev, chan, val);
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D ad4691_get_sampling_freq(st);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D st->vref_uV / 1000;
> +		*val2 =3D chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4691_set_sampling_freq(indio_dev, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int writeval, unsigned int *readval=
)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static const struct iio_info ad4691_info =3D {
> +	.read_raw =3D &ad4691_read_raw,
> +	.write_raw =3D &ad4691_write_raw,
> +	.debugfs_reg_access =3D &ad4691_reg_access,
> +};
> +
> +static int ad4691_reset(struct ad4691_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct reset_control *rst;
> +
> +	rst =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get reset\n");
> +
> +	if (!rst)
> +		return 0;
> +
> +	reset_control_assert(rst);

You can get the reset in the asserted state already.

> +	/* Reset delay required. See datasheet Table 5. */
> +	fsleep(300);
> +	reset_control_deassert(rst);
> +
> +	return 0;
> +}
> +
> +static int ad4691_config(struct ad4691_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	enum ad4691_ref_ctrl ref_val;
> +	unsigned int reg_val;
> +	int ret;
> +
> +	/*
> +	 * Determine buffer conversion mode from DT: if a PWM is provided it
> +	 * drives the CNV pin (CNV_CLOCK_MODE); otherwise CNV is tied to CS
> +	 * and each SPI transfer triggers a conversion (MANUAL_MODE).
> +	 * Both modes idle in AUTONOMOUS mode so that read_raw can use the
> +	 * internal oscillator without disturbing the hardware configuration.
> +	 */
> +	if (device_property_present(dev, "pwms")) {
> +		st->adc_mode =3D AD4691_CNV_CLOCK_MODE;
> +		ret =3D ad4691_pwm_get(st);
> +		if (ret)
> +			return ret;
> +	} else {
> +		st->adc_mode =3D AD4691_MANUAL_MODE;
> +		st->sampling_period =3D
> ns_to_ktime(DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
> +			AD4691_MANUAL_MODE_STD_FREQ(st->chip->num_channels,
> +				to_spi_device(dev)->max_speed_hz)));
> +	}
> +
> +	/* Perform a state reset on the channels at start-up. */
> +	ret =3D regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +			=C2=A0=C2=A0 AD4691_STATE_RESET_ALL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write state reset\n");
> +
> +	/* Clear STATUS register by reading from the STATUS register. */
> +	ret =3D regmap_read(st->regmap, AD4691_STATUS_REG, &reg_val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read status
> register\n");
> +
> +	switch (st->vref_uV) {
> +	case AD4691_VREF_uV_MIN ... 2750000:
> +		ref_val =3D AD4691_VREF_2P5;
> +		break;
> +	case 2750001 ... 3250000:
> +		ref_val =3D AD4691_VREF_3P0;
> +		break;
> +	case 3250001 ... 3750000:
> +		ref_val =3D AD4691_VREF_3P3;
> +		break;
> +	case 3750001 ... 4500000:
> +		ref_val =3D AD4691_VREF_4P096;
> +		break;
> +	case 4500001 ... AD4691_VREF_uV_MAX:
> +		ref_val =3D AD4691_VREF_5P0;
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Unsupported vref voltage: %d uV\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 st->vref_uV);
> +	}
> +
> +	ret =3D regmap_write(st->regmap, AD4691_REF_CTRL,
> +			=C2=A0=C2=A0 FIELD_PREP(AD4691_REF_CTRL_MASK, ref_val));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write REF_CTRL\n");
> +
> +	/* Both CNV_CLOCK and MANUAL devices start in AUTONOMOUS mode. */
> +	ret =3D regmap_write(st->regmap, AD4691_ADC_SETUP,
> AD4691_AUTONOMOUS_MODE_VAL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write ADC_SETUP\n");
> +
> +	return regmap_write(st->regmap, AD4691_GPIO_MODE1_REG, AD4691_ADC_BUSY)=
;
> +}
> +
> +static int ad4691_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4691_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	ret =3D devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +

Agree with Andy here.

> +	st->regmap =3D devm_regmap_init(dev, NULL, st, &ad4691_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize regmap\n");
> +
> +	st->chip =3D spi_get_device_match_data(spi);
> +
> +	ret =3D ad4691_regulator_get(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4691_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4691_config(st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name =3D st->chip->name;
> +	indio_dev->info =3D &ad4691_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	indio_dev->channels =3D (st->adc_mode =3D=3D AD4691_MANUAL_MODE) ?
> +		st->chip->manual_channels : st->chip->channels;
> +	indio_dev->num_channels =3D st->chip->num_channels;

nit: I would prefer explicit if() else

- Nuno S=C3=A1


