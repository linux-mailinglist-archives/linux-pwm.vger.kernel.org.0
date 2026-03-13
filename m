Return-Path: <linux-pwm+bounces-8251-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HsyLDnos2nZcwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8251-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:34:33 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C40E281805
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B740A302E906
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 10:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DD635F169;
	Fri, 13 Mar 2026 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op0cAmC2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5A3563FB;
	Fri, 13 Mar 2026 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773397899; cv=none; b=dhnHAFnf3vBHlUbTFCQfbrRmInsSJyhz9wg+noT7iJ0sQBt4+lMu/E0VOhhsbClRvc9eS/EHBJKsLj6iBtIufsUNKLfvEGRwVuvBkP07EffURKv61roEwyJ6HySFcmDrYvEnRS72LV+SGsZVvqNqhnyLMvmfg1KqgLrYXEE384g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773397899; c=relaxed/simple;
	bh=eZkcszx939Ywl2Ard9DWN1ZbdG1gP1UYuVN/rQweZaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDjaD7rNBBokPnpuj0RhN4wHY5LmicU/dYtf6IQfeFxUJrsPdIYRDQn2gunws6D0yulN/boMQALcShYxVuKNzaSa77h7ZOQUxd4Mx1Htx7Nd6b88dVPIOemkCm8PdVeXxFZzj5S5PUcdxZ0VO+mxm6rR3APHcHDOab5Z0Pxquqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op0cAmC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0EDC2BCB2;
	Fri, 13 Mar 2026 10:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773397898;
	bh=eZkcszx939Ywl2Ard9DWN1ZbdG1gP1UYuVN/rQweZaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=op0cAmC22BPh7aPm0TjgpV34tU4+IfCOjfPKWBCOcJXILVUfseDfTLUsudnn+ejir
	 i3iTb+yPaTiUkaerg7/UmbtK1qBckjL8spRCOITD9BxwhXfPkjyg3f0AheWgsOqAo6
	 jXt07D9YeNUbffpVOP5KgpKICQIvXp/eayfPaxlv/Pvv4TKIXfeLjQZ+MeEb4M0kvG
	 WRtTVm0qwlO422DKttKW0+eaFyvpps47hRXuU+xNdN8H4tygh0swxm0u/HRlSk8nif
	 hWbk4xFsNsUaOpT8GXDkdFKWm3LSNrvpo6dXsdeow7oeYDByTOSzHJUim+IWdZSaHv
	 TJ4O0ZSyvetnQ==
Date: Fri, 13 Mar 2026 11:31:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <abPa8r8XjOd9AoMB@monoceros>
References: <20260310-ad4692-multichannel-sar-adc-driver-v2-0-d9bb8aeb5e17@analog.com>
 <20260310-ad4692-multichannel-sar-adc-driver-v2-2-d9bb8aeb5e17@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="amwkcpt2w7rk5qj2"
Content-Disposition: inline
In-Reply-To: <20260310-ad4692-multichannel-sar-adc-driver-v2-2-d9bb8aeb5e17@analog.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8251-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,analog.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C40E281805
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--amwkcpt2w7rk5qj2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
MIME-Version: 1.0

On Tue, Mar 10, 2026 at 04:32:23PM +0200, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
>=20
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
>=20
> Two buffered operating modes are supported, auto-detected from the
> device tree:
>=20
>     - CNV Clock Mode:  an external PWM drives the CNV pin; the sampling
>                        rate is controlled via the PWM period. Requires a
>                        reference clock and a DATA_READY interrupt.
>=20
>     - Manual Mode:     CNV is tied to SPI CS; each SPI transfer triggers
>                        a conversion and returns the previous result
>                        (pipelined). No external clock or interrupt needed.
>=20
> In both modes the chip idles in Autonomous Mode so that single-shot
> read_raw can use the internal oscillator without disturbing the
> hardware configuration.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/iio/adc/Kconfig  |  11 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad4691.c | 773 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 786 insertions(+)
>=20
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
> =20
>  ANALOG DEVICES INC AD4695 DRIVER
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 60038ae8dfc4..3685a03aa8dc 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -139,6 +139,17 @@ config AD4170_4
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad4170-4.
> =20
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
> @@ -16,6 +16,7 @@ obj-$(CONFIG_AD4080) +=3D ad4080.o
>  obj-$(CONFIG_AD4130) +=3D ad4130.o
>  obj-$(CONFIG_AD4134) +=3D ad4134.o
>  obj-$(CONFIG_AD4170_4) +=3D ad4170-4.o
> +obj-$(CONFIG_AD4691) +=3D ad4691.o
>  obj-$(CONFIG_AD4695) +=3D ad4695.o
>  obj-$(CONFIG_AD4851) +=3D ad4851.o
>  obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> new file mode 100644
> index 000000000000..528c37a9a383
> --- /dev/null
> +++ b/drivers/iio/adc/ad4691.c
> @@ -0,0 +1,773 @@
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
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
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
> +#define AD4691_VREF_MIN				2400000
> +#define AD4691_VREF_MAX				5250000
> +
> +/*
> + * Default sampling frequency for MANUAL_MODE.
> + * Each sample needs (num_channels + 1) SPI transfers of 24 bits.
> + * The factor 36 =3D 24 * 3/2 folds in a 50% scheduling margin:
> + *   freq =3D spi_hz / (24 * 3/2 * (num_channels + 1))
> + *        =3D spi_hz / (36 * (num_channels + 1))
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
> +#define AD4691_STATUS_REG			0x14
> +#define AD4691_CLAMP_STATUS1_REG		0x1A
> +#define AD4691_CLAMP_STATUS2_REG		0x1B
> +#define AD4691_DEVICE_SETUP			0x20
> +#define AD4691_REF_CTRL				0x21
> +#define AD4691_OSC_FREQ_REG			0x23
> +#define AD4691_STD_SEQ_CONFIG			0x25
> +#define AD4691_SPARE_CONTROL			0x2A
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
> +	AD4691_ADC_BUSY =3D 4,
> +	AD4691_DATA_READY =3D 6,
> +};
> +
> +enum ad4691_ref_ctrl {
> +	AD4691_VREF_2P5 =3D 0,
> +	AD4691_VREF_3P0,
> +	AD4691_VREF_3P3,
> +	AD4691_VREF_4P096,
> +	AD4691_VREF_5P0,
> +};
> +
> +struct ad4691_chip_info {
> +	const struct iio_chan_spec *channels;
> +	const struct iio_chan_spec *manual_channels;
> +	const char *name;
> +	int num_channels;
> +	int max_rate;
> +};
> +
> +#define AD4691_CHANNEL(chan, index, real_bits, storage_bits, _shift)	\
> +	{								\
> +		.type =3D IIO_VOLTAGE,					\
> +		.indexed =3D 1,						\
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
> +					   | BIT(IIO_CHAN_INFO_SCALE),	\
> +		.channel =3D chan,					\
> +		.scan_index =3D index,					\
> +		.scan_type =3D {						\
> +			.sign =3D 'u',					\
> +			.realbits =3D real_bits,				\
> +			.storagebits =3D storage_bits,			\
> +			.shift =3D _shift,				\
> +		},							\
> +	}
> +
> +static const struct iio_chan_spec ad4691_channels[] =3D {
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
> +static const struct iio_chan_spec ad4693_channels[] =3D {
> +	AD4691_CHANNEL(0, 0, 16, 32, 0),
> +	AD4691_CHANNEL(1, 1, 16, 32, 0),
> +	AD4691_CHANNEL(2, 2, 16, 32, 0),
> +	AD4691_CHANNEL(3, 3, 16, 32, 0),
> +	AD4691_CHANNEL(4, 4, 16, 32, 0),
> +	AD4691_CHANNEL(5, 5, 16, 32, 0),
> +	AD4691_CHANNEL(6, 6, 16, 32, 0),
> +	AD4691_CHANNEL(7, 7, 16, 32, 0)
> +};
> +
> +static const struct iio_chan_spec ad4691_manual_channels[] =3D {
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
> +
> +static const struct iio_chan_spec ad4693_manual_channels[] =3D {
> +	AD4691_CHANNEL(0, 0, 16, 24, 8),
> +	AD4691_CHANNEL(1, 1, 16, 24, 8),
> +	AD4691_CHANNEL(2, 2, 16, 24, 8),
> +	AD4691_CHANNEL(3, 3, 16, 24, 8),
> +	AD4691_CHANNEL(4, 4, 16, 24, 8),
> +	AD4691_CHANNEL(5, 5, 16, 24, 8),
> +	AD4691_CHANNEL(6, 6, 16, 24, 8),
> +	AD4691_CHANNEL(7, 7, 16, 24, 8)
> +};
> +
> +static const struct ad4691_chip_info ad4691_ad4691 =3D {
> +	.channels =3D ad4691_channels,
> +	.manual_channels =3D ad4691_manual_channels,
> +	.name =3D "ad4691",
> +	.num_channels =3D ARRAY_SIZE(ad4691_channels),
> +	.max_rate =3D 500000,
> +};
> +
> +static const struct ad4691_chip_info ad4691_ad4692 =3D {
> +	.channels =3D ad4691_channels,
> +	.manual_channels =3D ad4691_manual_channels,
> +	.name =3D "ad4692",
> +	.num_channels =3D ARRAY_SIZE(ad4691_channels),
> +	.max_rate =3D 1000000,
> +};
> +
> +static const struct ad4691_chip_info ad4691_ad4693 =3D {
> +	.channels =3D ad4693_channels,
> +	.manual_channels =3D ad4693_manual_channels,
> +	.name =3D "ad4693",
> +	.num_channels =3D ARRAY_SIZE(ad4693_channels),
> +	.max_rate =3D 500000,
> +};
> +
> +static const struct ad4691_chip_info ad4691_ad4694 =3D {
> +	.channels =3D ad4693_channels,
> +	.manual_channels =3D ad4693_manual_channels,
> +	.name =3D "ad4694",
> +	.num_channels =3D ARRAY_SIZE(ad4693_channels),
> +	.max_rate =3D 1000000,
> +};
> +
> +struct ad4691_state {
> +	const struct ad4691_chip_info	*chip;
> +	struct spi_device		*spi;
> +	struct regmap			*regmap;
> +
> +	unsigned long			ref_clk_rate;
> +	struct pwm_device		*conv_trigger;
> +
> +	enum ad4691_adc_mode		adc_mode;
> +
> +	int				vref;
> +	u64				cnv_period;
> +	/*
> +	 * Synchronize access to members of the driver state, and ensure
> +	 * atomicity of consecutive SPI operations.
> +	 */
> +	struct mutex			lock;
> +};
> +
> +static void ad4691_disable_pwm(void *data)
> +{
> +	struct pwm_device *pwm =3D data;
> +	struct pwm_state state;
> +
> +	pwm_get_state(pwm, &state);
> +	state.enabled =3D false;
> +	pwm_apply_might_sleep(pwm, &state);

You can just do:

	struct pwm_state state =3D { .enabled =3D false, };
	pwm_apply_might_sleep(pwm, &state);

as there is no need to keep period and duty_cycle.

> +}
> +
> +static int ad4691_regulator_get(struct ad4691_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	int ret;
> +
> +	ret =3D devm_regulator_get_enable(dev, "vio");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable VIO\n");
> +
> +	st->vref =3D devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (st->vref =3D=3D -ENODEV)
> +		st->vref =3D devm_regulator_get_enable_read_voltage(dev, "vrefin");
> +	if (st->vref < 0)
> +		return dev_err_probe(dev, st->vref,
> +				     "Failed to get reference supply\n");
> +
> +	if (st->vref < AD4691_VREF_MIN || st->vref > AD4691_VREF_MAX)
> +		return dev_err_probe(dev, -EINVAL, "vref(%d) must be under [%u %u]\n",
> +				     st->vref, AD4691_VREF_MIN, AD4691_VREF_MAX);
> +
> +	return 0;
> +}
> +
> +static int ad4691_reg_read(void *context, unsigned int reg, unsigned int=
 *val)
> +{
> +	struct ad4691_state *st =3D context;
> +	u8 tx[2], rx[4];
> +	int ret;
> +
> +	put_unaligned_be16(0x8000 | reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
> +		ret =3D spi_write_then_read(st->spi, tx, 2, rx, 1);
> +		if (!ret)
> +			*val =3D rx[0];
> +		return ret;
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +		ret =3D spi_write_then_read(st->spi, tx, 2, rx, 2);
> +		if (!ret)
> +			*val =3D get_unaligned_be16(rx);
> +		return ret;
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +		ret =3D spi_write_then_read(st->spi, tx, 2, rx, 3);
> +		if (!ret)
> +			*val =3D get_unaligned_be24(rx);
> +		return ret;
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		ret =3D spi_write_then_read(st->spi, tx, 2, rx, 4);
> +		if (!ret)
> +			*val =3D get_unaligned_be32(rx);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_reg_write(void *context, unsigned int reg, unsigned in=
t val)
> +{
> +	struct ad4691_state *st =3D context;
> +	u8 tx[4];
> +
> +	put_unaligned_be16(reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_GPIO_MODE2_REG:
> +		if (val > 0xFF)
> +			return -EINVAL;
> +		tx[2] =3D val;
> +		return spi_write_then_read(st->spi, tx, 3, NULL, 0);
> +	case AD4691_STD_SEQ_CONFIG:
> +		if (val > 0xFFFF)
> +			return -EINVAL;
> +		put_unaligned_be16(val, &tx[2]);
> +		return spi_write_then_read(st->spi, tx, 4, NULL, 0);
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
> +static const struct regmap_config ad4691_regmap_config =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 32,
> +	.reg_read =3D ad4691_reg_read,
> +	.reg_write =3D ad4691_reg_write,
> +	.volatile_reg =3D ad4691_volatile_reg,
> +	.readable_reg =3D ad4691_readable_reg,
> +	.writeable_reg =3D ad4691_writeable_reg,
> +	.max_register =3D AD4691_ACC_STS_DATA(15),
> +	.cache_type =3D REGCACHE_RBTREE,
> +};
> +
> +static int ad4691_get_sampling_freq(struct ad4691_state *st)
> +{
> +	if (st->adc_mode =3D=3D AD4691_MANUAL_MODE) {
> +		return DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
> +					     ktime_to_ns(st->sampling_period));
> +	}
> +
> +	return DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
> +				     pwm_get_period(st->conv_trigger));

Other iio drivers (I looked at ad4062.c) use down-rounding division to
provide the sampling frequency. I wonder if there should be some
consistency about that in the different drivers?
(But having said that, the ad4062.c calculation looks somewhat fishy, is
AD4062_TCONV_NS really relevant to the frequency?)

> +}
> +
> +static int __ad4691_set_sampling_freq(struct ad4691_state *st, int freq)
> +{
> +	unsigned long long target, ref_clk_period_ns;
> +	struct pwm_state cnv_state;
> +
> +	pwm_init_state(st->conv_trigger, &cnv_state);
> +
> +	freq =3D clamp(freq, 1, st->chip->max_rate);
> +	target =3D DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate, freq);
> +	ref_clk_period_ns =3D DIV_ROUND_CLOSEST_ULL(NANO, st->ref_clk_rate);
> +	st->cnv_period =3D ref_clk_period_ns * target;
> +	cnv_state.period =3D ref_clk_period_ns * target;

You're losing precision here. Consider ref_clk_rate =3D 64000000, freq =3D
1234560. Then
   cnv_state.period
 =3D ref_clk_period_ns * target
 =3D DIV_ROUND_CLOSEST_ULL(NANO, st->ref_clk_rate) * DIV_ROUND_CLOSEST_ULL(=
st->ref_clk_rate, freq)=20
 =3D 16 * 52
 =3D 832

The exact value is NANO / freq (as st->ref_clk_rate cancels out) which
is 810.0051840331778.

So this either needs a comment why the calculation is as it is without
canceling st->ref_clk_rate and two divisions instead of only one, or it
should be simplified.

Also I wonder if DIV_ROUND_CLOSEST_ULL(NANO, freq) is right. With freq =3D
793336 we get:

	NANO / freq =3D 1260.499964706001

so 1260 is picked as period which results in an actual frequency of

	NANO / 1260 =3D 793650.7936507936

and thus a delta of 314.79365079361014 Hz. With period =3D 1261 however we
get

	NANO / 1261 =3D 793021.4115781126

which has a delta of 314.5884218873689 and thus is (maybe?) the better
choice? But maybe that is too theoretic as the underlying PWM hardware
probably cannot set 1260 ns or 1261 ns exactly anyhow and most probably
both result in the same HW setting (but if not, 1261 yields the better
setting).

> +	cnv_state.duty_cycle =3D AD4691_CNV_DUTY_CYCLE_NS;
> +	cnv_state.enabled =3D false;
> +
> +	return pwm_apply_might_sleep(st->conv_trigger, &cnv_state);
> +}

Best regards
Uwe

--amwkcpt2w7rk5qj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmz54UACgkQj4D7WH0S
/k7U2QgAn4YyAc8Fw2+n2l7BZ1locp9Tq72dYSPRukDyBsJj+19NGb4c8Rc1rHVf
UbYoGeAII70L6kJqfVQJwoUMnjT4QWe1nubeiqbOsUyEEkP4rUz4YLAmM7JUtWxT
aeGCvl4rh8bT9zJRljN/Fd5i4XYY75VsXUxDiQL13nSZd0S4M/FwkmLFON12ty/D
eBPzShXzvvcwDTKp3ezRtyCiQB5ZJe8TYwUMabCpmGuR0Kz8bno8WNqf5GSZhykd
FKIl3NooFcWvnarG3+Gw81cl6JdDmdJgxiJTmq4blrtb8OHajeNpfwyWgIbx9AhH
GB/An5hlTfQcaZHljeb9dAvuwTbDgw==
=X1aI
-----END PGP SIGNATURE-----

--amwkcpt2w7rk5qj2--

