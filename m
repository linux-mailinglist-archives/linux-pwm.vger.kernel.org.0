Return-Path: <linux-pwm+bounces-6210-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2D5ACACC2
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 12:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A053A66A4
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 10:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD5D2040BF;
	Mon,  2 Jun 2025 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvdT6aER"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD751FFC5D;
	Mon,  2 Jun 2025 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748861452; cv=none; b=q2BFavOfic1OyiHkedSFmN+FpUGdRzdEcwbgHfWDfFndeH8+k/bHLDl+BFc4i/OnKeHi4T0vfM13aQly2dxjelUOQ1e4wxd0E+6SRG4NYSPf283tSqk+OKe0eYBHE2v3R9YuvXtcTBG+/aH78zG3y65/KBu7uh+3EsNfe0tnj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748861452; c=relaxed/simple;
	bh=t/zvyfPhwjFoLdvzt4xTMC5xmwvAcN13GgebQtkR+hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjQwOz+FG99RXYHcANaYO2Nh4eXZvDOtpVzTHLhZYP00Cdp1K6cFi95b33jCU6pURRKgPTkiEzPj4WPG2R5DV34g2ArJ25un64WJheAadgF2DyqmIiFLoB84wS9pKmE6jaMK4aOQQPZUAnZzdY2WxsTdNkfYt/LEtiPjwpI2zVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvdT6aER; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-87e37ab3c70so2175219241.1;
        Mon, 02 Jun 2025 03:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748861449; x=1749466249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=89bgeMlhiyBp2EdkLj5TJglckU9NgvMSlN+AXQsrikY=;
        b=OvdT6aERbhzba7fjemAEwSdg1eYu0BEBwLVlTuuVRluV4EByMn//usL979og1y2BLI
         pyCpy10J4cdfxpt0Y44F6KnLjWPM6afi+YavKmePMFpjnaGZejv1ke6O3fuCDK5QgBTx
         DOYN6znMMfcmOWCD+1af4fEX5vOyarfDED6PsdOJHEsWYScNEtu4bLYgUmVfvRiJvkUD
         an5EJhzqfJw3XTWAABPlJefNgFjKOeoxpkZQ9FHkxaP96afCvaFLpi6Evvz7KGnsPMdX
         TmXh5/EZGaE/0uF8vRS3SqMkhNqYEcRdSMCj+vmKCtK+laNppytAy3gmjX7ht/Cg2J0n
         gcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748861449; x=1749466249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89bgeMlhiyBp2EdkLj5TJglckU9NgvMSlN+AXQsrikY=;
        b=j897/FM0sdmdUer0cchq86GRTJbqSihKO6dysygkE4dSIxZnSKkb+b88ElFFs3hxdb
         SmmKykW2a28H4E9GL3PDUtXN4+dSVoouZGaXpgr+A13zpW7Md9B8+XvkCoKFq5n8RLTP
         i0gQ5nV8JcroqN0ZaQ7X76tw79KqP3wbENJwDPe+at8qXcUJZ2v3LuqeDkywX8EhjEWP
         i3rtZNnzVTnECTstPGMvkkL0bgcGhF8vZlaGHezMfb+IUnJeaDBmzhHIgXLXAzByaPuq
         yXYO0Lb6mfaB/pIkLDiHBObYIPUmqKRWcndkg6fPZRRRynWust/LjIQyKkTlL4GM+x07
         +9YA==
