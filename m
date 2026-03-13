Return-Path: <linux-pwm+bounces-8254-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LvQAmPxs2nYdgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8254-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 12:13:39 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC0528208B
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 12:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E014300B866
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC84375F85;
	Fri, 13 Mar 2026 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nk4bbAFJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039B4377EA9;
	Fri, 13 Mar 2026 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400401; cv=none; b=VmJyiuvUubn9/Wq0tAAu/40PJZlO3i83z6ri5CRfq6+oYqqWx4ckgDDUYlgp+iXaLnkpiR1UxJtjmfktU6CXV3s/fY+69VDMtiqHsbVKhwAzFbHNaKx9RPJMdLKXHQbqkCegwprjhvj1cuGs2uCbWJVWHt5MLHN8CAuVn0ii558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400401; c=relaxed/simple;
	bh=EJHBeujEDulfWj2dGzLhht2vIW4Neha+cukrkdqydn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNF/sURFa6j4ILQ3BKkQhccpLuKy59Jw344kyayXxnM/mfsjehYhFcq0LV3OFT6VRbN/+cBWIhzV2p6WLgGYzxlP9w0StFb7Hld6r2QC37bpGacFqOou5ZMYcyI43hfLx5vovCD6PLTa7EuXo1oCGWKhjP7AiUs2XbeBDHSHOmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nk4bbAFJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773400400; x=1804936400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EJHBeujEDulfWj2dGzLhht2vIW4Neha+cukrkdqydn4=;
  b=nk4bbAFJYYK0C5E2p6TDQ7sF8SwBh7Mag2lFi/2v4c+RZRUrQR2b2FXZ
   uaAIa0Qwo4tNZFwam5wIRLbYCDjkzR/Sq6Ie0jqN8ikecHq5d4n0Wzjq4
   pkrwVi2SvcIz1V1ye2mw79/FoYkLpUj/cCwkXvNc/tsaja9+v5Ba0WznQ
   4TcolOrz5Rhcz4VlVNKt8MhwfHLvcWeZzHr2RegSkD7Wx7xGsBLiEQzVO
   GQqWG3J5tgF2AeBvil5pcAZqmaVnj6Dpt1jbB/LTUqvXEsQm88NdKcaas
   Xlf2VPrzG0mR/7aVMRaAOmdlReHt7gIMg7ypRAr+EhMmLZmZOpIDIAXoA
   A==;
X-CSE-ConnectionGUID: xtk+jVNKSZCXK6FsDujsRg==
X-CSE-MsgGUID: aNcQJ6I9RpScfl6kbEnJFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74473839"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74473839"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 04:13:20 -0700
X-CSE-ConnectionGUID: PDPhjYsdRIiso0T+XB1mgg==
X-CSE-MsgGUID: a3pAEM41TOe4p4HSeQ+NMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225588573"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 04:13:15 -0700
Date: Fri, 13 Mar 2026 13:13:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: adc: ad4691: add triggered buffer support
Message-ID: <abPxR0TVa70sMg38@ashevche-desk.local>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-3-b4d14d81a181@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313-ad4692-multichannel-sar-adc-driver-v3-3-b4d14d81a181@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8254-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: 8CC0528208B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 12:07:27PM +0200, Radu Sabau via B4 Relay wrote:

