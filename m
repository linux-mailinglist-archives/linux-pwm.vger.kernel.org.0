Return-Path: <linux-pwm+bounces-8262-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHgrNKmOtWmX1wAAu9opvQ
	(envelope-from <linux-pwm+bounces-8262-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 17:36:57 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5136728DEDC
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 17:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B0A4300D37B
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1F3043B2;
	Sat, 14 Mar 2026 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CssAZYmA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD3286A7
	for <linux-pwm@vger.kernel.org>; Sat, 14 Mar 2026 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773506214; cv=none; b=Vi6MWxIuoSsS8JX9+9aA9BdJLcpwiRKJczEYJ8ImipqHNOVOVMbf4SYqT1KE62gh3UmTiHGzgZJnnYQR+udPgLT27nrvm3GgxpT2Dokdz5MU9Q35B95IhnN2LmXe+KO5jvk0kCP5ZXtaKm64OGzhnYnqi6wolMgI1isBIGTn8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773506214; c=relaxed/simple;
	bh=k1Y8TgfYbhysVRnukEhW+1EWo5zrkZCsGqeoSCYkGAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/4cCCkOGFXFYNiaMHWiYt/ELgQpZWIS7RHBhkeIdn5neD4c3GYDTzYiZhF918MWtc+NSOmnZ0nbFsuoBpDb8h3zL56KF05qoOb6VdeYDcAcF2eBQoH5C2qFAsuw2kFMbAqDFB9H59Ethh1UJ9rFvqMMZTeH/frmMKwzIaZ1T9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CssAZYmA; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d749f99691so1547305a34.3
        for <linux-pwm@vger.kernel.org>; Sat, 14 Mar 2026 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773506210; x=1774111010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GP8TCAmV+sEBdph0Dyg7uEwuCToVskjd/wPHYMbnYeM=;
        b=CssAZYmAEjFFg/nlYZdXwvggE297gCYnTdp7YTEJPGW//+RoXQEjryDLolvZ1dT7PH
         Ppvp0sd3HJVnoyDrYikbKzZkP2PSC40kCzNQRomqFzq7UxnMELiYq4rQ2AUAcOHWzzQr
         UhPtt16n5y8rmx4/23NPqsHXXCPw1bdC28urLA/mKGdZEp6E9rthiURV9bdfdJWn8/4C
         /PE5vf+A8SiKkdDjWVSHKp1iIrW4+PpQhPoF2UrtsrCz74mkCaTek2kh3HauuyfcdtUv
         0coApG/7j64Bdqya5neuJa+ATpBC7H2N5g1oq5OspFKt2tOjWKyQz/1LhJyETxvtuHah
         aGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773506210; x=1774111010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GP8TCAmV+sEBdph0Dyg7uEwuCToVskjd/wPHYMbnYeM=;
        b=d4e7UIUVz+vPa85JIcV1FdzdHKfhIOp0g5SyD5ISBpNNtV3JhUN+3PJ4TChrYj2Sv5
         IbxTfWNjb+/1gaLXs1VMzSSu63xY7xhgDf/y8SCFfs5cPZlGKl1GLWYV4jnF7iWfSJ6J
         mc6a3SXcQiInq9v3B0GsWzDSYeBVNJSlauVDSIrjyD4zL1ArzO0ihPKkVbxL847A59Fm
         86iQnBaK5PFRE6nSMO5olNiYkdDAAibjgDjZuNGC0tCKsqfYwpVQItL23h4+i0P6vm6M
         TPPRSQgeYRDJOEI8OIrNqWOgx45kx6RlT2odLn8CJeqixsI3ctj7WiP+fH+mBQei7wOx
         DpCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyaWLNsD+yASajrcqWSpsAccUG+CcCiJwwggtqEACceEHI+CRJeWiOhosHrM7U0XZB2vROzniUS6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK5boqDGWVCKlsTs50U47DbWvs+kGyHg83JjvRrT3KegLe8YKA
	smyYCY8T+SKVbdYV8fYuOQSSDozkLmItjzZUIkThbcst0GUChNlzqieTTMSFMqxmdD2dUr4dQcC
	pXtmZ
X-Gm-Gg: ATEYQzxrKb1oHAHHt2GrANqyII134agwgFGaNp9QRsJd7lfIcqo/VbL0wzhQ5ASZ++f
	IxpSXrOCh3cfZUIIX6aOgvVSYB1Fgd8enz3PId74gY3/+GW5wSJ2SAXDuuAKOEoghbc9ksTA6LC
	bL9Ntm2Yv/1WHUwe/gt8y5medK6VX3zHRy6+4wUH2T3z48ZAuyDx7+lIL9UJpt32qrIwD77Okzh
	YLxqRI0VvLwKTDZKXwZ1FgSBhi5OnV/ed63zriWBFJiUnbfL1RAz1lRd04Zvdvwa38+vn76VJtg
	7uujsTB6LbhI6SWX/UyRDNgKRg77x24vjIhgARUZUs8XoGxob09BOE+i6AfICx1i1IitrUYBoL8
	iGlW/CMYfuXC8WU2/y3SttNHyRH8ave0qtWyjN38NXTZsc0vnrN2JHtJp4H7pi6y0deo8cyQT75
	wmm4Woo8MX0ZXVn59N5w5wdfP5BI0VqMZrQVEs89MzLhI0q1X9YGa0hWJJniqkXqaDjfMJK6b8N
	Q==
X-Received: by 2002:a05:6830:6503:b0:7d7:4b65:e8d2 with SMTP id 46e09a7af769-7d78243bcc4mr4678197a34.1.1773506209892;
        Sat, 14 Mar 2026 09:36:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ac898d6sm8642882a34.9.2026.03.14.09.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 09:36:49 -0700 (PDT)
Message-ID: <aa83d2ab-a531-4f3c-869b-85c323c469c7@baylibre.com>
Date: Sat, 14 Mar 2026 11:36:48 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
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
 <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8262-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,baylibre.com:mid,analog.com:email,analog.com:url,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5136728DEDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 5:07 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
> 
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
> 
> Two buffered operating modes are supported, auto-detected from the
> device tree:
> 
>     - CNV Clock Mode:  an external PWM drives the CNV pin; the sampling
>                        rate is controlled via the PWM period. Requires a
>                        reference clock and a DATA_READY interrupt.
> 
>     - Manual Mode:     CNV is tied to SPI CS; each SPI transfer triggers
>                        a conversion and returns the previous result
>                        (pipelined). No external clock or interrupt needed.
> 
> In both modes the chip idles in Autonomous Mode so that single-shot
> read_raw can use the internal oscillator without disturbing the
> hardware configuration.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/iio/adc/Kconfig  |  11 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad4691.c | 772 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 785 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9994d107d88d..5325f7d3b7f4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1490,6 +1490,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> +F:	drivers/iio/adc/ad4691.c
>  F:	include/dt-bindings/iio/adc/adi,ad4691.h
>  
>  ANALOG DEVICES INC AD4695 DRIVER
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 60038ae8dfc4..3685a03aa8dc 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -139,6 +139,17 @@ config AD4170_4
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad4170-4.
>  
> +config AD4691
> +	tristate "Analog Devices AD4691 Family ADC Driver"
> +	depends on SPI
> +	select REGMAP
> +	help
> +	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
> +	  SPI analog to digital converters (ADC).
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad4691.
> +
>  config AD4695
>  	tristate "Analog Device AD4695 ADC Driver"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index c76550415ff1..4ac1ea09d773 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_AD4080) += ad4080.o
>  obj-$(CONFIG_AD4130) += ad4130.o
>  obj-$(CONFIG_AD4134) += ad4134.o
>  obj-$(CONFIG_AD4170_4) += ad4170-4.o
> +obj-$(CONFIG_AD4691) += ad4691.o
>  obj-$(CONFIG_AD4695) += ad4695.o
>  obj-$(CONFIG_AD4851) += ad4851.o
>  obj-$(CONFIG_AD7091R) += ad7091r-base.o
> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> new file mode 100644
> index 000000000000..31eafa12bef8
> --- /dev/null
> +++ b/drivers/iio/adc/ad4691.c
> @@ -0,0 +1,772 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024-2026 Analog Devices, Inc.
> + * Author: Radu Sabau <radu.sabau@analog.com>
> + */
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/reset.h>
> +#include <linux/interrupt.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/util_macros.h>
> +#include <linux/units.h>
> +#include <linux/unaligned.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#include <dt-bindings/iio/adc/adi,ad4691.h>
> +
> +#define AD4691_VREF_uV_MIN			2400000
> +#define AD4691_VREF_uV_MAX			5250000
> +
> +/*
> + * Default sampling frequency for MANUAL_MODE.
> + * Each sample needs (num_channels + 1) SPI transfers of 24 bits.
> + * The factor 36 = 24 * 3/2 folds in a 50% scheduling margin:
> + *   freq = spi_hz / (24 * 3/2 * (num_channels + 1))
> + *        = spi_hz / (36 * (num_channels + 1))
> + */
> +#define AD4691_MANUAL_MODE_STD_FREQ(x, y)	((y) / (36 * ((x) + 1)))
> +#define AD4691_BITS_PER_XFER			24
> +#define AD4691_CNV_DUTY_CYCLE_NS		380
> +#define AD4691_MAX_CONV_PERIOD_US		800
> +
> +#define AD4691_SEQ_ALL_CHANNELS_OFF		0x00
> +#define AD4691_STATE_RESET_ALL			0x01
> +
> +#define AD4691_REF_CTRL_MASK			GENMASK(4, 2)
> +
> +#define AD4691_DEVICE_MANUAL			0x14
> +#define AD4691_DEVICE_REGISTER			0x10
> +#define AD4691_AUTONOMOUS_MODE_VAL		0x02
> +
> +#define AD4691_NOOP				0x00
> +#define AD4691_ADC_CHAN(ch)			((0x10 + (ch)) << 3)
> +
> +#define AD4691_STATUS_REG			0x014
> +#define AD4691_CLAMP_STATUS1_REG		0x01A
> +#define AD4691_CLAMP_STATUS2_REG		0x01B
> +#define AD4691_DEVICE_SETUP			0x020
> +#define AD4691_REF_CTRL				0x021
> +#define AD4691_OSC_FREQ_REG			0x023
> +#define AD4691_STD_SEQ_CONFIG			0x025
> +#define AD4691_SPARE_CONTROL			0x02A
> +
> +#define AD4691_OSC_EN_REG			0x180
> +#define AD4691_STATE_RESET_REG			0x181
> +#define AD4691_ADC_SETUP			0x182
> +#define AD4691_ACC_MASK1_REG			0x184
> +#define AD4691_ACC_MASK2_REG			0x185
> +#define AD4691_ACC_COUNT_LIMIT(n)		(0x186 + (n))
> +#define AD4691_ACC_COUNT_VAL			0x3F
> +#define AD4691_GPIO_MODE1_REG			0x196
> +#define AD4691_GPIO_MODE2_REG			0x197
> +#define AD4691_GPIO_READ			0x1A0
> +#define AD4691_ACC_STATUS_FULL1_REG		0x1B0
> +#define AD4691_ACC_STATUS_FULL2_REG		0x1B1
> +#define AD4691_ACC_STATUS_OVERRUN1_REG		0x1B2
> +#define AD4691_ACC_STATUS_OVERRUN2_REG		0x1B3
> +#define AD4691_ACC_STATUS_SAT1_REG		0x1B4
> +#define AD4691_ACC_STATUS_SAT2_REG		0x1BE
> +#define AD4691_ACC_SAT_OVR_REG(n)		(0x1C0 + (n))
> +#define AD4691_AVG_IN(n)			(0x201 + (2 * (n)))
> +#define AD4691_AVG_STS_IN(n)			(0x222 + (3 * (n)))
> +#define AD4691_ACC_IN(n)			(0x252 + (3 * (n)))
> +#define AD4691_ACC_STS_DATA(n)			(0x283 + (4 * (n)))
> +
> +enum ad4691_adc_mode {
> +	AD4691_CNV_CLOCK_MODE,
> +	AD4691_MANUAL_MODE,
> +};
> +
> +enum ad4691_gpio_mode {
> +	AD4691_ADC_BUSY   = 4,
> +	AD4691_DATA_READY = 6,
> +};
> +
> +enum ad4691_ref_ctrl {
> +	AD4691_VREF_2P5   = 0,
> +	AD4691_VREF_3P0   = 1,
> +	AD4691_VREF_3P3   = 2,
> +	AD4691_VREF_4P096 = 3,
> +	AD4691_VREF_5P0   = 4,
> +};
> +
> +struct ad4691_chip_info {
> +	const struct iio_chan_spec *channels;
> +	const struct iio_chan_spec *manual_channels;
> +	const char *name;
> +	unsigned int num_channels;
> +	unsigned int max_rate;
> +};
> +
> +#define AD4691_CHANNEL(chan, index, real_bits, storage_bits, _shift)	\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
> +					   | BIT(IIO_CHAN_INFO_SCALE),	\
> +		.channel = chan,					\
> +		.scan_index = index,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = real_bits,				\
> +			.storagebits = storage_bits,			\
> +			.shift = _shift,				\
> +		},							\
> +	}
> +
> +static const struct iio_chan_spec ad4691_channels[] = {
> +	AD4691_CHANNEL(0, 0, 16, 32, 0),
> +	AD4691_CHANNEL(1, 1, 16, 32, 0),
> +	AD4691_CHANNEL(2, 2, 16, 32, 0),
> +	AD4691_CHANNEL(3, 3, 16, 32, 0),
> +	AD4691_CHANNEL(4, 4, 16, 32, 0),
> +	AD4691_CHANNEL(5, 5, 16, 32, 0),
> +	AD4691_CHANNEL(6, 6, 16, 32, 0),
> +	AD4691_CHANNEL(7, 7, 16, 32, 0),
> +	AD4691_CHANNEL(8, 8, 16, 32, 0),
> +	AD4691_CHANNEL(9, 9, 16, 32, 0),
> +	AD4691_CHANNEL(10, 10, 16, 32, 0),
> +	AD4691_CHANNEL(11, 11, 16, 32, 0),
> +	AD4691_CHANNEL(12, 12, 16, 32, 0),
> +	AD4691_CHANNEL(13, 13, 16, 32, 0),
> +	AD4691_CHANNEL(14, 14, 16, 32, 0),
> +	AD4691_CHANNEL(15, 15, 16, 32, 0)
> +};
> +
> +static const struct iio_chan_spec ad4693_channels[] = {
> +	AD4691_CHANNEL(0, 0, 16, 32, 0),
> +	AD4691_CHANNEL(1, 1, 16, 32, 0),
> +	AD4691_CHANNEL(2, 2, 16, 32, 0),
> +	AD4691_CHANNEL(3, 3, 16, 32, 0),
> +	AD4691_CHANNEL(4, 4, 16, 32, 0),
> +	AD4691_CHANNEL(5, 5, 16, 32, 0),
> +	AD4691_CHANNEL(6, 6, 16, 32, 0),
> +	AD4691_CHANNEL(7, 7, 16, 32, 0)
> +};

