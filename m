Return-Path: <linux-pwm+bounces-6211-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD28ACAD12
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 13:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F84D7AAED4
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F39A13AA2E;
	Mon,  2 Jun 2025 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik+8vz6n"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6C82F41;
	Mon,  2 Jun 2025 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862998; cv=none; b=t/8eF8E4OvEpvsVkbLUHoacBrJjeZFjIZacLcv0VRlSL/S1M9nNO8uc75JJ7oRiqZlbAVXFkMAGSPl97TgM+UtcwRVCI5jtVdhcp3FklUbWy5nu95zjVOtB0VU/NKOTt6Kv4xctduTZcguYpGFdh1gQJEYmbwwUIwdDZ0D0JoBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862998; c=relaxed/simple;
	bh=4OT8dMpWFfRv+z7H1pdYOxW7SBC/RdYIz2rgJ9mw79I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f71Gg0yA/GpI03Z5rpYQJtsYkxPIM1dRHlicxe6Wgz9kIoBcT43TiedDC2uTG/8u2DcMPE1ZfLBXDAlN5VDZ3we70tUVb0WlBZ+FufzArIEKaodeROiej587Yro6fChrg2H3o+apLfUHgv8rszlfdzEHz2evJnrCj8FigLOhmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik+8vz6n; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-527a2b89a11so1648292e0c.2;
        Mon, 02 Jun 2025 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748862995; x=1749467795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PKLuI0S04K4LHs4sr1kzhjQoZYDDn3yve0UomIXNTlE=;
        b=Ik+8vz6nqH2qZF44+FqWRLjxDsznNvOdCbwJdJnAezcsuX/Erva3BZ+P8yp18SmODh
         3ZpnyFMzHW5M8q5qmWBeDZhP0NRzwyq7b1EphjvoROc82q9zw9k3OrYuR7cTrZmG/vXI
         ea2cQrdVHtcya7X/lXCn+u2HkdkfO+easXEmcMYxSw9herOmYS+kVwhXfnS0yVCGaJww
         3m+2gmzq1cPhdtPSkL1LlPQDtQ//ryRUdlocDuGcHDkg7d1UQ3OnSra9JREU2sxHQnGc
         qPzIAmHMDvGQ0Ogz9qaOpaZNH7ry3+2o/y3VH7pZyLSoi7Hw3ai1DWw+bTt15hnJ3j7Y
         u6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748862995; x=1749467795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKLuI0S04K4LHs4sr1kzhjQoZYDDn3yve0UomIXNTlE=;
        b=YfScKT4rTReV7PCOrOInnLYE58/iD7UkJQciHdmjXhFpn/m/RcZK/yA2iUPnZilZxp
         l2DGN1aGJCW+myn9soAhRqwMsOTZwloxQfbm3irvf5i19RDy/FNlSiNF/cLt7Znf5LOf
         tSnWrKTo/iQBSlViJMnN5QnqInsiSv8LerYC1QtmVZym1b6N0sv235GpKLgViYm6KSC7
         NeocAF6rMVdIIc6a1k57GXpG9jISH87slj8O8pJMMN1yn95NNWWIQAkVOjZBkwS47y2J
         s/K9tNukUqsgvG2iyz82A2uZrzZqmN/bUU6F0EcMVR4ZYmwxNOeDlvrbLuiopMaGUcv+
         wO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX8OTUiOKHrm0k6w+amYQ6cYVAIK0lrzIOAHRE5s9Grgh5Q4fkmOQIDgz/Mepw53GUSO9YxOHwxkg8@vger.kernel.org, AJvYcCVOXRpt9ut9BXw7cSgpDUm9odetvxcbvQlqJjpBMuk0JOK1Uy9SgYsF34aYQWJd155YPIIAdMRLKg2U@vger.kernel.org, AJvYcCWl3szmDZp5mqTEhevILxXbBVyK3ya3GtyH9VwPQFma3uFSOyeFW6iXd1aAPBPCzy8qCQZMjVIPx/LH@vger.kernel.org, AJvYcCXEO7prIY+RXwjhs6ks1gM4VH931sdEChNSkSaSRCLq7V52vFUJWT9GcAyrcp1RsoI/r5NJxGcPjcl+B8Ne@vger.kernel.org, AJvYcCXooV78v8z3lUZfLTZPF7Bh8xDKrMrW61raiugy3d/hA5V9lQJupG3Jd0NiW8XBs6XA+3S/zSFti5ul@vger.kernel.org
