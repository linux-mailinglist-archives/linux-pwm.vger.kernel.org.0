Return-Path: <linux-pwm+bounces-3498-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F579918E5
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 19:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1231C21039
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 17:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78D215539F;
	Sat,  5 Oct 2024 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji9wNf+e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA444C77;
	Sat,  5 Oct 2024 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728149702; cv=none; b=XWvasYHBhqMzDqPprh8JrdtgL/3YQ6HwPEZmBJv5OiEV6trdWUxgQhhCW90b9+oC1Z0Hc0qhZDNL+At67a2FkkwKoXGEuoRp0LyCZFvEDtoJpwnjS6697z77Pd6ogKLJP90QFxlvuRtyyac3Wi659XHYE8s35OzJSbLJcmr9RN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728149702; c=relaxed/simple;
	bh=maX21YXY2LWW1lCItcaSJo/EQqIPWZScegzNbWBjE2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9tWOONM7Ut4z73A8sa+DBB3I5vnzQC2rm6AMnrNMiBdocW8/JHfsf+zBuWHjREif6GZ51E7mYwd98EDurt+t6jatzrGtqOrBNZ10NpG9VGb4NNsH50/1Xuevi8ARVxs7EYFkTTLNLIstr516gPot8BgAdoJ8hvKJVycXCkQjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji9wNf+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D433C4CEC2;
	Sat,  5 Oct 2024 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728149702;
	bh=maX21YXY2LWW1lCItcaSJo/EQqIPWZScegzNbWBjE2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ji9wNf+ewsb8mtdKzhzXU08nLBEcjomV9RqjI+G5AKuyXKZ6ptjmRb+wQ36ZB3Gpv
	 e0bpCBDQmsn/d6OER3lSncF0LBbgkefEU3afhKTaQjJl6a7nL4IR6WJkPtJMN5gs7R
	 3iSebLtBk24/4lRCx10PoaGQO1wNKZGg5oignzb5hj1ear4GOVxCamuH3UbEBTewjQ
	 UsULQRhzXgR5HFu1ONE6+nkdJ+gIMsOkeDn3mqMKgZ2ojs1aJcF6gab9ZkCdK0TqVd
	 p+CLQdM30ZIN+4l4TNsJJO7oIWi0PrfmAB0CgwazA0L6lDwtKioQjBPF3Bqr9bpVhh
	 0oIKLTV+BGqhA==
Date: Sat, 5 Oct 2024 18:34:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, "Mike Looijmans" <mike.looijmans@topic.nl>,
 Marius Cristea <marius.cristea@microchip.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
Message-ID: <20241005183427.61cae54f@jic23-huawei>
In-Reply-To: <20241004140922.233939-6-antoniu.miclaus@analog.com>
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
	<20241004140922.233939-6-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Oct 2024 17:07:55 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD485X DAS familiy.
As with the DT docs, it is good to have a little bit more info on the device
in this patch description. Just lets casual readers have some idea what
they are looking at!

I've left the packet_format ABI question for the next patch, but
I would like some info on the default.  The code doesn't set it currently=20
but maybe for documentation purposes it should?

=46rom the earlier discussion (ongoing) I think the oversampling control
requires particular formats. I'd like to see that in the driver
first with it overriding that format as necessary.

Then we can see whether we need the additional control

Various other minor comments inline.  With the exception of that
question of packet_format this is in a pretty good state.


Jonathan


>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - update headers and include the missing ones, order them alphabetically.
>  - use clamp()
>  - use units macros where applies
>  - convert int to unsigned variables where applies.
>  - add trailing commas where applies.
>  - return FIELD_GET directly.
>  - shrink function header to one line where it fits.
>  - update scale table values arrangement - pow-of-two per line
>  - rename j to have a proper meaning.
>  - invert if (st->offsets[chan->channel] !=3D val) and drop next lines in=
dentation.
>  - drop whitespace from * val =3D ... (altough checkpatch complains about=
 it)