> Add buffered capture support using the IIO triggered buffer framework.
> 
> Both operating modes share a single IIO trigger and trigger handler.
> The handler builds a complete scan — one u32 slot per channel at its
> scan_index position, followed by a timestamp — and pushes it to the
> IIO buffer in a single iio_push_to_buffers_with_ts() call.
> 
> For CNV Clock Mode the GP0 pin is configured as DATA_READY output. The
> IRQ handler stops conversions and fires the IIO trigger; the trigger
> handler reads accumulated results from the AVG_IN registers via regmap
> and restarts conversions for the next cycle.
> 
> For Manual Mode there is no DATA_READY signal; CNV is tied to SPI CS
> so conversions are triggered by CS assertion rather than by a dedicated
> pin. The standard iio-trig-hrtimer module is not used because the timer
> period must be derived from the SPI clock rate and the number of active
> channels: the pipelined protocol requires N+1 SPI transfers per scan
> (the first result is garbage and is discarded), so the minimum period
> depends on both the SPI speed and the live channel count at buffer
> enable time. A driver-private hrtimer whose period is recomputed by
> buffer_postenable is simpler and avoids requiring the user to configure
> an external trigger with the correct hardware-derived period.
> 
> Manual mode channels use storagebits=32 (shift=8, realbits=16) so all
> channel slots in the scan buffer are uniformly sized regardless of the
> SPI wire format (24-bit transfer, 16-bit ADC data in bits[23:8]).

...

>  #include <linux/device.h>
>  #include <linux/err.h>

>  #include <linux/reset.h>

This is unordered.

> +#include <linux/hrtimer.h>
>  #include <linux/interrupt.h>
>  #include <linux/math.h>
>  #include <linux/module.h>

...

> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>

>  

Unneeded blank line.

> -#define AD4691_ACC_COUNT_VAL			0x3F
> +#define AD4691_ACC_COUNT_VAL			0x01

No ping-pong, and actually this was not used at all. So, make sure you add
constants when they are really started being used.

>  #define AD4691_GPIO_MODE1_REG			0x196
>  #define AD4691_GPIO_MODE2_REG			0x197
>  #define AD4691_GPIO_READ			0x1A0

...

>  static const struct iio_chan_spec ad4691_manual_channels[] = {
> -	AD4691_CHANNEL(0, 0, 16, 24, 8),
> -	AD4691_CHANNEL(1, 1, 16, 24, 8),
> -	AD4691_CHANNEL(2, 2, 16, 24, 8),
> -	AD4691_CHANNEL(3, 3, 16, 24, 8),
> -	AD4691_CHANNEL(4, 4, 16, 24, 8),
> -	AD4691_CHANNEL(5, 5, 16, 24, 8),
> -	AD4691_CHANNEL(6, 6, 16, 24, 8),
> -	AD4691_CHANNEL(7, 7, 16, 24, 8),
> -	AD4691_CHANNEL(8, 8, 16, 24, 8),
> -	AD4691_CHANNEL(9, 9, 16, 24, 8),
> -	AD4691_CHANNEL(10, 10, 16, 24, 8),
> -	AD4691_CHANNEL(11, 11, 16, 24, 8),
> -	AD4691_CHANNEL(12, 12, 16, 24, 8),
> -	AD4691_CHANNEL(13, 13, 16, 24, 8),
> -	AD4691_CHANNEL(14, 14, 16, 24, 8),
> -	AD4691_CHANNEL(15, 15, 16, 24, 8)
> +	AD4691_CHANNEL(0, 0, 16, 32, 8),
> +	AD4691_CHANNEL(1, 1, 16, 32, 8),
> +	AD4691_CHANNEL(2, 2, 16, 32, 8),
> +	AD4691_CHANNEL(3, 3, 16, 32, 8),
> +	AD4691_CHANNEL(4, 4, 16, 32, 8),
> +	AD4691_CHANNEL(5, 5, 16, 32, 8),
> +	AD4691_CHANNEL(6, 6, 16, 32, 8),
> +	AD4691_CHANNEL(7, 7, 16, 32, 8),
> +	AD4691_CHANNEL(8, 8, 16, 32, 8),
> +	AD4691_CHANNEL(9, 9, 16, 32, 8),
> +	AD4691_CHANNEL(10, 10, 16, 32, 8),
> +	AD4691_CHANNEL(11, 11, 16, 32, 8),
> +	AD4691_CHANNEL(12, 12, 16, 32, 8),
> +	AD4691_CHANNEL(13, 13, 16, 32, 8),
> +	AD4691_CHANNEL(14, 14, 16, 32, 8),
> +	AD4691_CHANNEL(15, 15, 16, 32, 8)
>  };
>  
>  static const struct iio_chan_spec ad4693_manual_channels[] = {
> -	AD4691_CHANNEL(0, 0, 16, 24, 8),
> -	AD4691_CHANNEL(1, 1, 16, 24, 8),
> -	AD4691_CHANNEL(2, 2, 16, 24, 8),
> -	AD4691_CHANNEL(3, 3, 16, 24, 8),
> -	AD4691_CHANNEL(4, 4, 16, 24, 8),
> -	AD4691_CHANNEL(5, 5, 16, 24, 8),
> -	AD4691_CHANNEL(6, 6, 16, 24, 8),
> -	AD4691_CHANNEL(7, 7, 16, 24, 8)
> +	AD4691_CHANNEL(0, 0, 16, 32, 8),
> +	AD4691_CHANNEL(1, 1, 16, 32, 8),
> +	AD4691_CHANNEL(2, 2, 16, 32, 8),
> +	AD4691_CHANNEL(3, 3, 16, 32, 8),
> +	AD4691_CHANNEL(4, 4, 16, 32, 8),
> +	AD4691_CHANNEL(5, 5, 16, 32, 8),
> +	AD4691_CHANNEL(6, 6, 16, 32, 8),
> +	AD4691_CHANNEL(7, 7, 16, 32, 8)
>  };

