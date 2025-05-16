Return-Path: <linux-pwm+bounces-6002-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569BDAB99D3
	for <lists+linux-pwm@lfdr.de>; Fri, 16 May 2025 12:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F116D4E84FE
	for <lists+linux-pwm@lfdr.de>; Fri, 16 May 2025 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946EC2356D0;
	Fri, 16 May 2025 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ6TgyDN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF923536E;
	Fri, 16 May 2025 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390319; cv=none; b=LYNCDVrr2Lv4Yr5ddzd3zM/2O+kRPvCvgUee2E7N3+OW8r5qGwQgox5fezS3XudjZxx3ygCzXypxoVobsKstfoCyLB1l8gva7SBUHRSnou83ZEeX/up3RkRmciDHEnVzUwsnY6w1L31iN+n0nbCehV1OiqMvCJKaSBbAqfPTzOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390319; c=relaxed/simple;
	bh=R20/4fb1Xb5ziJT95mIbUUzOyLqHmV7GI85TVQT4+8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOiO4OaF9+kFPruX1z7ISKoz56Lff99riXrxL6f7cjI4Le8DPFmfqYP3C38QUPWNJKPethsrk7kNDsvgeo6zqSrpTjDEiFoHmg4xyFpuZELRxupx7e/7kZAhOOPxhnPi04bhKQ6Rk77GzktRDIwjwKkwI81MlypNy2gQQWRbSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ6TgyDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95E0C4CEE4;
	Fri, 16 May 2025 10:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747390319;
	bh=R20/4fb1Xb5ziJT95mIbUUzOyLqHmV7GI85TVQT4+8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZ6TgyDNxjwjdhf6k6M7sVMUTURuIpVaHwR243Qd0i767J/dC7b2G+Pa9j4UJWC59
	 A8zPzu8SlrqtHkUCwijFBqWt03ylKhHTAqcxWlzQxzGWdJMgMDymQKLo8y3V/AOaPE
	 lfzfwSJ6UVLaApdEQ5B5cAmrkrVjTQHVKDNT8Pxcvk5fT/lhvofyagd0cL6vnQ1dtY
	 DOBAvIkvJ82Ms6B7AqaH6EhdZ33cgVtfBGs6UUSj0D01bkaY1PJb/Q+bIAM8Pw9jWt
	 d3xinY7T38yqWCDkPDHDpq1kLHQtuGUxilzprnTvz135Gz4A2G4yq3yTOpgig+QRjm
	 LPdsHKA9f5vDw==
Date: Fri, 16 May 2025 12:11:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: adc: add support for ad4052
Message-ID: <6zn53fgyiwtm5ad5piyt32uxcwenwgkhwhantizsjytwbf42ts@4pg6hkna3yah>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hlofdy26eqw7ig5c"
Content-Disposition: inline
In-Reply-To: <20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>


--hlofdy26eqw7ig5c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 5/5] iio: adc: add support for ad4052
MIME-Version: 1.0

Hello,

On Tue, Apr 22, 2025 at 01:34:50PM +0200, Jorge Marques wrote:
> +static int ad4052_set_sampling_freq(struct ad4052_state *st, unsigned int freq)
> +{
> +	struct pwm_state pwm_st;
> +
> +	if (freq <= 0 || freq > AD4052_MAX_RATE(st->grade))
> +		return -EINVAL;
> +
> +	pwm_get_state(st->cnv_pwm, &pwm_st);
> +	pwm_st.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
> +	return pwm_apply_might_sleep(st->cnv_pwm, &pwm_st);

Is it clear that pwm_st.duty_cycle isn't greater than
DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);

I'm not a big fan of pwm_get_state() because the semantic is a bit
strange. My preferred alternative would be to either use pwm_init_state
and initialize all fields, or maintain a struct pwm_state in struct
ad4052_state.