X-Forwarded-Encrypted: i=1; AJvYcCU0PA39vstIq6Wl1O9ab6RKg7hnIl0c9Cc8hlOtupVtY4yVue9Tdn154eoi8yt5Jc97WjGJfwhY7SDF@vger.kernel.org, AJvYcCXI/yGxk2vDt0hJO8cewBQj+89WeNX5ip/bXRqmS9JyB03JXPYoPxfkZ3zx8xqnPpsPd8KVRTKWQn88@vger.kernel.org, AJvYcCXQi6w1xGrlKTNdpKgUz7jYIRd4wzGULAkd+2Wdil4GWcX0UQtiy4LI9jbC22Fh+d6eQvxPujYYlwzA@vger.kernel.org, AJvYcCXYf3QFLt5XBFD9wq+LcEsyGlrkpwPMyjGFYyuWe8oKcIF3T5xotJKZg+u5CUHJ2jcnPjb8I81X1Ogh@vger.kernel.org, AJvYcCXr3lBIEOPfnyBl+6E6OEh8MmL3wu3bEsMMIbdiL8yWvJkbhm4zDK6ALSe7pohbbirtBkRs+9/gR2hza60l@vger.kernel.org
X-Gm-Message-State: AOJu0YztSCWgsc9o7sZXQBAYBWedLmMYw/qp4Sa0Yv01//jDQojUWEaK
	WT7Rlm/hgcBsW9uEPqQa6muYEx18HneuO2Yjg2smgCFkfvPie0GsuLacrwpBFhDnx/M=
X-Gm-Gg: ASbGnctMMlVrRCyw4LzQ5pbvVMl7fOipGs52sUvPx1jBTr/7d+Sd3b10z7BSqjjzShj
	NUVTzr8sLfoGz0KJf4yLEI9ycFxgdc6SzIoAe7XCZBWa2op/0NhOOERVPTYSota8EnpMx3Sdzgs
	Wugm7sS2VaR2RE2svTngnMJoCdw3EybUf4qN1tX168qJ0UFh8jrmXhtNU0nAB/hVxgOjmVZjjJ6
	qWRtp90TwiR9Ibvt0qUqsIXVIrTUXD7eYniCQGlzogPKSfd6jvVy4QU4hUr+OicHUjRyM7grc7s
	+hWmDyKIlg5o4lm+CCfKIfbs0mk82W0ZmbBDs3jlmUmKBkzNyCOe1HXXWuGwLYEsQ98AzTAuuml
	+5kPmybSfWCs=
X-Google-Smtp-Source: AGHT+IEgPI3ZO8B3VTjWajZkDaVSiEx0x76gtIvUbtrb+oXOgqViNy96PtWy8TU2os5VFvo7ZzK4iw==
X-Received: by 2002:a05:6102:c89:b0:4e2:86e8:3188 with SMTP id ada2fe7eead31-4e6e473792bmr8549544137.0.1748861439020;
        Mon, 02 Jun 2025 03:50:39 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:1225:ec01:ecf2:8e21:9f0f:159e])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e64e9bf9b9sm6739157137.20.2025.06.02.03.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 03:50:38 -0700 (PDT)
Date: Mon, 2 Jun 2025 12:50:27 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: adc: add support for ad4052
Message-ID: <3sltihsbo7z4sqyicwkbeg4wsmebz2ilv77t2bqadv3wtndfeq@cdk5kpq6qnnr>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>
 <20250426170302.02bdf844@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426170302.02bdf844@jic23-huawei>

Hi Jonathan,