Hold on, you just introduced them in the first patch. Are those wrong?!
Please, fix this mess and make sure you have no - (minus) lines from
the previous patch(es).

...

> +	/*
> +	 * DMA (thus cache coherency maintenance) may require the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	unsigned char rx_data[ALIGN(3, sizeof(s64)) + sizeof(s64)]	__aligned(IIO_DMA_MINALIGN);
> +	unsigned char tx_data[ALIGN(3, sizeof(s64)) + sizeof(s64)];

Don't we have macro for this?

...

> +static int ad4691_transfer(struct ad4691_state *st, int command,

Signed 'command'? Why?

> +			   unsigned int *val)

...

> +static int ad4691_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct spi_device *spi = to_spi_device(dev);
> +	u16 mask = ~(*indio_dev->active_scan_mask);

> +	u32 acc_mask[2] = { mask & 0xFF, mask >> 8 };

Same Q as per previous patch. This seems very wrong.

> +	int n_active = hweight_long(*indio_dev->active_scan_mask);

Why signed?

> +	unsigned int bit;
> +	int ret;
> +
> +	ret = ad4691_enter_conversion_mode(st);
> +	if (ret)
> +		return ret;
> +
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		u64 min_period_ns;
> +
> +		/* N+1 transfers needed for N channels, with 50% overhead */
> +		min_period_ns = div64_u64((u64)(n_active + 1) * AD4691_BITS_PER_XFER *
> +					  NSEC_PER_SEC * 3,
> +					  spi->max_speed_hz * 2);
> +
> +		if (ktime_to_ns(st->sampling_period) < min_period_ns) {
> +			dev_err(dev,
> +				"Sampling period %lld ns too short for %d channels. Min: %llu ns\n",
> +				ktime_to_ns(st->sampling_period), n_active,
> +				min_period_ns);
> +			return -EINVAL;
> +		}
> +
> +		hrtimer_start(&st->sampling_timer, st->sampling_period,
> +			      HRTIMER_MODE_REL);
> +		return 0;
> +	}
> +
> +	/* CNV_CLOCK_MODE: configure sequencer and start PWM */
> +	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +			   AD4691_STATE_RESET_ALL);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_write(st->regmap, AD4691_ACC_MASK1_REG, acc_mask, 2);

sizeof()? ARRAY_SIZE()? See comments per previous patch.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   *indio_dev->active_scan_mask);
> +	if (ret)
> +		return ret;
> +
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		ret = regmap_write(st->regmap, AD4691_ACC_COUNT_LIMIT(bit),
> +				   AD4691_ACC_COUNT_VAL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ad4691_sampling_enable(st, true);
> +}

...

> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int val, i;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		unsigned int prev_val;
> +		int prev_chan = -1;
> +
> +		/*
> +		 * MANUAL_MODE with CNV tied to CS: each transfer triggers a
> +		 * conversion AND returns the previous conversion's result.
> +		 * First transfer returns garbage, so we do N+1 transfers for
> +		 * N channels. Collect all results into scan.vals[], then push
> +		 * the complete scan once.
> +		 */
> +		iio_for_each_active_channel(indio_dev, i) {
> +			ret = ad4691_transfer(st, AD4691_ADC_CHAN(i), &val);
> +			if (ret)
> +				goto done;
> +
> +			if (prev_chan >= 0)
> +				st->scan.vals[prev_chan] = prev_val;
> +			prev_val = val;
> +			prev_chan = i;
> +		}
> +
> +		/* Final NOOP transfer to retrieve last channel's result */
> +		ret = ad4691_transfer(st, AD4691_NOOP, &val);
> +		if (ret)
> +			goto done;

> +		st->scan.vals[prev_chan] = val;

How do you guarantee that prev_chan never ever be -1 here?

> +	} else {
> +		iio_for_each_active_channel(indio_dev, i) {
> +			ret = regmap_read(st->regmap, AD4691_AVG_IN(i), &val);
> +			if (ret)
> +				goto done;
> +
> +			st->scan.vals[i] = val;
> +		}
> +
> +		regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_RESET_ALL);
> +
> +		/* Restart conversions for the next trigger cycle. */
> +		ad4691_sampling_enable(st, true);
> +	}
> +
> +	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
> +				    pf->timestamp);
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}

...

>  static int ad4691_config(struct ad4691_state *st)
>  {
>  	struct device *dev = regmap_get_device(st->regmap);
> +	struct spi_device *spi = to_spi_device(dev);
>  	enum ad4691_ref_ctrl ref_val;
>  	unsigned int reg_val;
>  	int ret;

>  		st->adc_mode = AD4691_MANUAL_MODE;
>  		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
>  			AD4691_MANUAL_MODE_STD_FREQ(st->chip->num_channels,
> -				to_spi_device(dev)->max_speed_hz)));
> +						    spi->max_speed_hz)));
>  	}

Okay, this should be part of the previous patch.

>  	return regmap_write(st->regmap, AD4691_GPIO_MODE1_REG, AD4691_ADC_BUSY);
>  }

...

> +static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
> +					 struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct spi_device *spi = to_spi_device(dev);
> +	int irq, ret;
> +
> +	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +					  indio_dev->name,
> +					  iio_device_id(indio_dev));

It seems you ignored some of my comments. Please go back and read carefully
what I commented on previous version of the series.

> +	if (!st->trig)
> +		return -ENOMEM;
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
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		/*
> +		 * No DATA_READY signal in MANUAL_MODE; CNV is tied to CS so
> +		 * conversions start with each SPI transfer. Use an hrtimer to
> +		 * schedule periodic reads.
> +		 */
> +		hrtimer_setup(&st->sampling_timer, ad4691_sampling_timer_handler,
> +			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST_ULL(
> +			NSEC_PER_SEC,
> +			AD4691_MANUAL_MODE_STD_FREQ(st->chip->num_channels,
> +						    spi->max_speed_hz)));
> +	} else {
> +		/*
> +		 * DATA_READY asserts at end-of-conversion. The IRQ handler
> +		 * stops conversions and fires the IIO trigger so the trigger
> +		 * handler can read and push the sample to the buffer.
> +		 */
> +		irq = fwnode_irq_get(dev_fwnode(dev), 0);
> +		if (irq < 0)
> +			return dev_err_probe(dev, irq,
> +					     "failed to get DATA_READY interrupt\n");
> +
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						&ad4691_irq,
> +						IRQF_ONESHOT,
> +						indio_dev->name, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					       &iio_pollfunc_store_time,
> +					       &ad4691_trigger_handler,
> +					       &ad4691_buffer_setup_ops);
> +}

-- 
With Best Regards,
Andy Shevchenko