I would expect the 16-bits in 32-bits to be only for SPI offload and
therefore not introduced until the later patch that adds SPI offload
support. And we should include a comment on why it is needed so that
no one tries to "fix" it later (since normally we would use 16-bit
storage for 16-bit data).

> +
> +static const struct iio_chan_spec ad4691_manual_channels[] = {
> +	AD4691_CHANNEL(0, 0, 16, 24, 8),
> +	AD4691_CHANNEL(1, 1, 16, 24, 8),
> +	AD4691_CHANNEL(2, 2, 16, 24, 8),
> +	AD4691_CHANNEL(3, 3, 16, 24, 8),
> +	AD4691_CHANNEL(4, 4, 16, 24, 8),
> +	AD4691_CHANNEL(5, 5, 16, 24, 8),
> +	AD4691_CHANNEL(6, 6, 16, 24, 8),
> +	AD4691_CHANNEL(7, 7, 16, 24, 8),
> +	AD4691_CHANNEL(8, 8, 16, 24, 8),
> +	AD4691_CHANNEL(9, 9, 16, 24, 8),
> +	AD4691_CHANNEL(10, 10, 16, 24, 8),
> +	AD4691_CHANNEL(11, 11, 16, 24, 8),
> +	AD4691_CHANNEL(12, 12, 16, 24, 8),
> +	AD4691_CHANNEL(13, 13, 16, 24, 8),
> +	AD4691_CHANNEL(14, 14, 16, 24, 8),
> +	AD4691_CHANNEL(15, 15, 16, 24, 8)
> +};

