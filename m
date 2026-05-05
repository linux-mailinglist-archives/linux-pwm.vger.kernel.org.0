Return-Path: <linux-pwm+bounces-8783-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOY3Hnn7+WkYFwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8783-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 16:15:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5D84CF33D
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 16:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B90193003BC6
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653FF480328;
	Tue,  5 May 2026 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjBdfeMN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6F43E51D7;
	Tue,  5 May 2026 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990390; cv=none; b=oKFrrYI+9L4KnQe8FA9J6vpvUaJhWo8hSo6t+fI7V+6UJMqCbTb6Hz9MeI0dCoXeSTVVbe729zCOm9NQwCH/Spxu1zvC5ikM9MCz5c1Irk7dMCryXh/9eHbqFbyu2z8h0EdmqlyOLdNJVuG0iruF+feWkAnOkwWU6iTxUbeavWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990390; c=relaxed/simple;
	bh=ZOjUNHe9D+ZO5F0CooExI8tSsZdiNfTkV5INJ4CerVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1klyghu6bjrDuvhla9ebDNDEa9c1LMAHFVYdQMEZRMrnt7JXLDkTZr2OFQZHVMoDpILdlFuUL6w4CD9ImfJVR3Np+4KldBBCRvRoLt/0royWooAzSeFBPed5rBkeLun4xtnHDJPXiGS507vRyJbPbYjRX4cmWFfodOort+BKXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjBdfeMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4403BC2BCC7;
	Tue,  5 May 2026 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777990389;
	bh=ZOjUNHe9D+ZO5F0CooExI8tSsZdiNfTkV5INJ4CerVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SjBdfeMNsFeA/DzVO7V3Od0m+3SCPmZ9Njh5k9GhJ8Kl8Ls5l3CUBGd2DLyRDgdPA
	 m1W/QbsW+WLQnoZIyP3lDjebDgUXuc77J/u7oEc3DmQZ3I3CA1y98jJjBvDme3nspd
	 nOgLCDn2mvUYEd6Xh7vxCkaIvhRYXR+bIAZh5wVsJEdq04i2Ex6vG/PvyCDW9O+iaR
	 7aVPTplnJ73nE2is15lupzekX2FvfYyW7ZYlqXzAd4XUSsvONnbN7eexACu0+2dZQZ
	 dDYbmiLbnGEX1jiMeqE+Jh3EsJcrauJEKxjT688Crkde7QeXz/b8h2/fC14vC+34zO
	 4EQvdLF0d1BLA==
Date: Tue, 5 May 2026 15:12:56 +0100
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
Message-ID: <20260505151256.23e07d6b@jic23-huawei>
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
X-Rspamd-Queue-Id: 6F5D84CF33D
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-8783-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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

Probably good to call out that oversampling hasn't been introduced
to the driver yet. This confused Sashiko ;)

> 
> Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
One minor thing inline.

>  static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
>  {
>  	struct spi_device *spi = context;
> @@ -712,6 +791,7 @@ static const struct iio_buffer_setup_ops ad4691_manual_buffer_setup_ops = {
>  static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
>  {
>  	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int acc_mask;
>  	unsigned int k, i;
>  	int ret;
>  
> @@ -758,9 +838,9 @@ static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
>  	if (ret)
>  		goto err_unoptimize;
>  
> -	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> -			   ~bitmap_read(indio_dev->active_scan_mask, 0,
> -				iio_get_masklength(indio_dev)) & GENMASK(15, 0));
> +	acc_mask = ~bitmap_read(indio_dev->active_scan_mask, 0,
> +				iio_get_masklength(indio_dev)) & GENMASK(15, 0);

Not obvious to me why this change is here.  If you want it, push back to the
original patch that introduced this code.

> +	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG, acc_mask);
>  	if (ret)
>  		goto err_unoptimize;
>  
> @@ -803,6 +883,209 @@ static const struct iio_buffer_setup_ops ad4691_cnv_burst_buffer_setup_ops = {
>  	.postdisable = &ad4691_cnv_burst_buffer_postdisable,
>  };