On Sat, Apr 26, 2025 at 05:03:02PM +0100, Jonathan Cameron wrote:
> On Tue, 22 Apr 2025 13:34:50 +0200
> Jorge Marques <jorge.marques@analog.com> wrote:
>
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
> Hi Jorge,
>
> A few additional comments from me.
>
> Thanks,
>
> Jonathan
>
> > diff --git a/drivers/iio/adc/ad4052.c b/drivers/iio/adc/ad4052.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..f412f0884bab4f500091f6c7ca761967c8f6e3b6
> > --- /dev/null
> > +++ b/drivers/iio/adc/ad4052.c
> > @@ -0,0 +1,1425 @@
>
>
> > +static int ad4052_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long mask)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	struct pwm_state pwm_st;
> > +	int ret;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> > +
> > +	if (st->wait_event) {
> > +		iio_device_release_direct(indio_dev);
> > +		return -EBUSY;
> > +	}
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = ad4052_read_chan_raw(indio_dev, val);
> > +		if (ret)
> > +			goto out_release;
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +		ret = ad4052_get_oversampling_ratio(st, val);
> > +		if (ret)
> > +			goto out_release;
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		ret = pwm_get_state_hw(st->cnv_pwm, &pwm_st);
> > +		if (ret)
> > +			goto out_release;
> > +
> > +		if (!pwm_st.enabled)
> > +			pwm_get_state(st->cnv_pwm, &pwm_st);
> > +
> > +		*val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, pwm_st.period);
> > +
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +
> > +out_release:
> > +	iio_device_release_direct(indio_dev);
> > +	return ret;
> > +}
>
>
> > +static int ad4052_write_event_value(struct iio_dev *indio_dev,
> > +				    const struct iio_chan_spec *chan,
> > +				    enum iio_event_type type,
> > +				    enum iio_event_direction dir,
> > +				    enum iio_event_info info, int val,
> > +				    int val2)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	int ret = -EINVAL;
> > +	u8 reg, size = 1;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
>
> Sometimes it is worth a n internal function factored out in cases
> like this to allow direct returns in error cases with the release
> always happening before we check if the inner function failed.
>
> That suggestion applies in other places in this code.

Ack. I will refactor out the methods using auxiliary methods suffixed
with _dispatch.

> > +
> > +	if (st->wait_event) {
> > +		iio_device_release_direct(indio_dev);
> > +		return -EBUSY;
> > +	}
> > +
> > +	switch (type) {
> > +	case IIO_EV_TYPE_THRESH:
> > +		switch (info) {
> > +		case IIO_EV_INFO_VALUE:
> > +			if (st->data_format & AD4052_ADC_MODES_DATA_FORMAT) {
> > +				if (val > 2047 || val < -2048)
> > +					goto out_release;
> > +			} else if (val > 4095 || val < 0) {
> > +				goto out_release;
> > +			}
> > +			if (dir == IIO_EV_DIR_RISING)
> > +				reg = AD4052_REG_MAX_LIMIT;
> > +			else
> > +				reg = AD4052_REG_MIN_LIMIT;
> > +			size = 2;
> > +			st->d16 = cpu_to_be16(val);
> > +			break;
> > +		case IIO_EV_INFO_HYSTERESIS:
> > +			if (val & BIT(7))
> > +				goto out_release;
> > +			if (dir == IIO_EV_DIR_RISING)
> > +				reg = AD4052_REG_MAX_HYST;
> > +			else
> > +				reg = AD4052_REG_MIN_HYST;
> > +			st->d16 = cpu_to_be16(val >> 8);
> > +			break;
> > +		default:
> > +			goto out_release;
> > +		}
> > +		break;
> > +	default:
> > +		goto out_release;
> > +	}
> > +
> > +	ret = regmap_bulk_write(st->regmap, reg, &st->d16, size);
> > +
> > +out_release:
> > +	iio_device_release_direct(indio_dev);
> > +	return ret;
> > +}
> > +
> > +static int ad4052_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	struct spi_offload_trigger_config config = {
> > +		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
> > +	};
> > +	int ret;
> > +
> > +	if (st->wait_event)
> > +		return -EBUSY;
> > +
> > +	ret = pm_runtime_resume_and_get(&st->spi->dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4052_set_operation_mode(st, st->mode);
> > +	if (ret)
> > +		goto out_error;
> > +
> > +	ret = ad4052_update_xfer_offload(indio_dev, indio_dev->channels);
> > +	if (ret)
> > +		goto out_error;
> > +
> > +	/* SPI Offload handles the data ready irq */
> > +	disable_irq(st->gp1_irq);
> > +
> > +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> > +					 &config);
> > +	if (ret)
> > +		goto out_offload_error;
> > +
> > +	ret = pwm_enable(st->cnv_pwm);
> > +	if (ret)
> > +		goto out_pwm_error;
> > +
> > +	return 0;
> > +
> > +out_pwm_error:
> > +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> > +out_offload_error:
> > +	enable_irq(st->gp1_irq);
> > +	spi_unoptimize_message(&st->offload_msg);
> > +	ad4052_exit_command(st);
>
> What is this matching to?  Feels like it would be set_operation_mode()
> but I may be wrong on that.  If it is then you need another label
> to call only this update_xfer_offload fails.
>

