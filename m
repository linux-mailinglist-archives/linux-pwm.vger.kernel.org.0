Return-Path: <linux-pwm+bounces-8560-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M3wKBfd22lMHgkAu9opvQ
	(envelope-from <linux-pwm+bounces-8560-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 19:57:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4108D3E546F
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 19:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D5333018AEC
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C7F3624CF;
	Sun, 12 Apr 2026 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0wdgmfL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE9E2F12CF;
	Sun, 12 Apr 2026 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016593; cv=none; b=WLNfES0jgdhKg7Ob8Pavfc0dZga1yBggV3582WgBuE0xlgDLyidRN5xaHTax23KXm4qIXaKaA2kniQ0165xvxeauo2CO3qfDDMsYjCSDveOhEn1ekNRrG2H3eLU8cTQSMFapXLVmvhEQQxSxbHoroQRdTuxI6QA1NyLKBwhJaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016593; c=relaxed/simple;
	bh=ZH2xmfRZ6G5E0Z3i/WYuhZZTh+s6+LY0DlBanLVI+8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfE7ZYVQ4cm7F2IAlkLa77M6oEvY5pdR74lsj6n7SXrmjNaCrheoZuwJYXAzsa5fYCKlKTfNW6Mr6ULqSSi4g8RB+TspZj4rBO+lFOd8zQoFWUoPK3WOBKit7tVRKelyijXDdvVr+xRYeUD1CgrEmNb0ONwXODIgB8DLKBxQpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0wdgmfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E36C19424;
	Sun, 12 Apr 2026 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776016593;
	bh=ZH2xmfRZ6G5E0Z3i/WYuhZZTh+s6+LY0DlBanLVI+8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B0wdgmfLA2+nguCIFApE+Cjl05PPFLjYEdVjXLDZOEa14PX3kDsg2r1+vhn7z7uoS
	 QVfoL/N8C1GW/KVDotJOy96K2IZpVIE4WN7Er6frPSMVAspyzENp+Ubza7xcevCIEj
	 yzI9LkDhulj4QMrjBbCMM5y/e6SvkDeFw5lZbjglP+X56U1WaKJ3IB/nSndl6S4ZoD
	 JC9ZFflOAeytvKVaNJdBLbVjn/DrWV53ah6VC1yzx4I2/SkTos26OpQM/cKAo/wC2M
	 SSjrq5KlQy4Qlgkqw3iGsqzvdYqlHNIA7Cbk5BECd2j2KppvV8wL7czM1h9t0rSE5q
	 rsSNICUg4wHLA==
Date: Sun, 12 Apr 2026 18:56:19 +0100
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
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 4/6] iio: adc: ad4691: add SPI offload support
Message-ID: <20260412185619.5584fca9@jic23-huawei>
In-Reply-To: <20260409-ad4692-multichannel-sar-adc-driver-v7-4-be375d4df2c5@analog.com>
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
	<20260409-ad4692-multichannel-sar-adc-driver-v7-4-be375d4df2c5@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8560-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4108D3E546F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 09 Apr 2026 18:28:25 +0300
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
> the pipelined CNV-on-CS protocol: N+1 16-bit transfers are issued
> for N active channels (the first result is discarded as garbage from
> the pipeline flush) and the remaining N results are captured by DMA.
> 
> All offload transfers use 16-bit frames (bits_per_word=16, len=2).
> The channel scan_type (storagebits=16, shift=0, IIO_BE) is shared
> between the software triggered-buffer and offload paths; no separate
> scan_type or channel array is needed for the offload case. The
> ad4691_manual_channels[] array introduced in the triggered-buffer
> commit is reused here: it hides the IIO_CHAN_INFO_OVERSAMPLING_RATIO
> attribute, which is not applicable in Manual Mode.
> 
> Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

A few comments inline.

> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> index 3e5caa0972eb..839ea7f44c78 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c


> +
> +static int ad4691_cnv_burst_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	struct ad4691_offload_state *offload = st->offload;
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct spi_offload_trigger_config config = {
> +		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
> +	};
> +	unsigned int n_active;
> +	unsigned int bit, k;
> +	int ret;
> +
> +	n_active = bitmap_weight(indio_dev->active_scan_mask, iio_get_masklength(indio_dev));
> +
> +	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   bitmap_read(indio_dev->active_scan_mask, 0,
> +				       iio_get_masklength(indio_dev)));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> +			   ~bitmap_read(indio_dev->active_scan_mask, 0,
> +				iio_get_masklength(indio_dev)) & GENMASK(15, 0));
This indent is hard to read. I would either use a local variable, or do it as

	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
			   ~bitmap_read(indio_dev->active_scan_mask, 0,
					iio_get_masklength(indio_dev)) &
			   GENMASK(15, 0));