X-Gm-Message-State: AOJu0YxiR0uzrTx31MkLr+ctS0c9QinNLfDHY+DU9N/Opb8DV09m+4Qc
	qka32OaJ4CpmCEOTXUtaa42BCasQUTfn1qg+J7QU3k1FUO5lFLa+KrOK
X-Gm-Gg: ASbGncsrxj4tObD9XYNCvKG3gfd9yYmiFamzNyWR8odzpkVRULCn0PYA6GbyzHKSeD3
	Lm4s4IyPGv64M74wC8oiq5Fnlmozup6QptPW5XqZLyRLhRJ0K+PRS66ApJz3HfBvMwHqv8aiVr4
	tOnOg5Uolg7UcSQAN9Elup/YXgY0PfI76AA3u7/xnY2Cn1umxMYsZwfsaDzcDKdqxRI84legquL
	8++WY6XwAclubsrZ6Qxy9Kxy3HI6qj2MWsiHRLvKYMK0xgFsPhary0emsy9qZH1k7uxo/f04ggc
	GgZkPMSu7WIcn6NLnx43jvSXlRBlQ7ns82q+b3cD4acFo9PLk+Ah948I59Ca4/AYJ9VnwwfXmTb
	AsjKK7G0LN+s=
X-Google-Smtp-Source: AGHT+IE1fCcnudgIyjz/EVtkZki9Gx2Qym/YMRI6t0KTxFoSgpTwKryR/zHmVu0g33PqZq6K6wbYfA==
X-Received: by 2002:a05:6122:3d01:b0:52a:791f:7e20 with SMTP id 71dfb90a1353d-53080f76fd9mr10502605e0c.4.1748862994774;
        Mon, 02 Jun 2025 04:16:34 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:1225:ec01:ecf2:8e21:9f0f:159e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074c32099sm7263789e0c.41.2025.06.02.04.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 04:16:34 -0700 (PDT)
Date: Mon, 2 Jun 2025 13:16:22 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: adc: add support for ad4052
Message-ID: <zofjbh4yvtz4sfj2t6cpdohqqlrgwqdqtiahpvalbbfv2tdqqi@g5zpdp3zn4gb>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>
 <c82b8c53-e653-4cd3-80ef-37c5daf9314c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c82b8c53-e653-4cd3-80ef-37c5daf9314c@baylibre.com>

Hi David,

On Fri, Apr 25, 2025 at 06:13:48PM -0500, David Lechner wrote:
> On 4/22/25 6:34 AM, Jorge Marques wrote:
> > The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit,
> > successive approximation register (SAR) analog-to-digital converter (ADC)
> > that enables low-power, high-density data acquisition solutions without
> > sacrificing precision.
> > This ADC offers a unique balance of performance and power efficiency,
> > plus innovative features for seamlessly switching between high-resolution
> > and low-power modes tailored to the immediate needs of the system.
> > The AD4052/AD4058/AD4050/AD4056 are ideal for battery-powered,
> > compact data acquisition and edge sensing applications.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
> >  MAINTAINERS              |    1 +
> >  drivers/iio/adc/Kconfig  |   14 +
> >  drivers/iio/adc/Makefile |    1 +
> >  drivers/iio/adc/ad4052.c | 1425 ++++++++++++++++++++++++++++++++++++++++++++++
> 
> This patch is way too big, so I didn't review most of it yet. But time to call
> it quits for today. In the future, it would be a lot easier for reviewers if
> you can split things into multiple patches instead of implementing all of the
> features at once. E.g. start with just a basic driver, then a patch to add
> oversampling support, then another patch to add SPI offload support. 500 lines
> is a more manageable size for review.
> 

Ack. I split v3 into three commits: base, offload and iio events.
My playground is here: https://github.com/gastmaier/adi-linux/pull/9

> ...
> 
> > +static int ad4052_update_xfer_offload(struct iio_dev *indio_dev,
> > +				      struct iio_chan_spec const *chan)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	const struct iio_scan_type *scan_type;
> > +	struct spi_transfer *xfer = &st->xfer;
> > +
> > +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> > +
> > +	if (IS_ERR(scan_type))
> > +		return PTR_ERR(scan_type);
> > +
> > +	xfer = &st->offload_xfer;
> > +	xfer->bits_per_word = scan_type->realbits;
> > +	xfer->len = BITS_TO_BYTES(scan_type->storagebits);
> 
> This doesn't work for oversampling. realbits may be 16 while storagebits is 32.
> But the SPI controller needs to know how many realbits-sized words to read.
> 
> So this should be 
> 
> 	xfer->len = BITS_TO_BYTES(scan_type->realbits);
> 