Yep, here an additional label is needed, thanks!
Changing to:

	out_pwm_error:
		spi_offload_trigger_disable(st->offload, st->offload_trigger);
	out_offload_error:
		enable_irq(st->gp1_irq);
		spi_unoptimize_message(&st->offload_msg);
	out_xfer_error:
		ad4052_exit_command(st);
	out_mode_error:
		pm_runtime_mark_last_busy(&st->spi->dev);
		pm_runtime_put_autosuspend(&st->spi->dev);

		return ret;

> > +out_error:
> > +	pm_runtime_mark_last_busy(&st->spi->dev);
> > +	pm_runtime_put_autosuspend(&st->spi->dev);
> > +
> > +	return ret;
> > +}
>
> > +static int ad4052_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> > +				     unsigned int writeval, unsigned int *readval)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> > +
> > +	if (st->wait_event) {
> > +		iio_device_release_direct(indio_dev);
> Probably use a goto to release this in only one place.
>
Ack.

> > +		return -EBUSY;
> > +	}
> > +
> > +	if (readval)
> > +		ret = regmap_read(st->regmap, reg, readval);
> > +	else
> > +		ret = regmap_write(st->regmap, reg, writeval);
> > +
> > +	iio_device_release_direct(indio_dev);
> > +	return ret;
> > +}
> > +
> > +static int ad4052_get_current_scan_type(const struct iio_dev *indio_dev,
> > +					const struct iio_chan_spec *chan)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +
> > +	if (iio_buffer_enabled(indio_dev))
>
> This is the bit I'm not really following. Why is the enabling or not of
> the buffer related to whether offload is going on?
>
Will be dropped and the scan_type only depends on the oversampling value.
My misunderstanding is explained on thread
[PATCH v2 2/5] iio: code: mark iio_dev as const in iio_buffer_enabled
> > +		return st->mode == AD4052_BURST_AVERAGING_MODE ?
> > +				   AD4052_SCAN_TYPE_OFFLOAD_BURST_AVG :
> > +				   AD4052_SCAN_TYPE_OFFLOAD_SAMPLE;
> > +
> > +	return st->mode == AD4052_BURST_AVERAGING_MODE ?
> > +			   AD4052_SCAN_TYPE_BURST_AVG :
> > +			   AD4052_SCAN_TYPE_SAMPLE;
> > +}
>
>
> > +static int ad4052_probe(struct spi_device *spi)
> > +{
> ...
>
> > +
> > +	st->mode = AD4052_SAMPLE_MODE;
> > +	st->wait_event = false;
> > +	st->chip = chip;
> > +	st->grade = chip->prod_id <= 0x75 ? AD4052_2MSPS : AD4052_500KSPS;
>
> That feels like it should be encoded directly in chip.  Basing it
> on prod_id seems liable to bite us at somepoint in the future.
>
Ack. Moved to a const chip_info.grade.
> > +
> > +static int ad4052_runtime_resume(struct device *dev)
> > +{
> > +	struct ad4052_state *st = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG,
> > +			   FIELD_PREP(AD4052_DEVICE_CONFIG_POWER_MODE_MSK, 0));
> > +	return ret;
>
> 	return regmap_write();
> and no need for the local variable ret.
>

A sleep of 4ms will be added to ensure not triggering NOT_RDY_ERROR
flag, and therefore ret will be kept:

	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG,
			   FIELD_PREP(AD4052_DEVICE_CONFIG_POWER_MODE_MSK, 0));
	fsleep(4000);
	return ret;

> > +}
> > +
> > +static DEFINE_RUNTIME_DEV_PM_OPS(ad4052_pm_ops, ad4052_runtime_suspend,
> > +				 ad4052_runtime_resume, NULL);

Best regards,
Jorge