>  - drop comma in the terminator lines for ext_info.
>  - fix inconsistency between chip_info structures.
>  - use devm_mutex_init
>  - return -ENOENT on max_cnt check.
>  - check both val and val2 for negative before converting to unsigned.
>  - remove val2 where not used.
>  - use dev_info() instead of dev_warn()
>  - add spaces after { and before } in ad485x_scale_table
>=20
>  drivers/iio/adc/Kconfig  |   12 +
>  drivers/iio/adc/Makefile |    1 +
>  drivers/iio/adc/ad485x.c | 1094 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1107 insertions(+)
>  create mode 100644 drivers/iio/adc/ad485x.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f60fe85a30d5..83f55229d731 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -36,6 +36,18 @@ config AD4130
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad4130.
> =20
> +config AD485X

No wild cards in drivers.  It goes wrong far too often!  Just
pick a part and name everything after that (files, functions etc).

For text, use 'and similar' to cover the range.

> +	tristate "Analog Device AD485x DAS Driver"
> +	depends on SPI
> +	select REGMAP_SPI
> +	select IIO_BACKEND
> +	help
> +	  Say yes here to build support for Analog Devices AD485x high speed
> +	  data acquisition system (DAS).

List all supported parts in here. Makes for easier grepping.

> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad485x.
> +
>  config AD7091R
>  	tristate
> =20
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d370e066544e..26c1670c8913 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
>  obj-$(CONFIG_AD4130) +=3D ad4130.o
> +obj-$(CONFIG_AD485X) +=3D ad485x.o
>  obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
>  obj-$(CONFIG_AD7091R5) +=3D ad7091r5.o
>  obj-$(CONFIG_AD7091R8) +=3D ad7091r8.o
> diff --git a/drivers/iio/adc/ad485x.c b/drivers/iio/adc/ad485x.c
> new file mode 100644
> index 000000000000..faa10d56a791
> --- /dev/null
> +++ b/drivers/iio/adc/ad485x.c
> @@ -0,0 +1,1094 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD485x DAS driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +
> +#include <asm/unaligned.h>

> +
> +#define AD4858_PROD_ID			0x60
> +#define AD4857_PROD_ID			0x61
> +#define AD4856_PROD_ID			0x62
> +#define AD4855_PROD_ID			0x63
> +#define AD4854_PROD_ID			0x64
> +#define AD4853_PROD_ID			0x65
> +#define AD4852_PROD_ID			0x66
> +#define AD4851_PROD_ID			0x67
> +#define AD4858I_PROD_ID			0x6F
These don't add anything over just using the numeric value
to fill the chip_info structure field.  That field clearly documents
what these magic numbers are anyway.

Note we used to have this code pattern of defines at the top
for PROD_ID in a load more drivers but have gotten rid of them
in favour of inline values.  May well be more to do!

> +
> +struct ad485x_chip_info {
> +	const char *name;
> +	unsigned int product_id;
> +	const unsigned int (*scale_table)[2];
> +	int num_scales;
As below.  Currently we only seem to have one option for the
scale parameters.  If that is so for now, drop these and encode
that option directly.

> +	const int *offset_table;
> +	int num_offset;
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +	unsigned long throughput;
> +	unsigned int resolution;
> +};


