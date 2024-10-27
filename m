Return-Path: <linux-pwm+bounces-3923-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE749B1C98
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Oct 2024 10:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14010B2123A
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Oct 2024 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6CE55E73;
	Sun, 27 Oct 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib8qUhc3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B145948;
	Sun, 27 Oct 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730020373; cv=none; b=YQ1OwpPTijpMaoficIOKSw2D79ZgKaylJ0ADTBa2xO/Jhvsio5qghvJvGo49qgkjaoUC/MtUm8uKJm0ZVJFw+VYse0G5VFMNPcTQcsms8WEovGSmyxNqT4peKq8P/YqSPByBPMNLDrl8YEOWRcViPOdBhqLidTI+yFDw0rzD/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730020373; c=relaxed/simple;
	bh=vYmaaCF0O9kxNZGZuSUUPa9U+zrGwPci9G+GBw7A13U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gy27p9Jm77mUQZssiXlFirBQVuXr+MfHwsARPanT/MUW0eVri9uc6r9QhAlk3Ufk+QCjUSXgdrt8fxA+28D6NnX9YFi/FL/KaC1ad0IJFFtB2F8bBXWEkCucR/QtMZDJmB4gMXUCdsX+8aixLGLTeycXPhTm6Ew1oxMxJ5JL+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib8qUhc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156BDC4CEC3;
	Sun, 27 Oct 2024 09:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730020373;
	bh=vYmaaCF0O9kxNZGZuSUUPa9U+zrGwPci9G+GBw7A13U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ib8qUhc3gZ6m2kQ9mBHGW3P9PZeAETEToShpTwEJ4itJhDvOYHqyc13Doz3bYA1g7
	 F0kd2HV/eVj3keu+DBtr/Wrxs7b2GiRNHV3HI+RL+GEu8Dl27u3JDPcOWuqg1M7DSM
	 qKVeM/5xIRIYS22Gh9gpogurtjGBq78jG+S9mxxoJwl5+MFSK+g3h1SFsgFaEeRLDZ
	 SkI/WuLlhAQF54l7Dq5V7vMDUGFtxDxDARTH1UtxOX1uQUgUgVyoVujCesZS7PZ35C
	 deU1SmTANrMTcbAMsSjo3TWdLkKiWfNw6prD+7KoaPV2WPRcXe40wMyvSsPdonHqA1
	 dFMA2Zdh4g2Ww==
Date: Sun, 27 Oct 2024 09:12:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC v4 15/15] iio: adc: ad4695: Add support for SPI
 offload
Message-ID: <20241027091244.2fe3c0ad@jic23-huawei>
In-Reply-To: <5a090847-ee53-41be-ad28-b7604cf9020a@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	<20241023-dlech-mainline-spi-engine-offload-2-v4-15-f8125b99f5a1@baylibre.com>
	<20241026170038.4b629cff@jic23-huawei>
	<5a090847-ee53-41be-ad28-b7604cf9020a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 19:01:53 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/26/24 11:00 AM, Jonathan Cameron wrote:
