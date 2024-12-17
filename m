Return-Path: <linux-pwm+bounces-4371-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA309F4AC0
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 13:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDAC27A064D
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 12:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134E1EB9E8;
	Tue, 17 Dec 2024 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZTXYirW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F314D8CE;
	Tue, 17 Dec 2024 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437629; cv=none; b=qxpwuJNYqimKrHtzEW5XR/ZwLh36/MC1Ufeu4qg9kVDW0zO2F0q1TQ4C1gLIzApowe+VgawFQYFL7mojtUTpcNdD4rZRjauF237r5iNQjjiE654QiUweI/fnN3Wie1kjMRNvEsUt5QFMr/alC2dIu1IeKnEPMRCFrbHV2glMDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437629; c=relaxed/simple;
	bh=OtPHWwYDEm1c0eAndnDwaxCRun/qZ23tLwe8SVhQaNc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AQqqrKbtjsNZyqxOnhLAzXsu4uylcBv7zcKBWbzhtT+sbQhoAzON8hQGGxHCY469jjZtiMIJIeuYuayv8znAiIfyQTMm1+aj8GmVT08O+oqn127WsSLd8msQ9bfXtr7I40csdp02ygHGSc1NnIz0TsjNKK3k+tVbETVsc2O2Pk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZTXYirW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso898478466b.1;
        Tue, 17 Dec 2024 04:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734437626; x=1735042426; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yjujiW/cvB722V1/D/rPQofNjp3fdkA4kH1I2dkQcmc=;
        b=bZTXYirWkRUPA2u73E7/zjsxvTaBKuzpR2FwRQaEpj91UaB0IGXwfON4Mykaek/0c/
         eGwU0208B2L6v1NLTQXjRm1BV4Mu/mCDrw+OS+V2N5D4hjwY7n1O90xGIEBQJRGmlho6
         EtWL0H61ZZYJeTbD5zzOhjD1La53g8C1P0XkYtTxPRjwoB7y5k9Mfj+TLYGlY34iw3El
         +0OY+OwOeIh4PdfYz6VJZSD1x0dwosPQQALH1CLiou//JO2Hi9TZKyBpHBvyCt8NJJyY
         pr49dCq0IS4DdBCifFxwCBn5YChvzfAEnZp1x8WOuUIGFXuuHRNmSO7MxsYYSeTRYX1s
         KB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734437626; x=1735042426;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjujiW/cvB722V1/D/rPQofNjp3fdkA4kH1I2dkQcmc=;
        b=YFaiuB44mBHJumtI+LlVmZkG/rhFFvZ1gej2hVd8ZfHyEhKCqTNdHzkE7CNQt4jjf2
         oUPfb0EBHB1k4WdRyGnS9i6g9ebmJwXCC/nYxVDnZcAPSLWd1FfUtxL4aL0kDMlDaBAu
         glWg+WlQ5jGJkU8mYVeolUVRKiNgHXtUpBjRtxLhOn21aW8NYDe8yj0tPZT1rkk9xX1M
         uadSVx9/qbcp6Kda5sH0wKtJpRmHv+wrQyLhyQY84xE2abGGd+VE9a8MYrBb9QaPcmWp
         /o3n1UI9d24xCjheiCNmX3ynlZ2HgiWReg9zNiJUknnedFThcpFumL/J1WX3X2lW2qtB
         NeEw==
X-Forwarded-Encrypted: i=1; AJvYcCV7N9BAiD1w3SXaVAsdQ1cLQ3RvDf+52yCOSkRZFo4j5omOCWWuNZky/mfsWwbEsSjUAMd0t4zRrShW9KxL@vger.kernel.org, AJvYcCVrkGLc6cWTwSlXrYqahrW5Swzde1F3AKGT2EXc57ZGaiTkXkF9zM36tmRTbXdsho6Pzc2aiYPoQrm4@vger.kernel.org, AJvYcCVt2ej0Voa96ZGrfyKkEhoyPDN/jiJ4EuUVx4eqo0PDZGj8X103NIPgd+/SXgJuWQnVv3r8rO24a3BP@vger.kernel.org, AJvYcCX+b2UIVdx5vEpqhdAyYBtEi8xeKTxMq/6NpasO2+7iWMTp8zXQBonCbvfqpzH/BUWn+rhiWdk2O2Ap@vger.kernel.org, AJvYcCXH5gaVVoG5h4guwgwZTytIaaZ2kPOh+sFbtjfCTm5UBkLJlRUAIvRhRplYQ4Dd1JKCA2qRXdxNcLZ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7hJOJRVpoIHECaz22yyVGa/XSwhSQ/WJ40usk5Ou1M4zZ1AhW
	URIo8VRIzE6b94lgn6SWwOLFlnL/je04/TCRarFOskku15uiJqk3
