Return-Path: <linux-pwm+bounces-8692-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK4MBFAB7WnmeAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8692-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Apr 2026 20:00:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2424672AD
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Apr 2026 20:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F28FF306A571
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Apr 2026 17:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBCE3624AF;
	Sat, 25 Apr 2026 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFMvKtJk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441091AA1D2;
	Sat, 25 Apr 2026 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139667; cv=none; b=ZbCnROJSM2DLWU+CvX7BNRGZ2dOdWAlbHzoYp4ueL/1+8RI6hgKmPjAOqYhNg1ZdRqlUaWvhBvL8jYAJJUf3kI5oAqXGTSSarDCqcOdR7/YEzIPOrZbj/EdckuL/t/6L3m1GbRO3eML9kajmLTtw0ftI9mdFZ0sKhZ6lEEIGXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139667; c=relaxed/simple;
	bh=dVYFfq9D/wPHM2YOAQmblEGgtktKpkqI+v2SbdR/LSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dzc7JbuErpvRxlazNAj/MdbP0gGpCCkKpfZMD48kwotHd9Orpk1jOklhUoBKxJbkpQlFjYESNwoOs+G1Mdz7R36Bg2en50lpnbDzkK4+gZazb1qzH2KYkmUO++K493MZW9kvcuUqe7Qg1ovsBl+mZ4rrfhB6DAZl0gGw64YKEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFMvKtJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBD5C2BCB0;
	Sat, 25 Apr 2026 17:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777139666;
	bh=dVYFfq9D/wPHM2YOAQmblEGgtktKpkqI+v2SbdR/LSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IFMvKtJkcTHlKsenz2lPKpwjyrwXt5/kmVxJNxBViRDYLOp/lZWucRukWYnom4YEO
	 dQuO5KaZM0/Tg/II6UEt5zZqfnqziugSXs/8W7FBAZcZZWLuJk+vNBPEO1J88fxewJ
	 IxUeck+/um82msXOvpD+wXlhz0s9YfSKg+0IAGGSoZAQhZJ6BdqXfvLuTbChqP4rLa
	 ++jvCn7sg7RyuSY8RVB7KtIy8/+X6GzdL4xEppyAjH3P1VNaEtoSN2xJvYdHA0RgfO
	 yORpVn5W7334hfAs+GcBCvaWLzLJgvCl5j8U86JHajXB2LH7Am9lWS8Y4ootb1wDNV
	 qsgAlbt6W8kLA==
Date: Sat, 25 Apr 2026 18:54:13 +0100
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
Subject: Re: [PATCH v8 4/6] iio: adc: ad4691: add SPI offload support
Message-ID: <20260425185413.0e81f521@jic23-huawei>
In-Reply-To: <20260416-ad4692-multichannel-sar-adc-driver-v8-4-c415bd048fa3@analog.com>
References: <20260416-ad4692-multichannel-sar-adc-driver-v8-0-c415bd048fa3@analog.com>
	<20260416-ad4692-multichannel-sar-adc-driver-v8-4-c415bd048fa3@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8D2424672AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8692-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:email]

On Thu, 16 Apr 2026 12:18:49 +0300
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

Another case where you would ideally have pushed the refactor
back to where the original code was introduced. It might have looked
slightly over the top there, but it would have been correct and reduce
churn in this later patch.

> @@ -825,12 +1111,25 @@ static ssize_t sampling_frequency_store(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	ret = iio_device_claim_direct(indio_dev);
> -	if (ret)
> -		return ret;
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
Ideally this would have been pushed back into the patch that introduced
the code to reduce the churn here.  Fix that up if you end up doing a v9.

> +
> +	if (st->manual_mode && st->offload) {
> +		struct spi_offload_trigger_config config = {
> +			.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
> +			.periodic = { .frequency_hz = freq },
> +		};
> +
> +		ret = spi_offload_trigger_validate(st->offload->trigger, &config);
> +		if (ret)
> +			return ret;
> +
> +		st->offload->trigger_hz = config.periodic.frequency_hz;
> +		return len;
> +	}
>  
>  	ret = ad4691_set_pwm_freq(st, freq);
> -	iio_device_release_direct(indio_dev);
>  	if (ret)
>  		return ret;

