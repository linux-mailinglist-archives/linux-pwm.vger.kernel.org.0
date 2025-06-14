Return-Path: <linux-pwm+bounces-6347-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD616AD9C10
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 12:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7D11894F4A
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E5E1C8639;
	Sat, 14 Jun 2025 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piUZ5d7V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B113A3ED;
	Sat, 14 Jun 2025 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749896433; cv=none; b=h1U5zdrkWFMEMT/UKLQdujkKMkA1ezkPz5hIj53vaEDND4UmLIOFaV9cCVL4WHzPnMlpmBVnrU4hFyxW8eFJHG9ej8jhURW7Twev2t0pbEzUZjlqTpQF5wcNA8+gGKbDoPSJ/qz3RBl5R5pp746BwUGnl9zmilcwmAsQcLkcZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749896433; c=relaxed/simple;
	bh=9kBgyACW0MlK3mcsQIVPWQWru0PIBMqYAr+R/SA2ySc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwRHUpunUXtkG641O1l3D/BXcWv7ePBUJ+0v1s/DsskS9QxoW4nZHYraEEt4eoHW2OPqrau7lR/bEZP6s74qp0kLddFmM9W4uui3LqQf06V1xO8kLYmSLazFAfyd2IO0X9kPZvthaB46ovC9h2Q6cIGv9Mo0jueNOXqRGNm4Iws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piUZ5d7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44067C4CEEB;
	Sat, 14 Jun 2025 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749896432;
	bh=9kBgyACW0MlK3mcsQIVPWQWru0PIBMqYAr+R/SA2ySc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=piUZ5d7VrqKU36eT6MYy/BzUOTg/6wEUEAjit/aXA6Vv9Nm8JDhLGPMw3HRyBfGNx
	 pL22t16btsSfNxdpyYYPMWlKaUoOngE/MKdUYzsLVr4MXdneNIpmGRCzdhZ6N8kjrm
	 qukrnDyLErczGEZRxlT3lfwJcSS8OCSrA+pFBwrmw+8mq1qsg4lRHL/4iSLV0xcQ8C
	 eG62w90IsBMz2ebFmqqe+NAr+afhtVjpNZXJHkrTiOKGRAj1RIs6tHSrxT80maTCnW
	 K0rX1KfZNaZ3Ui2daLmvqYN/EntBrYWljHt3coWSZ7G02BglUHagPS2E9exzqh5sqW
	 uHl4mvUdTyloQ==
Date: Sat, 14 Jun 2025 11:20:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 6/8] iio: adc: Add offload support for ad4052
Message-ID: <20250614112022.24bf9212@jic23-huawei>
In-Reply-To: <20250610-iio-driver-ad4052-v3-6-cf1e44c516d4@analog.com>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
	<20250610-iio-driver-ad4052-v3-6-cf1e44c516d4@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 09:34:39 +0200
Jorge Marques <jorge.marques@analog.com> wrote:

> Support SPI offload with appropriate FPGA firmware. Since the SPI-Engine
> offload module always sends 32-bit data to the DMA engine, the
> scantype.storagebytes is set to 32-bit and the SPI transfer length is
> based on the scantype.realbits. This combination allows to optimize the
> SPI to transfer only 2 or 3 bytes (depending on the granularity and
> mode), while the number of samples are computed correctly by tools on
> top of the iio scantype.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Minor comments inline.  I think they are all follow up from comments on
earlier patches that apply here as well.

> ---
>  drivers/iio/adc/ad4052.c | 244 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 242 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4052.c b/drivers/iio/adc/ad4052.c
> index 842f5972a1c58701addf5243e7b87da9c26c773f..7d32dc4701ddb0204b5505a650ce7caafc2cb5ed 100644
> --- a/drivers/iio/adc/ad4052.c
> +++ b/drivers/iio/adc/ad4052.c
> @@ -11,6 +11,8 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/interrupt.h>
> @@ -23,6 +25,8 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> +#include <linux/spi/offload/consumer.h>
> +#include <linux/spi/offload/provider.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/units.h>
> @@ -111,6 +115,7 @@ enum ad4052_interrupt_en {
>  
>  struct ad4052_chip_info {
>  	const struct iio_chan_spec channels[1];
> +	const struct iio_chan_spec offload_channels[1];

If there is only ever one of these drop the array.


>  
> +static int ad4052_update_xfer_offload(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +	struct spi_transfer *xfer = &st->offload_xfer;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> +	xfer->bits_per_word = scan_type->realbits;
> +	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +	xfer->len = scan_type->realbits == 24 ? 4 : 2;

Same question on length vs bits_per_word applies here as in the earlier
patch.

> +	xfer->speed_hz = AD4052_SPI_MAX_ADC_XFER_SPEED(st->vio_uv);
> +
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> +	st->offload_msg.offload = st->offload;
> +
> +	return 0;
> +}
> +
>  static int ad4052_set_oversampling_ratio(struct iio_dev *indio_dev,
>  					 const struct iio_chan_spec *chan,
>  					 unsigned int val)
> @@ -838,6 +873,87 @@ static int ad4052_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }

>  static int __ad4052_validate_trigger_sources(struct of_phandle_args *trigger_sources)
>  {
>  	switch (trigger_sources->args[1]) {
> +	case AD4052_TRIGGER_PIN_GP0:
> +		return trigger_sources->args[0] == AD4052_TRIGGER_EVENT_EITHER_THRESH ?
> +		       0 : -EINVAL;
>  	case AD4052_TRIGGER_PIN_GP1:
>  		return trigger_sources->args[0] == AD4052_TRIGGER_EVENT_DATA_READY ?
>  		       0 : -EINVAL;
> @@ -903,14 +1092,45 @@ static int ad4052_validate_trigger_sources(struct iio_dev *indio_dev)
>  	int ret;
>  
>  	np = st->spi->dev.of_node;
> +	for (u8 i = 0; i < 2; i++) {
> +		ret = of_parse_phandle_with_args(np, "trigger-sources",
> +						 "#trigger-source-cells", i,
> +						 &trigger_sources);
> +		if (ret)
> +			return ret;
> +
> +		ret = __ad4052_validate_trigger_sources(&trigger_sources);
> +		of_node_put(trigger_sources.np);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;

I think this is always 0. So return 0; preferred to make that explicit.

> +}
> 