X-Gm-Gg: ASbGncu30Wc1prRoUDe05G/cEa9h0FsxZntTsHwW/XNmg0vkzU5c4I91J6BTBK1NrcJ
	tQ+1rIdDrVXQNrNqnPISeqM1fsF7Dndnr6LyTOKTtKagQhGWi+bC3XhmdfPGFxERhp2Vo4vmxef
	lN5S1v1BCFAvl2oUq6eDpN+0SvAPZCuyfws70DI/YZoXIemkPCFVpdByUzVrYkVAU8lLBsQSqTL
	10e/3TJimHPSXsD86+UOvEqdNamjcca/7IanLQRVft+pm/N3yHObMo+FZZfhId+2IZOpb/pdNel
	/RJQxBmrhsG2ixvLQ7Yxl/bt701lTjFEOb+zqr0q6qItUagCNIN4Eebo+Dsp5ZxswBjhuXuwrqr
	wuh8FlT73M1y6Hw==
X-Google-Smtp-Source: AGHT+IHoPtEFMa9olCmn32dyxjmNPyn9UCOKAbIP1jXvhZ7Me2Wv9qgdM7HcD2e+RVCj39gW72KRBw==
X-Received: by 2002:a17:907:1c0f:b0:aa6:b4b3:5925 with SMTP id a640c23a62f3a-aab77909d61mr1466654066b.14.1734437626005;
        Tue, 17 Dec 2024 04:13:46 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ec48sm440699266b.147.2024.12.17.04.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:13:45 -0800 (PST)
Message-ID: <c54da9aa3edb841b1e3d5f2fbfd0b29e89da1184.camel@gmail.com>
Subject: Re: [PATCH v6 17/17] iio: dac: ad5791: Add offload support
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
 linux-iio@vger.kernel.org, 	linux-pwm@vger.kernel.org, Axel Haslam
 <ahaslam@baylibre.com>
Date: Tue, 17 Dec 2024 13:18:16 +0100
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-17-88ee574d5d03@baylibre.com>
References: 
	<20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	 <20241211-dlech-mainline-spi-engine-offload-2-v6-17-88ee574d5d03@baylibre.com>
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
> From: Axel Haslam <ahaslam@baylibre.com>
>=20
> Add SPI offload support to stream TX buffers using DMA.
> This allows loading samples to the DAC with a rate of 1 MSPS.
>=20
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