Can't have 24-bit storage, but I guess that got fixed in a later patch.


> +
> +static const struct iio_chan_spec ad4693_manual_channels[] = {
> +	AD4691_CHANNEL(0, 0, 16, 24, 8),
> +	AD4691_CHANNEL(1, 1, 16, 24, 8),
> +	AD4691_CHANNEL(2, 2, 16, 24, 8),
> +	AD4691_CHANNEL(3, 3, 16, 24, 8),
> +	AD4691_CHANNEL(4, 4, 16, 24, 8),
> +	AD4691_CHANNEL(5, 5, 16, 24, 8),
> +	AD4691_CHANNEL(6, 6, 16, 24, 8),
> +	AD4691_CHANNEL(7, 7, 16, 24, 8)
> +};

channel and index is always the same, so we can combine that into
one argument.

> +
> +static const struct ad4691_chip_info ad4691_ad4691 = {

Usually, we name these like: ad4691_chip_info instead of ad4691_ad4691.

> +	.channels = ad4691_channels,
> +	.manual_channels = ad4691_manual_channels,
> +	.name = "ad4691",
> +	.num_channels = ARRAY_SIZE(ad4691_channels),
> +	.max_rate = 500 * HZ_PER_KHZ,
> +};
> +
> +static const struct ad4691_chip_info ad4691_ad4692 = {

And here would be ad4692_chip_info.

> +	.channels = ad4691_channels,
> +	.manual_channels = ad4691_manual_channels,
> +	.name = "ad4692",
> +	.num_channels = ARRAY_SIZE(ad4691_channels),
> +	.max_rate = 1 * HZ_PER_MHZ,
> +};
> +
> +static const struct ad4691_chip_info ad4691_ad4693 = {
> +	.channels = ad4693_channels,
> +	.manual_channels = ad4693_manual_channels,
> +	.name = "ad4693",
> +	.num_channels = ARRAY_SIZE(ad4693_channels),
> +	.max_rate = 500 * HZ_PER_KHZ,
> +};
> +
> +static const struct ad4691_chip_info ad4691_ad4694 = {
> +	.channels = ad4693_channels,
> +	.manual_channels = ad4693_manual_channels,
> +	.name = "ad4694",
> +	.num_channels = ARRAY_SIZE(ad4693_channels),
> +	.max_rate = 1 * HZ_PER_MHZ,
> +};
> +
> +struct ad4691_state {
> +	const struct ad4691_chip_info	*chip;

Usually, we would call this "info" rather than "chip".

> +	struct regmap			*regmap;
> +
> +	unsigned long			ref_clk_rate;
> +	struct pwm_device		*conv_trigger;
> +
> +	enum ad4691_adc_mode		adc_mode;
> +
> +	int				vref_uV;
> +	u64				cnv_period;

Always include units in variable names when possible. Is this ns?

> +	ktime_t				sampling_period;
> +	/*
> +	 * Synchronize access to members of the driver state, and ensure
> +	 * atomicity of consecutive SPI operations.
> +	 */
> +	struct mutex			lock;
> +};
> +
> +static void ad4691_disable_pwm(void *data)
> +{
> +	struct pwm_device *pwm = data;
> +	struct pwm_state state;
> +
> +	pwm_get_state(pwm, &state);
> +	state.enabled = false;
> +	pwm_apply_might_sleep(pwm, &state);

See Uwe's comment from v2. This is why we always tell people to wait a week
before sending a new revision. It takes a while for all comments to come in.

> +}
> +
> +static int ad4691_regulator_get(struct ad4691_state *st)

