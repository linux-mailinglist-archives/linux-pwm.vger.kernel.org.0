Return-Path: <linux-pwm+bounces-8264-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAE7HPyqtWkJ3QAAu9opvQ
	(envelope-from <linux-pwm+bounces-8264-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 19:37:48 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1095828E7EC
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 19:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51124300E2A1
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461730DEB8;
	Sat, 14 Mar 2026 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XbCXB3GW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4121B2D5950
	for <linux-pwm@vger.kernel.org>; Sat, 14 Mar 2026 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773513464; cv=none; b=fHa2BwP36rUOJouOJgKSiD4t/d6QWhNfNUOfg+QLrFIoeDGiO8/K07zrduqiMd4dOUVSe8eBAnUkyFoeRRxtI4npdiSVHXXWIv/PjcUVGqvGFr7ZLFP8AM0UxFA9kRHzd+b60XUyX9QsfKzw9SXcIGPvkRooQiIxbIBBjqY0gDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773513464; c=relaxed/simple;
	bh=dpet9lLIe9hmS2sf7ZHjr3KiMTFRzPuJq+6ICgbESXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTJktLe0exi1D9/bkpdhtj61VAmDcQ7Du9U3oP5Kzoy+fvnKkcWebLvziJoW/XGPshEiQEOD89vmSYwbRrgLVqNxpvY+n9Ipzfw/PLcFwhfhp2DDzMIBJjKMVDBk1mCIKgmvX+/Xajt6gBkxir1ingm/4U75TEWuRh7CKEI5UMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XbCXB3GW; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d750eeaec3so1157008a34.0
        for <linux-pwm@vger.kernel.org>; Sat, 14 Mar 2026 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773513460; x=1774118260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQsSrLCDlWZxhNuIWYjqcLumU1FYYKxtVBNbqkUVqf0=;
        b=XbCXB3GWhxRzCzA/7ferI0CMQhPspmByOYYn+exWzjYRlrOZVDxLBxyX/qHxB/b7m8
         BhTDPD93o7NdoN/I5OiJyPieNGLxgjKxrj4tMbYaqt/FWHK1DSWCwBOCUz/Ht1jM0lOa
         NWYhKCUoKUoJeUgN6Tb1iFhFMx0uMe9NK/1Vu0JQvOa0JrHI6MH+P+Xf8s0QOsyuA27g
         TT0pKYJRlBaVxvXVPa9MlPWfoDUOm0AWVVUgO8b0D9Ord2+cZH8gZzU8iwen8ZXuBI07
         lsUF6lHzkbKGkceQUUkBUxJR0ha2q6LcjkI2FEzUY9YOCJoJIrNlo8Sn20Pv1tiXdBPf
         nEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773513460; x=1774118260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQsSrLCDlWZxhNuIWYjqcLumU1FYYKxtVBNbqkUVqf0=;
        b=QLso4WnsXt1caPf6ENDh3h3CQoDbu0xLnj6TR7HRGYWf+emn/2vnlIJ88PSqNrZwMO
         hZt68FwYNhA0zd5u++hPrOnIfNixqjXs4aKQVbVvR6pbzSEE82Jv7kCvOqYCnuiTZ/dE
         4snTMWU0fj8XILFEFKwTPYpMPr+MUTyQT9ttXGxu1vFYfgbGV4iriOWJMCPA7OQ+PUfh
         sXvN87FBZfqv65ajT0si0nQZ09KGiyO707QxTbr/a0e0ae4L6b4LgDmpkZc5YVrFbB/E
         Laj2iNV/Tzp/Sy3tJPBbB4fEMef6yM4U+MpL6DcbSUA8im1eteFy36NqhEkuRiZMkS0I
         DNXw==
X-Forwarded-Encrypted: i=1; AJvYcCVBV37FYGld5fYI9uZTGPu+5neygbQVTtPAAvFOf9qkERQix1uHneEEzrG1I1ooWrUv1nNsQR8mJ4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPsz70DrKUzGZB3DQjouk90o87hMu0/i6fhXzIiLXy21yqJxBh
	wGCEjBMMcdPVuLfBrkJh367sNqJVlC6efHEWKFzhWYc5cwHKCIPn/ugr6DqtbhHOwrs=
X-Gm-Gg: ATEYQzw5TF7EK6u3N0kUhjJbZ7R9AKPxG/NVY0n0pi1zqAheKWkwi7F6zwbVslCJ8xe
	Z0iED0KGWpcqx0R7lHsJbxNQHhv4kYT9e8xaKsmulMsaZMyMXzNtBWzvni6fC/R8nv6T8UPthbV
	bOQdBqFvX9j4ea9Ka+eJA0sFCH0mCVe0DSd3LTfXGJbU2quY4y9dT4IJ6fcVUnch9wVT0NGRdNW
	aj0ZzsL1/TlbXZDIIBzD26Nj0kbTeOLzdgdXJDioUUs5X4Nqp797kr+Njf2dMXS5BSY6k0t0jBG
	FdORGZGaw93Cl8TasCcgO3C5GDSGMyimXbcV9CiOiLeoMICQHIw4SDklF9V2jTcMli7L9PEUD4k
	LRc8MV4dfpauUj9vn8iznmO5HRp2U4ec9OEHx8wUH5J79rNO8ih+mgySJx+jrlnjo0uO307JGce
	x4G6AfaYWTsPBgHhxyPko8vXeuyBzt33i4Cubir1nXe6h66hfDKFb81fdEj52zI7+mBVxb/EfA4
	w==
X-Received: by 2002:a05:6830:488f:b0:7d7:587c:f756 with SMTP id 46e09a7af769-7d78250c8c3mr5111088a34.23.1773513460097;
        Sat, 14 Mar 2026 11:37:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6e82cdsm12014257fac.18.2026.03.14.11.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 11:37:39 -0700 (PDT)
Message-ID: <0bca5313-a968-48a1-9245-aeae25ab4187@baylibre.com>
Date: Sat, 14 Mar 2026 13:37:37 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iio: adc: ad4691: add triggered buffer support
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-3-b4d14d81a181@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260313-ad4692-multichannel-sar-adc-driver-v3-3-b4d14d81a181@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8264-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:mid,analog.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1095828E7EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 5:07 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add buffered capture support using the IIO triggered buffer framework.
> 
> Both operating modes share a single IIO trigger and trigger handler.
> The handler builds a complete scan — one u32 slot per channel at its
> scan_index position, followed by a timestamp — and pushes it to the
> IIO buffer in a single iio_push_to_buffers_with_ts() call.

It would really help here to see some timing diagrams to know if we
are implementing this right.

For example, it isn't clear that in clocked mode if CNV triggers a
single conversion in the sequencer (i.e. IIO_SAMP_FREQ should be
info_mask_separate) or if it triggers the sequence (i.e. IIO_SAMP_FREQ
should be info_mask_shared_by_all).

> 
> For CNV Clock Mode the GP0 pin is configured as DATA_READY output. The
> IRQ handler stops conversions and fires the IIO trigger; the trigger
> handler reads accumulated results from the AVG_IN registers via regmap
> and restarts conversions for the next cycle.

This seems OK, but I would kind of would expect that PWM as CNV to
only be used for SPI offloading and not without SPI offloading.

The ADC also has an internal oscillator, so it seems like it would
be more useful to use that as a conversion trigger rather than
requiring external hardware.

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

I'm not really following the argument here. It is quite normal that if
an hrtimer trigger is set too fast then samples will be missed. So I don't
see why we wouldn't be able to use it here. This is why we usually have
a timestamp channel, so we can know roughly when the conversion actually
took place.

> 
> Manual mode channels use storagebits=32 (shift=8, realbits=16) so all
> channel slots in the scan buffer are uniformly sized regardless of the
> SPI wire format (24-bit transfer, 16-bit ADC data in bits[23:8]).

I also don't understand why we are including the status bits in manual
mode but not in CNV clock mode.

> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  drivers/iio/adc/Kconfig  |   2 +
>  drivers/iio/adc/ad4691.c | 402 ++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 378 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 3685a03aa8dc..d498f16c0816 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -142,6 +142,8 @@ config AD4170_4
>  config AD4691
>  	tristate "Analog Devices AD4691 Family ADC Driver"
>  	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	select REGMAP
>  	help
>  	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> index 31eafa12bef8..de2208395b21 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c
> @@ -11,6 +11,7 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/reset.h>
> +#include <linux/hrtimer.h>
>  #include <linux/interrupt.h>
>  #include <linux/math.h>
>  #include <linux/module.h>
> @@ -24,8 +25,13 @@
>  #include <linux/units.h>
>  #include <linux/unaligned.h>
>  
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
>  #include <dt-bindings/iio/adc/adi,ad4691.h>
>  
>  #define AD4691_VREF_uV_MIN			2400000
> @@ -70,7 +76,7 @@
>  #define AD4691_ACC_MASK1_REG			0x184
>  #define AD4691_ACC_MASK2_REG			0x185
>  #define AD4691_ACC_COUNT_LIMIT(n)		(0x186 + (n))
> -#define AD4691_ACC_COUNT_VAL			0x3F
> +#define AD4691_ACC_COUNT_VAL			0x01
>  #define AD4691_GPIO_MODE1_REG			0x196
>  #define AD4691_GPIO_MODE2_REG			0x197
>  #define AD4691_GPIO_READ			0x1A0
> @@ -160,33 +166,33 @@ static const struct iio_chan_spec ad4693_channels[] = {
>  };
>  
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
>  
>  static const struct ad4691_chip_info ad4691_ad4691 = {
> @@ -228,6 +234,8 @@ struct ad4691_state {
>  	unsigned long			ref_clk_rate;
>  	struct pwm_device		*conv_trigger;
>  
> +	struct iio_trigger		*trig;
> +
>  	enum ad4691_adc_mode		adc_mode;
>  
>  	int				vref_uV;
> @@ -238,6 +246,21 @@ struct ad4691_state {
>  	 * atomicity of consecutive SPI operations.
>  	 */
>  	struct mutex			lock;
> +
> +	/* hrtimer for MANUAL_MODE triggered buffer (non-offload) */
> +	struct hrtimer			sampling_timer;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) may require the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	unsigned char rx_data[ALIGN(3, sizeof(s64)) + sizeof(s64)]	__aligned(IIO_DMA_MINALIGN);
> +	unsigned char tx_data[ALIGN(3, sizeof(s64)) + sizeof(s64)];
> +	/* Scan buffer: one slot per channel (u32) plus timestamp */
> +	struct {
> +		u32 vals[16];
> +		s64 ts __aligned(8);
> +	} scan __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  static void ad4691_disable_pwm(void *data)
> @@ -399,6 +422,28 @@ static const struct regmap_config ad4691_regmap_config = {
>  	.cache_type = REGCACHE_MAPLE,
>  };
>  
> +static int ad4691_transfer(struct ad4691_state *st, int command,
> +			   unsigned int *val)
> +{
> +	struct spi_device *spi = to_spi_device(regmap_get_device(st->regmap));
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_data,
> +		.rx_buf = st->rx_data,
> +		.len = 3,
> +	};
> +	int ret;
> +
> +	memcpy(st->tx_data, &command, 3);
> +
> +	ret = spi_sync_transfer(spi, &xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	*val = get_unaligned_be24(st->rx_data);
> +
> +	return 0;
> +}
> +
>  static int ad4691_get_sampling_freq(struct ad4691_state *st)
>  {
>  	if (st->adc_mode == AD4691_MANUAL_MODE)
> @@ -483,6 +528,18 @@ static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq
>  	return __ad4691_set_sampling_freq(st, freq);
>  }
>  
> +static int ad4691_sampling_enable(struct ad4691_state *st, bool enable)
> +{
> +	struct pwm_state conv_state = { };
> +
> +	conv_state.period = st->cnv_period;
> +	conv_state.duty_cycle = AD4691_CNV_DUTY_CYCLE_NS;
> +	conv_state.polarity = PWM_POLARITY_NORMAL;
> +	conv_state.enabled = enable;
> +
> +	return pwm_apply_might_sleep(st->conv_trigger, &conv_state);
> +}
> +
>  static int ad4691_single_shot_read(struct iio_dev *indio_dev,
>  				   struct iio_chan_spec const *chan, int *val)
>  {
> @@ -594,6 +651,235 @@ static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg,
>  	return regmap_write(st->regmap, reg, writeval);
>  }
>  
> +/*
> + * ad4691_enter_conversion_mode - Switch the chip to its buffer conversion mode.
> + *
> + * Configures the ADC hardware registers for the mode selected at probe
> + * (CNV_CLOCK or MANUAL). Called from buffer postenable before starting
> + * sampling. The chip is in AUTONOMOUS mode during idle (for read_raw).
> + */
> +static int ad4691_enter_conversion_mode(struct ad4691_state *st)
> +{
> +	int ret;
> +
> +	if (st->adc_mode == AD4691_MANUAL_MODE)
> +		return regmap_write(st->regmap, AD4691_DEVICE_SETUP,
> +				    AD4691_DEVICE_MANUAL);
> +
> +	ret = regmap_write(st->regmap, AD4691_ADC_SETUP, AD4691_CNV_CLOCK_MODE);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4691_GPIO_MODE1_REG,
> +			    AD4691_DATA_READY);
> +}
> +
> +/*
> + * ad4691_exit_conversion_mode - Return the chip to AUTONOMOUS mode.
> + *
> + * Called from buffer postdisable/predisable to restore the chip to the
> + * idle state used by read_raw. Clears the sequencer and resets state.
> + */
> +static int ad4691_exit_conversion_mode(struct ad4691_state *st)
> +{
> +	int ret;
> +
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		ret = regmap_write(st->regmap, AD4691_DEVICE_SETUP,
> +				   AD4691_DEVICE_REGISTER);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(st->regmap, AD4691_ADC_SETUP, AD4691_AUTONOMOUS_MODE_VAL);
> +	if (ret)
> +		return ret;
> +
> +	/* Restore GP0 to ADC_BUSY for AUTONOMOUS idle (enter set it to DATA_READY) */
> +	ret = regmap_write(st->regmap, AD4691_GPIO_MODE1_REG, AD4691_ADC_BUSY);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   AD4691_SEQ_ALL_CHANNELS_OFF);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +			    AD4691_STATE_RESET_ALL);
> +}
> +
> +static int ad4691_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct spi_device *spi = to_spi_device(dev);
> +	u16 mask = ~(*indio_dev->active_scan_mask);
> +	u32 acc_mask[2] = { mask & 0xFF, mask >> 8 };
> +	int n_active = hweight_long(*indio_dev->active_scan_mask);
> +	unsigned int bit;
> +	int ret;
> +
> +	ret = ad4691_enter_conversion_mode(st);
> +	if (ret)
> +		return ret;
> +
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {

We can just make two different struct iio_buffer_setup_ops so we don't have
to put these ifs in each function. The mode can't change at runtime.

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
> +
> +static int ad4691_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +
> +	if (st->adc_mode == AD4691_MANUAL_MODE)
> +		hrtimer_cancel_wait_running(&st->sampling_timer);
> +	else
> +		ad4691_sampling_enable(st, false);
> +
> +	return ad4691_exit_conversion_mode(st);
> +}
> +
> +static const struct iio_buffer_setup_ops ad4691_buffer_setup_ops = {
> +	.postenable = &ad4691_buffer_postenable,
> +	.postdisable = &ad4691_buffer_postdisable,

I feel like I said this already (maybe it was a different series).

These aren't symetric. It needs to be postenable/predisable or
preenable/postdiable. Otherwise error unwinding doesn't work correclty.

> +};
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
> +	 */
> +	ad4691_sampling_enable(st, false);
> +	iio_trigger_poll(st->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static enum hrtimer_restart ad4691_sampling_timer_handler(struct hrtimer *timer)
> +{
> +	struct ad4691_state *st = container_of(timer, struct ad4691_state,
> +					       sampling_timer);
> +
> +	iio_trigger_poll(st->trig);
> +	hrtimer_forward_now(timer, st->sampling_period);
> +
> +	return HRTIMER_RESTART;
> +}
> +
> +static const struct iio_trigger_ops ad4691_trigger_ops = {
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static irqreturn_t ad4691_trigger_handler(int irq, void *p)
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

It would be more efficient to set up a single SPI message (in buffer enable
callback) that reads all channels at once rather than doing multiple SPI
messages.

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
> +
> +		st->scan.vals[prev_chan] = val;
> +	} else {
> +		iio_for_each_active_channel(indio_dev, i) {
> +			ret = regmap_read(st->regmap, AD4691_AVG_IN(i), &val);

Same here.

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

I don't recall seeing timestamp channels.

> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct iio_info ad4691_info = {
>  	.read_raw = &ad4691_read_raw,
>  	.write_raw = &ad4691_write_raw,
> @@ -624,6 +910,7 @@ static int ad4691_reset(struct ad4691_state *st)
>  static int ad4691_config(struct ad4691_state *st)
>  {
>  	struct device *dev = regmap_get_device(st->regmap);
> +	struct spi_device *spi = to_spi_device(dev);
>  	enum ad4691_ref_ctrl ref_val;
>  	unsigned int reg_val;
>  	int ret;
> @@ -644,7 +931,7 @@ static int ad4691_config(struct ad4691_state *st)
>  		st->adc_mode = AD4691_MANUAL_MODE;
>  		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
>  			AD4691_MANUAL_MODE_STD_FREQ(st->chip->num_channels,
> -				to_spi_device(dev)->max_speed_hz)));
> +						    spi->max_speed_hz)));
>  	}
>  
>  	/* Perform a state reset on the channels at start-up. */
> @@ -693,6 +980,65 @@ static int ad4691_config(struct ad4691_state *st)
>  	return regmap_write(st->regmap, AD4691_GPIO_MODE1_REG, AD4691_ADC_BUSY);
>  }
>  
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

There is no such line as DATA_READY. This would be GP0.

> +
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						&ad4691_irq,
> +						IRQF_ONESHOT,
> +						indio_dev->name, indio_dev);

Not many drivers do this, but I think it is good practice to use the
IRQF_NO_AUTOEN flag in IIO and only enable the interrupt when it has
been fully configured during the buffer enable.


> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					       &iio_pollfunc_store_time,
> +					       &ad4691_trigger_handler,
> +					       &ad4691_buffer_setup_ops);
> +}
> +
>  static int ad4691_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> @@ -736,6 +1082,10 @@ static int ad4691_probe(struct spi_device *spi)
>  		st->chip->manual_channels : st->chip->channels;
>  	indio_dev->num_channels = st->chip->num_channels;
>  
> +	ret = ad4691_setup_triggered_buffer(indio_dev, st);
> +	if (ret)
> +		return ret;
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> 