>=20
> v6 changes: new patch in v6
> ---
> =C2=A0drivers/iio/dac/Kconfig=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0drivers/iio/dac/ad5791.c | 150
> +++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A02 files changed, 153 insertions(+)
>=20
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index
> 4cde34e8c8e3356aa41bcd2cba38d67d5c6f8049..f6c5cb632acbdc2432f60b163452bb0=
c5f89
> fa72 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -296,6 +296,9 @@ config AD5770R
> =C2=A0config AD5791
> =C2=A0	tristate "Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC SP=
I
> driver"
> =C2=A0	depends on SPI
> +	select SPI_OFFLOAD
> +	select IIO_BUFFER
> +	select IIO_BUFFER_DMAENGINE
> =C2=A0	help
> =C2=A0	=C2=A0 Say yes here to build support for Analog Devices AD5760, AD=
5780,
> =C2=A0	=C2=A0 AD5781, AD5790, AD5791 High Resolution Voltage Output Digit=
al to
> diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> index
> 24462cb020e19e8e2c6faa13109ac047cf423c37..a2953a9a4e5d5bc17c9c4a8281be4b4=
1b1af
> 5de8 100644
> --- a/drivers/iio/dac/ad5791.c
> +++ b/drivers/iio/dac/ad5791.c
> @@ -15,9 +15,12 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/slab.h>
> +#include <linux/spi/offload/consumer.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0#include <linux/sysfs.h>
> +#include <linux/units.h>
> =C2=A0
> +#include <linux/iio/buffer-dmaengine.h>
> =C2=A0#include <linux/iio/dac/ad5791.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/sysfs.h>
> @@ -64,11 +67,13 @@
> =C2=A0 * struct ad5791_chip_info - chip specific information
> =C2=A0 * @name:		name of the dac chip
> =C2=A0 * @channel:		channel specification
> + * @channel_offload:	channel specification for offload
> =C2=A0 * @get_lin_comp:	function pointer to the device specific function
> =C2=A0 */
> =C2=A0struct ad5791_chip_info {
> =C2=A0	const char *name;
> =C2=A0	const struct iio_chan_spec channel;
> +	const struct iio_chan_spec channel_offload;
> =C2=A0	int (*get_lin_comp)(unsigned int span);
> =C2=A0};
> =C2=A0
> @@ -81,6 +86,11 @@ struct ad5791_chip_info {
> =C2=A0 * @gpio_clear:		clear gpio
> =C2=A0 * @gpio_ldac:		load dac gpio
> =C2=A0 * @chip_info:		chip model specific constants
> + * @offload_msg:	spi message used for offload
> + * @offload_xfer:	spi transfer used for offload
> + * @offload:		offload device
> + * @offload_trigger:	offload trigger
> + * @offload_trigger_hz:	offload sample rate
> =C2=A0 * @vref_mv:		actual reference voltage used
> =C2=A0 * @vref_neg_mv:	voltage of the negative supply
> =C2=A0 * @ctrl:		control register cache
> @@ -96,6 +106,11 @@ struct ad5791_state {
> =C2=A0	struct gpio_desc		*gpio_clear;
> =C2=A0	struct gpio_desc		*gpio_ldac;
> =C2=A0	const struct ad5791_chip_info	*chip_info;
> +	struct spi_message		offload_msg;
> +	struct spi_transfer		offload_xfer;
> +	struct spi_offload		*offload;
> +	struct spi_offload_trigger	*offload_trigger;
> +	unsigned int			offload_trigger_hz;
> =C2=A0	unsigned short			vref_mv;
> =C2=A0	unsigned int			vref_neg_mv;
> =C2=A0	unsigned			ctrl;
> @@ -232,6 +247,25 @@ static int ad5780_get_lin_comp(unsigned int span)
> =C2=A0		return AD5780_LINCOMP_10_20;
> =C2=A0}
> =C2=A0
> +static int ad5791_set_sample_freq(struct ad5791_state *st, int val)
> +{
> +	struct spi_offload_trigger_config config =3D {
> +		.type =3D SPI_OFFLOAD_TRIGGER_PERIODIC,
> +		.periodic =3D {
> +			.frequency_hz =3D val,
> +		},
> +	};
> +	int ret;
> +
> +	ret =3D spi_offload_trigger_validate(st->offload_trigger, &config);
> +	if (ret)
> +		return ret;
> +
> +	st->offload_trigger_hz =3D config.periodic.frequency_hz;
> +
> +	return 0;
> +}
> +
> =C2=A0static int ad5791_read_raw(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> =C2=A0			=C2=A0=C2=A0 int *val,
> @@ -259,6 +293,9 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
> =C2=A0		do_div(val64, st->vref_mv);
> =C2=A0		*val =3D -val64;
> =C2=A0		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D st->offload_trigger_hz;
> +		return IIO_VAL_INT;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -299,6 +336,24 @@ static const struct ad5791_chip_info _name##_chip_in=
fo =3D
> {		\
> =C2=A0			},						\
> =C2=A0			.ext_info =3D ad5791_ext_info,			\
> =C2=A0	},								\
> +	.channel_offload =3D {						\
> +			.type =3D IIO_VOLTAGE,				\
> +			.output =3D 1,					\
> +			.indexed =3D 1,					\
> +			.address =3D AD5791_ADDR_DAC0,			\
> +			.channel =3D 0,					\
> +			.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),	\
> +			.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE)
> |	\
> +				BIT(IIO_CHAN_INFO_OFFSET),		\
> +			.info_mask_shared_by_all =3D
> BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +			.scan_type =3D {					\
> +				.sign =3D 'u',				\
> +				.realbits =3D (bits),			\
> +				.storagebits =3D 32,			\
> +				.shift =3D (_shift),			\
> +			},						\
> +			.ext_info =3D ad5791_ext_info,			\
> +	},								\
> =C2=A0}
> =C2=A0
> =C2=A0AD5791_DEFINE_CHIP_INFO(ad5760, 16, 4, ad5780_get_lin_comp);
> @@ -322,16 +377,95 @@ static int ad5791_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0
> =C2=A0		return ad5791_spi_write(st, chan->address, val);
> =C2=A0
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val < 0 || val2 < 0)
> +			return -EINVAL;
> +		return ad5791_set_sample_freq(st, val);
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int ad5791_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad5791_state *st =3D iio_priv(indio_dev);
> +	struct spi_offload_trigger_config config =3D {
> +		.type =3D SPI_OFFLOAD_TRIGGER_PERIODIC,
> +		.periodic =3D {
> +			.frequency_hz =3D st->offload_trigger_hz,
> +		},
> +	};
> +
> +	if (st->pwr_down)
> +		return -EINVAL;
> +
> +	return spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &config);
> +}
> +
> +static int ad5791_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad5791_state *st =3D iio_priv(indio_dev);
> +
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ad5791_buffer_setup_ops =3D {
> +	.preenable =3D &ad5791_buffer_preenable,
> +	.postdisable =3D &ad5791_buffer_postdisable,
> +};
> +
> +static int ad5791_offload_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad5791_state *st =3D iio_priv(indio_dev);
> +	struct spi_device *spi =3D st->spi;
> +	struct dma_chan *tx_dma;
> +	int ret;
> +
> +	st->offload_trigger =3D devm_spi_offload_trigger_get(&spi->dev,
> +		st->offload, SPI_OFFLOAD_TRIGGER_PERIODIC);
> +	if (IS_ERR(st->offload_trigger))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->offload_trigger),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get offload trigger\n");
> +
> +	ret =3D ad5791_set_sample_freq(st, 1 * MEGA);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to init sample rate\n");
> +
> +	tx_dma =3D devm_spi_offload_tx_stream_request_dma_chan(&spi->dev,
> +							=C2=A0=C2=A0=C2=A0=C2=A0 st->offload);
> +	if (IS_ERR(tx_dma))
> +		return dev_err_probe(&spi->dev, PTR_ERR(tx_dma),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get offload TX DMA\n");
> +
> +	ret =3D devm_iio_dmaengine_buffer_setup_with_handle(&spi->dev,
> +		indio_dev, tx_dma, IIO_BUFFER_DIRECTION_OUT);
> +	if (ret)
> +		return ret;
> +
> +	st->offload_xfer.len =3D 4;
> +	st->offload_xfer.bits_per_word =3D 24;
> +	st->offload_xfer.offload_flags =3D SPI_OFFLOAD_XFER_TX_STREAM;
> +
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer,
> 1);
> +	st->offload_msg.offload =3D st->offload;
> +
> +	return devm_spi_optimize_message(&spi->dev, st->spi, &st-
> >offload_msg);
> +}
> +
> =C2=A0static const struct iio_info ad5791_info =3D {
> =C2=A0	.read_raw =3D &ad5791_read_raw,
> =C2=A0	.write_raw =3D &ad5791_write_raw,
> =C2=A0};
> =C2=A0
> +static const struct spi_offload_config ad5791_offload_config =3D {
> +	.capability_flags =3D SPI_OFFLOAD_CAP_TRIGGER |
> +			=C2=A0=C2=A0=C2=A0 SPI_OFFLOAD_CAP_TX_STREAM_DMA,
> +};
> +
> =C2=A0static int ad5791_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	const struct ad5791_platform_data *pdata =3D dev_get_platdata(&spi=
-
> >dev);
> @@ -416,6 +550,21 @@ static int ad5791_probe(struct spi_device *spi)
> =C2=A0	indio_dev->channels =3D &st->chip_info->channel;
> =C2=A0	indio_dev->num_channels =3D 1;
> =C2=A0	indio_dev->name =3D st->chip_info->name;
> +
> +	st->offload =3D devm_spi_offload_get(&spi->dev, spi,
> &ad5791_offload_config);
> +	ret =3D PTR_ERR_OR_ZERO(st->offload);
> +	if (ret && ret !=3D -ENODEV)
> +		return dev_err_probe(&spi->dev, ret, "failed to get
> offload\n");
> +
> +	if (ret !=3D -ENODEV) {
> +		indio_dev->channels =3D &st->chip_info->channel_offload;
> +		indio_dev->setup_ops =3D &ad5791_buffer_setup_ops;
> +		ret =3D=C2=A0 ad5791_offload_setup(indio_dev);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "fail to setup offload\n");
> +	}
> +
> =C2=A0	return devm_iio_device_register(&spi->dev, indio_dev);
> =C2=A0}
> =C2=A0
> @@ -452,3 +601,4 @@ module_spi_driver(ad5791_driver);
> =C2=A0MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> =C2=A0MODULE_DESCRIPTION("Analog Devices AD5760/AD5780/AD5781/AD5790/AD57=
91 DAC");
> =C2=A0MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
>=20