> +	if (ret)
> +		return ret;
> +
> +	ret = ad4691_enter_conversion_mode(st);
> +	if (ret)
> +		return ret;
> +
> +	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
> +
> +	/*
> +	 * Each AVG_IN register read uses two 16-bit transfers:
> +	 *   TX: [reg_hi | 0x80, reg_lo]  (address, CS stays asserted)
> +	 *   RX: [data_hi, data_lo]       (data, storagebits=16, shift=0)
> +	 * The state reset is also split into two 16-bit transfers
> +	 * (address then value) to keep bits_per_word uniform throughout.
> +	 */
> +	k = 0;
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		put_unaligned_be16(0x8000 | AD4691_AVG_IN(bit), offload->tx_cmd[k]);
> +
> +		/* TX: address phase, CS stays asserted into data phase */
> +		st->scan_xfers[2 * k].tx_buf = offload->tx_cmd[k];
> +		st->scan_xfers[2 * k].len = sizeof(offload->tx_cmd[k]);
> +		st->scan_xfers[2 * k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
> +
> +		/* RX: data phase, CS toggles after to delimit the next register op */
> +		st->scan_xfers[2 * k + 1].len = sizeof(offload->tx_cmd[k]);
> +		st->scan_xfers[2 * k + 1].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
> +		st->scan_xfers[2 * k + 1].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +		st->scan_xfers[2 * k + 1].cs_change = 1;
> +		k++;
> +	}
> +
> +	/* State reset to re-arm DATA_READY for the next scan. */
> +	put_unaligned_be16(AD4691_STATE_RESET_REG, offload->tx_reset);
> +	offload->tx_reset[2] = AD4691_STATE_RESET_ALL;
> +
> +	st->scan_xfers[2 * k].tx_buf = offload->tx_reset;
> +	st->scan_xfers[2 * k].len = sizeof(offload->tx_cmd[k]);
> +	st->scan_xfers[2 * k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
> +
> +	st->scan_xfers[2 * k + 1].tx_buf = &offload->tx_reset[2];
> +	st->scan_xfers[2 * k + 1].len = sizeof(offload->tx_cmd[k]);
> +	st->scan_xfers[2 * k + 1].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
> +	st->scan_xfers[2 * k + 1].cs_change = 1;
> +
> +	spi_message_init_with_transfers(&st->scan_msg, st->scan_xfers, 2 * k + 2);
> +	st->scan_msg.offload = offload->spi;
> +
> +	ret = spi_optimize_message(spi, &st->scan_msg);
> +	if (ret)
> +		goto err_exit_conversion;
> +
> +	ret = ad4691_sampling_enable(st, true);
> +	if (ret)
> +		goto err_unoptimize;
> +
> +	ret = spi_offload_trigger_enable(offload->spi, offload->trigger, &config);
> +	if (ret)
> +		goto err_sampling_disable;
> +
> +	return 0;
> +
> +err_sampling_disable:
> +	ad4691_sampling_enable(st, false);
> +err_unoptimize:
> +	spi_unoptimize_message(&st->scan_msg);
> +err_exit_conversion:
> +	ad4691_exit_conversion_mode(st);
> +	return ret;
> +}

>  
>  static ssize_t sampling_frequency_store(struct device *dev,
> @@ -833,6 +1123,23 @@ static ssize_t sampling_frequency_store(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> +	if (st->manual_mode && st->offload) {
> +		struct spi_offload_trigger_config config = {
> +			.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
> +			.periodic = { .frequency_hz = freq },
> +		};
> +
> +		ret = spi_offload_trigger_validate(st->offload->trigger, &config);
> +		if (ret) {
> +			iio_device_release_direct(indio_dev);
> +			return ret;
> +		}
> +
> +		st->offload->trigger_hz = config.periodic.frequency_hz;
> +		iio_device_release_direct(indio_dev);
This release in a different scope is a bit ugly. 

Look at whether the auto cleanup approach works well here.

https://elixir.bootlin.com/linux/v7.0-rc7/source/include/linux/iio/iio.h#L767


> +		return len;
> +	}
> +

