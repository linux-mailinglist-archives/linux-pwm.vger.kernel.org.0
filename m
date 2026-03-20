Return-Path: <linux-pwm+bounces-8316-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJHSFD6BvWk4+gIAu9opvQ
	(envelope-from <linux-pwm+bounces-8316-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 18:17:50 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC632DE72E
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 18:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4218D304038B
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F5A3CEBB2;
	Fri, 20 Mar 2026 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQKdlWMW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BEE1EB9E1;
	Fri, 20 Mar 2026 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026470; cv=none; b=RVFa6uAdtHD6Jov0wbBEG0Euwkx7ODgmksfD5dc9id71pGc80Ki1N9eiKiF/+c2GIxgNJu7cRF6xvwVP23CcU8791SdIQEgfRzyVv+Ln1ejwG3cPJ70YWWsTjigB+FvhXtQNvOs3nKVIhWhD3gk2tWT7IRg7DPzjb0e2QyyJ3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026470; c=relaxed/simple;
	bh=K0n7PtbZscSYHZTpNewnpXiO3uLV59cevvAXQJ8i2OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n74aBNj46RnR1BQtro6PiGUS92dufIeY5npDIHlkXtrgLZNxnP4E44FZdzpvcE1pXmO90aR98gx4m6jl84saVOpU2rchClnyTF1EgOImsFe2gpj+I8npuRpwRRRxF+4UOUOUPG+QvQrSijtrB0LeHflM//4/fC7XQO2apre+xN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQKdlWMW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774026468; x=1805562468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K0n7PtbZscSYHZTpNewnpXiO3uLV59cevvAXQJ8i2OM=;
  b=WQKdlWMWSb3nlkrVtDEeQMXeCAgyWjblrCggpWBaiMhSwhNzKtoAAeKG
   wnP6ubW62nmxoaP/e9jVGRdgIMC5DRgbisuiMmGBA3P8OKzIOqovmdxeH
   JMaVUb9dfrdxzTzyTDULiXCWSpqh1n7PbsC1oQ6/k2clW1Fn3UUaZvwKV
   xCqJPGCZ4fK8qaBOvEmWtZ3RzISo/LsYIZY+fCkT64JspToO21B1H1jrq
   Rmw7skXED0yBvTtR3m9q33ww0Pk0AVcFtNGyyJDEtPmi2PB0zYaBKU7BU
   SLI600VYfyGg2N2yXBGbDDZXCS0MscG6/nJYGvtxRbFZgb4vGZ3IdBTOr
   A==;
X-CSE-ConnectionGUID: hhQSw12nTUC7l+Zb/cVuxw==
X-CSE-MsgGUID: xHQs4iaDRgSLpFSXX3K3rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75308976"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75308976"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:07:47 -0700
X-CSE-ConnectionGUID: QfBlZzGeSyC3Ltz6/lwk4Q==
X-CSE-MsgGUID: WSo707w0QICSzzyU2iq/fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="228066475"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:07:42 -0700
Date: Fri, 20 Mar 2026 19:07:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: radu.sabau@analog.com, Wolfram Sang <wsa+renesas@sang-engineering.com>
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
Subject: Re: [PATCH v4 4/4] iio: adc: ad4691: add SPI offload support
Message-ID: <ab1-3FLCDbu_iEQt@ashevche-desk.local>
References: <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
 <20260320-ad4692-multichannel-sar-adc-driver-v4-4-052c1050507a@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-4-052c1050507a@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8316-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,renesas,dt];
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: 9AC632DE72E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 01:03:58PM +0200, Radu Sabau via B4 Relay wrote:

> Add SPI offload support to enable DMA-based, CPU-independent data
> acquisition using the SPI Engine offload framework.
> 
> When an SPI offload is available (devm_spi_offload_get() succeeds),
> the driver registers a DMA engine IIO buffer and uses dedicated buffer
> setup operations. If no offload is available the existing software
> triggered buffer path is used unchanged.
> 
> Both CNV Burst Mode and Manual Mode support offload, but use different
> trigger mechanisms:
> 
> CNV Burst Mode: the SPI Engine is triggered by the ADC's DATA_READY
> signal on the GP pin specified by the trigger-source consumer reference
> in the device tree (one cell = GP pin number 0-3). For this mode the
> driver acts as both an SPI offload consumer (DMA RX stream, message
> optimization) and a trigger source provider: it registers the
> GP/DATA_READY output via devm_spi_offload_trigger_register() so the
> offload framework can match the '#trigger-source-cells' phandle and
> automatically fire the SPI Engine DMA transfer at end-of-conversion.
> 
> Manual Mode: the SPI Engine is triggered by a periodic trigger at
> the configured sampling frequency. The pre-built SPI message uses
> the pipelined CNV-on-CS protocol: N+1 4-byte transfers are issued
> for N active channels (the first result is discarded as garbage from
> the pipeline flush) and the remaining N results are captured by DMA.
> 
> All offload transfers use 32-bit frames (bits_per_word=32, len=4) for
> DMA word alignment. This patch promotes the channel scan_type from
> storagebits=16 (triggered-buffer path) to storagebits=32 to match the
> DMA word size; the triggered-buffer paths are updated to the same layout
> for consistency. CNV Burst Mode channel data arrives in the lower 16
> bits of the 32-bit word (shift=0); Manual Mode data arrives in the upper
> 16 bits (shift=16), matching the 4-byte SPI transfer layout
> [data_hi, data_lo, 0, 0]. A separate ad4691_manual_channels[] array
> encodes the shift=16 scan type for manual mode.
> 
> Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.

