Return-Path: <linux-pwm+bounces-3730-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0DF9A4E64
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Oct 2024 15:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C81B223C5
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Oct 2024 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21A02770E;
	Sat, 19 Oct 2024 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa8Kj6J0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74258C153;
	Sat, 19 Oct 2024 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729345761; cv=none; b=adBGSbRUFmQEbYF770amH1XpdZqUiUAS5mc8fYIkLmQCLXvxwNRuMaCoAg7ndR6AOE2zhHoA2Eq058XGskjeXD8pbGfBLYJf2CA+HcHlufCbSmYTCfIguNrB63TVofjTTrJp49sB+BKIaFRrfxpxT4IxT0YomVSOfHCW/0vBluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729345761; c=relaxed/simple;
	bh=JqD4UEmY84yK9GwSLt3rLagkP2TW8IsPUxluCAO3+/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPPebgJwGTLLSPdixy8MjqYIjqPuU0jE+PLthPnyHJZNWBPM6fw6nym7MQr4i5ixV5NdL0akgRGYl49DhPpGdXdsotdgQCbV2mMkz3F8HAa/hTPHS2qq/KjhlB9e4MrQeoHKGdFYJXWL7OSr51DAetcNdyQDrmKzgjFsEfDjGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa8Kj6J0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471B0C4CEC5;
	Sat, 19 Oct 2024 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729345761;
	bh=JqD4UEmY84yK9GwSLt3rLagkP2TW8IsPUxluCAO3+/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fa8Kj6J0IF9TgU3/oG4WefEo5nQJ+2aX76iZeKlRPNpdxfk0V4xMCtyPu/diJaXa4
	 ZXx/e1Olu7XfLw/Van1eLNTLI+ZMrhw2V6+R3gLYRYGvG06ExjiU9kqWXJYZRMiVmP
	 CNw51LDV3C6xPKLtl+RAJx1m1jWqjOhC/WMFXiBxgEfTE4z6IFMgsqxfn7S9/ILFfb
	 xI2n0Dx8tZ6AKtDsLW8ChRSyPVGGguicKMBLwXabUlZO0bT5TAZBD7D21Bz2X3QB+u
	 SMa2kCF4y9eedYHrEUnMGuISd55dpfcPPtifZIx63AZLu9X4gJxfEPP32a3q2aT1Fn
	 aaPpmpQ8zEL3w==
Date: Sat, 19 Oct 2024 14:49:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <nuno.sa@analog.com>,
 <conor+dt@kernel.org>, <ukleinek@kernel.org>, <dragos.bogdan@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] iio: adc: ad4851: add ad485x driver
Message-ID: <20241019144912.697d9d29@jic23-huawei>
In-Reply-To: <20241018104210.51659-6-antoniu.miclaus@analog.com>
References: <20241018104210.51659-1-antoniu.miclaus@analog.com>
	<20241018104210.51659-6-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 13:42:10 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

A few minor things from me that I could fix whilst applying,
but David gave a much more detailed review of v3, so I'll wait
for his feedback on this.  I haven't dug into datasheets much and
may well have missed other things.

>  obj-$(CONFIG_AD7091R8) += ad7091r8.o
> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> new file mode 100644
> index 000000000000..65aa434b535f
> --- /dev/null
> +++ b/drivers/iio/adc/ad4851.c
> @@ -0,0 +1,1155 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD4851 DAS driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
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
This moved. I can fix up whilst applying but it is now at linux/unaligned.h
as of rc2.



> +static int ad4851_get_calibscale(struct ad4851_state *st, int ch, int *val, int *val2)
> +{
> +	unsigned int reg_val;
> +	int gain;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_GAIN_MSB(ch),
> +			  &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	gain = (reg_val & 0xFF) << 8;

The register size is 8 bits, so I'm not sure what that masking is adding.
	gain = reg_val << 8; should be fine.  Maybe the compiler or some
static analysis is wrong?

> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_GAIN_LSB(ch),
> +			  &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	gain |= reg_val & 0xFF;

same here.

> +
> +	*val = gain;
> +	*val2 = 32768;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +

