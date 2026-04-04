Return-Path: <linux-pwm+bounces-8476-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HAKPBuk00WlcGgcAu9opvQ
	(envelope-from <linux-pwm+bounces-8476-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 04 Apr 2026 17:57:29 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E1C39BAAB
	for <lists+linux-pwm@lfdr.de>; Sat, 04 Apr 2026 17:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4471F300C26B
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Apr 2026 15:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE3F322B8B;
	Sat,  4 Apr 2026 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Zuq0TCBL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9F31960A
	for <linux-pwm@vger.kernel.org>; Sat,  4 Apr 2026 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775318246; cv=none; b=czeWaLPiQfU1oB3IwXSab08dsN4Ah18cMtpSijheBDP5SU7PFYMUZaW+B75UQkGbLlJxhy50V7u0Wh+4dKL/1FZ5izosYcoGHSV8iX6vnUpWW8dXb7IUYhvJ9y/yWRHKgrpXfxuVjKv6VgEXyT/DkEKTHUvjFhIJ2zf3w2rWz6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775318246; c=relaxed/simple;
	bh=I9Zc1R7+yUYIp68dd8Jqc6iCF/xRFUnDWe+7ow9SHeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8ih9t+Axz44apGT7RXuPC549aWLA9j9zNyuYveWoZv7RzqwOBJWgNc0HGYOlvSk+oY6UvKjk7cPU/U+UpIDPT4nT7kuzlpoJj7VTIFiLrgeKB8AhlYD7Vkd+ke/XAdt6Mhp10yXxzgpuchWBMbmLlU88Q1WjIeR1+QnVgV0xKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Zuq0TCBL; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-66f747175d8so1472896eaf.0
        for <linux-pwm@vger.kernel.org>; Sat, 04 Apr 2026 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775318242; x=1775923042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBJlkG7WAtThtA0KugNK0B/B0Wk0ExPVBWNuyoZfRiw=;
        b=Zuq0TCBL+X7JnG9hWQKoIoOWQc/b9PjxnZ6azoWz74E8I9ZyzifyYWsVqSy0ZM/BdE
         brfib2/Cn/PKC6uOPibWsLuLESFUMGdZcmaxQet7DIUuCdyFw4jMz8oO84hqLMZYlPD1
         nqK6l3CPgSZCBUH35g7RzBj1G0eaKwLXLptiaQldt4Sq4l2pj9fbc0X96WcfnFk0DMfa
         xyzHGoXbJNhXXyY0/dR+zCAClUE8jHDLQC0pTfPuB7IP+ruWjJNO/LoUMmHF2DtCP69A
         DBLsAx+DwJrk//SC/krEYe9OgwwRks0vwzOFoJapQSbUSBrR+a7zLJWqBGII9o7ESzcw
         XnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775318242; x=1775923042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBJlkG7WAtThtA0KugNK0B/B0Wk0ExPVBWNuyoZfRiw=;
        b=UB3DAcyCZ1wmCf3d3XqfhZx53x5i12grubgURZkY1Ifee0fdgtDL8NSdHXEdiX7nc4
         zh+7O4xjYaw3CUvDDABmAMaQqsc2QT9Ns6VERykPGezaDSFbH/tJO1UwgPvKK2rBTlgN
         aG2Ubc+uWhTgwD2cZRPdqevKmjoyYjXf3OLpCsNQ73h0EaoYdHkR67N8eiGJqgnn1Eoq
         cPFJXNRSw+8t06YBQpkdFxLq5cojqA8jmZQ6V9aox/USNqnwY1PBbcyl1wcWrIAF8Wxs
         dX6EOZVz05dnkR1u1Oqsabb+WCT9XXZJuzVsjU66L6aEZqHKLAhkCyTZgETavQLSW9OZ
         N32Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiKc1OjqINFv3TVPf/viCgBv3vLlWAEWuHAcpak0EOrALrw8fd67x/twkioG/rwEAlCZb9D17CqYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPTG5T0FN0KmRpXLroQOQWU/atQS1q9UStku5bsY08sqVm/3vi
	8+jQVhCUXxewOsUTFwcMcyb++5j/k8Mf2WSHL3UoUQT0sF7BefVvddQV0zahJyrrcaw=
X-Gm-Gg: AeBDietccg4LsfrYUoF6KjWR1aF4wg0AS44sKeKaeU2euORsGLCjS4FfNarOf2PHV9X
	DDJpE6y52MyybEuy0aV7G5jybifB3pt2TJEiyJcsnH1MlNlGWJJGqWkJessZUYZxLgpDCHB/1Dk
	0N8VsZoAKPJYb8OtChPGrRK4+hWpovCJQTPhT71PtLZR/6fQ9vBKAwGmqWQOt1welt9xFIV7j2H
	2GuJEwIZIHcIPZwXEhwK4/xEeeA8CLSuBXJFS/PwC1cLBlEy6WsWcMNS//f9k+1ZERuQL6QVOon
	abIyc+BgIKvu03rSiNWuTgNqM5jLNV13HdYth7WQfwbRKcDnEHQe9jPbdyrYvL240+3I4MizvpB
	BDTPrK3lhF2cxBF87figoO6H5JG4WAnG/euKyCIbHR/m7o4MEP5JpuTuvozht19M3pNm0wudBbG
	q+9VdE3RVCOkI4MO36qi5cIIva8FRfuKXh7MjrwqiH/wqCRrG7+4fq2xogit/WpnzyeEUZtjy9x
	w==
X-Received: by 2002:a05:6820:4c0b:b0:67a:1eaf:a912 with SMTP id 006d021491bc7-6821d747f37mr5208597eaf.2.1775318241917;
        Sat, 04 Apr 2026 08:57:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e14e:bcc6:3f95:26eb? ([2600:8803:e7e4:500:e14e:bcc6:3f95:26eb])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68448c1c15dsm673767eaf.0.2026.04.04.08.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 08:57:21 -0700 (PDT)
Message-ID: <22b44acb-bfb5-4b97-8fa2-aeb4aec704c2@baylibre.com>
Date: Sat, 4 Apr 2026 10:57:19 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] iio: adc: ad4691: add SPI offload support
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8476-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim,baylibre.com:mid,analog.com:email]
X-Rspamd-Queue-Id: 69E1C39BAAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 6:03 AM, Radu Sabau via B4 Relay wrote:
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
> for consistency. CNV Burst Mode channel data arrives in the lower 16
> bits of the 32-bit word (shift=0); Manual Mode data arrives in the upper
> 16 bits (shift=16), matching the 4-byte SPI transfer layout
> [data_hi, data_lo, 0, 0]. A separate ad4691_manual_channels[] array
> encodes the shift=16 scan type for manual mode.
> 
> Add driver documentation under Documentation/iio/ad4691.rst covering
> operating modes, oversampling, reference voltage, SPI offload paths,
> and buffer data layout; register in MAINTAINERS and index.rst
> 
> Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  Documentation/iio/ad4691.rst | 259 ++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   1 +
>  drivers/iio/adc/Kconfig      |   1 +
>  drivers/iio/adc/ad4691.c     | 422 ++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 676 insertions(+), 8 deletions(-)
> 