Would be more logical to keep this close to probe function since it is
only used during probe.

> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	int ret;
> +

As mentioned in the DT review, there are also avdd and ldo-in regulators that can
be handled here.

Later we may need to set DEVICE_SETUP:LDO_EN based on this info.

> +	ret = devm_regulator_get_enable(dev, "vio");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable VIO\n");
> +
> +	st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (st->vref_uV == -ENODEV)
> +		st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "vrefin");

Don't we need to keep track of REF vs. REFIN so that we can set REF_CTRL:REFBUF_EN
correctly later?

> +	if (st->vref_uV < 0)
> +		return dev_err_probe(dev, st->vref_uV,
> +				     "Failed to get reference supply\n");
> +
> +	if (st->vref_uV < AD4691_VREF_uV_MIN || st->vref_uV > AD4691_VREF_uV_MAX)
> +		return dev_err_probe(dev, -EINVAL, "vref(%d) must be under [%u %u]\n",
> +				     st->vref_uV, AD4691_VREF_uV_MIN, AD4691_VREF_uV_MAX);
> +
> +	return 0;
> +}
> +
> +static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct ad4691_state *st = context;
> +	struct spi_device *spi = to_spi_device(regmap_get_device(st->regmap));
> +	u8 tx[2], rx[4];
> +	int ret;
> +
> +	put_unaligned_be16(0x8000 | reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
> +		ret = spi_write_then_read(spi, tx, 2, rx, 1);
> +		if (ret)
> +			return ret;
> +		*val = rx[0];
> +		return 0;
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +		ret = spi_write_then_read(spi, tx, 2, rx, 2);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be16(rx);
> +		return 0;
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +		ret = spi_write_then_read(spi, tx, 2, rx, 3);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be24(rx);
> +		return 0;
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		ret = spi_write_then_read(spi, tx, 2, rx, 4);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be32(rx);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct ad4691_state *st = context;
> +	struct spi_device *spi = to_spi_device(regmap_get_device(st->regmap));
> +	u8 tx[4];
> +
> +	put_unaligned_be16(reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_GPIO_MODE2_REG:
> +		if (val > 0xFF)
> +			return -EINVAL;
> +		tx[2] = val;
> +		return spi_write_then_read(spi, tx, 3, NULL, 0);
> +	case AD4691_STD_SEQ_CONFIG:
> +		if (val > 0xFFFF)
> +			return -EINVAL;
> +		put_unaligned_be16(val, &tx[2]);
> +		return spi_write_then_read(spi, tx, 4, NULL, 0);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static bool ad4691_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case AD4691_STATUS_REG:
> +	case AD4691_CLAMP_STATUS1_REG:
> +	case AD4691_CLAMP_STATUS2_REG:
> +	case AD4691_GPIO_READ:
> +	case AD4691_ACC_STATUS_FULL1_REG ... AD4691_ACC_STATUS_SAT2_REG:
> +	case AD4691_ACC_SAT_OVR_REG(0) ... AD4691_ACC_SAT_OVR_REG(15):
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool ad4691_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool ad4691_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_SPARE_CONTROL ... AD4691_GPIO_MODE2_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config ad4691_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 32,
> +	.reg_read = ad4691_reg_read,
> +	.reg_write = ad4691_reg_write,
> +	.volatile_reg = ad4691_volatile_reg,
> +	.readable_reg = ad4691_readable_reg,
> +	.writeable_reg = ad4691_writeable_reg,
> +	.max_register = AD4691_ACC_STS_DATA(15),
> +	.cache_type = REGCACHE_MAPLE,
> +};
> +
> +static int ad4691_get_sampling_freq(struct ad4691_state *st)
> +{
> +	if (st->adc_mode == AD4691_MANUAL_MODE)
> +		return DIV_ROUND_CLOSEST(NSEC_PER_SEC,
> +					 ktime_to_ns(st->sampling_period));
> +
> +	return DIV_ROUND_CLOSEST(NSEC_PER_SEC,
> +				 pwm_get_period(st->conv_trigger));
> +}
> +
> +static int __ad4691_set_sampling_freq(struct ad4691_state *st, int freq)
> +{
> +	unsigned long long target, ref_clk_period_ns;
> +	struct pwm_state cnv_state;
> +
> +	pwm_init_state(st->conv_trigger, &cnv_state);
> +
> +	freq = clamp(freq, 1, st->chip->max_rate);
> +	target = DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate, freq);
> +	ref_clk_period_ns = DIV_ROUND_CLOSEST_ULL(NANO, st->ref_clk_rate);
> +	st->cnv_period = ref_clk_period_ns * target;
> +	cnv_state.period = ref_clk_period_ns * target;
> +	cnv_state.duty_cycle = AD4691_CNV_DUTY_CYCLE_NS;
> +	cnv_state.enabled = false;
> +
> +	return pwm_apply_might_sleep(st->conv_trigger, &cnv_state);
> +}
> +
> +static int ad4691_pwm_get(struct ad4691_state *st)

"get" is confusing name for a "setup" function.

> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct clk *ref_clk;
> +	int ret;
> +
> +	ref_clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(ref_clk))
> +		return dev_err_probe(dev, PTR_ERR(ref_clk),
> +				     "Failed to get ref clock\n");
> +
> +	st->ref_clk_rate = clk_get_rate(ref_clk);

This clock stuff was already done in probe.

Also, as mentioned in the DT review, since this clock isn't connected to
the ADC chip, it doesn't really make sense that it should be assigned to
the ADC. We should be able to just set the PWM rate to what we need without
caring what the the input clock to the PWM is.

If something else is needed to make it actually work, we need a detailed
explanation in the cover letter so that we can discuss it more.

> +
> +	st->conv_trigger = devm_pwm_get(dev, "cnv");
> +	if (IS_ERR(st->conv_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->conv_trigger),
> +				     "Failed to get cnv pwm\n");
> +
> +	ret = devm_add_action_or_reset(dev, ad4691_disable_pwm,
> +				       st->conv_trigger);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register PWM disable action\n");
> +
> +	return __ad4691_set_sampling_freq(st, st->chip->max_rate);
> +}
> +
> +static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		if (!freq || freq > st->chip->max_rate)
> +			return -ERANGE;
> +
> +		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST(NSEC_PER_SEC,
> +									 freq));

