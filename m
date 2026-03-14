Return-Path: <linux-pwm+bounces-8265-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GJDFgC5tWmc4AAAu9opvQ
	(envelope-from <linux-pwm+bounces-8265-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 20:37:36 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B67B028E9FE
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 20:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC6AA3025F4A
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A534D3B0;
	Sat, 14 Mar 2026 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T8r15Gde"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4A734CFC4
	for <linux-pwm@vger.kernel.org>; Sat, 14 Mar 2026 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773517050; cv=none; b=Zyu+Ak/LTXVFSCmHN8824fWn4xX0XwQq+sgbEmF4beBWQHxXQ7LDDx+aBeO71KKN3Kg4u1mgRz2UX+8imj8gORg8ti/YUhgFkvSy4UVRbVE+vl00BvFlTUOTCi4X1u/v11FPugVsLftSDyWUwhi+QsSJ7X05GgfoxYPWPm9o/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773517050; c=relaxed/simple;
	bh=bmJoDlubNuiSuTHjybhtVNBPxfnUm5q0x17kzUHhCx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg5TxO/WTEJREeouCKwjqIyRMabyFrC9w3IJv01KeJ0dZu98OI9sLjP67WIRjysNnhT3bZpgUIjlFB7pNeLcY5ucZhsLuCydXTC4V9CrUofC9juKhqyhwoU+VjiJiC5xyFgfxkP4iLxRGZFotumR7ZXkuyy44Xy4oQfUkDNR0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T8r15Gde; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-41706b23543so2158785fac.1
        for <linux-pwm@vger.kernel.org>; Sat, 14 Mar 2026 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773517045; x=1774121845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cC8ZFoiqCiOYv0fc78n7vNqBObMBFZkLshHY/fh8V5k=;
        b=T8r15Gdeui/6u1qc//ByND50ST/JLzU4o6hSUIrJ58ONW2mOxO+mpDkbsE3+sQE+rt
         4PiCkRQtXMgQmBAB8nXl5Ol/ioHxvb3gdqniZJA7nGkH+mT+PLj5SRCXEhwFh/n1Cpng
         fYgX8Xrz1kKx7norfBGc73RZMN15ppQRO7QkmgxjqE8KxqgwlcIFWeHg7TJfI+qAfaeC
         IMGXXzmP4eTM41VQMoFnh1IyfAeRQY582sYobdhNixukY5S2JadyF/WS8akq2fk/AHhk
         QHp9fCtu480lh2kJM8cpmy+eg4pzWGjW1gnFs6/S9vJP69hlnsuBk/ke6Af4g7cxQr0e
         bzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773517045; x=1774121845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cC8ZFoiqCiOYv0fc78n7vNqBObMBFZkLshHY/fh8V5k=;
        b=VqqCZBvKsn1XhiSW8W4qSAgc023rKoCY//aec8IXy652E+1TX/B1DTkdqTWbDth8LV
         jDmK/YwQngV6QOat/KeWWVywVZOsnhXr25XsAh8TnmSa18xQaqifTOU8jpUxClWFVXPc
         AgxPJIQiZ/Bj4UA/xWNmv8fKKzFrOydsmjmprp3Z95gb/tDoZhebh+snSpC+Jkzfs9Kn
         Q09aR41tBeyhVfXsPbnFMUxU8UrM+/87ADSBp8pLUXJZ0ZB3zJtlkuSda6inJ4n2htvA
         TONtdxosiL8uZo5tlk/Vd8vhZv9G4Wf5DWhODgmmgvFvkZJ0sea4/67r1B2Zj88W6RFO
         bqUA==
X-Forwarded-Encrypted: i=1; AJvYcCXYv6uuAzJ0qAYk42BBChmUsd7LCwvmiMdboxcnOUdQy6z9BweBMIu8Dpp4z6pPjV3IYBLWNu+0QQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPAb2JromMQFPEvgfdLAz6G+1kn9T4iWi8o/fuqIu789YWYKr
	4qA1hxSDEf2k0JJqP5+S2NZCEhtke3HIVtENznGbNACYgkxSEEgrobpxJAQCL+phRNo=
X-Gm-Gg: ATEYQzxnyG+KtVriqEnf5vYPCseSlsbBgFDUKxZxuvqJnvRDX/esl74i2JOQTVcIyEk
	lAAcxUVZJRwcXIT2lMARllh5DdTMeVcbXjD9mPEuoAX9YacDvnNIWZHChc5LHxlIx1r/vxXLJu0
	sfVpNzzTohXgUnvkBSiyzYMt7FmbeGt5b3uHdoos8h20yiSzLQ2QoQxXj9qW6meTIqbhxxPZ+No
	eqefk67t0L5DhLg36ozE/2rtrkZ8c6ZJudnSW+Qu880AjjAiHytXQeO7rbz0pQ3HX0MF2IMR19w
	iwgJ4nrvbau7QEc9jijThhMEpvPSrG9iil6JhRGB/17KulQRpvdCctZXW7/KlU+30rase3dlVuD
	KnH/VxlNv4kD6lvt33C9q5i3XfD6P7lPxTdGir23Cue8ISr20vFwjprLlRStkil5GCukGCEHz+B
	EeyrgAE65bOLt6klD8ua/tK/asr9mYf0y33m9+kWW0a8Hp19aTNKzH/QWxOU0FS5tpAkM8KW9E2
	Q==
X-Received: by 2002:a05:6870:c10c:b0:417:8539:bdba with SMTP id 586e51a60fabf-417b72df1acmr4347566fac.24.1773517044891;
        Sat, 14 Mar 2026 12:37:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177de88106sm11554928fac.0.2026.03.14.12.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 12:37:23 -0700 (PDT)
Message-ID: <b8a9a56b-04cb-4bb3-8606-3d90d1aba721@baylibre.com>
Date: Sat, 14 Mar 2026 14:37:21 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] iio: adc: ad4691: add SPI offload support
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
 <20260313-ad4692-multichannel-sar-adc-driver-v3-4-b4d14d81a181@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260313-ad4692-multichannel-sar-adc-driver-v3-4-b4d14d81a181@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8265-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B67B028E9FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 5:07 AM, Radu Sabau via B4 Relay wrote:
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
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  drivers/iio/adc/Kconfig  |   1 +
>  drivers/iio/adc/ad4691.c | 397 ++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 391 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d498f16c0816..93f090e9a562 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -144,6 +144,7 @@ config AD4691
>  	depends on SPI
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select IIO_BUFFER_DMAENGINE
>  	select REGMAP
>  	help
>  	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> index de2208395b21..ad9eaa94727e 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c
> @@ -9,6 +9,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/dmaengine.h>
>  #include <linux/err.h>
>  #include <linux/reset.h>
>  #include <linux/hrtimer.h>
> @@ -21,11 +22,15 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> +#include <linux/spi/offload/consumer.h>
> +#include <linux/spi/offload/provider.h>
>  #include <linux/util_macros.h>
>  #include <linux/units.h>
>  #include <linux/unaligned.h>
>  
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dma.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/iio.h>
>  
>  #include <linux/iio/trigger.h>
> @@ -46,6 +51,7 @@
>   */
>  #define AD4691_MANUAL_MODE_STD_FREQ(x, y)	((y) / (36 * ((x) + 1)))
>  #define AD4691_BITS_PER_XFER			24
> +#define AD4691_OFFLOAD_BITS_PER_WORD		32
>  #define AD4691_CNV_DUTY_CYCLE_NS		380
>  #define AD4691_MAX_CONV_PERIOD_US		800
>  
> @@ -92,6 +98,11 @@
>  #define AD4691_ACC_IN(n)			(0x252 + (3 * (n)))
>  #define AD4691_ACC_STS_DATA(n)			(0x283 + (4 * (n)))
>  
> +/* SPI offload 32-bit message byte-field masks (MSB = first transmitted) */
> +#define AD4691_MSG_ADDR_HI			GENMASK(31, 24)
> +#define AD4691_MSG_ADDR_LO			GENMASK(23, 16)
> +#define AD4691_MSG_DATA				GENMASK(15, 8)
> +
>  enum ad4691_adc_mode {
>  	AD4691_CNV_CLOCK_MODE,
>  	AD4691_MANUAL_MODE,
> @@ -250,6 +261,16 @@ struct ad4691_state {
>  	/* hrtimer for MANUAL_MODE triggered buffer (non-offload) */
>  	struct hrtimer			sampling_timer;
>  
> +	struct spi_offload		*offload;
> +	struct spi_offload_trigger	*offload_trigger;
> +	struct spi_offload_trigger	*offload_trigger_periodic;

Aren't these mutually exclusive (depends on hardware wiring)?

It seems like we only need one trigger pointer because we never
have two at the same time.

> +	u64				offload_trigger_hz;
> +	struct spi_message		offload_msg;
> +	/* Max 16 channel transfers + 1 state reset or NOOP */
> +	struct spi_transfer		offload_xfer[17];
> +	/* TX commands for manual and accumulator modes */
> +	u32				offload_tx_cmd[17];
> +	u32				offload_tx_reset;
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
>  	 * transfer buffers to live in their own cache lines.
> @@ -263,6 +284,65 @@ struct ad4691_state {
>  	} scan __aligned(IIO_DMA_MINALIGN);
>  };
>  
> +static const struct spi_offload_config ad4691_offload_config = {
> +	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
> +			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
> +};
> +
> +static bool ad4691_offload_trigger_match(struct spi_offload_trigger *trigger,
> +					 enum spi_offload_trigger_type type,
> +					 u64 *args, u32 nargs)
> +{
> +	if (type != SPI_OFFLOAD_TRIGGER_DATA_READY)
> +		return false;
> +
> +	/*
> +	 * Requires 2 args:
> +	 * args[0] is the trigger event (BUSY or DATA_READY).
> +	 * args[1] is the GPIO pin number (only GP0 supported).
> +	 */
> +	if (nargs != 2)
> +		return false;
> +
> +	if (args[0] != AD4691_TRIGGER_EVENT_BUSY &&
> +	    args[0] != AD4691_TRIGGER_EVENT_DATA_READY)

What is the difference between BUSY and DATA_READY?

> +		return false;
> +
> +	if (args[1] != AD4691_TRIGGER_PIN_GP0)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int ad4691_offload_trigger_request(struct spi_offload_trigger *trigger,
> +					  enum spi_offload_trigger_type type,
> +					  u64 *args, u32 nargs)
> +{
> +	/*
> +	 * GP0 is configured as DATA_READY or BUSY in ad4691_config()
> +	 * based on the ADC mode. No additional configuration needed here.
> +	 */
> +	if (nargs != 2)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ad4691_offload_trigger_validate(struct spi_offload_trigger *trigger,
> +					   struct spi_offload_trigger_config *config)
> +{
> +	if (config->type != SPI_OFFLOAD_TRIGGER_DATA_READY)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct spi_offload_trigger_ops ad4691_offload_trigger_ops = {
> +	.match = ad4691_offload_trigger_match,
> +	.request = ad4691_offload_trigger_request,
> +	.validate = ad4691_offload_trigger_validate,
> +};
> +
>  static void ad4691_disable_pwm(void *data)
>  {
>  	struct pwm_device *pwm = data;
> @@ -446,9 +526,13 @@ static int ad4691_transfer(struct ad4691_state *st, int command,
>  
>  static int ad4691_get_sampling_freq(struct ad4691_state *st)
>  {
> -	if (st->adc_mode == AD4691_MANUAL_MODE)
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		/* Offload uses periodic trigger, non-offload uses hrtimer */
> +		if (st->offload)
> +			return st->offload_trigger_hz;
>  		return DIV_ROUND_CLOSEST(NSEC_PER_SEC,
>  					 ktime_to_ns(st->sampling_period));
> +	}
>  
>  	return DIV_ROUND_CLOSEST(NSEC_PER_SEC,
>  				 pwm_get_period(st->conv_trigger));
> @@ -502,6 +586,7 @@ static int ad4691_pwm_get(struct ad4691_state *st)
>  static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq)
>  {
>  	struct ad4691_state *st = iio_priv(indio_dev);
> +	int ret;
>  
>  	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>  
> @@ -511,11 +596,29 @@ static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq
>  	guard(mutex)(&st->lock);
>  
>  	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		/* For offload mode, validate and store frequency for periodic trigger */
> +		if (st->offload) {
> +			struct spi_offload_trigger_config config = {
> +				.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
> +				.periodic = {
> +					.frequency_hz = freq,
> +				},
> +			};
> +
> +			ret = spi_offload_trigger_validate(st->offload_trigger_periodic,
> +							   &config);
> +			if (ret)
> +				return ret;
> +
> +			st->offload_trigger_hz = config.periodic.frequency_hz;
> +			return 0;
> +		}
> +
> +		/* Non-offload: update hrtimer sampling period */
>  		if (!freq || freq > st->chip->max_rate)
>  			return -ERANGE;
>  
> -		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST(NSEC_PER_SEC,
> -									 freq));
> +		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq));
>  		return 0;
>  	}
>  
> @@ -787,6 +890,223 @@ static const struct iio_buffer_setup_ops ad4691_buffer_setup_ops = {
>  	.postdisable = &ad4691_buffer_postdisable,
>  };
>  
> +static int ad4691_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	struct spi_device *spi = to_spi_device(regmap_get_device(st->regmap));
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
> +		u16 mask = ~(*indio_dev->active_scan_mask);
> +		u32 acc_mask[2] = { mask & 0xFF, mask >> 8 };

This is hard to grok. Probably should use bitfield helper and
cpu_to_be16().

> +
> +		ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +				   AD4691_STATE_RESET_ALL);
> +		if (ret)
> +			return ret;
> +
> +		/* Configure accumulator masks - 0 = enabled, 1 = masked */
> +		ret = regmap_bulk_write(st->regmap, AD4691_ACC_MASK1_REG,
> +					acc_mask, 2);
> +		if (ret)
> +			return ret;
> +
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
> +			put_unaligned_be32(FIELD_PREP(AD4691_MSG_ADDR_HI,

Nothing unaligned here.

> +						      AD4691_ADC_CHAN(active_chans[i])),
> +					   &st->offload_tx_cmd[num_xfers]);
> +			xfer[num_xfers].tx_buf = &st->offload_tx_cmd[num_xfers];
> +			xfer[num_xfers].len = 4;
> +			xfer[num_xfers].bits_per_word = 32;

> +			xfer[num_xfers].speed_hz = spi->max_speed_hz;

This should already be the default.

> +			xfer[num_xfers].cs_change = 1;
> +			xfer[num_xfers].cs_change_delay.value = 1000;

This needs an explantion of where the number comes from. I would expect 430 ns
based on max value of t_CONV from the datasheet.

> +			xfer[num_xfers].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;

If it really is 1 microsecond, we can change the units.

> +			/* First transfer RX is garbage - don't capture it */
> +			if (num_xfers)

Would make more sense as (i > 0)

> +				xfer[num_xfers].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +			num_xfers++;

Why have 2nd variable instead of using i?

> +		}
> +
> +		/* Final NOOP to flush pipeline and get last channel's data */
> +		put_unaligned_be32(FIELD_PREP(AD4691_MSG_ADDR_HI, AD4691_NOOP),
> +				   &st->offload_tx_cmd[num_xfers]);
> +		xfer[num_xfers].tx_buf = &st->offload_tx_cmd[num_xfers];
> +		xfer[num_xfers].len = 4;
> +		xfer[num_xfers].bits_per_word = 32;
> +		xfer[num_xfers].speed_hz = spi->max_speed_hz;
> +		xfer[num_xfers].cs_change = 0;
> +		xfer[num_xfers].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +		num_xfers++;
> +	} else {
> +		/*
> +		 * CNV_CLOCK_MODE: single transfer per channel (2-byte cmd +
> +		 * 2-byte data = 4 bytes, one 32-bit SPI Engine DMA word).
> +		 * AVG_IN registers are used; RX layout: [cmd_hi, cmd_lo, d_hi, d_lo]

These comments are confusing. What it actually appears we are doing is
doing a 16-bit write and then a 16-bit read. I assume we are doing it
using 32-bit words for efficiny so that we only have 1/2 of the number
of xfers required to do it separately.

TX layout: [cmd_hi, cmd_lo, ignore, ignore]
RX layout: [ignore, ignore, data_hi, data_lo]


> +		 */
> +		for (i = 0; i < n_active; i++) {
> +			unsigned int reg;
> +			int ch = active_chans[i];
> +
> +			reg = AD4691_AVG_IN(ch);
> +			put_unaligned_be32(FIELD_PREP(AD4691_MSG_ADDR_HI, (reg >> 8) | 0x80) |

Mixing FIELD_PREP() and bit ops looks wrong.

> +					   FIELD_PREP(AD4691_MSG_ADDR_LO, reg & 0xFF),
> +					   &st->offload_tx_cmd[ch]);
> +			xfer[num_xfers].tx_buf = &st->offload_tx_cmd[ch];
> +			xfer[num_xfers].len = 4;
> +			xfer[num_xfers].bits_per_word = 32;
> +			xfer[num_xfers].speed_hz = spi->max_speed_hz;
> +			xfer[num_xfers].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +			xfer[num_xfers].cs_change = 1;
> +			num_xfers++;
> +		}
> +
> +		/* State reset: clear accumulator so DATA_READY can fire again. */
> +		put_unaligned_be32(FIELD_PREP(AD4691_MSG_ADDR_HI, AD4691_STATE_RESET_REG >> 8) |
> +				   FIELD_PREP(AD4691_MSG_ADDR_LO, AD4691_STATE_RESET_REG & 0xFF) |
> +				   FIELD_PREP(AD4691_MSG_DATA, AD4691_STATE_RESET_ALL),
> +				   &st->offload_tx_reset);
> +		xfer[num_xfers].tx_buf = &st->offload_tx_reset;
> +		xfer[num_xfers].len = 4;
> +		xfer[num_xfers].bits_per_word = 32;
> +		xfer[num_xfers].speed_hz = spi->max_speed_hz;
> +		xfer[num_xfers].cs_change = 0;
> +		num_xfers++;
> +	}
> +
> +	if (num_xfers == 0)
> +		return -EINVAL;
> +

