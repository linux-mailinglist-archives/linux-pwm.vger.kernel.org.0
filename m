Return-Path: <linux-pwm+bounces-5724-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F458A9DC17
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Apr 2025 18:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEFDB7B5045
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Apr 2025 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8C525D1EF;
	Sat, 26 Apr 2025 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQhIRSNU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82EC7081F;
	Sat, 26 Apr 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745683394; cv=none; b=pYDvArcefx2JRkRIcKFzB2QKsVANBkvV1z+99Fw9UyqCW0v0cNqN3ACUym5bKskOrgnO4fGcstMcDxE7UOLWSlyCiBWzpAtyb792E0geZicD+XN31yzL+K8bFEv9KbgVpNtAM9G8PckYM0nSVnyF2wsUNXmgvBJ4h370McRWXfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745683394; c=relaxed/simple;
	bh=aNCpu1GTXkTZ8yigL0hnXXHDY/VPpMBNeMp4GLdNY2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dc3V+YrocUto1HrmFyvIMc8Kz242esZFnK/Tp96cDsGhceNZmvjsO9PfH4Pl9CQHpKsqn7mA8hYRntKbpwfT83AcCNhVgYCJ5fyjopTzcnoVaVD+9B5+jKydbT9id/Yi1QqVVzxgn37/bbpVcffjINKorez7FbHxJ2dGiyChBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQhIRSNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687CEC4CEE2;
	Sat, 26 Apr 2025 16:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745683393;
	bh=aNCpu1GTXkTZ8yigL0hnXXHDY/VPpMBNeMp4GLdNY2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MQhIRSNUbK2/Zbkf+6NayszLIs3WyHCCym0rzouYuAX2U1LBiTtwml9Jjy3GQIWU7
	 FX+VhNR0O2vO3xRVnkKxilYeEy7lQ43WVKx+7nY0KoDE+9RC/mBL/jgJ4ltm+HnwoL
	 /OEpPEdzDnFRRErFwzB05l/pUPAVf2iLNnynC30Nec2x9tayvyNXUh6yO+Y6T5Xaia
	 IolihGvCXTeNdpkWbU6UNiqMlJkoyXAHqAkL5Zr/Av64qkJeXPc2RTP0MxU0TkxOcp
	 C3FhMLjQ9dNUUjuYjkNyMVdtpwgd93Jnb24o0tAKwGfC9rS6/i8D/+2aM5btBxRmce
	 eIkHmnGSGgoQg==
Date: Sat, 26 Apr 2025 17:03:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] iio: adc: add support for ad4052
Message-ID: <20250426170302.02bdf844@jic23-huawei>
In-Reply-To: <20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
	<20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 13:34:50 +0200
Jorge Marques <jorge.marques@analog.com> wrote:

> The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit,
> successive approximation register (SAR) analog-to-digital converter (ADC)
> that enables low-power, high-density data acquisition solutions without
> sacrificing precision.
> This ADC offers a unique balance of performance and power efficiency,
> plus innovative features for seamlessly switching between high-resolution
> and low-power modes tailored to the immediate needs of the system.
> The AD4052/AD4058/AD4050/AD4056 are ideal for battery-powered,
> compact data acquisition and edge sensing applications.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Hi Jorge,

A few additional comments from me.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ad4052.c b/drivers/iio/adc/ad4052.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f412f0884bab4f500091f6c7ca761967c8f6e3b6
> --- /dev/null
> +++ b/drivers/iio/adc/ad4052.c
> @@ -0,0 +1,1425 @@


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
> +
> +		ret = IIO_VAL_INT;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +out_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}


> +static int ad4052_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int val,
> +				    int val2)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +	u8 reg, size = 1;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;

Sometimes it is worth a n internal function factored out in cases
like this to allow direct returns in error cases with the release
always happening before we check if the inner function failed.

That suggestion applies in other places in this code.
> +
> +	if (st->wait_event) {
> +		iio_device_release_direct(indio_dev);
> +		return -EBUSY;
> +	}
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			if (st->data_format & AD4052_ADC_MODES_DATA_FORMAT) {
> +				if (val > 2047 || val < -2048)
> +					goto out_release;
> +			} else if (val > 4095 || val < 0) {
> +				goto out_release;
> +			}
> +			if (dir == IIO_EV_DIR_RISING)
> +				reg = AD4052_REG_MAX_LIMIT;
> +			else
> +				reg = AD4052_REG_MIN_LIMIT;
> +			size = 2;
> +			st->d16 = cpu_to_be16(val);
> +			break;
> +		case IIO_EV_INFO_HYSTERESIS:
> +			if (val & BIT(7))
> +				goto out_release;
> +			if (dir == IIO_EV_DIR_RISING)
> +				reg = AD4052_REG_MAX_HYST;
> +			else
> +				reg = AD4052_REG_MIN_HYST;
> +			st->d16 = cpu_to_be16(val >> 8);
> +			break;
> +		default:
> +			goto out_release;
> +		}
> +		break;
> +	default:
> +		goto out_release;
> +	}
> +
> +	ret = regmap_bulk_write(st->regmap, reg, &st->d16, size);
> +
> +out_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}
> +
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
> +
> +	return 0;
> +
> +out_pwm_error:
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +out_offload_error:
> +	enable_irq(st->gp1_irq);
> +	spi_unoptimize_message(&st->offload_msg);
> +	ad4052_exit_command(st);

What is this matching to?  Feels like it would be set_operation_mode()
but I may be wrong on that.  If it is then you need another label
to call only this update_xfer_offload fails.

> +out_error:
> +	pm_runtime_mark_last_busy(&st->spi->dev);
> +	pm_runtime_put_autosuspend(&st->spi->dev);
> +
> +	return ret;
> +}

> +static int ad4052_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +				     unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	if (st->wait_event) {
> +		iio_device_release_direct(indio_dev);
Probably use a goto to release this in only one place.

> +		return -EBUSY;
> +	}
> +
> +	if (readval)
> +		ret = regmap_read(st->regmap, reg, readval);
> +	else
> +		ret = regmap_write(st->regmap, reg, writeval);
> +
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}
> +
> +static int ad4052_get_current_scan_type(const struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))

This is the bit I'm not really following. Why is the enabling or not of
the buffer related to whether offload is going on?


> +		return st->mode == AD4052_BURST_AVERAGING_MODE ?
> +				   AD4052_SCAN_TYPE_OFFLOAD_BURST_AVG :
> +				   AD4052_SCAN_TYPE_OFFLOAD_SAMPLE;
> +
> +	return st->mode == AD4052_BURST_AVERAGING_MODE ?
> +			   AD4052_SCAN_TYPE_BURST_AVG :
> +			   AD4052_SCAN_TYPE_SAMPLE;
> +}


> +static int ad4052_probe(struct spi_device *spi)
> +{
...

> +
> +	st->mode = AD4052_SAMPLE_MODE;
> +	st->wait_event = false;
> +	st->chip = chip;
> +	st->grade = chip->prod_id <= 0x75 ? AD4052_2MSPS : AD4052_500KSPS;

That feels like it should be encoded directly in chip.  Basing it
on prod_id seems liable to bite us at somepoint in the future.




> +
> +static int ad4052_runtime_resume(struct device *dev)
> +{
> +	struct ad4052_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG,
> +			   FIELD_PREP(AD4052_DEVICE_CONFIG_POWER_MODE_MSK, 0));
> +	return ret;

	return regmap_write();
and no need for the local variable ret.

> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(ad4052_pm_ops, ad4052_runtime_suspend,
> +				 ad4052_runtime_resume, NULL);