Why do we convert this to ktime when we just convert it back to ns later?

> +		return 0;
> +	}
> +
> +	if (!st->conv_trigger)
> +		return -ENODEV;
> +
> +	if (!freq || freq > st->chip->max_rate)
> +		return -ERANGE;
> +
> +	return __ad4691_set_sampling_freq(st, freq);
> +}
> +
> +static int ad4691_single_shot_read(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan, int *val)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	u16 mask = ~BIT(chan->channel);
> +	u32 acc_mask[2] = { mask & 0xFF, mask >> 8 };
> +	unsigned int reg_val;
> +	int ret;

No mutex lock here?

> +
> +	/*
> +	 * Always use AUTONOMOUS mode for single-shot reads, regardless
> +	 * of the buffer mode (CNV_CLOCK or MANUAL). The chip is kept
> +	 * in AUTONOMOUS mode during idle; enter_conversion_mode() and
> +	 * exit_conversion_mode() handle the switch for buffer operation.
> +	 */
> +	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +			   AD4691_STATE_RESET_ALL);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   BIT(chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_write(st->regmap, AD4691_ACC_MASK1_REG, acc_mask, 2);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 1);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Wait for conversion to complete using a timed delay.
> +	 * A single read needs 2 internal oscillator periods.
> +	 * OSC_FREQ_REG is never modified by the driver, so the
> +	 * oscillator runs at reset-default speed. Use chip->max_rate
> +	 * as a conservative proxy: it is always <= the OSC frequency,
> +	 * so the computed delay is >= the actual conversion time.
> +	 */
> +	unsigned long conv_us = DIV_ROUND_UP(2 * USEC_PER_SEC,
> +					     st->chip->max_rate);
> +	fsleep(conv_us);
> +
> +	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4691_AVG_IN(chan->channel), &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*val = reg_val;
> +	regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_RESET_ALL);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad4691_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		return ad4691_single_shot_read(indio_dev, chan, val);
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = ad4691_get_sampling_freq(st);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_uV / 1000;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4691_set_sampling_freq(indio_dev, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static const struct iio_info ad4691_info = {
> +	.read_raw = &ad4691_read_raw,
> +	.write_raw = &ad4691_write_raw,
> +	.debugfs_reg_access = &ad4691_reg_access,
> +};
> +
> +static int ad4691_reset(struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct reset_control *rst;
> +
> +	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst),
> +				     "Failed to get reset\n");
> +
> +	if (!rst)

