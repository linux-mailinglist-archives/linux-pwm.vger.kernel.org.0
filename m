Return-Path: <linux-pwm+bounces-8235-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OeiDV/UsWk2FgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8235-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 21:45:19 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A17AA26A202
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 21:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B2A3301469C
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 20:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454AC23A9B3;
	Wed, 11 Mar 2026 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mb/P+Jfe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6840DFBF;
	Wed, 11 Mar 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261916; cv=none; b=M1TMv01bDKqzGV7pPz3y2JlIm0LpMc71apMQCYmGJ6MaurJjh73G4OBrvDHckt+Yq1jXsMRMw3IF5jFEvcMnF2tE1PZoKzs5Dp0upoPQzR7++yZTV4/RfilTvXLDxm9yFunWyFkRKlpDZJvoDc8yeSxz+/ryRW/6RoZqJKcXXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261916; c=relaxed/simple;
	bh=6TRekZdvkbd9f0OpdlQPRDHF/IQMHeW26AhV4m0RVqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPTnfABWfvnY7IRgVPTa5ut1tOEui5E7hTIGPtt9jEgJYtR09K4/xTtGHXFqy+zpu0smGqwgzhXBA3ezQHgb6/li8H/W/1T8/aOn6ONJ3etAkRZ09cwmdMEqIMOaI4zcZFiIxkffuvXKb19KzaVIUKgXSeZN7XsT/LUVxZ8qB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mb/P+Jfe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773261914; x=1804797914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6TRekZdvkbd9f0OpdlQPRDHF/IQMHeW26AhV4m0RVqk=;
  b=mb/P+JfeVyelfzw7AiNUz4Eb9k9mcXgsE93uLkzlBzl5NJfepDg2+IeO
   MRKiyIjEEMPjA0+APsIMP+ePKOPNJSbXAWTsa4A+GfPF39co7G9UMHPsZ
   vEp0G7p9bs6p7YmD+jiB3e1gajyoCBHZm4SKwGU/ijlDKqJaktZLTOW39
   2zDJ/ijUdGOeaVxtc8iJYo3/hu1nNtiqZ2y6QFTL/Pjo2FAXvDDZNyJMI
   Ryl5/mO+1evUUdqcmUnbvtSddDxOXDL0F1cv+NwtqTXWcYxnfa5iSXi5h
   Tm7uJX33BkF6smE6o23SR/vT9AY7EJaLh/F98IjP5OOkR4SSwrL01zmgX
   w==;
X-CSE-ConnectionGUID: 4erqmlwaS4+Gv4hZxHW6qg==
X-CSE-MsgGUID: m1CLzGBZSeu5GcgFwoKtRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="76954947"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="76954947"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 13:45:13 -0700
X-CSE-ConnectionGUID: BUdD0TjMR5CWvEEeezl0VQ==
X-CSE-MsgGUID: CyhqjCyUQaqA/taXcDBdRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225053019"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 13:45:08 -0700
Date: Wed, 11 Mar 2026 22:45:04 +0200
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: adc: ad4691: add SPI offload support
Message-ID: <abHUUPlcoDPtZF4v@ashevche-desk.local>
References: <20260310-ad4692-multichannel-sar-adc-driver-v2-0-d9bb8aeb5e17@analog.com>
 <20260310-ad4692-multichannel-sar-adc-driver-v2-4-d9bb8aeb5e17@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-ad4692-multichannel-sar-adc-driver-v2-4-d9bb8aeb5e17@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8235-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: A17AA26A202
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 04:32:25PM +0200, Radu Sabau via B4 Relay wrote:

> Add SPI offload support to enable DMA-based, CPU-independent data
> acquisition using the SPI Engine offload framework.
> 
> When an SPI offload is available (devm_spi_offload_get() succeeds),
> the driver registers a DMA engine IIO buffer and uses dedicated buffer
> setup operations. If no offload is available the existing software
> triggered buffer path is used unchanged.
> 
> Both CNV Clock Mode and Manual Mode support offload, but use different
> trigger mechanisms:
> 
> CNV Clock Mode: the SPI Engine is triggered by the ADC's DATA_READY
> signal on GP0. For this mode the driver acts as both an SPI offload
> consumer (DMA RX stream, message optimization) and a trigger source
> provider: it registers the GP0/DATA_READY output via
> devm_spi_offload_trigger_register() so the offload framework can
> match the '#trigger-source-cells' phandle from the device tree and
> automatically fire the SPI Engine DMA transfer at end-of-conversion.
> The pre-built SPI message reads all active channels from the AVG_IN
> accumulator registers (2-byte address + 2-byte data per channel,
> one 4-byte transfer each) followed by a state reset word to re-arm
> the accumulator for the next cycle.
> 
> Manual Mode: the SPI Engine is triggered by a periodic trigger at
> the configured sampling frequency. The pre-built SPI message uses
> the pipelined CNV-on-CS protocol: N+1 4-byte transfers are issued
> for N active channels (the first result is discarded as garbage from
> the pipeline flush) and the remaining N results are captured by DMA.
> 
> All offload transfers use 32-bit frames (bits_per_word=32, len=4) for
> DMA word alignment. In Manual Mode the 4-byte DMA word layout is
> [dummy(8), data_hi(8), data_lo(8), extra(8)]; the channel scan type
> storagebits=32, shift=8, realbits=16 correctly extracts the 16-bit
> ADC result from the middle two bytes.
> 
> Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.