Agreed, but due to spi message optimization needs to be:

  	xfer->len = scan_type->realbits == 24 ? 4 : 2;

Because 3 bytes cannot be optimized.
> > +
> > +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> > +	st->offload_msg.offload = st->offload;
> > +
> > +	return spi_optimize_message(st->spi, &st->offload_msg);
> 
> I know it is like this in a few other drivers already, but I don't like having
> spi_optimize_message() in this funtion because it makes it really easy to
> forget to do have balanced calls to spi_unoptimize_message().
> 

Ack.

> > +}
> > +
> 
> ...
> 
> > +static const struct iio_buffer_setup_ops ad4052_buffer_setup_ops = {
> > +	.postenable = &ad4052_buffer_postenable,
> > +	.predisable = &ad4052_buffer_predisable,
> > +};
> 
> Would be nice to add "offload" to the name of this struct and the callbacks
> to make it clear that these are only for the SPI offload use case.
> 
Ack.
> ...
> 
> > +
> > +static bool ad4052_offload_trigger_match(struct spi_offload_trigger *trigger,
> > +					 enum spi_offload_trigger_type type,
> > +					 u64 *args, u32 nargs)
> > +{
> 
> We should be checking the args here according to what I suggested in my reply
> to the devicetree bindings patch. Right now it is assuming that we are only
> using this for SPI offload and that the pin used is GP1 and the event is data
> read. We should at least verify that the args match those assumptions.
> 
> For bonus points, we could implement allowing GPO as well.
> 

Yes, it is assuming as you mentioned.
I'm okay with "at least verifying".
but then I need to look-up at the parent node first, since it resides at
the spi-controller node, if that's ok.

> > +	return type == SPI_OFFLOAD_TRIGGER_DATA_READY;
> > +}
> > +
> > +static const struct spi_offload_trigger_ops ad4052_offload_trigger_ops = {
> > +	.match = ad4052_offload_trigger_match,
> > +};
> > +
> > +static int ad4052_request_offload(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	struct device *dev = &st->spi->dev;
> > +	struct dma_chan *rx_dma;
> > +	struct spi_offload_trigger_info trigger_info = {
> > +		.fwnode = dev_fwnode(dev),
> > +		.ops = &ad4052_offload_trigger_ops,
> > +		.priv = st,
> > +	};
> > +	struct pwm_state pwm_st;
> > +	int ret;
> > +
> > +	indio_dev->setup_ops = &ad4052_buffer_setup_ops;
> > +
> > +	ret = devm_spi_offload_trigger_register(dev, &trigger_info);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "failed to register offload trigger\n");
> 
> Strictly speaking, the trigger-source provider is indendant of using it for
> SPI offload. I guess this is fine here for now though.
> 
Ok.
> > +
> > +	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
> > +							   SPI_OFFLOAD_TRIGGER_DATA_READY);
> > +	if (IS_ERR(st->offload_trigger))
> > +		return PTR_ERR(st->offload_trigger);
> > +
> > +	st->cnv_pwm = devm_pwm_get(dev, NULL);
> > +	if (IS_ERR(st->cnv_pwm))
> > +		return dev_err_probe(dev, PTR_ERR(st->cnv_pwm),
> > +				     "failed to get CNV PWM\n");
> > +
> > +	pwm_init_state(st->cnv_pwm, &pwm_st);
> > +
> > +	pwm_st.enabled = false;
> > +	pwm_st.duty_cycle = AD4052_T_CNVH_NS * 2;
> > +	pwm_st.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> > +					 AD4052_MAX_RATE(st->grade));
> > +
> > +	ret = pwm_apply_might_sleep(st->cnv_pwm, &pwm_st);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to apply CNV PWM\n");
> > +
> > +	ret = devm_add_action_or_reset(dev, ad4052_pwm_disable, st->cnv_pwm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
> > +	if (IS_ERR(rx_dma))
> > +		return PTR_ERR(rx_dma);
> > +
> > +	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
> > +							   IIO_BUFFER_DIRECTION_IN);
> > +}
> > +
> > +static int ad4052_probe(struct spi_device *spi)
> > +{
> > +	const struct ad4052_chip_info *chip;
> > +	struct device *dev = &spi->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct ad4052_state *st;
> > +	int ret = 0;
> > +
> > +	chip = spi_get_device_match_data(spi);
> > +	if (!chip)
> > +		return dev_err_probe(dev, -ENODEV,
> > +				     "Could not find chip info data\n");
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st = iio_priv(indio_dev);
> > +	st->spi = spi;
> > +	spi_set_drvdata(spi, st);
> > +	init_completion(&st->completion);
> > +
> > +	st->regmap = devm_regmap_init_spi(spi, &ad4052_regmap_config);
> > +	if (IS_ERR(st->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> > +				     "Failed to initialize regmap\n");
> > +
> > +	st->mode = AD4052_SAMPLE_MODE;
> > +	st->wait_event = false;
> > +	st->chip = chip;
> > +	st->grade = chip->prod_id <= 0x75 ? AD4052_2MSPS : AD4052_500KSPS;
> > +	st->oversampling_frequency = AD4052_FS_OFFSET(st->grade);
> > +	st->events_frequency = AD4052_FS_OFFSET(st->grade);
> 
> Somewhere around here, we should be turning on the power supplies. Also, it
> looks like we need some special handling to get the reference volage. If there
> is a supply connected to REF, use that, if not, use VDD which requires writing
> to a register to let the chip know.
> 
Yes, v3 will add regulators.
Vref can be sourced from either REF (default) or VDD.
So the idea is, if REF node not provided, set VDD as REF?

> > +
> > +	st->cnv_gp = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
> > +	if (IS_ERR(st->cnv_gp))
> > +		return dev_err_probe(dev, PTR_ERR(st->cnv_gp),
> > +				     "Failed to get cnv gpio\n");
> > +
> > +	indio_dev->modes = INDIO_BUFFER_HARDWARE | INDIO_DIRECT_MODE;
> 
> INDIO_BUFFER_HARDWARE should not be set here. If using SPI offload,
> devm_iio_dmaengine_buffer_setup_with_handle() will add it automatically.
> For non-SPI-offload operation, it should not be set.
> 
Ack.
> > +	indio_dev->num_channels = 1;
> > +	indio_dev->info = &ad4052_info;
> > +	indio_dev->name = chip->name;
> > +
> > +	st->offload = devm_spi_offload_get(dev, spi, &ad4052_offload_config);
> 
> This
> 
> > +	if (IS_ERR(st->offload))
> > +		return PTR_ERR(st->offload);
> 
> should be
> 
> 	ret = PTR_ERR_OR_ZERO(st->offload);
> 
Ack.

> > +
> > +	if (ret && ret != -ENODEV)
> > +		return dev_err_probe(dev, ret, "Failed to get offload\n");
> > +
> > +	if (ret == -ENODEV) {
> > +		st->offload_trigger = NULL;
> > +		indio_dev->channels = chip->channels;
> > +	} else {
> > +		indio_dev->channels = chip->offload_channels;
> > +		ret = ad4052_request_offload(indio_dev);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "Failed to configure offload\n");
> > +	}
> > +
> > +	st->xfer.rx_buf = &st->d32;
> 
> I don't think we want this set globally. I.e. it doesn't make sense for SPI
> offload xfers.
> 
Ack.

> > +
> > +	ret = ad4052_soft_reset(st);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "AD4052 failed to soft reset\n");
> > +
> > +	ret = ad4052_check_ids(st);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "AD4052 fields assertions failed\n");
> > +
> > +	ret = ad4052_setup(indio_dev, indio_dev->channels);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_STATUS,
> > +			   AD4052_DEVICE_STATUS_DEVICE_RESET);
> 
> Why not include this in ad4052_setup() or even ad4052_soft_reset()?
> 
Ack.
But on setup to not write registers before doing the sanity test.

> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4052_request_irq(indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ad4052_update_xfer_raw(indio_dev, indio_dev->channels);
> > +
> > +	pm_runtime_set_active(dev);
> > +	ret = devm_pm_runtime_enable(dev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "Failed to enable pm_runtime\n");
> > +
> > +	pm_runtime_set_autosuspend_delay(dev, 1000);
> > +	pm_runtime_use_autosuspend(dev);
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static int ad4052_runtime_suspend(struct device *dev)
> > +{
> > +	struct ad4052_state *st = dev_get_drvdata(dev);
> > +
> > +	return regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG,
> > +			    FIELD_PREP(AD4052_DEVICE_CONFIG_POWER_MODE_MSK,
> > +				       AD4052_DEVICE_CONFIG_LOW_POWER_MODE));
> > +}
> > +
> > +static int ad4052_runtime_resume(struct device *dev)
> > +{
> > +	struct ad4052_state *st = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG,
> > +			   FIELD_PREP(AD4052_DEVICE_CONFIG_POWER_MODE_MSK, 0));
> 
> regmap_clear_bits() would be shorter if there isn't going to be a macro to
> explain the meaning of 0.
> 
Ack.
> > +	return ret;
> > +}
> > +

Regards,
Jorge