Usually, we do a software reset here (see SPI_CONFIG_A register)
if hardware reset is not possible.

> +		return 0;
> +
> +	reset_control_assert(rst);
> +	/* Reset delay required. See datasheet Table 5. */
> +	fsleep(300);
> +	reset_control_deassert(rst);
> +
> +	return 0;
> +}
> +
> +static int ad4691_config(struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	enum ad4691_ref_ctrl ref_val;
> +	unsigned int reg_val;
> +	int ret;
> +
> +	/*
> +	 * Determine buffer conversion mode from DT: if a PWM is provided it
> +	 * drives the CNV pin (CNV_CLOCK_MODE); otherwise CNV is tied to CS
> +	 * and each SPI transfer triggers a conversion (MANUAL_MODE).
> +	 * Both modes idle in AUTONOMOUS mode so that read_raw can use the
> +	 * internal oscillator without disturbing the hardware configuration.
> +	 */
> +	if (device_property_present(dev, "pwms")) {
> +		st->adc_mode = AD4691_CNV_CLOCK_MODE;
> +		ret = ad4691_pwm_get(st);
> +		if (ret)
> +			return ret;
> +	} else {
> +		st->adc_mode = AD4691_MANUAL_MODE;
> +		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
> +			AD4691_MANUAL_MODE_STD_FREQ(st->chip->num_channels,
> +				to_spi_device(dev)->max_speed_hz)));
> +	}
> +
> +	/* Perform a state reset on the channels at start-up. */
> +	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +			   AD4691_STATE_RESET_ALL);

This seems redundant since we already did a hardware (or software reset).

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write state reset\n");
> +
> +	/* Clear STATUS register by reading from the STATUS register. */
> +	ret = regmap_read(st->regmap, AD4691_STATUS_REG, &reg_val);

Ditto.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read status register\n");
> +
> +	switch (st->vref_uV) {
> +	case AD4691_VREF_uV_MIN ... 2750000:

Strange to mix macro and non-macro for range.

> +		ref_val = AD4691_VREF_2P5;
> +		break;
> +	case 2750001 ... 3250000:
> +		ref_val = AD4691_VREF_3P0;
> +		break;
> +	case 3250001 ... 3750000:
> +		ref_val = AD4691_VREF_3P3;
> +		break;
> +	case 3750001 ... 4500000:
> +		ref_val = AD4691_VREF_4P096;
> +		break;
> +	case 4500001 ... AD4691_VREF_uV_MAX:
> +		ref_val = AD4691_VREF_5P0;
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Unsupported vref voltage: %d uV\n",
> +				     st->vref_uV);
> +	}
> +
> +	ret = regmap_write(st->regmap, AD4691_REF_CTRL,
> +			   FIELD_PREP(AD4691_REF_CTRL_MASK, ref_val));

As mentioned elsewhere, also expect to set REFBUF_EN here if needed.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write REF_CTRL\n");
> +
> +	/* Both CNV_CLOCK and MANUAL devices start in AUTONOMOUS mode. */
> +	ret = regmap_write(st->regmap, AD4691_ADC_SETUP, AD4691_AUTONOMOUS_MODE_VAL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write ADC_SETUP\n");
> +
> +	return regmap_write(st->regmap, AD4691_GPIO_MODE1_REG, AD4691_ADC_BUSY);

We should not be setting anything about the gpios without checking what the
devicetree says is wired up.

I would defer adding all of the pwm/CNV_CLOCK/samling_freqnecy/GP0 trigger
stuff to the patch that actually adds SPI offload support for it to logically
make sense.

> +}
> +
> +static int ad4691_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4691_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	st->regmap = devm_regmap_init(dev, NULL, st, &ad4691_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	st->chip = spi_get_device_match_data(spi);
> +
> +	ret = ad4691_regulator_get(st);

I would call this ad4691_regulator_setup() or something similar to make it more
obvious this is an init function.

> +	if (ret)
> +		return ret;
> +
> +	ret = ad4691_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4691_config(st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->chip->name;
> +	indio_dev->info = &ad4691_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	indio_dev->channels = (st->adc_mode == AD4691_MANUAL_MODE) ?
> +		st->chip->manual_channels : st->chip->channels;
> +	indio_dev->num_channels = st->chip->num_channels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad4691_of_match[] = {
> +	{ .compatible = "adi,ad4691", .data = &ad4691_ad4691 },
> +	{ .compatible = "adi,ad4692", .data = &ad4691_ad4692 },
> +	{ .compatible = "adi,ad4693", .data = &ad4691_ad4693 },
> +	{ .compatible = "adi,ad4694", .data = &ad4691_ad4694 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad4691_of_match);
> +
> +static const struct spi_device_id ad4691_id[] = {
> +	{ "ad4691", (kernel_ulong_t)&ad4691_ad4691 },
> +	{ "ad4692", (kernel_ulong_t)&ad4691_ad4692 },
> +	{ "ad4693", (kernel_ulong_t)&ad4691_ad4693 },
> +	{ "ad4694", (kernel_ulong_t)&ad4691_ad4694 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad4691_id);
> +
> +static struct spi_driver ad4691_driver = {
> +	.driver = {
> +		.name = "ad4691",
> +		.of_match_table = ad4691_of_match,
> +	},
> +	.probe = ad4691_probe,
> +	.id_table = ad4691_id,
> +};
> +module_spi_driver(ad4691_driver);
> +
> +MODULE_AUTHOR("Radu Sabau <radu.sabau@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD4691 Family ADC Driver");
> +MODULE_LICENSE("GPL");
> 