...

> +			st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST_ULL
> +				(NSEC_PER_SEC, freq));

Bad indentation.

...

> +static int ad4691_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	struct spi_offload_trigger_config config = { };
> +	struct spi_offload_trigger *trigger;
> +	struct spi_transfer *xfer = st->offload_xfer;
> +	int ret, num_xfers = 0;
> +	int active_chans[16];
> +	unsigned int bit;
> +	int n_active = 0;
> +	int i;
> +
> +	memset(xfer, 0, sizeof(st->offload_xfer));
> +
> +	/* Collect active channels in scan order */
> +	iio_for_each_active_channel(indio_dev, bit)
> +		active_chans[n_active++] = bit;
> +
> +	ret = ad4691_enter_conversion_mode(st);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * MANUAL_MODE uses a periodic (PWM) trigger and reads directly from
> +	 * the ADC. CNV_CLOCK_MODE uses the DATA_READY trigger and reads from
> +	 * accumulators.
> +	 */
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		config.type = SPI_OFFLOAD_TRIGGER_PERIODIC;
> +		config.periodic.frequency_hz = st->offload_trigger_hz;
> +		trigger = st->offload_trigger_periodic;
> +		if (!trigger)
> +			return -EINVAL;
> +	} else {
> +		ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +				   AD4691_STATE_RESET_ALL);
> +		if (ret)
> +			return ret;

> +		/* Configure accumulator masks - 0 = enabled, 1 = masked */
> +		ret = regmap_write(st->regmap, AD4691_ACC_MASK1_REG,
> +				   ~(*indio_dev->active_scan_mask) & 0xFF);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD4691_ACC_MASK2_REG,
> +				   ~(*indio_dev->active_scan_mask >> 8) & 0xFF);
> +		if (ret)
> +			return ret;

Why bulk write can't be used?

