Return-Path: <linux-pwm+bounces-4368-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83569F4A70
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 12:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F6518886CE
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058A51F03F4;
	Tue, 17 Dec 2024 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmNK5Uqf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963931EE031;
	Tue, 17 Dec 2024 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436677; cv=none; b=JiXi8qLbReMY87sjIN7J24iHUd0j7GfhEMSY/ly1y3fedovVdnGkKJm0yqjCJLaWAiB/F1UqBNjBrUH+L1i23gKmDtmcOY8jK30ztNyze1Psenwif+6rS4u54VNlABZnzm9FciimHQEL6SR0B3lel0qy/yBkYCvd66cu2ZirS3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436677; c=relaxed/simple;
	bh=QkLpB/byIKkgPn9hZv6Qc21YBAoOPp5+qM+/ydtT7ws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fV97MsIBHKuc8aBsTuwsiaGuo+BWtU+p/Ov00uQwhCFYDw3TvSx2M3aXmjVD1ySO9MsRFwFtTJjQrT921h9cCsx2QhvGpwvDN5tnnkME4BoAKlUMJaL+P+3xDf7XCvPy4+qf2zQlDPtuLGDQgxWnuTYimVLaymmsbaYuB9Tbwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmNK5Uqf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa69107179cso973108966b.0;
        Tue, 17 Dec 2024 03:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734436674; x=1735041474; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JSLPO6B/5PgjlBiqpkaMKAUKZQHhIsg6Nl9LXNhkpL8=;
        b=DmNK5UqfND7Tn71w3gCa1ODxE+JH3eNqnSQa9gRDf8AJr7zaTf+SnbBbwYwfFGzi6u
         YubsBMorIUZGWc1RVLe0eIR9//rcoSDsfdTfchONRgkzf5PXkVdsCrNHr2Ids0gN/Au4
         XrG5AqI9eD914z3tab6tk92LhJZ8XQalkOABJ04Wk57GYb3Cmzm7zlqcJ+uulSqGcjP+
         lbPTn8Ltg6j0FlTYoIXGEsH8viDxWMnerloFdSOn6ZygR8Vpv714+Zy7AVKQeEQh/0TF
         UEuxprWmpQCwfEmiSVvU9f/VJUeJw+UjZs+6zC2so4zjABxVmO1aMeKN4zH93Rz/1qpt
         utVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436674; x=1735041474;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JSLPO6B/5PgjlBiqpkaMKAUKZQHhIsg6Nl9LXNhkpL8=;
        b=naaQdh0UXW1V+iYWU6rsWo0yC3HtfL7uIHKuI5BSkKG9zQemwqhM6p70RxSV8S/HPi
         K5HHsfptTNvomagvE37bGZpGboSRbRPH0rpJmcMAKzNPdPx2a18MDD/SSjwTtb8DoJmq
         i3v+ADzgKRy63J8whMNbqW2qpIMgH7A/5qu9Topl1mhM5J8Pzxk55cMbqq7X1SeISWcf
         lwHAo6Efv3HqIdCYOcp/17nBEgO7s9XkRd4nwRo+RZkW6fT4bXHGZwt+2sF7m92RIYST
         J9fR3P/4FSXJ25PNk1YUk1DEQh1rFJU6LUID6IfMZcb8pZ+qhtHggQEkA7byLKonT/iM
         b+iA==
X-Forwarded-Encrypted: i=1; AJvYcCUBe0tqrdo9cF6cLfyRWmaT0d89amWlZw11HgfeHIPL7DNJsKZ/Bw1vq7ufXl2jrjDSt58ByluHg4EK@vger.kernel.org, AJvYcCUh7266+TSymtxvwZWQ6ZkWo8lIcUhbMiX8Q3WuGtRQjq0pfYQT6TrQTFhjk1eD2WK63oQD1F4oyNuk5GJC@vger.kernel.org, AJvYcCUkuvsz2Z3MQrKpgognydfAm2s/NuTwPhRVFBabUQooFK/ftD4ruGDtx6kn673LoiY7XSsqqGjzaWZD@vger.kernel.org, AJvYcCVcJYaxt9tG1S90oqgsBtmVf2z9dt4UYGvIyILPJd4Lq0492AXEshsoYaxzdkawu0aZ/fiY6ikN2tat@vger.kernel.org, AJvYcCX+/3Azj/qiMNaB2V46GisQMbsFfGaDsxKqoYQsH5sWYcsYointX2Gr4T6smnDP4Fl7OQ07yvwJR0OF@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQFvIWxM+yO8viqTtHuL0uQBLjY6sIn13bQHlJUoiW+IhexTa
	YpsvZXcgTJUlZUeHn5Ik5tsPGVawrb7btKcGG8QWNoI4M3XleH8t
X-Gm-Gg: ASbGncvkgV3TJD9QGq6sTwA4PsziPfyHflrC+8ceTebO+CWvNbihCrV1k71sfdVQsIi
	ETq92aJ8897McchUjbnDqPiG8RoAJqSjNNJNDseUZZNEfv52bVH6Fu3a69uaVVVlkWaSL1DgqYJ
	uYfV4+DEn7PhrytsHtbhkiO2/azztOliACsPcTCi1HGA4D79N53GxApYt69uAwJWcOce7JAAGCV
	rCXed9AEWmJ+Z0A6FigOP7ahOMoCbpFsfgkMuzEJXA+aRFEIy45X4TKvdt0e/yISSh8IT1bckHT
	O1eXSw+z0BjE74l4Q0QEY5Hg0/aACi88dJmbGr3lh6ndEXWrjsP+MNHBjqSDzU1TdRrKUUhCfYd
	kr531CzKlwUEBGA==
X-Google-Smtp-Source: AGHT+IEMIk0P1CLnugYlWNqwGLoMmZDZ6yJTxKH8HaScgU696+Iuplee0jdvBHVnI60iRUYr9tDG8Q==
X-Received: by 2002:a17:907:2d8c:b0:aa6:9ee3:e51f with SMTP id a640c23a62f3a-aab77e974a5mr1667124366b.41.1734436673476;
        Tue, 17 Dec 2024 03:57:53 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aabbe35c629sm259486866b.175.2024.12.17.03.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:57:53 -0800 (PST)
Message-ID: <3bb6c6347b09ac62178f79ab53d52aebe867197f.camel@gmail.com>
Subject: Re: [PATCH v6 11/17] iio: adc: ad7944: add support for SPI offload
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
Date: Tue, 17 Dec 2024 13:02:24 +0100
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-11-88ee574d5d03@baylibre.com>
References: 
	<20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	 <20241211-dlech-mainline-spi-engine-offload-2-v6-11-88ee574d5d03@baylibre.com>
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
> Add support for SPI offload to the ad7944 driver. This allows reading
> data at the max sample rate of 2.5 MSPS.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