> +
> +static const char *const ad4858_packet_fmts[] =3D {
> +	"20-bit", "24-bit", "32-bit",
> +};
> +
> +static const char *const ad4857_packet_fmts[] =3D {
> +	"16-bit", "24-bit",
I'll leave discussing these for the docs patch.

> +};
> +
> +static int ad485x_set_packet_format(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    unsigned int format)
> +{
> +	struct ad485x_state *st =3D iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	if (chan->scan_type.realbits =3D=3D 20)

Perhaps a switch would be cleaner?

> +		switch (format) {
> +		case 0:
> +			val =3D 20;
> +			break;
> +		case 1:
> +			val =3D 24;
> +			break;
> +		case 2:
> +			val =3D 32;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	else if (chan->scan_type.realbits =3D=3D 16)
> +		switch (format) {
> +		case 0:
> +			val =3D 16;
> +			break;
> +		case 1:
> +			val =3D 24;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	else
> +		return -EINVAL;
> +
> +	ret =3D iio_backend_data_size_set(st->back, val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap, AD485X_REG_PACKET,
> +				  AD485X_PACKET_FORMAT_MASK, format);
> +}


> +static struct iio_chan_spec_ext_info ad4858_ext_info[] =3D {
> +	IIO_ENUM("packet_format", IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> +	IIO_ENUM_AVAILABLE("packet_format",
> +			   IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> +	{}
	{ }
> +};
> +
> +static struct iio_chan_spec_ext_info ad4857_ext_info[] =3D {
> +	IIO_ENUM("packet_format", IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
> +	IIO_ENUM_AVAILABLE("packet_format",
> +			   IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
> +	{}
	{ }

I'm slowly standardizing across IIO on this mostly so we have a 'right'
answer rather than a messy mix of styles.  The choice was a random
pick rather than there being anything better about having a space.

> +};

> +
> +static const struct ad485x_chip_info ad4858_info =3D {
> +	.name =3D "ad4858",
> +	.product_id =3D AD4858_PROD_ID,
> +	.scale_table =3D ad485x_scale_table,

There only seems to be one scale table.
Unless you plan to very soon add more devices, drop it from
here for now and access it directly in the code.

Reduces complexity a little + it is easy to bring back the
entries in here when you need them.

If you are planning to send out support for more parts shortly
then it is fine to keep this as it is and reduce the churn.
I'm just not keen on speculative flexibility in drivers
where it may never use used!

> +	.num_scales =3D ARRAY_SIZE(ad485x_scale_table),
> +	.offset_table =3D ad4858_offset_table,
> +	.num_offset =3D ARRAY_SIZE(ad4858_offset_table),
> +	.channels =3D ad4858_channels,
> +	.num_channels =3D ARRAY_SIZE(ad4858_channels),
> +	.throughput =3D 1 * MEGA,
> +	.resolution =3D 20,
> +};
...


> +
> +static const struct of_device_id ad485x_of_match[] =3D {
> +	{ .compatible =3D "adi,ad4858", .data =3D &ad4858_info, },
> +	{ .compatible =3D "adi,ad4857", .data =3D &ad4857_info, },
> +	{ .compatible =3D "adi,ad4856", .data =3D &ad4856_info, },
> +	{ .compatible =3D "adi,ad4855", .data =3D &ad4855_info, },
> +	{ .compatible =3D "adi,ad4854", .data =3D &ad4854_info, },
> +	{ .compatible =3D "adi,ad4853", .data =3D &ad4853_info, },
> +	{ .compatible =3D "adi,ad4852", .data =3D &ad4852_info, },
> +	{ .compatible =3D "adi,ad4851", .data =3D &ad4851_info, },
> +	{ .compatible =3D "adi,ad4858i", .data =3D &ad4858i_info, },
> +	{}
	{ }
+ reorder as below.


> +};
> +
> +static const struct spi_device_id ad485x_spi_id[] =3D {
> +	{ "ad4858", (kernel_ulong_t)&ad4858_info },
> +	{ "ad4857", (kernel_ulong_t)&ad4857_info },
> +	{ "ad4856", (kernel_ulong_t)&ad4856_info },
> +	{ "ad4855", (kernel_ulong_t)&ad4855_info },
> +	{ "ad4854", (kernel_ulong_t)&ad4854_info },
> +	{ "ad4853", (kernel_ulong_t)&ad4853_info },
> +	{ "ad4852", (kernel_ulong_t)&ad4852_info },
> +	{ "ad4851", (kernel_ulong_t)&ad4851_info },
alphanumeric order.  So pretty much the reverse.


> +	{ "ad4858i", (kernel_ulong_t)&ad4858i_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad485x_spi_id);

