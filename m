Return-Path: <linux-pwm+bounces-8193-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPWmLxnYqWl5GAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8193-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 20:23:05 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF50F2176E1
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 20:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 428583013FD9
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 19:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE430DEB2;
	Thu,  5 Mar 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6Ohvbvh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E37308F0A;
	Thu,  5 Mar 2026 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738485; cv=none; b=nwtjHSlVkiLzOuIQcP3uyVstgrB497KJLAQrrlsUfDm4fGZXasNOMv1XoLhAZdqr/5oUBKDyS8NTTi4tiX+ak8K26m1zHvOi7itmB8nEjvyE6Pk0QDUad3IkRu6PFbFGlsPIezrNdzBT6hQdCn7OLFT7eblQA6bl0GwQ2YvWkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738485; c=relaxed/simple;
	bh=ZvZf9oMArKx4NsbpQdDg8H/ozTDCkeCO/N3r+LjJGTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4lAB0iXpYBDmjVQU17/tC2t8CX/6ZGfTak30iCoqBvevi18rZpqbnJlxM0KEpiRjVUcZtN7qOCeRpfQdwfGNcTaZyk/IcXsMkZy1xfYzwAQ0bytBlDt7ujpMoyg0iCQR+KScC/sWBAzIFuStv6qV5Od79Gte+Wu6oniX1X/a3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6Ohvbvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8908C2BC9E;
	Thu,  5 Mar 2026 19:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772738484;
	bh=ZvZf9oMArKx4NsbpQdDg8H/ozTDCkeCO/N3r+LjJGTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K6OhvbvhrvUUnyvzm7ThziiqZrLqP51Fc282xoDYAYUTtQaagTtpGS21UWLGuDzUa
	 xwmOENV93sUAOGQmwlK1A0fzmQnA38+OvmOHB3/voE4rEGrESvMbNpHrFKwZN7TFqr
	 HQUFEb0xfA3jTdfXMBDIrlTXkLwi60m4kUzK6tgKBkaTjyVzTNqv719EcSaCQxxR8i
	 yH4L55UOxRqw1D329LV2CaIgH0P9x3Wn7w4QCPAPG6JKOEQzvuLv9+igNsB21tk2sf
	 sySQw8sN3dxYTSCmONwmt4oLLBPHVzbf4TUc421BE0J2//mAJ+H8G9xgAQQQHgY1Xk
	 PdCppAh32RrcQ==
Date: Thu, 5 Mar 2026 19:21:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260305192113.5ea46240@jic23-huawei>
In-Reply-To: <20260305-ad4692-multichannel-sar-adc-driver-v1-3-336229a8dcc7@analog.com>
References: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
	<20260305-ad4692-multichannel-sar-adc-driver-v1-3-336229a8dcc7@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CF50F2176E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8193-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,analog.com:email]
X-Rspamd-Action: no action

On Thu, 05 Mar 2026 14:23:29 +0200
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add buffered capture support using the IIO triggered buffer framework.
> 
> For CNV Clock, CNV Burst, Autonomous and SPI Burst modes the GP0 pin
> is configured as DATA_READY output and an interrupt is registered on
> its falling edge. Each interrupt fires the trigger, which reads
> accumulated results from the internal accumulator registers via regmap.
> 
> For Manual Mode (pipelined SPI protocol) there is no DATA_READY
> signal, so an hrtimer-based IIO trigger is used instead. The timer
> period is derived from the requested sampling frequency and validated
> against the minimum SPI transfer time for the active channel count.

This needs an explanation of why you can't just use a normal hrtimer trigger.
Those always run the risk of being set too fast, but we normally don't care
about that corner case. We don't want to have the equivalent code in every
driver.

> The trigger handler walks the active scan mask issuing one 3-byte SPI
> transfer per channel (selecting the next channel while reading the
> previous result) and pushes samples to the IIO buffer.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

A few other comments inline.

> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> index dee8bc312d44..ab48f336e46c 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c

