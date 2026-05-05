Return-Path: <linux-pwm+bounces-8784-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCn0DHcA+mkqFwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8784-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 16:36:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1F44CF8A1
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 16:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C88B30E7320
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 14:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285DC480940;
	Tue,  5 May 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWyp4N51"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0164F48034A;
	Tue,  5 May 2026 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991322; cv=none; b=MnCLDb5q+AHVBVNUWB94yiu++6MJF8qAH159OOx9+WMQyBn9KHw2V9qc2GP46FcSNH2Adio2lqLv3dS3C8TuXuMi2Gq3YIru58HpbPw1zlpWVp0SU38feAIhZZLAt63wuoKrQRj4VwYXoLaqyEKusH0dgkmrmVmZ8VJo2/be/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991322; c=relaxed/simple;
	bh=4J9jdu5Gyf0w3Bh8XkBSArTQNkrTtxNjqTRAPGsApHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTV/F8i3Dvlm827IYh1lilJpgz0FBiGESZi/vhdgTXWzLP+RzWaDiwau8lyGI3POQDH7T5rLg46qk4+OBcPi2wUDhQMWdijouC73zOv+ValLq0JiTX6YKln5jHAK6t6NU19lKR8lGafzH7zntH8Q8AlEfPLtzCSpNOJGQ82WHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWyp4N51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7A1C2BCB4;
	Tue,  5 May 2026 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777991321;
	bh=4J9jdu5Gyf0w3Bh8XkBSArTQNkrTtxNjqTRAPGsApHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eWyp4N51KWEvmGcmIiD+wdkIo/2a7hxfaiKYvuvbNgdFRMSimUG5Xx4AvXjkfMjrM
	 1kHDktWqPm+NkGg82m2OUC/bXQtKO1AONXZmYrT9wko+4ut1hKxj84/GCEGBeXO2M3
	 lTvYlSsSrZUKMXKnrBdtusereUFK1FyhLc/iDfIEy9CoJLy9awLt78WnOj4lT6Dwei
	 pLCKNysuFI2QJUhSNtiYoiDanZIMyUJHDCkqw2MRPEW1hjH0VoQNK1SP9d5H5fqNx8
	 sXV9Z4a3TUWq/z31DKKYAvECkFqPPtXAtsX260ErX8QajZ3a36FIk9zU0kfdfTwA/M
	 /OOfj193MVWdA==
Date: Tue, 5 May 2026 15:28:28 +0100
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
Subject: Re: [PATCH v9 4/6] iio: adc: ad4691: add SPI offload support
Message-ID: <20260505152828.61f40411@jic23-huawei>
In-Reply-To: <20260430-ad4692-multichannel-sar-adc-driver-v9-4-33e439e4fb87@analog.com>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-4-33e439e4fb87@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7E1F44CF8A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8784-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]

On Thu, 30 Apr 2026 13:16:46 +0300
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
In general have a read through Sashiko reviews once they come in and
if you agree with them reply to your own patches to say what you are
changing.
https://sashiko.dev/#/patchset/20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87%40analog.com
No perfect but another one in here is something I missed completely.

A few of them called out here but please make sure you've addressed them
all or established them to be false (which happens!)


> +
> +struct ad4691_offload_state {
> +	struct spi_offload *offload;
> +	struct spi_offload_trigger *trigger;
> +	u64 trigger_hz;
> +	u8 tx_cmd[17][2];
> +	u8 tx_reset[4];
These two buffers share cachelines with trigger_hz. That can
be written via sysfs in the middle of a non coherent DMA transfer.
If it is you may loose the written value when a post transfer
flush copies back a stale cacheline (with the new data in tx_cmd
/ tx_reset).  These need marking to force them to have their own cache lines.


>  };
>  

> +
> +static int ad4691_manual_offload_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	struct ad4691_offload_state *offload = st->offload;
> +
> +	spi_offload_trigger_disable(offload->offload, offload->trigger);
> +	spi_unoptimize_message(&st->scan_msg);
> +
> +	return ad4691_exit_conversion_mode(st);
> +}
> +
> +static const struct iio_buffer_setup_ops ad4691_manual_offload_buffer_setup_ops = {
> +	.postenable = &ad4691_manual_offload_buffer_postenable,
> +	.predisable = &ad4691_manual_offload_buffer_predisable,
> +};
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
> +	unsigned int bpw = indio_dev->channels[0].scan_type.realbits;
> +	unsigned int acc_mask;
> +	unsigned int bit, k;
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   bitmap_read(indio_dev->active_scan_mask, 0,
> +				       iio_get_masklength(indio_dev)));
> +	if (ret)
> +		return ret;
> +
> +	acc_mask = ~bitmap_read(indio_dev->active_scan_mask, 0,
> +				iio_get_masklength(indio_dev)) & GENMASK(15, 0);
> +	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG, acc_mask);
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

Sashiko makes the interesting point that you are setting bpw to 16 at least sometimes
and that means the SPI bus will be dealing in u16s. As such the endian swap seems
odd.  Which also makes a mess if the word length isn't 16 bits. I'm assuming it
always is. If that's the case hard code it rather than giving impression this
will work otherwise.  The endian swap probably wants to be unconditional rather
than only if little endian host.

There is a related question whether the larger words interact with the channel
endianness marking. I think that should be fine but please check.


> +
> +		/* TX: address phase, CS stays asserted into data phase */
> +		st->scan_xfers[2 * k].tx_buf = offload->tx_cmd[k];
> +		st->scan_xfers[2 * k].len = sizeof(offload->tx_cmd[k]);
> +		st->scan_xfers[2 * k].bits_per_word = bpw;
> +
> +		/* RX: data phase, CS toggles after to delimit the next register op */
> +		st->scan_xfers[2 * k + 1].len = sizeof(offload->tx_cmd[k]);
> +		st->scan_xfers[2 * k + 1].bits_per_word = bpw;
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
> +	st->scan_xfers[2 * k].bits_per_word = bpw;
> +
> +	st->scan_xfers[2 * k + 1].tx_buf = &offload->tx_reset[2];
> +	st->scan_xfers[2 * k + 1].len = sizeof(offload->tx_cmd[k]);
> +	st->scan_xfers[2 * k + 1].bits_per_word = bpw;
> +	st->scan_xfers[2 * k + 1].cs_change = 1;
This is odd. Add a comment on why if you do want to leave CS active
after this sequence.

> +
> +	spi_message_init_with_transfers(&st->scan_msg, st->scan_xfers, 2 * k + 2);
> +	st->scan_msg.offload = offload->offload;
> +
> +	ret = spi_optimize_message(spi, &st->scan_msg);
> +	if (ret)
> +		goto err_exit_conversion;
> +
> +	ret = ad4691_sampling_enable(st, true);
There are some questions from Sashiko around whether the offload trigger should be enabled
first to avoid getting the device into an odd state. I haven't read the datasheet
in enough depth to check - so over to you to argue one way or the other!

> +	if (ret)
> +		goto err_unoptimize;
> +
> +	ret = spi_offload_trigger_enable(offload->offload, offload->trigger, &config);
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