> > On Wed, 23 Oct 2024 15:59:22 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> Add support for SPI offload to the ad4695 driver. SPI offload allows
> >> sampling data at the max sample rate (500kSPS or 1MSPS).
> >>
> >> This is developed and tested against the ADI example FPGA design for
> >> this family of ADCs [1].
> >>
> >> [1]: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>  
> > A few questions inline. In general looks ok, but it's complex code and I'm
> > too snowed under for a very close look at the whole thing for a least a few weeks.
> > 
> > Jonathan
> >   
> >> ---
> >>  drivers/iio/adc/Kconfig  |   1 +
> >>  drivers/iio/adc/ad4695.c | 470 +++++++++++++++++++++++++++++++++++++++++++----
> >>  2 files changed, 440 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> >> index 92dfb495a8ce..f76a3f62a9ad 100644
> >> --- a/drivers/iio/adc/Kconfig
> >> +++ b/drivers/iio/adc/Kconfig
> >> @@ -53,6 +53,7 @@ config AD4695
> >>  	depends on SPI
> >>  	select REGMAP_SPI
> >>  	select IIO_BUFFER
> >> +	select IIO_BUFFER_DMAENGINE
> >>  	select IIO_TRIGGERED_BUFFER
> >>  	help
> >>  	  Say yes here to build support for Analog Devices AD4695 and similar  
> >   
> >> +static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
> >> +{
> >> +	struct ad4695_state *st = iio_priv(indio_dev);
> >> +	struct spi_offload_trigger_config config = {
> >> +		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
> >> +	};
> >> +	struct spi_transfer *xfer = &st->buf_read_xfer[0];
> >> +	struct pwm_state state;
> >> +	u8 temp_chan_bit = st->chip_info->num_voltage_inputs;
> >> +	u8 num_slots = 0;
> >> +	u8 temp_en = 0;
> >> +	unsigned int bit;
> >> +	int ret;
> >> +
> >> +	iio_for_each_active_channel(indio_dev, bit) {
> >> +		if (bit == temp_chan_bit) {
> >> +			temp_en = 1;
> >> +			continue;
> >> +		}
> >> +
> >> +		ret = regmap_write(st->regmap, AD4695_REG_AS_SLOT(num_slots),
> >> +				   FIELD_PREP(AD4695_REG_AS_SLOT_INX, bit));
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		num_slots++;
> >> +	}
> >> +
> >> +	/*
> >> +	 * For non-offload, we could discard data to work around this
> >> +	 * restriction, but with offload, that is not possible.
> >> +	 */
> >> +	if (num_slots < 2) {
> >> +		dev_err(&st->spi->dev,
> >> +			"At least two voltage channels must be enabled.\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	ret = regmap_update_bits(st->regmap, AD4695_REG_TEMP_CTRL,
> >> +				 AD4695_REG_TEMP_CTRL_TEMP_EN,
> >> +				 FIELD_PREP(AD4695_REG_TEMP_CTRL_TEMP_EN,
> >> +					    temp_en));
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* Each BUSY event means just one sample for one channel is ready. */
> >> +	memset(xfer, 0, sizeof(*xfer));
> >> +	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> >> +	xfer->bits_per_word = 16;
> >> +	xfer->len = 2;
> >> +
> >> +	spi_message_init_with_transfers(&st->buf_read_msg, xfer, 1);
> >> +	st->buf_read_msg.offload = st->offload;
> >> +
> >> +	st->spi->max_speed_hz = st->spi_max_speed_hz;
> >> +	ret = spi_optimize_message(st->spi, &st->buf_read_msg);
> >> +	st->spi->max_speed_hz = AD4695_REG_ACCESS_SCLK_HZ;
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/*
> >> +	 * NB: technically, this is part the SPI offload trigger enable, but it
> >> +	 * doesn't work to call it from the offload trigger enable callback
> >> +	 * due to issues with ordering with respect to entering/exiting
> >> +	 * conversion mode.  
> > Give some detail on the operations order.
> >   
> >> +	 */
> >> +	ret = regmap_set_bits(st->regmap, AD4695_REG_GP_MODE,
> >> +			      AD4695_REG_GP_MODE_BUSY_GP_EN);
> >> +	if (ret)
> >> +		goto err_unoptimize_message;
> >> +
> >> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> >> +					 &config);
> >> +	if (ret)
> >> +		goto err_disable_busy_output;
> >> +
> >> +	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
> >> +	if (ret)
> >> +		goto err_offload_trigger_disable;
> >> +
> >> +	guard(mutex)(&st->cnv_pwm_lock);
> >> +	pwm_get_state(st->cnv_pwm, &state);
> >> +	/*
> >> +	 * PWM subsystem generally rounds down, so requesting 2x minimum high
> >> +	 * time ensures that we meet the minimum high time in any case.
> >> +	 */
> >> +	state.duty_cycle = AD4695_T_CNVH_NS * 2;
> >> +	ret = pwm_apply_might_sleep(st->cnv_pwm, &state);
> >> +	if (ret)
> >> +		goto err_offload_exit_conversion_mode;
> >> +
> >> +	return 0;
> >> +
> >> +err_offload_exit_conversion_mode:
> >> +	/* have to unwind in a different order to avoid triggering offload */  
> > 
> > Needs more details here.
> >   
> >> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> >> +	ad4695_cnv_manual_trigger(st);
> >> +	ad4695_exit_conversion_mode(st);
> >> +	goto err_disable_busy_output;
> >> +
> >> +err_offload_trigger_disable:
> >> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> >> +
> >> +err_disable_busy_output:
> >> +	regmap_clear_bits(st->regmap, AD4695_REG_GP_MODE,
> >> +			  AD4695_REG_GP_MODE_BUSY_GP_EN);
> >> +
> >> +err_unoptimize_message:
> >> +	spi_unoptimize_message(&st->buf_read_msg);
> >> +
> >> +	return ret;
> >> +}  
> >   
> >> +
> >>  static int ad4695_write_raw(struct iio_dev *indio_dev,
> >>  			    struct iio_chan_spec const *chan,
> >>  			    int val, int val2, long mask)
> >> @@ -779,6 +992,17 @@ static int ad4695_write_raw(struct iio_dev *indio_dev,
> >>  			default:
> >>  				return -EINVAL;
> >>  			}
> >> +		case IIO_CHAN_INFO_SAMP_FREQ: {
> >> +			struct pwm_state state;
> >> +
> >> +			if (val <= 0)
> >> +				return -EINVAL;
> >> +
> >> +			guard(mutex)(&st->cnv_pwm_lock);
> >> +			pwm_get_state(st->cnv_pwm, &state);  
> > 
> > What limits this to rates the ADC can cope with?
> >   
> >> +			state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, val);
> >> +			return pwm_apply_might_sleep(st->cnv_pwm, &state);
> >> +		}
> >>  		default:
> >>  			return -EINVAL;
> >>  		}  
> >   
> >>  static int ad4695_probe(struct spi_device *spi)
> >>  {
> >>  	struct device *dev = &spi->dev;
> >>  	struct ad4695_state *st;
> >>  	struct iio_dev *indio_dev;
> >> -	struct gpio_desc *cnv_gpio;
> >>  	bool use_internal_ldo_supply;
> >>  	bool use_internal_ref_buffer;
> >>  	int ret;
> >>  
> >> -	cnv_gpio = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
> >> -	if (IS_ERR(cnv_gpio))
> >> -		return dev_err_probe(dev, PTR_ERR(cnv_gpio),
> >> -				     "Failed to get CNV GPIO\n");
> >> -
> >> -	/* Driver currently requires CNV pin to be connected to SPI CS */
> >> -	if (cnv_gpio)
> >> -		return dev_err_probe(dev, -ENODEV,
> >> -				     "CNV GPIO is not supported\n");
> >> -
> >>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> >>  	if (!indio_dev)
> >>  		return -ENOMEM;
> >> @@ -1002,8 +1374,13 @@ static int ad4695_probe(struct spi_device *spi)
> >>  		return -EINVAL;
> >>  
> >>  	/* Registers cannot be read at the max allowable speed */
> >> +	st->spi_max_speed_hz = spi->max_speed_hz;
> >>  	spi->max_speed_hz = AD4695_REG_ACCESS_SCLK_HZ;
> >>  
> >> +	ret = devm_add_action_or_reset(dev, ad4695_restore_spi_max_speed_hz, st);  
> > 
> > Why do you need to put it back in devm? What happens after this but without
> > a driver restart that uses that faster rate?
> >   
> I should have added a comment here as this was a weird bug to trace.
> 
> The core SPI framework sets the initial value of spi->max_speed_hz
> to the minimum of the controller max rate and the max rate specified
> by the devicetree.
> 
> The SPI device lives beyond this driver, so if we bind the driver
> and set spi->max_speed_hz to something other than what the SPI core
> set it, then the next time we bind the driver, we don't get the
> the max rate from the SPI core, but rather we changed it to when
> the driver unbound.
> 
> So on the second bind, the max rate would be the slow register
> read rate instead of the actual max allowable rate.
> 
> So we need to reset spi->max_speed_hz to what it was originally
> on driver unbind so that everything works as expected on the
> next bind.
> 
> (Or we call this a SPI core bug and fix it there instead).
Definitely a question to ask.  Directly accessing spi_max_speed_hz may
be the fundamental issue as I don't think the driver is generally
expected to touch that in a dynamic fashion.  Should we be instead setting it
per transfer for the ones that need it controlled?

Jonathan



> 