...

> +	struct spi_offload		*offload;
> +	/* SPI offload trigger - periodic (MANUAL) or DATA_READY (CNV_BURST) */
> +	struct spi_offload_trigger	*offload_trigger;
> +	u64				offload_trigger_hz;
> +	struct spi_message		offload_msg;
> +	/* Max 16 channel xfers + 1 state-reset or NOOP */
> +	struct spi_transfer		offload_xfer[17];
> +	u32				offload_tx_cmd[17];
> +	u32				offload_tx_reset;

Ouch! Can you guarantee this kilobytes (isn't it?) of memory will be used in
majority of the cases? When I got comment on replacing a single u8 by unsigned
long in one well used data structure in the kernel I was laughing, but this
single driver may beat the recode of memory waste on the embedded platforms.
Perhaps having a separate structure and allocate it separately when we sure
the offload is supported?

Cc'ed to Wolfram.

...

> +	/* Scan buffer: one slot per channel (u32) plus timestamp */
>  	struct {
> -		u16 vals[16];
> +		u32 vals[16];
>  		s64 ts __aligned(8);

This might break the existing cases or make code ugly and not actually
compatible with u32 layout.

>  	} scan __aligned(IIO_DMA_MINALIGN);

...

> +static int ad4691_cnv_burst_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct spi_offload_trigger_config config = {
> +		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
> +	};

> +	unsigned int n_active = hweight_long(*indio_dev->active_scan_mask);

Should be bitmap_weight() with properly given amount of bits.


> +	unsigned int bit, k;
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> +			   (u16)~(*indio_dev->active_scan_mask));

This is not how we work with bitmaps. Use bitmap_read().

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   *indio_dev->active_scan_mask);

Ditto.

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
> +	ret = ad4691_enter_conversion_mode(st);
> +	if (ret)
> +		return ret;
> +
> +	memset(st->offload_xfer, 0, sizeof(st->offload_xfer));
> +
> +	/*
> +	 * N transfers to read N AVG_IN registers plus one state-reset
> +	 * transfer (no RX) to re-arm DATA_READY.
> +	 *   TX: [reg_hi | 0x80, reg_lo, 0x00, 0x00]
> +	 *   RX: [0x00, 0x00, data_hi, data_lo]   (shift=0)
> +	 */
> +	k = 0;
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		unsigned int reg = AD4691_AVG_IN(bit);
> +
> +		st->offload_tx_cmd[k] =

> +			cpu_to_be32(((reg >> 8 | 0x80) << 24) |
> +				    ((reg & 0xFF) << 16));

Isn't this is just a cpu_to_be16(0x8000 | reg) ?

> +		st->offload_xfer[k].tx_buf = &st->offload_tx_cmd[k];
> +		st->offload_xfer[k].len = sizeof(u32);
> +		st->offload_xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
> +		st->offload_xfer[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +		if (k < n_active - 1)
> +			st->offload_xfer[k].cs_change = 1;
> +		k++;
> +	}
> +
> +	/* State reset to re-arm DATA_READY for the next scan. */
> +	st->offload_tx_reset =
> +		cpu_to_be32(((AD4691_STATE_RESET_REG >> 8) << 24) |
> +			    ((AD4691_STATE_RESET_REG & 0xFF) << 16) |
> +			    (AD4691_STATE_RESET_ALL << 8));

In similar way

		cpu_to_be32((AD4691_STATE_RESET_REG << 16) |
			    (AD4691_STATE_RESET_ALL << 8));

> +	st->offload_xfer[k].tx_buf = &st->offload_tx_reset;
> +	st->offload_xfer[k].len = sizeof(u32);
> +	st->offload_xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
> +	k++;
> +
> +	spi_message_init_with_transfers(&st->offload_msg, st->offload_xfer, k);
> +	st->offload_msg.offload = st->offload;
> +
> +	ret = spi_optimize_message(spi, &st->offload_msg);
> +	if (ret)
> +		goto err_exit_conversion;
> +
> +	ret = ad4691_sampling_enable(st, true);
> +	if (ret)
> +		goto err_unoptimize;
> +
> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger, &config);
> +	if (ret)
> +		goto err_sampling_disable;
> +
> +	return 0;
> +
> +err_sampling_disable:
> +	ad4691_sampling_enable(st, false);
> +err_unoptimize:
> +	spi_unoptimize_message(&st->offload_msg);
> +err_exit_conversion:
> +	ad4691_exit_conversion_mode(st);
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko



