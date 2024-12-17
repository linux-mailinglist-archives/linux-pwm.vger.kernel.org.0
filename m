Return-Path: <linux-pwm+bounces-4369-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C9D9F4AB0
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 13:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F69F16681E
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037911F1309;
	Tue, 17 Dec 2024 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhVFjkva"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA7A1F12E4;
	Tue, 17 Dec 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437438; cv=none; b=bFwxuQfn16eF+oxK5v3JWZLj5DrJ5p4zA+6H7Nxn7N6rQFfe6IQKXTLx16C4KxeeNdW+xOws4VMmiUrFuz4xIwoI6zvZK9oFzkvm9ATaZI1ZV78XoevHQOgUjAu6g2i01NntQNn0s04/7TZGTvKQIqIdeRqNeVNLkOgFTrqX9ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437438; c=relaxed/simple;
	bh=jZEWCtNBdhPWuoS2qGNT6xL2xtWKbuYmV9goFc3FUD8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FpLTL4o7TgR5NdHMhX9ID2gBGjngNnwxtLbK7Lp7Vh4pDFbXqZTar5gueHkU4CzBq5ruut3sg4RpgWhlH7GiaO3xY857iXI53+fvctRhAH4lvyFBx3pdLJI44jComBV/vHLXtA0fWfAMJbU7Fq+PZVOMBdgNpVFsGB/+EQdc9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhVFjkva; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso877035166b.3;
        Tue, 17 Dec 2024 04:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734437434; x=1735042234; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JyI+wfOz0gMJ+Vp/8cZH7WJbtI+4xoqHkJiIi/bjvRg=;
        b=VhVFjkvaYt939e08X1frYBaU3B3iX5e52eI5QczSaJ/SFz3DWOWtyALlRkB4L+IELG
         wqlwuwgmtmDcPpwHnuhKpjjXZT/bf5XT1gWZHMf2wKTC8egoR+D6IXQQwKHx8ywZanSE
         89x+vvdhotO8J0vKh4CkS+Sg4/slH7Ef6kuv15ts+0cu+4dGbxpqPJ2C57yoKG0ZSLrt
         Jrb3yaEpcEgDzEaIQ8m8atYVPV9hgONHaVN3ovUoCSZjQpe2o0T/NZ27eg5WJohbSnWd
         6y7BpIiiMw7BOH8zPTfvyaG4+S1J3gruUPt1iE1u6l46v/POe4XSPP23RzLko+hWsHcD
         6RTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734437434; x=1735042234;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyI+wfOz0gMJ+Vp/8cZH7WJbtI+4xoqHkJiIi/bjvRg=;
        b=j3/5NvGMEOVvxcfy9N80uQjp7rigQml8GCVKhOgnwzUyoWVVC54jTlhoB6pjVx/2+9
         XpnY2A0FRjBN0G5wQ9/wBWZTfYTNlyyKP4uDlhXXsG5P5myGuRgwHDsaqK1yuTII++6h
         pMYpzx8cDujpgB8Be33JiG6///8bgbswevz6R4n9ik4WGzxPbxjL0uhoKJx+EYMqQb07
         UgLGp7bxgEitqlosr/6QOH89Y/t3TqOtylUR9pavKFf5b0y7LT5AnmcUzkK5xATZfvsL
         wueF5yTfa80pt6XE4OSyZWYE20Pf1VdolE5oVLIkPynXuPpg2F64FOsuNY8CjsfKtRYr
         MuCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4gjoW3JLwH2lOb61Ml8BZuQyKlbEpv87XSSeB9R7XV3tgbF0c/xUWFx5lOybBPFA5K9qpWpmpJaaR@vger.kernel.org, AJvYcCU5KKhZuObQHpzLamnV0mEJ1/OQIiODk2CFluOaZ8u82IITPEQZHnS/42qviwPl98UZHSkXVvpfY/D8@vger.kernel.org, AJvYcCVGQpRB1NzuHww7HoEwaodzwrLuTgy9WnfxBWQlG33rx5rjjjdlwqzElUYf44QdKtJ3wQEdOpiaRs5b@vger.kernel.org, AJvYcCVRHE+UnQzEW/kRFWqxBlRQItVk1iUTB1CVw4uVwunTIGxEOS3gLkQgU2nxEbPdM6LB+4FdZA+pLuBU@vger.kernel.org, AJvYcCXyXAZWiJYBJ9c+LWw5l5kzKHhGCL4Nkb0HNhN9tUo5gkDVnPn+n2z5fna47pnIFl4mDDxVjKBuiHXq4wau@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqR5ajFQ6GaNn/8/fvCSMGB37wjtXVVaHagIXcxgxRk0nC4Og
	ZKY1w5mESnI51eeVNPLxp11IYu8P9CFBGwg0EjufxQcaTvyKYg/m
X-Gm-Gg: ASbGncuOzgdpm65xJgAR9ZVv7Ow3iip35Pg0Qp7qsyhzY+PxKIfTh/gLVtyrB3Z6fdF
	2HIaHF1v53infBS1SKWgFzMOnlwoNEyRvnRV6Bc2GRB4XUNPC3ii9mKhG7apk91oRcDjftDt00f
	ckVRXFqPHzX1LqMnfGrsMCp1VktGoF9O+UXZk8lnx8dx76GmPxrBqZE8oauZVHiWrF0cQva4YyW
	9RIcGdlM5aQ3daBRyOn6EoukaYbq6+0EuktTK1yBJgeg/bKxAtt9ip7E+7rteluZsrvEYWBqpgP
	AO1sRU7KTRSutAZ9+w0X9H5Zswghy/6bRPuJkMU9Rw7BWP9rt7/k6LhdklF7HfqaEZSMrpslMl2
	JUHxjbLevNbav8Q==
X-Google-Smtp-Source: AGHT+IGdq8z1/D1SY2Bg0VtClXQkSvoYQwKDmZxwSdzLpkCFVY1DFsWRCIv4ynlXB3JHYXxWoEMBrA==
X-Received: by 2002:a17:906:7944:b0:aa6:6e04:eef6 with SMTP id a640c23a62f3a-aab77f07a24mr1780961066b.61.1734437434271;
        Tue, 17 Dec 2024 04:10:34 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963c5489sm445163766b.186.2024.12.17.04.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:10:33 -0800 (PST)
Message-ID: <97c283e3bf48ca6425a61363afcdd221e7392a39.camel@gmail.com>
Subject: Re: [PATCH v6 14/17] iio: adc: ad4695: Add support for SPI offload
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Jander	 <david@protonic.nl>, Martin Sperl
 <kernel@martin.sperl.org>, 	linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-pwm@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Tue, 17 Dec 2024 13:15:05 +0100
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-14-88ee574d5d03@baylibre.com>
References: 
	<20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	 <20241211-dlech-mainline-spi-engine-offload-2-v6-14-88ee574d5d03@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-11 at 14:54 -0600, David Lechner wrote:
> Add support for SPI offload to the ad4695 driver. SPI offload allows
> sampling data at the max sample rate (500kSPS or 1MSPS).
>=20
> This is developed and tested against the ADI example FPGA design for
> this family of ADCs [1].
>=20
> [1]: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20

LGTM,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> v6 changes:
> * Fixed use of c++ style comments
> * Moved static const struct definition out of probe function
> * Changes bits_per_word to always be 19 for future oversampling
> =C2=A0 compatibility (Trevor is working on implementing oversampling supp=
ort
> =C2=A0 on top of this patch, so we have high confidence this is the corre=
ct
> =C2=A0 thing to do)
> * Fixed wrong xfer->len
>=20
> v5 changes:
> * Register SCLK speed handling has been split out into a separate series.
> * Add sampling_frequency_available attribute.
> * Limit max allowed sampling frequency based on chip info.
> * Expand explanations of offload enable/disable ordering requirements.
> * Finish TODO to use macros for phandle arg values.
> * Don't use dev_info() when falling back to non-offload operation.
> * Update to accommodate changes in other patches in this series.
>=20
> v4 changes: new patch in v4
> ---
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4695.c | 445 ++++++++++++++++++++++++++++++++++++=
+++++++++-
> -
> =C2=A02 files changed, 429 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index
> 995b9cacbaa964d26424346120c139858f93cdcd..ec60b64c46e187e2be18ab1f8ca9e6f=
4f032
> 99f9 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -52,6 +52,7 @@ config AD4695
> =C2=A0	tristate "Analog Device AD4695 ADC Driver"
> =C2=A0	depends on SPI
> =C2=A0	select IIO_BUFFER
> +	select IIO_BUFFER_DMAENGINE
> =C2=A0	select IIO_TRIGGERED_BUFFER
> =C2=A0	select REGMAP
> =C2=A0	help
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index
> 13cf01d35301be40369571e7dd2aeac1a8148d15..c8cd73d19e869f11999608f61df5724=
d329b
> 4427 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c
> @@ -19,14 +19,19 @@
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/gpio/consumer.h>
> +#include <linux/iio/buffer-dmaengine.h>
> =C2=A0#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/triggered_buffer.h>
> =C2=A0#include <linux/iio/trigger_consumer.h>
> =C2=A0#include <linux/minmax.h>
> +#include <linux/mutex.h>
> =C2=A0#include <linux/property.h>
> +#include <linux/pwm.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/regulator/consumer.h>
> +#include <linux/spi/offload/consumer.h>
> +#include <linux/spi/offload/provider.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0#include <linux/units.h>
> =C2=A0
> @@ -66,6 +71,8 @@
> =C2=A0#define AD4695_REG_STD_SEQ_CONFIG			0x0024
> =C2=A0#define AD4695_REG_GPIO_CTRL				0x0026
> =C2=A0#define AD4695_REG_GP_MODE				0x0027
> +#define=C2=A0=C2=A0 AD4695_REG_GP_MODE_BUSY_GP_SEL		=C2=A0 BIT(5)
> +#define=C2=A0=C2=A0 AD4695_REG_GP_MODE_BUSY_GP_EN			=C2=A0 BIT(1)
> =C2=A0#define AD4695_REG_TEMP_CTRL				0x0029
> =C2=A0#define=C2=A0=C2=A0 AD4695_REG_TEMP_CTRL_TEMP_EN			=C2=A0 BIT(0)
> =C2=A0#define AD4695_REG_CONFIG_IN(n)				(0x0030 |
> (n))
> @@ -124,13 +131,22 @@ struct ad4695_channel_config {
> =C2=A0
> =C2=A0struct ad4695_state {
> =C2=A0	struct spi_device *spi;
> +	struct spi_offload *offload;
> +	struct spi_offload_trigger *offload_trigger;
> =C2=A0	struct regmap *regmap;
> =C2=A0	struct regmap *regmap16;
> =C2=A0	struct gpio_desc *reset_gpio;
> +	/* currently PWM CNV only supported with SPI offload use */
> +	struct pwm_device *cnv_pwm;
> +	/* protects against concurrent use of cnv_pwm */
> +	struct mutex cnv_pwm_lock;
> +	/* offload also requires separate gpio to manually control CNV */
> +	struct gpio_desc *cnv_gpio;
> =C2=A0	/* voltages channels plus temperature and timestamp */
> =C2=A0	struct iio_chan_spec iio_chan[AD4695_MAX_CHANNELS + 2];
> =C2=A0	struct ad4695_channel_config channels_cfg[AD4695_MAX_CHANNELS];
> =C2=A0	const struct ad4695_chip_info *chip_info;
> +	int sample_freq_range[3];
> =C2=A0	/* Reference voltage. */
> =C2=A0	unsigned int vref_mv;
> =C2=A0	/* Common mode input pin voltage. */
> @@ -355,6 +371,13 @@ static const struct ad4695_chip_info ad4698_chip_inf=
o =3D {
> =C2=A0	.num_voltage_inputs =3D 8,
> =C2=A0};
> =C2=A0
> +static void ad4695_cnv_manual_trigger(struct ad4695_state *st)
> +{
> +	gpiod_set_value_cansleep(st->cnv_gpio, 1);
> +	ndelay(10);
> +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> +}
> +
> =C2=A0/**
> =C2=A0 * ad4695_set_single_cycle_mode - Set the device in single cycle mo=
de
> =C2=A0 * @st: The AD4695 state
> @@ -460,6 +483,17 @@ static int ad4695_exit_conversion_mode(struct
> ad4695_state *st)
> =C2=A0	 */
> =C2=A0	st->cnv_cmd2 =3D AD4695_CMD_EXIT_CNV_MODE << 3;
> =C2=A0
> +	if (st->cnv_gpio) {
> +		ad4695_cnv_manual_trigger(st);
> +
> +		/*
> +		 * In this case, CNV is not connected to CS, so we don't need
> +		 * the extra CS toggle to trigger the conversion and toggling
> +		 * CS would have no effect.
> +		 */
> +		return spi_sync_transfer(st->spi, &xfers[1], 1);
> +	}
> +
> =C2=A0	return spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> =C2=A0}
> =C2=A0
> @@ -687,6 +721,160 @@ static irqreturn_t ad4695_trigger_handler(int irq, =
void
> *p)
> =C2=A0	return IRQ_HANDLED;
> =C2=A0}
> =C2=A0
> +static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4695_state *st =3D iio_priv(indio_dev);
> +	struct spi_offload_trigger_config config =3D {
> +		.type =3D SPI_OFFLOAD_TRIGGER_DATA_READY,
> +	};
> +	struct spi_transfer *xfer =3D &st->buf_read_xfer[0];
> +	struct pwm_state state;
> +	u8 temp_chan_bit =3D st->chip_info->num_voltage_inputs;
> +	u8 num_slots =3D 0;
> +	u8 temp_en =3D 0;
> +	unsigned int bit;
> +	int ret;
> +
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		if (bit =3D=3D temp_chan_bit) {
> +			temp_en =3D 1;
> +			continue;
> +		}
> +
> +		ret =3D regmap_write(st->regmap, AD4695_REG_AS_SLOT(num_slots),
> +				=C2=A0=C2=A0 FIELD_PREP(AD4695_REG_AS_SLOT_INX, bit));
> +		if (ret)
> +			return ret;
> +
> +		num_slots++;
> +	}
> +
> +	/*
> +	 * For non-offload, we could discard data to work around this
> +	 * restriction, but with offload, that is not possible.
> +	 */
> +	if (num_slots < 2) {
> +		dev_err(&st->spi->dev,
> +			"At least two voltage channels must be enabled.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D regmap_update_bits(st->regmap, AD4695_REG_TEMP_CTRL,
> +				 AD4695_REG_TEMP_CTRL_TEMP_EN,
> +				 FIELD_PREP(AD4695_REG_TEMP_CTRL_TEMP_EN,
> +					=C2=A0=C2=A0=C2=A0 temp_en));
> +	if (ret)
> +		return ret;
> +
> +	/* Each BUSY event means just one sample for one channel is ready. */
> +	memset(xfer, 0, sizeof(*xfer));
> +	xfer->offload_flags =3D SPI_OFFLOAD_XFER_RX_STREAM;
> +	/* Using 19 bits per word to allow for possible oversampling */
> +	xfer->bits_per_word =3D 19;
> +	xfer->len =3D 4;
> +
> +	spi_message_init_with_transfers(&st->buf_read_msg, xfer, 1);
> +	st->buf_read_msg.offload =3D st->offload;
> +
> +	ret =3D spi_optimize_message(st->spi, &st->buf_read_msg);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * NB: technically, this is part the SPI offload trigger enable, but
> it
> +	 * doesn't work to call it from the offload trigger enable callback
> +	 * because it requires accessing the SPI bus. Calling it from the
> +	 * trigger enable callback could cause a deadlock.
> +	 */
> +	ret =3D regmap_set_bits(st->regmap, AD4695_REG_GP_MODE,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4695_REG_GP_MODE_BUSY_GP_EN);
> +	if (ret)
> +		goto err_unoptimize_message;
> +
> +	ret =3D spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &config);
> +	if (ret)
> +		goto err_disable_busy_output;
> +
> +	ret =3D ad4695_enter_advanced_sequencer_mode(st, num_slots);
> +	if (ret)
> +		goto err_offload_trigger_disable;
> +
> +	guard(mutex)(&st->cnv_pwm_lock);
> +	pwm_get_state(st->cnv_pwm, &state);
> +	/*
> +	 * PWM subsystem generally rounds down, so requesting 2x minimum high
> +	 * time ensures that we meet the minimum high time in any case.
> +	 */
> +	state.duty_cycle =3D AD4695_T_CNVH_NS * 2;
> +	ret =3D pwm_apply_might_sleep(st->cnv_pwm, &state);
> +	if (ret)
> +		goto err_offload_exit_conversion_mode;
> +
> +	return 0;
> +
> +err_offload_exit_conversion_mode:
> +	/*
> +	 * We have to unwind in a different order to avoid triggering
> offload.
> +	 * ad4695_exit_conversion_mode() triggers a conversion, so it has to
> be
> +	 * done after spi_offload_trigger_disable().
> +	 */
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +	ad4695_exit_conversion_mode(st);
> +	goto err_disable_busy_output;
> +
> +err_offload_trigger_disable:
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +
> +err_disable_busy_output:
> +	regmap_clear_bits(st->regmap, AD4695_REG_GP_MODE,
> +			=C2=A0 AD4695_REG_GP_MODE_BUSY_GP_EN);
> +
> +err_unoptimize_message:
> +	spi_unoptimize_message(&st->buf_read_msg);
> +
> +	return ret;
> +}
> +
> +static int ad4695_offload_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4695_state *st =3D iio_priv(indio_dev);
> +	struct pwm_state state;
> +	int ret;
> +
> +	scoped_guard(mutex, &st->cnv_pwm_lock) {
> +		pwm_get_state(st->cnv_pwm, &state);
> +		state.duty_cycle =3D 0;
> +		ret =3D pwm_apply_might_sleep(st->cnv_pwm, &state);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +
> +	/*
> +	 * ad4695_exit_conversion_mode() triggers a conversion, so it has to
> be
> +	 * done after spi_offload_trigger_disable().
> +	 */
> +	ret =3D ad4695_exit_conversion_mode(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_clear_bits(st->regmap, AD4695_REG_GP_MODE,
> +				AD4695_REG_GP_MODE_BUSY_GP_EN);
> +	if (ret)
> +		return ret;
> +
> +	spi_unoptimize_message(&st->buf_read_msg);
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ad4695_offload_buffer_setup_ops=
 =3D {
> +	.postenable =3D ad4695_offload_buffer_postenable,
> +	.predisable =3D ad4695_offload_buffer_predisable,
> +};
> +
> =C2=A0/**
> =C2=A0 * ad4695_read_one_sample - Read a single sample using single-cycle=
 mode
> =C2=A0 * @st: The AD4695 state
> @@ -718,6 +906,13 @@ static int ad4695_read_one_sample(struct ad4695_stat=
e
> *st, unsigned int address)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> +	/*
> +	 * If CNV is connected to CS, the previous function will have
> triggered
> +	 * the conversion, otherwise, we do it manually.
> +	 */
> +	if (st->cnv_gpio)
> +		ad4695_cnv_manual_trigger(st);
> +
> =C2=A0	/*
> =C2=A0	 * Setting the first channel to the temperature channel isn't
> supported
> =C2=A0	 * in single-cycle mode, so we have to do an extra conversion to r=
ead
> @@ -729,6 +924,13 @@ static int ad4695_read_one_sample(struct ad4695_stat=
e
> *st, unsigned int address)
> =C2=A0		ret =3D spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> =C2=A0		if (ret)
> =C2=A0			return ret;
> +
> +		/*
> +		 * If CNV is connected to CS, the previous function will have
> +		 * triggered the conversion, otherwise, we do it manually.
> +		 */
> +		if (st->cnv_gpio)
> +			ad4695_cnv_manual_trigger(st);
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Then read the result and exit conversion mode. */
> @@ -842,11 +1044,34 @@ static int ad4695_read_raw(struct iio_dev *indio_d=
ev,
> =C2=A0		default:
> =C2=A0			return -EINVAL;
> =C2=A0		}
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		struct pwm_state state;
> +
> +		ret =3D pwm_get_state_hw(st->cnv_pwm, &state);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, state.period);
> +
> +		return IIO_VAL_INT;
> +	}
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int ad4695_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +				=C2=A0=C2=A0=C2=A0 long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return IIO_VAL_INT;
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +}
> +
> =C2=A0static int ad4695_write_raw(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> =C2=A0			=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> @@ -900,6 +1125,17 @@ static int ad4695_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0			default:
> =C2=A0				return -EINVAL;
> =C2=A0			}
> +		case IIO_CHAN_INFO_SAMP_FREQ: {
> +			struct pwm_state state;
> +
> +			if (val <=3D 0 || val > st->chip_info->max_sample_rate)
> +				return -EINVAL;
> +
> +			guard(mutex)(&st->cnv_pwm_lock);
> +			pwm_get_state(st->cnv_pwm, &state);
> +			state.period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, val);
> +			return pwm_apply_might_sleep(st->cnv_pwm, &state);
> +		}
> =C2=A0		default:
> =C2=A0			return -EINVAL;
> =C2=A0		}
> @@ -923,6 +1159,7 @@ static int ad4695_read_avail(struct iio_dev *indio_d=
ev,
> =C2=A0		 */
> =C2=A0		S16_MIN / 4, 0, 0, MICRO / 4, S16_MAX / 4, S16_MAX % 4 *
> MICRO / 4
> =C2=A0	};
> +	struct ad4695_state *st =3D iio_priv(indio_dev);
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_CALIBSCALE:
> @@ -943,6 +1180,10 @@ static int ad4695_read_avail(struct iio_dev *indio_=
dev,
> =C2=A0		default:
> =C2=A0			return -EINVAL;
> =C2=A0		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals =3D st->sample_freq_range;
> +		*type =3D IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -978,6 +1219,7 @@ static int ad4695_debugfs_reg_access(struct iio_dev
> *indio_dev,
> =C2=A0
> =C2=A0static const struct iio_info ad4695_info =3D {
> =C2=A0	.read_raw =3D &ad4695_read_raw,
> +	.write_raw_get_fmt =3D &ad4695_write_raw_get_fmt,
> =C2=A0	.write_raw =3D &ad4695_write_raw,
> =C2=A0	.read_avail =3D &ad4695_read_avail,
> =C2=A0	.debugfs_reg_access =3D &ad4695_debugfs_reg_access,
> @@ -1091,26 +1333,166 @@ static int ad4695_parse_channel_cfg(struct
> ad4695_state *st)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static bool ad4695_offload_trigger_match(struct spi_offload_trigger *tri=
gger,
> +					 enum spi_offload_trigger_type type,
> +					 u64 *args, u32 nargs)
> +{
> +	if (type !=3D SPI_OFFLOAD_TRIGGER_DATA_READY)
> +		return false;
> +
> +	/*
> +	 * Requires 2 args:
> +	 * args[0] is the trigger event.
> +	 * args[1] is the GPIO pin number.
> +	 */
> +	if (nargs !=3D 2 || args[0] !=3D AD4695_TRIGGER_EVENT_BUSY)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int ad4695_offload_trigger_request(struct spi_offload_trigger
> *trigger,
> +					=C2=A0 enum spi_offload_trigger_type type,
> +					=C2=A0 u64 *args, u32 nargs)
> +{
> +	struct ad4695_state *st =3D spi_offload_trigger_get_priv(trigger);
> +
> +	/* Should already be validated by match, but just in case. */
> +	if (nargs !=3D 2)
> +		return -EINVAL;
> +
> +	/* DT tells us if BUSY event uses GP0 or GP3. */
> +	if (args[1] =3D=3D AD4695_TRIGGER_PIN_GP3)
> +		return regmap_set_bits(st->regmap, AD4695_REG_GP_MODE,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4695_REG_GP_MODE_BUSY_GP_SEL)=
;
> +
> +	return regmap_clear_bits(st->regmap, AD4695_REG_GPIO_CTRL,
> +				 AD4695_REG_GP_MODE_BUSY_GP_SEL);
> +}
> +
> +static int
> +ad4695_offload_trigger_validate(struct spi_offload_trigger *trigger,
> +				struct spi_offload_trigger_config *config)
> +{
> +	if (config->type !=3D SPI_OFFLOAD_TRIGGER_DATA_READY)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/*
> + * NB: There are no enable/disable callbacks here due to requiring a SPI
> + * message to enable or disable the BUSY output on the ADC.
> + */
> +static const struct spi_offload_trigger_ops ad4695_offload_trigger_ops =
=3D {
> +	.match =3D ad4695_offload_trigger_match,
> +	.request =3D ad4695_offload_trigger_request,
> +	.validate =3D ad4695_offload_trigger_validate,
> +};
> +
> +static void ad4695_pwm_disable(void *pwm)
> +{
> +	pwm_disable(pwm);
> +}
> +
> +static int ad4695_probe_spi_offload(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0 struct ad4695_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	struct spi_offload_trigger_info trigger_info =3D {
> +		.fwnode =3D dev_fwnode(dev),
> +		.ops =3D &ad4695_offload_trigger_ops,
> +		.priv =3D st,
> +	};
> +	struct pwm_state pwm_state;
> +	struct dma_chan *rx_dma;
> +	int ret, i;
> +
> +	indio_dev->num_channels =3D st->chip_info->num_voltage_inputs + 1;
> +	indio_dev->setup_ops =3D &ad4695_offload_buffer_setup_ops;
> +
> +	if (!st->cnv_gpio)
> +		return dev_err_probe(dev, -ENODEV,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "CNV GPIO is required for SPI
> offload\n");
> +
> +	ret =3D devm_spi_offload_trigger_register(dev, &trigger_info);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to register offload trigger\n");
> +
> +	st->offload_trigger =3D devm_spi_offload_trigger_get(dev, st->offload,
> +		SPI_OFFLOAD_TRIGGER_DATA_READY);
> +	if (IS_ERR(st->offload_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get offload trigger\n");
> +
> +	ret =3D devm_mutex_init(dev, &st->cnv_pwm_lock);
> +	if (ret)
> +		return ret;
> +
> +	st->cnv_pwm =3D devm_pwm_get(dev, NULL);
> +	if (IS_ERR(st->cnv_pwm))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_pwm),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get CNV PWM\n");
> +
> +	pwm_init_state(st->cnv_pwm, &pwm_state);
> +
> +	/* If firmware didn't provide default rate, use 10kHz (arbitrary). */
> +	if (pwm_state.period =3D=3D 0)
> +		pwm_state.period =3D 100 * MILLI;
> +
> +	pwm_state.enabled =3D true;
> +
> +	ret =3D pwm_apply_might_sleep(st->cnv_pwm, &pwm_state);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to apply CNV PWM\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, ad4695_pwm_disable, st->cnv_pwm);
> +	if (ret)
> +		return ret;
> +
> +	rx_dma =3D devm_spi_offload_rx_stream_request_dma_chan(dev, st-
> >offload);
> +	if (IS_ERR(rx_dma))
> +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get offload RX DMA\n");
> +
> +	for (i =3D 0; i < indio_dev->num_channels; i++) {
> +		struct iio_chan_spec *chan =3D &st->iio_chan[i];
> +
> +		/*
> +		 * NB: When using offload support, all channels need to have
> the
> +		 * same bits_per_word because they all use the same SPI
> message
> +		 * for reading one sample. In order to prevent breaking
> +		 * userspace in the future when oversampling support is
> added,
> +		 * all channels are set read 19 bits with a shift of 3 to
> mask
> +		 * out the extra bits even though we currently only support
> 16
> +		 * bit samples (oversampling ratio =3D=3D 1).
> +		 */
> +		chan->scan_type.shift =3D 3;
> +		chan->scan_type.storagebits =3D 32;
> +		/* add sample frequency for PWM CNV trigger */
> +		chan->info_mask_separate |=3D BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +		chan->info_mask_separate_available |=3D
> BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +	}
> +
> +	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
> +		rx_dma, IIO_BUFFER_DIRECTION_IN);
> +}
> +
> +static const struct spi_offload_config ad4695_spi_offload_config =3D {
> +	.capability_flags =3D SPI_OFFLOAD_CAP_TRIGGER |
> +			=C2=A0=C2=A0=C2=A0 SPI_OFFLOAD_CAP_RX_STREAM_DMA,
> +};
> +
> =C2=A0static int ad4695_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	struct device *dev =3D &spi->dev;
> =C2=A0	struct ad4695_state *st;
> =C2=A0	struct iio_dev *indio_dev;
> -	struct gpio_desc *cnv_gpio;
> =C2=A0	bool use_internal_ldo_supply;
> =C2=A0	bool use_internal_ref_buffer;
> =C2=A0	int ret;
> =C2=A0
> -	cnv_gpio =3D devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
> -	if (IS_ERR(cnv_gpio))
> -		return dev_err_probe(dev, PTR_ERR(cnv_gpio),
> -				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get CNV GPIO\n");
> -
> -	/* Driver currently requires CNV pin to be connected to SPI CS */
> -	if (cnv_gpio)
> -		return dev_err_probe(dev, -ENODEV,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 "CNV GPIO is not supported\n");
> -
> =C2=A0	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> =C2=A0	if (!indio_dev)
> =C2=A0		return -ENOMEM;
> @@ -1122,6 +1504,10 @@ static int ad4695_probe(struct spi_device *spi)
> =C2=A0	if (!st->chip_info)
> =C2=A0		return -EINVAL;
> =C2=A0
> +	st->sample_freq_range[0] =3D 1; /* min */
> +	st->sample_freq_range[1] =3D 1; /* step */
> +	st->sample_freq_range[2] =3D st->chip_info->max_sample_rate; /* max */
> +
> =C2=A0	st->regmap =3D devm_regmap_init(dev, &ad4695_regmap_bus, st,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ad4695_regmap_config);
> =C2=A0	if (IS_ERR(st->regmap))
> @@ -1134,6 +1520,11 @@ static int ad4695_probe(struct spi_device *spi)
> =C2=A0		return dev_err_probe(dev, PTR_ERR(st->regmap16),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize regmap16\n");
> =C2=A0
> +	st->cnv_gpio =3D devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->cnv_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get CNV GPIO\n");
> +
> =C2=A0	ret =3D devm_regulator_bulk_get_enable(dev,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0
> ARRAY_SIZE(ad4695_power_supplies),
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 ad4695_power_supplies);
> @@ -1261,12 +1652,31 @@ static int ad4695_probe(struct spi_device *spi)
> =C2=A0	indio_dev->channels =3D st->iio_chan;
> =C2=A0	indio_dev->num_channels =3D st->chip_info->num_voltage_inputs + 2;
> =C2=A0
> -	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_pollfunc_store_time,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad4695_trigger_handler,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ad4695_buffer_setup_ops);
> -	if (ret)
> -		return ret;
> +	st->offload =3D devm_spi_offload_get(dev, spi,
> &ad4695_spi_offload_config);
> +	ret =3D PTR_ERR_OR_ZERO(st->offload);
> +	if (ret && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get SPI
> offload\n");
> +
> +	/* If no SPI offload, fall back to low speed usage. */
> +	if (ret =3D=3D -ENODEV) {
> +		/* Driver currently requires CNV pin to be connected to SPI
> CS */
> +		if (st->cnv_gpio)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "CNV GPIO is not supported\n");
> +
> +		indio_dev->num_channels =3D st->chip_info->num_voltage_inputs +
> 2;
> +
> +		ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> iio_pollfunc_store_time,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad4695_trigger_handler,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> &ad4695_buffer_setup_ops);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret =3D ad4695_probe_spi_offload(indio_dev, st);
> +		if (ret)
> +			return ret;
> +	}
> =C2=A0
> =C2=A0	return devm_iio_device_register(dev, indio_dev);
> =C2=A0}
> @@ -1303,3 +1713,4 @@ MODULE_AUTHOR("Ramona Gradinariu
> <ramona.gradinariu@analog.com>");
> =C2=A0MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
> =C2=A0MODULE_DESCRIPTION("Analog Devices AD4695 ADC driver");
> =C2=A0MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
>=20