...

> +static int ad4691_setup_offload(struct iio_dev *indio_dev,
> +				struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct dma_chan *rx_dma;
> +	int ret;
> +
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		st->offload_trigger_periodic = devm_spi_offload_trigger_get(dev,
> +				st->offload, SPI_OFFLOAD_TRIGGER_PERIODIC);
> +		if (IS_ERR(st->offload_trigger_periodic))
> +			return dev_err_probe(dev,
> +				PTR_ERR(st->offload_trigger_periodic),
> +				"failed to get periodic offload trigger\n");
> +
> +		st->offload_trigger_hz = AD4691_MANUAL_MODE_STD_FREQ(st->chip->num_channels,
> +								      spi->max_speed_hz);
> +	} else {
> +		struct spi_offload_trigger_info trigger_info = {
> +			.fwnode = dev_fwnode(dev),
> +			.ops = &ad4691_offload_trigger_ops,
> +			.priv = st,
> +		};
> +
> +		ret = devm_spi_offload_trigger_register(dev, &trigger_info);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to register offload trigger\n");
> +
> +		st->offload_trigger = devm_spi_offload_trigger_get(dev,
> +				st->offload, SPI_OFFLOAD_TRIGGER_DATA_READY);
> +		if (IS_ERR(st->offload_trigger))
> +			return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
> +					     "failed to get offload trigger\n");
> +	}
> +
> +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
> +	if (IS_ERR(rx_dma))
> +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> +				     "failed to get offload RX DMA\n");
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_HARDWARE;

We don't need to set INDIO_BUFFER_HARDWARE here,
devm_iio_dmaengine_buffer_setup_with_handle() does that already.

> +	indio_dev->setup_ops = &ad4691_offload_buffer_setup_ops;
> +
> +	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
> +			rx_dma, IIO_BUFFER_DIRECTION_IN);
> +}
> +

