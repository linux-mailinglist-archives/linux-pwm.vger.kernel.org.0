Return-Path: <linux-pwm+bounces-8325-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJC9KDO6vmksYgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8325-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 16:33:07 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB362E61F1
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 16:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECF34300EF95
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0633932D7;
	Sat, 21 Mar 2026 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z05nrdxJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C033921FF;
	Sat, 21 Mar 2026 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774106943; cv=none; b=iRwEp0eB+Ld2VQmSRPW9qp3EN3h6H1R6c9Puo1P3nCkafJH9HN3+F4wv81workQl8mNJnjXs4lJmehAD8Vugm1owZfh+GYiBrvQKRgMU3RgRScXUc9L287gRYf5/ryElcXDUGgcijkoBYIcRG2BYKVyhILaHjFzDxk7aijYXp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774106943; c=relaxed/simple;
	bh=K6c44afHm4wAtDFoNyFzTRXJPGQI0mZfKrFyfkVgxJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mi9fNlPYMI4WJB2QlaRMIb91OaJ4Ghiq1ojHcTHv4G4U5MVunKo9/q6DX6v/FizAwjkOaa/muwaSRmZEV8MsrTZEy1zDpU//JiG0Aam7ck3fXNm3ESjvJmrm9spez4ZqqSZ7KSa1SDEKPBGxMUQeKhxQHQN2Wy7pIQ+jGXYpNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z05nrdxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574B2C19421;
	Sat, 21 Mar 2026 15:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774106942;
	bh=K6c44afHm4wAtDFoNyFzTRXJPGQI0mZfKrFyfkVgxJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z05nrdxJQ434cDusWakmG5P21Jw8UJsLgbvf2i3c9ccQEywTHRqCfHpveEnvzrWfC
	 pzC+4xygMILpbmxVCrW5fZkQq8n/sPMB+2zneC4L/Ed9SBSfPEDbi7zaq66pdN6Zl8
	 GeymeLaz90thjkkPnNtt2fTWnXJ0iNsf7YgvnCpy5AhzHFXfdsUCryoZFLKTgABvY0
	 7DKogH1jXwcJELeeB266WqWrhFIJf2RldN9WZvus5fjCVo1RXUa2aTW2BadMCKmSCy
	 bPekbpptq5qBqpZpxOsR6UHl1nLRoKh1qyiGsoDCFtqPrvWS+bDXH8Vl5rGpAr1d2x
	 oGZjFj/nF5dbg==
Date: Sat, 21 Mar 2026 15:28:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: adc: ad4691: add SPI offload support
Message-ID: <20260321152850.3f335d7c@jic23-huawei>
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-4-052c1050507a@analog.com>
References: <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
	<20260320-ad4692-multichannel-sar-adc-driver-v4-4-052c1050507a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8325-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0BB362E61F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 13:03:58 +0200
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
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
> for consistency. 

That's quite a large cost for the kfifo sizing, particularly if timestamps
are enabled. I think I'd prefer we kept the exiting paths using 16 bit data
storage for each channel.

> CNV Burst Mode channel data arrives in the lower 16
> bits of the 32-bit word (shift=0); Manual Mode data arrives in the upper
> 16 bits (shift=16), matching the 4-byte SPI transfer layout
> [data_hi, data_lo, 0, 0]. A separate ad4691_manual_channels[] array
> encodes the shift=16 scan type for manual mode.

That's odd - but fair enough if that's what the IP ends up doing.

> 
> Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

Various other minor comments inline.

> -#define AD4691_CHANNEL(ch)						\
> +/*
> + * 16-bit ADC data is stored in 32-bit slots to match the SPI offload DMA
> + * word size (32 bits per transfer). The shift reflects the data position

As mentioned elsewhere, I don't think we care about matching the offload
layout. Lots of existing drivers don't and if we can we want to minimize
wasted space whilst still keep the data naturally aligned to make accesses easy.

> + * within the 32-bit word:
> + *   CNV_BURST: RX = [dummy, dummy, data_hi, data_lo] -> shift = 0
> + *   MANUAL:    RX = [data_hi, data_lo, dummy, dummy] -> shift = 16
> + * The triggered-buffer paths store data in the same position for consistency.
> + * Do not "fix" storagebits to 16.
> + */
> +#define AD4691_CHANNEL(ch, _shift)					\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.indexed = 1,						\
> @@ -118,40 +140,72 @@ struct ad4691_chip_info {
>  		.scan_type = {						\
>  			.sign = 'u',					\
>  			.realbits = 16,					\
> -			.storagebits = 16,				\
> -			.shift = 0,					\
> +			.storagebits = 32,				\
> +			.shift = _shift,				\
>  		},							\
>  	}

> @@ -227,9 +285,9 @@ struct ad4691_state {
>  	 */
>  	struct mutex			lock;
>  	/*
> -	 * Per-buffer-enabl ree lifetimesources:
> -	 * Manual Mode - a pre-built SPI message that clocks out N+1
> -	 *		 transfers in one go.
> +	 * Per-buffer-enable lifetime resources (triggered-buffer paths):
> +	 * Manual Mode    - a pre-built SPI message that clocks out N+1
> +	 *		    transfers in one go.
>  	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
>  	 *		    transfers in one go.
>  	 */
> @@ -238,9 +296,19 @@ struct ad4691_state {
>  	struct spi_transfer		*scan_xfers;
>  	__be16				*scan_tx;
>  	__be16				*scan_rx;
> -	/* Scan buffer: one slot per channel (u16) plus timestamp */
> +	/* SPI offload DMA path resources */
> +	struct spi_offload		*offload;
> +	/* SPI offload trigger - periodic (MANUAL) or DATA_READY (CNV_BURST) */
> +	struct spi_offload_trigger	*offload_trigger;
> +	u64				offload_trigger_hz;
> +	struct spi_message		offload_msg;
> +	/* Max 16 channel xfers + 1 state-reset or NOOP */
> +	struct spi_transfer		offload_xfer[17];
> +	u32				offload_tx_cmd[17];

Andy already commented on this being large.  Allocating separately
probably makes sense.

> +	u32				offload_tx_reset;
> +	/* Scan buffer: one slot per channel (u32) plus timestamp */
>  	struct {
> -		u16 vals[16];
> +		u32 vals[16];
>  		s64 ts __aligned(8);
>  	} scan __aligned(IIO_DMA_MINALIGN);
>  };


> +static int ad4691_cnv_burst_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct spi_offload_trigger_config config = {
> +		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
> +	};
> +	unsigned int n_active = hweight_long(*indio_dev->active_scan_mask);
> +	unsigned int bit, k;
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> +			   (u16)~(*indio_dev->active_scan_mask));
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

This is an odd looking construct. Maybe it's worth casting offload_tx_cmd[k] to
a u8 * and just filling the two bytes in directly.

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
Similar to above. Feels like we should be manipulating this as a u8[4]

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