...

>  ANALOG DEVICES INC AD4695 DRIVER
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
> index f2a7273e43b9..cc2138e47feb 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c
> @@ -11,6 +11,7 @@
>  #include <linux/delay.h>
>  #include <linux/dev_printk.h>
>  #include <linux/device/devres.h>
> +#include <linux/dmaengine.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/math.h>
> @@ -22,10 +23,14 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/spi/spi.h>
> +#include <linux/spi/offload/consumer.h>
> +#include <linux/spi/offload/provider.h>
>  #include <linux/units.h>
>  #include <linux/unaligned.h>
>  
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dma.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>
> @@ -40,6 +45,7 @@
>  #define AD4691_VREF_4P096_uV_MAX		4500000
>  
>  #define AD4691_CNV_DUTY_CYCLE_NS		380
> +#define AD4691_CNV_HIGH_TIME_NS			430
>  
>  #define AD4691_SPI_CONFIG_A_REG			0x000
>  #define AD4691_SW_RESET				(BIT(7) | BIT(0))
> @@ -92,6 +98,8 @@
>  #define AD4691_ACC_IN(n)			(0x252 + (3 * (n)))
>  #define AD4691_ACC_STS_DATA(n)			(0x283 + (4 * (n)))
>  
> +#define AD4691_OFFLOAD_BITS_PER_WORD		32
> +
>  static const char * const ad4691_supplies[] = { "avdd", "vio" };
>  
>  enum ad4691_ref_ctrl {
> @@ -109,6 +117,31 @@ struct ad4691_chip_info {
>  	unsigned int max_rate;
>  };
>  
> +enum {
> +	AD4691_SCAN_TYPE_NORMAL,         /* triggered buffer:  storagebits=16, shift=0  */
> +	AD4691_SCAN_TYPE_OFFLOAD_CNV,    /* CNV burst offload: storagebits=32, shift=0  */
> +	AD4691_SCAN_TYPE_OFFLOAD_MANUAL, /* manual offload:    storagebits=32, shift=16 */
> +};
> +
> +static const struct iio_scan_type ad4691_scan_types[] = {
> +	[AD4691_SCAN_TYPE_NORMAL] = {
> +		.sign = 'u',
> +		.realbits = 16,
> +		.storagebits = 16,
> +	},
> +	[AD4691_SCAN_TYPE_OFFLOAD_CNV] = {
> +		.sign = 'u',
> +		.realbits = 16,
> +		.storagebits = 32,
> +	},
> +	[AD4691_SCAN_TYPE_OFFLOAD_MANUAL] = {
> +		.sign = 'u',
> +		.realbits = 16,
> +		.storagebits = 32,
> +		.shift = 16,
> +	},
> +};
> +
>  #define AD4691_CHANNEL(ch)						\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
> @@ -122,11 +155,9 @@ struct ad4691_chip_info {
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
>  		.channel = ch,						\
>  		.scan_index = ch,					\
> -		.scan_type = {						\
> -			.sign = 'u',					\
> -			.realbits = 16,					\
> -			.storagebits = 16,				\
> -		},							\
> +		.has_ext_scan_type = 1,					\
> +		.ext_scan_type = ad4691_scan_types,			\
> +		.num_ext_scan_type = ARRAY_SIZE(ad4691_scan_types),	\

Usually, we just make two separte ad4691_chip_info structs for offload
vs. not offload.

ext_scan_type is generally only used when the scan type can change
dynamically after probe.

>  	}
>  
>  static const struct iio_chan_spec ad4691_channels[] = {
> @@ -221,6 +252,17 @@ static const struct ad4691_chip_info ad4694_chip_info = {
>  	.max_rate = 1 * HZ_PER_MHZ,
>  };
>  
> +struct ad4691_offload_state {
> +	struct spi_offload *spi;
> +	struct spi_offload_trigger *trigger;
> +	u64 trigger_hz;
> +	struct spi_message msg;
> +	/* Max 16 channel xfers + 1 state-reset or NOOP */
> +	struct spi_transfer xfer[17];
> +	u8 tx_cmd[17][4];
> +	u8 tx_reset[4];
> +};
> +
>  struct ad4691_state {
>  	const struct ad4691_chip_info *info;
>  	struct regmap *regmap;
> @@ -251,6 +293,8 @@ struct ad4691_state {
>  	struct spi_transfer *scan_xfers;
>  	__be16 *scan_tx;
>  	__be16 *scan_rx;
> +	/* NULL when no SPI offload hardware is present */
> +	struct ad4691_offload_state *offload;
>  	/* Scan buffer: one slot per channel plus timestamp */
>  	struct {
>  		u16 vals[16];
> @@ -273,6 +317,46 @@ static int ad4691_gpio_setup(struct ad4691_state *st, unsigned int gp_num)
>  				  AD4691_GP_MODE_DATA_READY << shift);
>  }
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
> +	return type == SPI_OFFLOAD_TRIGGER_DATA_READY &&
> +	       nargs == 1 && args[0] <= 3;
> +}
> +
> +static int ad4691_offload_trigger_request(struct spi_offload_trigger *trigger,
> +					  enum spi_offload_trigger_type type,
> +					  u64 *args, u32 nargs)
> +{
> +	struct ad4691_state *st = spi_offload_trigger_get_priv(trigger);
> +
> +	if (nargs != 1)
> +		return -EINVAL;
> +
> +	return ad4691_gpio_setup(st, (unsigned int)args[0]);

Should be fine to leave out the cast here.

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
> +	.match    = ad4691_offload_trigger_match,
> +	.request  = ad4691_offload_trigger_request,
> +	.validate = ad4691_offload_trigger_validate,
> +};
> +
>  static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
>  {
>  	struct spi_device *spi = context;
> @@ -553,10 +637,17 @@ static int ad4691_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		*val = st->osr[chan->scan_index];
>  		return IIO_VAL_INT;
> -	case IIO_CHAN_INFO_SCALE:
> +	case IIO_CHAN_INFO_SCALE: {
> +		const struct iio_scan_type *scan_type;
> +
> +		scan_type = iio_get_current_scan_type(indio_dev, chan);
> +		if (IS_ERR(scan_type))
> +			return PTR_ERR(scan_type);
> +
>  		*val = st->vref_uV / (MICRO / MILLI);
> -		*val2 = chan->scan_type.realbits;
> +		*val2 = scan_type->realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -856,6 +947,213 @@ static const struct iio_buffer_setup_ops ad4691_cnv_burst_buffer_setup_ops = {
>  	.postdisable = &ad4691_cnv_burst_buffer_postdisable,
>  };
>  
> +static int ad4691_manual_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	struct ad4691_offload_state *offload = st->offload;
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct spi_offload_trigger_config config = {
> +		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
> +	};
> +	unsigned int bit, k;
> +	int ret;
> +
> +	ret = ad4691_enter_conversion_mode(st);
> +	if (ret)
> +		return ret;
> +
> +	memset(offload->xfer, 0, sizeof(offload->xfer));
> +
> +	/*
> +	 * N+1 transfers for N channels. Each CS-low period triggers
> +	 * a conversion AND returns the previous result (pipelined).
> +	 *   TX: [AD4691_ADC_CHAN(n), 0x00, 0x00, 0x00]
> +	 *   RX: [data_hi, data_lo, 0x00, 0x00]   (shift=16)
> +	 * Transfer 0 RX is garbage; transfers 1..N carry real data.
> +	 */
> +	k = 0;
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		offload->tx_cmd[k][0] = AD4691_ADC_CHAN(bit);
> +		offload->xfer[k].tx_buf = offload->tx_cmd[k];
> +		offload->xfer[k].len = sizeof(offload->tx_cmd[k]);
> +		offload->xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
> +		offload->xfer[k].cs_change = 1;
> +		offload->xfer[k].cs_change_delay.value = AD4691_CNV_HIGH_TIME_NS;
> +		offload->xfer[k].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
> +		/* First transfer RX is garbage — skip it. */
> +		if (k > 0)
> +			offload->xfer[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +		k++;
> +	}
> +
> +	/* Final NOOP to flush pipeline and capture last channel. */
> +	offload->tx_cmd[k][0] = AD4691_NOOP;
> +	offload->xfer[k].tx_buf = offload->tx_cmd[k];
> +	offload->xfer[k].len = sizeof(offload->tx_cmd[k]);
> +	offload->xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
> +	offload->xfer[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +	k++;
> +
> +	spi_message_init_with_transfers(&offload->msg, offload->xfer, k);
> +	offload->msg.offload = offload->spi;
> +
> +	ret = spi_optimize_message(spi, &offload->msg);
> +	if (ret)
> +		goto err_exit_conversion;
> +
> +	config.periodic.frequency_hz = offload->trigger_hz;
> +	ret = spi_offload_trigger_enable(offload->spi, offload->trigger, &config);
> +	if (ret)
> +		goto err_unoptimize;
> +
> +	return 0;
> +
> +err_unoptimize:
> +	spi_unoptimize_message(&offload->msg);
> +err_exit_conversion:
> +	ad4691_exit_conversion_mode(st);
> +	return ret;
> +}
> +
> +static int ad4691_manual_offload_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	struct ad4691_offload_state *offload = st->offload;
> +
> +	spi_offload_trigger_disable(offload->spi, offload->trigger);
> +	spi_unoptimize_message(&offload->msg);
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
> +	unsigned int n_active = bitmap_weight(indio_dev->active_scan_mask,
> +					      iio_get_masklength(indio_dev));
> +	unsigned int bit, k;
> +	int ret;
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
> +	if (ret)
> +		return ret;
> +
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(bit),
> +				   st->osr[bit]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ad4691_enter_conversion_mode(st);
> +	if (ret)
> +		return ret;
> +
> +	memset(offload->xfer, 0, sizeof(offload->xfer));
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
> +		offload->tx_cmd[k][0] = (reg >> 8) | 0x80;
> +		offload->tx_cmd[k][1] = reg & 0xFF;

Can we use put_unaligned_be16()?

> +		offload->xfer[k].tx_buf = offload->tx_cmd[k];
> +		offload->xfer[k].len = sizeof(offload->tx_cmd[k]);
> +		offload->xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
> +		offload->xfer[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +		if (k < n_active - 1)
> +			offload->xfer[k].cs_change = 1;
> +		k++;
> +	}
> +
> +	/* State reset to re-arm DATA_READY for the next scan. */
> +	offload->tx_reset[0] = AD4691_STATE_RESET_REG >> 8;
> +	offload->tx_reset[1] = AD4691_STATE_RESET_REG & 0xFF;

ditto.

> +	offload->tx_reset[2] = AD4691_STATE_RESET_ALL;
> +	offload->xfer[k].tx_buf = offload->tx_reset;
> +	offload->xfer[k].len = sizeof(offload->tx_reset);
> +	offload->xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
> +	k++;
> +
> +	spi_message_init_with_transfers(&offload->msg, offload->xfer, k);
> +	offload->msg.offload = offload->spi;
> +
> +	ret = spi_optimize_message(spi, &offload->msg);
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
> +	spi_unoptimize_message(&offload->msg);
> +err_exit_conversion:
> +	ad4691_exit_conversion_mode(st);
> +	return ret;
> +}
> +
> +static int ad4691_cnv_burst_offload_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	struct ad4691_offload_state *offload = st->offload;
> +	int ret;
> +
> +	spi_offload_trigger_disable(offload->spi, offload->trigger);
> +
> +	ret = ad4691_sampling_enable(st, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   AD4691_SEQ_ALL_CHANNELS_OFF);
> +	if (ret)
> +		return ret;
> +
> +	spi_unoptimize_message(&offload->msg);
> +
> +	return ad4691_exit_conversion_mode(st);
> +}
> +
> +static const struct iio_buffer_setup_ops ad4691_cnv_burst_offload_buffer_setup_ops = {
> +	.postenable = &ad4691_cnv_burst_offload_buffer_postenable,
> +	.predisable = &ad4691_cnv_burst_offload_buffer_predisable,
> +};
> +
>  static ssize_t sampling_frequency_show(struct device *dev,
>  				       struct device_attribute *attr,
>  				       char *buf)
> @@ -863,6 +1161,9 @@ static ssize_t sampling_frequency_show(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad4691_state *st = iio_priv(indio_dev);
>  
> +	if (st->manual_mode && st->offload)
> +		return sysfs_emit(buf, "%llu\n", st->offload->trigger_hz);
> +
>  	return sysfs_emit(buf, "%u\n", (u32)(NSEC_PER_SEC / st->cnv_period_ns));
>  }
>  
> @@ -883,6 +1184,20 @@ static ssize_t sampling_frequency_store(struct device *dev,
>  	if (iio_buffer_enabled(indio_dev))
>  		return -EBUSY;
>  
> +	if (st->manual_mode && st->offload) {
> +		struct spi_offload_trigger_config config = {
> +			.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
> +			.periodic = { .frequency_hz = freq },
> +		};

Same comment as other patches. This needs to account for oversampling ratio.

> +
> +		ret = spi_offload_trigger_validate(st->offload->trigger, &config);
> +		if (ret)
> +			return ret;
> +
> +		st->offload->trigger_hz = config.periodic.frequency_hz;
> +		return len;
> +	}
> +
>  	ret = ad4691_set_pwm_freq(st, freq);
>  	if (ret)
>  		return ret;
> @@ -968,10 +1283,23 @@ static irqreturn_t ad4691_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> +static int ad4691_get_current_scan_type(const struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +
> +	if (!st->offload)
> +		return AD4691_SCAN_TYPE_NORMAL;
> +	if (st->manual_mode)
> +		return AD4691_SCAN_TYPE_OFFLOAD_MANUAL;
> +	return AD4691_SCAN_TYPE_OFFLOAD_CNV;
> +}
> +
>  static const struct iio_info ad4691_info = {
>  	.read_raw = &ad4691_read_raw,
>  	.write_raw = &ad4691_write_raw,
>  	.read_avail = &ad4691_read_avail,
> +	.get_current_scan_type = &ad4691_get_current_scan_type,
>  	.debugfs_reg_access = &ad4691_reg_access,
>  };
>  
> @@ -1195,9 +1523,75 @@ static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
>  					       &ad4691_manual_buffer_setup_ops);
>  }
>  
> +static int ad4691_setup_offload(struct iio_dev *indio_dev,
> +				struct ad4691_state *st,
> +				struct spi_offload *spi_offload)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct ad4691_offload_state *offload;
> +	struct dma_chan *rx_dma;
> +	int ret;
> +
> +	offload = devm_kzalloc(dev, sizeof(*offload), GFP_KERNEL);
> +	if (!offload)
> +		return -ENOMEM;
> +
> +	offload->spi = spi_offload;
> +	st->offload = offload;
> +
> +	if (st->manual_mode) {
> +		offload->trigger =
> +			devm_spi_offload_trigger_get(dev, offload->spi,
> +						     SPI_OFFLOAD_TRIGGER_PERIODIC);
> +		if (IS_ERR(offload->trigger))
> +			return dev_err_probe(dev, PTR_ERR(offload->trigger),
> +					     "Failed to get periodic offload trigger\n");
> +
> +		offload->trigger_hz = st->info->max_rate;

I think I mentioned this elsewhere, but can we really get max_rate in manual mode
due to the extra SPI overhead? Probably safer to start with a lower rate.

> +	} else {
> +		struct spi_offload_trigger_info trigger_info = {
> +			.fwnode = dev_fwnode(dev),
> +			.ops    = &ad4691_offload_trigger_ops,
> +			.priv   = st,
> +		};
> +
> +		ret = devm_spi_offload_trigger_register(dev, &trigger_info);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to register offload trigger\n");
> +
> +		offload->trigger =
> +			devm_spi_offload_trigger_get(dev, offload->spi,
> +						     SPI_OFFLOAD_TRIGGER_DATA_READY);
> +		if (IS_ERR(offload->trigger))
> +			return dev_err_probe(dev, PTR_ERR(offload->trigger),
> +					     "Failed to get DATA_READY offload trigger\n");
> +	}
> +
> +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, offload->spi);
> +	if (IS_ERR(rx_dma))
> +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> +				     "Failed to get offload RX DMA channel\n");
> +
> +	if (st->manual_mode)
> +		indio_dev->setup_ops = &ad4691_manual_offload_buffer_setup_ops;
> +	else
> +		indio_dev->setup_ops = &ad4691_cnv_burst_offload_buffer_setup_ops;
> +
> +	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
> +							  IIO_BUFFER_DIRECTION_IN);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->buffer->attrs = ad4691_buffer_attrs;

Should including ad4691_buffer_attrs depend on st->manual_mode?

I thought it was only used when PWM is connected to CNV.

> +
> +	return 0;
> +}
> +
>  static int ad4691_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> +	struct spi_offload *spi_offload;
>  	struct iio_dev *indio_dev;
>  	struct ad4691_state *st;
>  	int ret;
> @@ -1232,6 +1626,13 @@ static int ad4691_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	spi_offload = devm_spi_offload_get(dev, spi, &ad4691_offload_config);
> +	ret = PTR_ERR_OR_ZERO(spi_offload);
> +	if (ret == -ENODEV)
> +		spi_offload = NULL;
> +	else if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get SPI offload\n");
> +
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &ad4691_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -1239,7 +1640,10 @@ static int ad4691_probe(struct spi_device *spi)
>  	indio_dev->channels = st->info->channels;
>  	indio_dev->num_channels = st->info->num_channels;

As mentioned earlier, we generally want separate channel structs
for SPI offload. These will also have different num_channels because
there is no timestamp channel in SPI offload.

>  
> -	ret = ad4691_setup_triggered_buffer(indio_dev, st);
> +	if (spi_offload)
> +		ret = ad4691_setup_offload(indio_dev, st, spi_offload);
> +	else
> +		ret = ad4691_setup_triggered_buffer(indio_dev, st);
>  	if (ret)
>  		return ret;
>  
> @@ -1277,3 +1681,5 @@ module_spi_driver(ad4691_driver);
>  MODULE_AUTHOR("Radu Sabau <radu.sabau@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD4691 Family ADC Driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_DMA_BUFFER");
> +MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
> 