> +}
> +
> +static int ad4052_soft_reset(struct ad4052_state *st)
> +{
> +	int ret;
> +
> +	memset(st->buf_reset_pattern, 0xFF, sizeof(st->buf_reset_pattern));
> +	for (int i = 0; i < 3; i++)
> +		st->buf_reset_pattern[6 * (i + 1) - 1] = 0xFE;
> +
> +	ret = spi_write(st->spi, st->buf_reset_pattern,
> +			sizeof(st->buf_reset_pattern));
> +	if (ret)
> +		return ret;
> +
> +	/* Wait AD4052 reset delay */
> +	fsleep(5000);
> +
> +	return 0;
> +}
> +
> +static int ad4052_setup(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> +
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> +	u8 val = FIELD_PREP(AD4052_GP_CONF_MODE_MSK_0, AD4052_GP_INTR) |
> +		 FIELD_PREP(AD4052_GP_CONF_MODE_MSK_1, AD4052_GP_DRDY);
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD4052_REG_GP_CONF,
> +				 AD4052_GP_CONF_MODE_MSK_1 | AD4052_GP_CONF_MODE_MSK_0,
> +				 val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(AD4052_INTR_CONF_EN_MSK_0, (AD4052_INTR_EN_EITHER)) |
> +	      FIELD_PREP(AD4052_INTR_CONF_EN_MSK_1, (AD4052_INTR_EN_NEITHER));
> +
> +	ret = regmap_update_bits(st->regmap, AD4052_REG_INTR_CONF,
> +				 AD4052_INTR_CONF_EN_MSK_0 | AD4052_INTR_CONF_EN_MSK_1,
> +				 val);
> +	if (ret)
> +		return ret;
> +
> +	val = 0;
> +	if (scan_type->sign == 's')
> +		val |= AD4052_ADC_MODES_DATA_FORMAT;
> +
> +	st->data_format = val;
> +
> +	if (st->grade == AD4052_500KSPS) {
> +		ret = regmap_write(st->regmap, AD4052_REG_TIMER_CONFIG,
> +				   FIELD_PREP(AD4052_TIMER_CONFIG_FS_MASK,
> +					      AD4052_TIMER_CONFIG_300KSPS));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return regmap_write(st->regmap, AD4052_REG_ADC_MODES, val);
> +}
> +
> +static irqreturn_t ad4052_irq_handler_thresh(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +
> +	iio_push_event(indio_dev,
> +		       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
> +					    IIO_EV_TYPE_THRESH,
> +					    IIO_EV_DIR_EITHER),
> +		       iio_get_time_ns(indio_dev));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ad4052_irq_handler_drdy(int irq, void *private)
> +{
> +	struct ad4052_state *st = private;
> +
> +	complete(&st->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ad4052_request_irq(struct iio_dev *indio_dev)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	int ret = 0;
> +
> +	ret = fwnode_irq_get_byname(dev_fwnode(&st->spi->dev), "gp0");
> +	if (ret <= 0)
> +		return ret ? ret : -EINVAL;
> +
> +	ret = devm_request_threaded_irq(dev, ret, NULL,
> +					ad4052_irq_handler_thresh,
> +					IRQF_ONESHOT, indio_dev->name,
> +					indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = fwnode_irq_get_byname(dev_fwnode(&st->spi->dev), "gp1");
> +	if (ret <= 0)
> +		return ret ? ret : -EINVAL;
> +
> +	st->gp1_irq = ret;
> +	return devm_request_threaded_irq(dev, ret, NULL,
> +					 ad4052_irq_handler_drdy,
> +					 IRQF_ONESHOT, indio_dev->name,
> +					 st);
> +}
> +
> +static const int ad4052_oversampling_avail[] = {
> +	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096,
> +};
> +
> +static int ad4052_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, const int **vals,
> +			     int *type, int *len, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = ad4052_oversampling_avail;
> +		*len = ARRAY_SIZE(ad4052_oversampling_avail);
> +		*type = IIO_VAL_INT;
> +
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int __ad4052_read_chan_raw(struct ad4052_state *st, int *val)
> +{
> +	struct spi_device *spi = st->spi;
> +	int ret;
> +	struct spi_transfer t_cnv = {
> +		.len = 0
> +	};
> +
> +	reinit_completion(&st->completion);
> +
> +	if (st->cnv_gp) {
> +		gpiod_set_value_cansleep(st->cnv_gp, 1);
> +		gpiod_set_value_cansleep(st->cnv_gp, 0);
> +	} else {
> +		ret = spi_sync_transfer(spi, &t_cnv, 1);
> +		if (ret)
> +			return ret;
> +	}
> +	/*
> +	 * Single sample read should be used only for oversampling and
> +	 * sampling frequency pairs that take less than 1 sec.
> +	 */
> +	ret = wait_for_completion_timeout(&st->completion,
> +					  msecs_to_jiffies(1000));
> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	ret = spi_sync_transfer(spi, &st->xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	if (st->xfer.len == 2) {
> +		*val = be16_to_cpu(st->d16);
> +		if (st->data_format & AD4052_ADC_MODES_DATA_FORMAT)
> +			*val = sign_extend32(*val, 15);
> +	} else {
> +		*val = be32_to_cpu(st->d32);
> +		if (st->data_format & AD4052_ADC_MODES_DATA_FORMAT)
> +			*val = sign_extend32(*val, 23);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad4052_read_chan_raw(struct iio_dev *indio_dev, int *val)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(&st->spi->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4052_set_operation_mode(st, st->mode);
> +	if (ret)
> +		goto out_error;
> +
> +	ret = __ad4052_read_chan_raw(st, val);
> +	if (ret)
> +		goto out_error;
> +
> +	ret = ad4052_exit_command(st);
> +
> +out_error:
> +	pm_runtime_mark_last_busy(&st->spi->dev);
> +	pm_runtime_put_autosuspend(&st->spi->dev);
> +	return ret;
> +}
> +
> +static int ad4052_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	struct pwm_state pwm_st;
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	if (st->wait_event) {
> +		iio_device_release_direct(indio_dev);
> +		return -EBUSY;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ad4052_read_chan_raw(indio_dev, val);
> +		if (ret)
> +			goto out_release;
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = ad4052_get_oversampling_ratio(st, val);
> +		if (ret)
> +			goto out_release;
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = pwm_get_state_hw(st->cnv_pwm, &pwm_st);
> +		if (ret)
> +			goto out_release;
> +
> +		if (!pwm_st.enabled)
> +			pwm_get_state(st->cnv_pwm, &pwm_st);
> +
> +		*val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, pwm_st.period);

Is this the expected semantic? I.e. if the PWM isn't running report
sample freq assuming the last set period (or if the pwm wasn't set
before the configured period length set by the bootloader, or the value
specified in the device tree)?

> +
> +		ret = IIO_VAL_INT;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> [...]
> +static int ad4052_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	struct spi_offload_trigger_config config = {
> +		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
> +	};
> +	int ret;
> +
> +	if (st->wait_event)
> +		return -EBUSY;
> +
> +	ret = pm_runtime_resume_and_get(&st->spi->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4052_set_operation_mode(st, st->mode);
> +	if (ret)
> +		goto out_error;
> +
> +	ret = ad4052_update_xfer_offload(indio_dev, indio_dev->channels);
> +	if (ret)
> +		goto out_error;
> +
> +	/* SPI Offload handles the data ready irq */
> +	disable_irq(st->gp1_irq);
> +
> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &config);
> +	if (ret)
> +		goto out_offload_error;
> +
> +	ret = pwm_enable(st->cnv_pwm);
> +	if (ret)
> +		goto out_pwm_error;

pwm_enable() is another disguised pwm_get_state().

> +
> +	return 0;
> +
> +out_pwm_error:
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +out_offload_error:
> +	enable_irq(st->gp1_irq);
> +	spi_unoptimize_message(&st->offload_msg);
> +	ad4052_exit_command(st);
> +out_error:
> +	pm_runtime_mark_last_busy(&st->spi->dev);
> +	pm_runtime_put_autosuspend(&st->spi->dev);
> +
> +	return ret;
> +}

Best regards
Uwe

--hlofdy26eqw7ig5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgnD2kACgkQj4D7WH0S
/k4ETwf/cJI4IIJ6RfYiR3k8fnuzzdH8y4vmcG990vOHofKCHH1GIgPW5JMuMgJF
O5hcrYEJcq53HiNN+xZNL8UyP4nyFfpuig1byINnMVLKDO1fo7ApmC8tRsHRJl65
iCvHMN68H1z4PalMwVTksjrvXmJ8aox+gvZO18an6HDSDlQhmSSxyTZDJY8VeNxz
NNWljTK2GT/6l2AstlNesekXPcWbRvJ8jeXz5EwlQ3PpnxgzvysUpoBHTHA46q+V
SJTbdQPd6NJnu5yp4/39zLzLNLc5ow/bRAdotOJnbT9B4a2aF8tzZ/R+B9AQG1s0
hw2MmSZ+6SLfTRwuWBGK1+aLRmPXDg==
=gSg7
-----END PGP SIGNATURE-----

--hlofdy26eqw7ig5c--