>  
> @@ -287,6 +294,8 @@ struct ad4691_state {
>  
>  	struct regulator_bulk_data	regulators[AD4691_NUM_REGULATORS];
>  
> +	struct iio_trigger		*trig;
> +
>  	enum ad4691_adc_mode		adc_mode;
>  
>  	int				vref;
> @@ -297,6 +306,8 @@ struct ad4691_state {
>  	 */
>  	struct mutex			lock;
>  
> +	/* hrtimer for MANUAL_MODE triggered buffer (non-offload) */
> +	struct hrtimer			sampling_timer;
>  	ktime_t				sampling_period;
>  
>  	/* DMA (thus cache coherency maintenance) may require the
> @@ -306,6 +317,11 @@ struct ad4691_state {
>  	 */
>  	unsigned char rx_data[ALIGN(3, sizeof(s64)) + sizeof(s64)]	__aligned(IIO_DMA_MINALIGN);
>  	unsigned char tx_data[ALIGN(3, sizeof(s64)) + sizeof(s64)]	__aligned(IIO_DMA_MINALIGN);
> +	/* Scan buffer for triggered buffer push (one sample + timestamp) */
> +	struct {
> +		u32 val;
> +		s64 ts __aligned(8);
> +	} scan __aligned(IIO_DMA_MINALIGN); 

Same question as earlier on whether we need more padding from aligning yet again.
Maybe we do for this one, I haven't checked.


>  };


> +
> +static irqreturn_t ad4691_irq(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +
> +	/*
> +	 * DATA_READY has asserted: stop conversions before reading so the
> +	 * accumulator does not continue sampling while the trigger handler
> +	 * processes the data. Then fire the IIO trigger to push the sample
> +	 * to the buffer.
> +	 *
> +	 * In direct (read_raw) mode the buffer is not enabled; read_raw uses
> +	 * a timed delay and stops conversions itself, so skip the trigger poll.
> +	 */
> +	ad4691_sampling_enable(st, false);
> +
> +	if (iio_buffer_enabled(indio_dev))

How did we get here otherwise?

> +		iio_trigger_poll(st->trig);
> +
> +	return IRQ_HANDLED;
> +}

> +
> +static irqreturn_t ad4691_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret, i;
> +
> +	mutex_lock(&st->lock);
> +
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		unsigned int prev_val;
> +		int prev_chan = -1;
> +
> +		/*
> +		 * MANUAL_MODE with CNV tied to CS: each transfer triggers a
> +		 * conversion AND returns the previous conversion's result.
> +		 * First transfer returns garbage, so we do N+1 transfers for
> +		 * N channels.
> +		 */
> +		iio_for_each_active_channel(indio_dev, i) {
> +			ret = ad4691_transfer(st, AD4691_ADC_CHAN(i), &val);
> +			if (ret)
> +				goto done;
> +
> +			/* Push previous channel's data (skip first - garbage) */
> +			if (prev_chan >= 0) {
> +				st->scan.val = prev_val;
> +				iio_push_to_buffers_with_ts(indio_dev,
> +					&st->scan, sizeof(st->scan),
> +					iio_get_time_ns(indio_dev));

We don't push one channel at a time... You need to build up a scan locally
and push it in one go.

> +			}
> +			prev_val = val;
> +			prev_chan = i;
> +		}
> +
> +		/* Final NOOP transfer to get last channel's data */
> +		ret = ad4691_transfer(st, AD4691_NOOP, &val);
> +		if (ret)
> +			goto done;
> +
> +		st->scan.val = val;
> +		iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
> +					    iio_get_time_ns(indio_dev));
> +		goto done;
> +	}
> +
> +	for (i = 0; i < st->chip->num_channels; i++) {
> +		if (BIT(i) & *indio_dev->active_scan_mask) {
> +			ret = regmap_read(st->regmap, AD4691_AVG_IN(i), &val);
> +			if (ret)
> +				goto done;
> +
> +			st->scan.val = val;
> +			iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
> +						    iio_get_time_ns(indio_dev));
As above.

> +		}
> +	}
> +
> +	regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_RESET_ALL);
> +
> +	/* START next conversion. */
> +	switch (st->adc_mode) {
> +	case AD4691_CNV_CLOCK_MODE:
> +	case AD4691_CNV_BURST_MODE:
> +	case AD4691_AUTONOMOUS_MODE:
> +	case AD4691_SPI_BURST_MODE:
> +		ad4691_sampling_enable(st, true);
> +		break;
> +	case AD4691_MANUAL_MODE:
> +	default:
> +		break;
> +	}
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +	mutex_unlock(&st->lock);

Why hold the lock over the notify done?  Having moved it up you can share the done label
code block and this one.

> +	return IRQ_HANDLED;
> +done:
> +	mutex_unlock(&st->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct iio_info ad4691_info = {
>  	.read_raw = &ad4691_read_raw,
>  	.read_avail = &ad4691_read_avail,
> @@ -1121,6 +1364,75 @@ static void ad4691_setup_channels(struct iio_dev *indio_dev,
>  	indio_dev->num_channels = st->chip->num_channels;
>  }
>  
> +static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
> +					 struct ad4691_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int irq, ret;
> +
> +	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +					  indio_dev->name,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "Failed to allocate IIO trigger\n");
> +
> +	st->trig->ops = &ad4691_trigger_ops;
> +	iio_trigger_set_drvdata(st->trig, st);
> +
> +	ret = devm_iio_trigger_register(dev, st->trig);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "IIO trigger register failed\n");
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	switch (st->adc_mode) {
> +	case AD4691_CNV_CLOCK_MODE:
> +	case AD4691_CNV_BURST_MODE:
> +	case AD4691_AUTONOMOUS_MODE:
> +	case AD4691_SPI_BURST_MODE:
> +		/*
> +		 * DATA_READY asserts at end-of-conversion (or when the
> +		 * accumulator fills in AUTONOMOUS_MODE). The IRQ handler stops
> +		 * conversions and fires the IIO trigger so the trigger handler
> +		 * can read and push the sample to the buffer.
> +		 */
> +		irq = fwnode_irq_get_byname(dev_fwnode(dev), "DRDY");
> +		if (irq <= 0)
> +			return dev_err_probe(dev, irq ? irq : -ENOENT,
> +					     "failed to get DRDY interrupt\n");
> +
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						&ad4691_irq,
> +						IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
Interrupt direction is a question for firmware. A driver should
not be setting it. We have some historical bugs in this area that we can't
fix because board maybe relying on the driver overriding but we don't want to
introduce more of them!
> +						indio_dev->name, indio_dev);