>=20
> v6 changes:
> * More detailed comments on offload channels info struct. (I didn't
> =C2=A0 put them inside the macro because the multiline comments don't pla=
y
> =C2=A0 well with the line continuation "\".)
>=20
> v5 changes:
> * Remove dev_info() message.
> * Implement sampling_frequency_available attribute.
> * Limit max sample rate to chip-specific value.
>=20
> v4 changes:
> * Adapted to changes in other patches.
> * Add new separate channel spec for when using SPI offload.
> * Fixed some nitpicks.
>=20
> v3 changes:
> * Finished TODOs.
> * Adapted to changes in other patches.
>=20
> v2 changes:
>=20
> In the previous version, there was a new separate driver for the PWM
> trigger and DMA hardware buffer. This was deemed too complex so they
> are moved into the ad7944 driver.
>=20
> It has also been reworked to accommodate for the changes described in
> the other patches.
> ---
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad7944.c | 291 ++++++++++++++++++++++++++++++++++++=
++++++++--
> -
> =C2=A02 files changed, 276 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index
> a3e8ac569ce4c6b6b30b48acb265d530aa98e89c..995b9cacbaa964d26424346120c1398=
58f93
> cdcd 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -360,6 +360,7 @@ config AD7923
> =C2=A0config AD7944
> =C2=A0	tristate "Analog Devices AD7944 and similar ADCs driver"
> =C2=A0	depends on SPI
> +	select SPI_OFFLOAD
> =C2=A0	select IIO_BUFFER
> =C2=A0	select IIO_TRIGGERED_BUFFER
> =C2=A0	help
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index
> 6d1202bd55a013b092ff803f2065fd128dfa9bdd..07984eb450e82fc06d67fa0a157e3ae=
4e755
> 5678 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -16,11 +16,14 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/property.h>
> =C2=A0#include <linux/regulator/consumer.h>
> +#include <linux/spi/offload/consumer.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0#include <linux/string_helpers.h>
> +#include <linux/units.h>
> =C2=A0
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer-dmaengine.h>
> =C2=A0#include <linux/iio/trigger_consumer.h>
> =C2=A0#include <linux/iio/triggered_buffer.h>
> =C2=A0
> @@ -54,6 +57,12 @@ struct ad7944_adc {
> =C2=A0	enum ad7944_spi_mode spi_mode;
> =C2=A0	struct spi_transfer xfers[3];
> =C2=A0	struct spi_message msg;
> +	struct spi_transfer offload_xfers[2];
> +	struct spi_message offload_msg;
> +	struct spi_offload *offload;
> +	struct spi_offload_trigger *offload_trigger;
> +	unsigned long offload_trigger_hz;
> +	int sample_freq_range[3];
> =C2=A0	void *chain_mode_buf;
> =C2=A0	/* Chip-specific timing specifications. */
> =C2=A0	const struct ad7944_timing_spec *timing_spec;
> @@ -81,6 +90,8 @@ struct ad7944_adc {
> =C2=A0
> =C2=A0/* quite time before CNV rising edge */
> =C2=A0#define AD7944_T_QUIET_NS	20
> +/* minimum CNV high time to trigger conversion */
> +#define AD7944_T_CNVH_NS	10
> =C2=A0
> =C2=A0static const struct ad7944_timing_spec ad7944_timing_spec =3D {
> =C2=A0	.conv_ns =3D 420,
> @@ -95,7 +106,9 @@ static const struct ad7944_timing_spec ad7986_timing_s=
pec =3D
> {
> =C2=A0struct ad7944_chip_info {
> =C2=A0	const char *name;
> =C2=A0	const struct ad7944_timing_spec *timing_spec;
> +	u32 max_sample_rate_hz;
> =C2=A0	const struct iio_chan_spec channels[2];
> +	const struct iio_chan_spec offload_channels[1];
> =C2=A0};
> =C2=A0
> =C2=A0/* get number of bytes for SPI xfer */
> @@ -105,13 +118,15 @@ struct ad7944_chip_info {
> =C2=A0 * AD7944_DEFINE_CHIP_INFO - Define a chip info structure for a spe=
cific chip
> =C2=A0 * @_name: The name of the chip
> =C2=A0 * @_ts: The timing specification for the chip
> + * @_max: The maximum sample rate in Hz
> =C2=A0 * @_bits: The number of bits in the conversion result
> =C2=A0 * @_diff: Whether the chip is true differential or not
> =C2=A0 */
> -#define AD7944_DEFINE_CHIP_INFO(_name, _ts, _bits, _diff)		\
> +#define AD7944_DEFINE_CHIP_INFO(_name, _ts, _max, _bits,
> _diff)		\
> =C2=A0static const struct ad7944_chip_info _name##_chip_info =3D {		\
> =C2=A0	.name =3D
> #_name,							\
> =C2=A0	.timing_spec =3D &_ts##_timing_spec,				\
> +	.max_sample_rate_hz =3D _max,					\
> =C2=A0	.channels =3D {							\
> =C2=A0		{							\
> =C2=A0			.type =3D IIO_VOLTAGE,				\
> @@ -129,13 +144,43 @@ static const struct ad7944_chip_info _name##_chip_i=
nfo =3D
> {		\
> =C2=A0		},							\
> =C2=A0		IIO_CHAN_SOFT_TIMESTAMP(1),				\
> =C2=A0	},								\
> +	.offload_channels =3D {						\
> +		{							\
> +			.type =3D IIO_VOLTAGE,				\
> +			.indexed =3D 1,					\
> +			.differential =3D _diff,				\
> +			.channel =3D 0,					\
> +			.channel2 =3D _diff ? 1 : 0,			\
> +			.scan_index =3D 0,				\
> +			.scan_type.sign =3D _diff ? 's' : 'u',		\
> +			.scan_type.realbits =3D _bits,			\
> +			.scan_type.storagebits =3D 32,			\
> +			.scan_type.endianness =3D IIO_CPU,		\
> +			.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)	\
> +					| BIT(IIO_CHAN_INFO_SCALE)	\
> +					|
> BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +			.info_mask_separate_available
> =3D			\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +		},							\
> +	},								\
> =C2=A0}
> =C2=A0
> +/*
> + * Notes on the offload channels:
> + * - There is no soft timestamp since everything is done in hardware.
> + * - There is a sampling frequency attribute added. This controls the SP=
I
> + *=C2=A0=C2=A0 offload trigger.
> + * - The storagebits value depends on the SPI offload provider. Currentl=
y
> there
> + *=C2=A0=C2=A0 is only one supported provider, namely the ADI PULSAR ADC=
 HDL project,
> + *=C2=A0=C2=A0 which always uses 32-bit words for data values, even for =
<=3D 16-bit ADCs.
> + *=C2=A0=C2=A0 So the value is just hardcoded to 32 for now.
> + */
> +
> =C2=A0/* pseudo-differential with ground sense */
> -AD7944_DEFINE_CHIP_INFO(ad7944, ad7944, 14, 0);
> -AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
> +AD7944_DEFINE_CHIP_INFO(ad7944, ad7944, 2.5 * MEGA, 14, 0);
> +AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 2.5 * MEGA, 16, 0);
> =C2=A0/* fully differential */
> -AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
> +AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 2 * MEGA, 18, 1);
> =C2=A0
> =C2=A0static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct
> ad7944_adc *adc,
> =C2=A0					 const struct iio_chan_spec *chan)
> @@ -239,6 +284,48 @@ static int ad7944_chain_mode_init_msg(struct device =
*dev,
> struct ad7944_adc *adc
> =C2=A0	return devm_spi_optimize_message(dev, adc->spi, &adc->msg);
> =C2=A0}
> =C2=A0
> +/*
> + * Unlike ad7944_3wire_cs_mode_init_msg(), this creates a message that r=
eads
> + * during the conversion phase instead of the acquisition phase when rea=
ding
> + * a sample from the ADC. This is needed to be able to read at the maxim=
um
> + * sample rate. It requires the SPI controller to have offload support a=
nd a
> + * high enough SCLK rate to read the sample during the conversion phase.
> + */
> +static int ad7944_3wire_cs_mode_init_offload_msg(struct device *dev,
> +						 struct ad7944_adc *adc,
> +						 const struct iio_chan_spec
> *chan)
> +{
> +	struct spi_transfer *xfers =3D adc->offload_xfers;
> +	int ret;
> +
> +	/*
> +	 * CS is tied to CNV and we need a low to high transition to start
> the
> +	 * conversion, so place CNV low for t_QUIET to prepare for this.
> +	 */
> +	xfers[0].delay.value =3D AD7944_T_QUIET_NS;
> +	xfers[0].delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +	/* CNV has to be high for a minimum time to trigger conversion. */
> +	xfers[0].cs_change =3D 1;
> +	xfers[0].cs_change_delay.value =3D AD7944_T_CNVH_NS;
> +	xfers[0].cs_change_delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +
> +	/* Then we can read the previous sample during the conversion phase
> */
> +	xfers[1].offload_flags =3D SPI_OFFLOAD_XFER_RX_STREAM;
> +	xfers[1].len =3D AD7944_SPI_BYTES(chan->scan_type);
> +	xfers[1].bits_per_word =3D chan->scan_type.realbits;
> +
> +	spi_message_init_with_transfers(&adc->offload_msg, xfers,
> +					ARRAY_SIZE(adc->offload_xfers));
> +
> +	adc->offload_msg.offload =3D adc->offload;
> +
> +	ret =3D devm_spi_optimize_message(dev, adc->spi, &adc->offload_msg);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to prepare offload
> msg\n");
> +
> +	return 0;
> +}
> +
> =C2=A0/**
> =C2=A0 * ad7944_convert_and_acquire - Perform a single conversion and acq=
uisition
> =C2=A0 * @adc: The ADC device structure
> @@ -294,6 +381,23 @@ static int ad7944_single_conversion(struct ad7944_ad=
c
> *adc,
> =C2=A0	return IIO_VAL_INT;
> =C2=A0}
> =C2=A0
> +static int ad7944_read_avail(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const int **vals, int *type, int *length,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 long mask)
> +{
> +	struct ad7944_adc *adc =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals =3D adc->sample_freq_range;
> +		*type =3D IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> =C2=A0static int ad7944_read_raw(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> =C2=A0			=C2=A0=C2=A0 int *val, int *val2, long info)
> @@ -326,13 +430,104 @@ static int ad7944_read_raw(struct iio_dev *indio_d=
ev,
> =C2=A0			return -EINVAL;
> =C2=A0		}
> =C2=A0
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D adc->offload_trigger_hz;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7944_set_sample_freq(struct ad7944_adc *adc, int val)
> +{
> +	struct spi_offload_trigger_config config =3D {
> +		.type =3D SPI_OFFLOAD_TRIGGER_PERIODIC,
> +		.periodic =3D {
> +			.frequency_hz =3D val,
> +		},
> +	};
> +	int ret;
> +
> +	ret =3D spi_offload_trigger_validate(adc->offload_trigger, &config);
> +	if (ret)
> +		return ret;
> +
> +	adc->offload_trigger_hz =3D config.periodic.frequency_hz;
> +
> +	return 0;
> +}
> +
> +static int ad7944_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +			=C2=A0=C2=A0=C2=A0 int val, int val2, long info)
> +{
> +	struct ad7944_adc *adc =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val < 1 || val > adc->sample_freq_range[2])
> +			return -EINVAL;
> +
> +		return ad7944_set_sample_freq(adc, val);
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int ad7944_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
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
> =C2=A0static const struct iio_info ad7944_iio_info =3D {
> +	.read_avail =3D &ad7944_read_avail,
> =C2=A0	.read_raw =3D &ad7944_read_raw,
> +	.write_raw =3D &ad7944_write_raw,
> +	.write_raw_get_fmt =3D &ad7944_write_raw_get_fmt,
> +};
> +
> +static int ad7944_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad7944_adc *adc =3D iio_priv(indio_dev);
> +	struct spi_offload_trigger_config config =3D {
> +		.type =3D SPI_OFFLOAD_TRIGGER_PERIODIC,
> +		.periodic =3D {
> +			.frequency_hz =3D adc->offload_trigger_hz,
> +		},
> +	};
> +	int ret;
> +
> +	gpiod_set_value_cansleep(adc->turbo, 1);
> +
> +	ret =3D spi_offload_trigger_enable(adc->offload, adc->offload_trigger,
> +					 &config);
> +	if (ret)
> +		gpiod_set_value_cansleep(adc->turbo, 0);
> +
> +	return ret;
> +}
> +
> +static int ad7944_offload_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad7944_adc *adc =3D iio_priv(indio_dev);
> +
> +	spi_offload_trigger_disable(adc->offload, adc->offload_trigger);
> +	gpiod_set_value_cansleep(adc->turbo, 0);
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ad7944_offload_buffer_setup_ops=
 =3D {
> +	.postenable =3D &ad7944_offload_buffer_postenable,
> +	.predisable =3D &ad7944_offload_buffer_predisable,
> =C2=A0};
> =C2=A0
> =C2=A0static irqreturn_t ad7944_trigger_handler(int irq, void *p)
> @@ -446,6 +641,11 @@ static const char * const ad7944_power_supplies[] =
=3D {
> =C2=A0	"avdd",	"dvdd",	"bvdd", "vio"
> =C2=A0};
> =C2=A0
> +static const struct spi_offload_config ad7944_offload_config =3D {
> +	.capability_flags =3D SPI_OFFLOAD_CAP_TRIGGER |
> +			=C2=A0=C2=A0=C2=A0 SPI_OFFLOAD_CAP_RX_STREAM_DMA,
> +};
> +
> =C2=A0static int ad7944_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	const struct ad7944_chip_info *chip_info;
> @@ -471,6 +671,10 @@ static int ad7944_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0	adc->timing_spec =3D chip_info->timing_spec;
> =C2=A0
> +	adc->sample_freq_range[0] =3D 1; /* min */
> +	adc->sample_freq_range[1] =3D 1; /* step */
> +	adc->sample_freq_range[2] =3D chip_info->max_sample_rate_hz; /* max */
> +
> =C2=A0	ret =3D device_property_match_property_string(dev, "adi,spi-mode",
> =C2=A0						=C2=A0=C2=A0=C2=A0 ad7944_spi_modes,
> =C2=A0						=C2=A0=C2=A0=C2=A0
> ARRAY_SIZE(ad7944_spi_modes));
> @@ -590,20 +794,74 @@ static int ad7944_probe(struct spi_device *spi)
> =C2=A0	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =C2=A0	indio_dev->info =3D &ad7944_iio_info;
> =C2=A0
> -	if (adc->spi_mode =3D=3D AD7944_SPI_MODE_CHAIN) {
> -		indio_dev->available_scan_masks =3D chain_scan_masks;
> -		indio_dev->channels =3D chain_chan;
> -		indio_dev->num_channels =3D n_chain_dev + 1;
> +	adc->offload =3D devm_spi_offload_get(dev, spi,
> &ad7944_offload_config);
> +	ret =3D PTR_ERR_OR_ZERO(adc->offload);
> +	if (ret && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get offload\n");
> +
> +	/* Fall back to low speed usage when no SPI offload available. */
> +	if (ret =3D=3D -ENODEV) {
> +		if (adc->spi_mode =3D=3D AD7944_SPI_MODE_CHAIN) {
> +			indio_dev->available_scan_masks =3D chain_scan_masks;
> +			indio_dev->channels =3D chain_chan;
> +			indio_dev->num_channels =3D n_chain_dev + 1;
> +		} else {
> +			indio_dev->channels =3D chip_info->channels;
> +			indio_dev->num_channels =3D ARRAY_SIZE(chip_info-
> >channels);
> +		}
> +
> +		ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> iio_pollfunc_store_time,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad7944_trigger_handler,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
> +		if (ret)
> +			return ret;
> =C2=A0	} else {
> -		indio_dev->channels =3D chip_info->channels;
> -		indio_dev->num_channels =3D ARRAY_SIZE(chip_info->channels);
> -	}
> +		struct dma_chan *rx_dma;
> =C2=A0
> -	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_pollfunc_store_time,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad7944_trigger_handler, NULL);
> -	if (ret)
> -		return ret;
> +		if (adc->spi_mode !=3D AD7944_SPI_MODE_SINGLE)
> +			return dev_err_probe(dev, -EINVAL,
> +				"offload only supported in single mode\n");
> +
> +		indio_dev->setup_ops =3D &ad7944_offload_buffer_setup_ops;
> +		indio_dev->channels =3D chip_info->offload_channels;
> +		indio_dev->num_channels =3D ARRAY_SIZE(chip_info-
> >offload_channels);
> +
> +		adc->offload_trigger =3D devm_spi_offload_trigger_get(dev,
> +			adc->offload, SPI_OFFLOAD_TRIGGER_PERIODIC);
> +		if (IS_ERR(adc->offload_trigger))
> +			return dev_err_probe(dev, PTR_ERR(adc-
> >offload_trigger),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get offload
> trigger\n");
> +
> +		ret =3D ad7944_set_sample_freq(adc, 2 * MEGA);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "failed to init sample rate\n");
> +
> +		rx_dma =3D devm_spi_offload_rx_stream_request_dma_chan(dev,
> +								=C2=A0=C2=A0=C2=A0=C2=A0 adc-
> >offload);
> +		if (IS_ERR(rx_dma))
> +			return dev_err_probe(dev, PTR_ERR(rx_dma),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get offload RX
> DMA\n");
> +
> +		/*
> +		 * REVISIT: ideally, we would confirm that the offload RX DMA
> +		 * buffer layout is the same as what is hard-coded in
> +		 * offload_channels. Right now, the only supported offload
> +		 * is the pulsar_adc project which always uses 32-bit word
> +		 * size for data values, regardless of the SPI bits per word.
> +		 */
> +
> +		ret =3D devm_iio_dmaengine_buffer_setup_with_handle(dev,
> +			indio_dev, rx_dma, IIO_BUFFER_DIRECTION_IN);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ad7944_3wire_cs_mode_init_offload_msg(dev, adc,
> +			&chip_info->offload_channels[0]);
> +		if (ret)
> +			return ret;
> +	}
> =C2=A0
> =C2=A0	return devm_iio_device_register(dev, indio_dev);
> =C2=A0}
> @@ -638,3 +896,4 @@ module_spi_driver(ad7944_driver);
> =C2=A0MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
> =C2=A0MODULE_DESCRIPTION("Analog Devices AD7944 PulSAR ADC family driver"=
);
> =C2=A0MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
>=20