> +		/* Configure sequencer with active channels */
> +		ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +				   *indio_dev->active_scan_mask);
> +		if (ret)
> +			return ret;
> +
> +		iio_for_each_active_channel(indio_dev, bit) {
> +			ret = regmap_write(st->regmap, AD4691_ACC_COUNT_LIMIT(bit),
> +					   AD4691_ACC_COUNT_VAL);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		config.type = SPI_OFFLOAD_TRIGGER_DATA_READY;
> +		trigger = st->offload_trigger;
> +	}
> +
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		/*
> +		 * Manual mode with CNV tied to CS: Each CS toggle triggers a
> +		 * conversion AND reads the previous conversion result (pipeline).
> +		 */
> +		for (i = 0; i < n_active; i++) {
> +			st->offload_tx_cmd[num_xfers] = AD4691_ADC_CHAN(active_chans[i]) << 24;
> +			xfer[num_xfers].tx_buf = &st->offload_tx_cmd[num_xfers];
> +			xfer[num_xfers].len = 4;
> +			xfer[num_xfers].bits_per_word = 32;
> +			xfer[num_xfers].speed_hz = st->spi->max_speed_hz;
> +			xfer[num_xfers].cs_change = 1;
> +			xfer[num_xfers].cs_change_delay.value = 1000;
> +			xfer[num_xfers].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
> +			/* First transfer RX is garbage - don't capture it */
> +			if (num_xfers)
> +				xfer[num_xfers].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +			num_xfers++;
> +		}
> +
> +		/* Final NOOP to flush pipeline and get last channel's data */
> +		st->offload_tx_cmd[num_xfers] = AD4691_NOOP << 24;
> +		xfer[num_xfers].tx_buf = &st->offload_tx_cmd[num_xfers];
> +		xfer[num_xfers].len = 4;
> +		xfer[num_xfers].bits_per_word = 32;
> +		xfer[num_xfers].speed_hz = st->spi->max_speed_hz;
> +		xfer[num_xfers].cs_change = 0;
> +		xfer[num_xfers].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +		num_xfers++;
> +	} else {
> +		/*
> +		 * CNV_CLOCK_MODE: single transfer per channel (2-byte cmd +
> +		 * 2-byte data = 4 bytes, one 32-bit SPI Engine DMA word).
> +		 * AVG_IN registers are used; RX layout: [cmd_hi, cmd_lo, d_hi, d_lo]
> +		 */
> +		for (i = 0; i < n_active; i++) {
> +			unsigned int reg;
> +			int ch = active_chans[i];
> +
> +			reg = AD4691_AVG_IN(ch);
> +			st->offload_tx_cmd[ch] =
> +				((reg >> 8) | 0x80) << 24 |
> +				(reg & 0xFF) << 16;

Use proper put_unaligned() and friends.

> +			xfer[num_xfers].tx_buf = &st->offload_tx_cmd[ch];
> +			xfer[num_xfers].len = 4;
> +			xfer[num_xfers].bits_per_word = 32;
> +			xfer[num_xfers].speed_hz = st->spi->max_speed_hz;
> +			xfer[num_xfers].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +			xfer[num_xfers].cs_change = 1;
> +			num_xfers++;
> +		}
> +
> +		/*
> +		 * State reset: clear accumulator so DATA_READY can fire again.
> +		 * With bits_per_word=32, SPI engine transmits MSB first.
> +		 */
> +		st->offload_tx_reset = ((AD4691_STATE_RESET_REG >> 8) << 24) |
> +				       ((AD4691_STATE_RESET_REG & 0xFF) << 16) |
> +				       (0x01 << 8);

Ditto.

> +
> +		xfer[num_xfers].tx_buf = &st->offload_tx_reset;
> +		xfer[num_xfers].len = 4;
> +		xfer[num_xfers].bits_per_word = 32;
> +		xfer[num_xfers].speed_hz = st->spi->max_speed_hz;
> +		xfer[num_xfers].cs_change = 0;
> +		num_xfers++;
> +	}
> +
> +	if (num_xfers == 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * For MANUAL_MODE, validate that the trigger frequency is low enough
> +	 * for all SPI transfers to complete. Each transfer is 32 bits.
> +	 * Add 50% margin for CS setup/hold and other overhead.
> +	 */
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		u64 min_period_ns;
> +		u64 trigger_period_ns;
> +
> +		/* Time for all transfers in nanoseconds, with 50% overhead margin */
> +		min_period_ns = div64_u64((u64)num_xfers * AD4691_OFFLOAD_BITS_PER_WORD *
> +					  NSEC_PER_SEC * 3,
> +					  st->spi->max_speed_hz * 2);
> +
> +		trigger_period_ns = div64_u64(NSEC_PER_SEC, st->offload_trigger_hz);

Why 64-bit division? The dividend is 32-bit value.

> +		if (trigger_period_ns < min_period_ns)
> +			return -EINVAL;
> +	}
> +
> +	spi_message_init_with_transfers(&st->offload_msg, xfer, num_xfers);
> +	st->offload_msg.offload = st->offload;
> +
> +	ret = spi_optimize_message(st->spi, &st->offload_msg);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * For CNV_CLOCK_MODE, start conversions before enabling the trigger.
> +	 * If the trigger is enabled first, the SPI engine blocks waiting for
> +	 * DATA_READY, and any subsequent SPI write times out.
> +	 *
> +	 * MANUAL_MODE: CNV is tied to CS; conversion starts with each transfer.
> +	 */
> +	if (st->adc_mode == AD4691_CNV_CLOCK_MODE) {
> +		ret = ad4691_sampling_enable(st, true);
> +		if (ret)
> +			goto err_unoptimize_message;
> +	}
> +
> +	ret = spi_offload_trigger_enable(st->offload, trigger, &config);
> +	if (ret)
> +		goto err_sampling_disable;
> +
> +	return 0;
> +
> +err_sampling_disable:
> +	if (st->adc_mode == AD4691_CNV_CLOCK_MODE)
> +		ad4691_sampling_enable(st, false);
> +err_unoptimize_message:
> +	spi_unoptimize_message(&st->offload_msg);
> +	return ret;
> +}

...

> +	st->offload = devm_spi_offload_get(dev, spi, &ad4691_offload_config);

	ret = PTR_ERR_OR_ZERO(...); ?

> +	if (IS_ERR(st->offload)) {
> +		if (PTR_ERR(st->offload) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(st->offload),
> +					     "failed to get SPI offload\n");
> +		st->offload = NULL;
> +	}

	if (ret == -ENODEV)
		->offload = NULL;
	else if (ret)
		return dev_err_probe(...);

-- 
With Best Regards,
Andy Shevchenko



