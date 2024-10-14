Return-Path: <linux-pwm+bounces-3637-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBD399CB65
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 15:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6561F2313B
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 13:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC691AC44C;
	Mon, 14 Oct 2024 13:14:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5561ABECB;
	Mon, 14 Oct 2024 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911679; cv=none; b=UEGPqw1QYvVKYb2EEvQc3bfZH85MEwF1yd52x3S68Tj0O/GupKJRw7bA4HBT4bLbOM9ohpCW63J+irK4I3cR6CXPiiQOROB72pT/1diR9ok1EpOzY3O9z3uzynMvUun8G1Qn/wxKFQ3mblrgEbj4UTwtR7BUJ2VxIY9YA2ssof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911679; c=relaxed/simple;
	bh=xXwO4yEcDBCtdafekjGBgr3jCuXdIIzWlt3mftDTRWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fl7EZf72Q9mxuo1wnr9ai7xyc0Gmw3ziatfWbH/9OiH0VhyAVNASALeYXHravExx+z4TpzXoTEHS+lXZrR3WpYZT4Wmf1f1Im09+bMs143o5Q+YuoLWHgl44yiWbxmjXk8qRyk5Cv78y1G3l3vGHTJ061Ff89mB/picN6HfuQEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: YqpTYbecSTq0wBZcMKLiKw==
X-CSE-MsgGUID: iP8gxxCHR3erMdMjUdPUFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28056318"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28056318"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 06:14:36 -0700
X-CSE-ConnectionGUID: rsQQmIELTc2V7MzR6xPP4g==
X-CSE-MsgGUID: tW5MjrUZQgqZIzRKycMaMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="77222177"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 06:14:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t0Ku3-00000002uP8-3VE2;
	Mon, 14 Oct 2024 16:14:27 +0300
Date: Mon, 14 Oct 2024 16:14:27 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: adc: ad4851: add ad485x driver
Message-ID: <Zw0ZM0vQXJep3dFJ@smile.fi.intel.com>
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
 <20241014094154.9439-6-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014094154.9439-6-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 14, 2024 at 12:40:40PM +0300, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.

...

> +config AD4851
> +	tristate "Analog Device AD4851 DAS Driver"
> +	depends on SPI
> +	select REGMAP_SPI
> +	select IIO_BACKEND
> +	help
> +	  Say yes here to build support for Analog Devices AD4851, AD4852,
> +	  AD4853, AD4854, AD4855, AD4856, AD4857, AD4858, AD4858I high speed
> +	  data acquisition system (DAS).

I think I already commented on this... Anyway, it's much better to support when
this list is broke down on per device per line. In such a case it's less churn
if we need to remove or add an entry in the future.

> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad4851.

Also, with all these devices to be supported why not ad485x as the name of
the driver? Is it a preference by the IIO subsystem?

...

> +#include <asm/unaligned.h>

linux/unaligned nowadays (I learnt it quite recently).
(It requires v6.12-rc2).

...

> +struct ad4851_chip_info {

Have you run `pahole`? It seems you may reduce the memory footprint of this
structure.

> +	const char *name;
> +	unsigned int product_id;
> +	const unsigned int (*scale_table)[2];
> +	int num_scales;
> +	const int *offset_table;
> +	int num_offset;
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +	unsigned long throughput;
> +	unsigned int resolution;
> +};

...

> +static const int ad4851_oversampling_ratios[] = {
> +	1,
> +	2,
> +	4,
> +	8,
> +	16,
> +	32,
> +	64,
> +	128,
> +	256,
> +	512,
> +	1024,
> +	2048,
> +	4096,
> +	8192,
> +	16384,
> +	32768,
> +	65536,

I believe you can compact them to be 4 or 8 per line

	1, 2, 4, 8, 16, 32, 64, 128,			/* 0-7 */
	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,	/* 8-15 */
	65536,						/* 16 */

> +};

...

> +static int ad4851_osr_to_regval(int ratio)
> +{
> +	int i;
> +
> +	for (i = 1; i < ARRAY_SIZE(ad4851_oversampling_ratios); i++)
> +		if (ratio == ad4851_oversampling_ratios[i])
> +			return i - 1;
> +
> +	return -EINVAL;
> +}
> +
> +static int ad4851_set_oversampling_ratio(struct ad4851_state *st,
> +					 const struct iio_chan_spec *chan,
> +					 unsigned int osr)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (osr == 1) {
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					 AD4851_OS_EN_MSK, 0);
> +		if (ret)
> +			return ret;
> +	} else {

0 is listed here. Is it a problem?

> +		ret = regmap_update_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					 AD4851_OS_EN_MSK, AD4851_OS_EN_MSK);
> +		if (ret)
> +			return ret;
> +
> +		val = ad4851_osr_to_regval(osr);
> +		if (val < 0)
> +			return -EINVAL;
> +
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					 AD4851_OS_RATIO_MSK, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	switch (chan->scan_type.realbits) {
> +	case 20:
> +		switch (osr) {
> +		case 1:
> +			val = 20;
> +			break;
> +		default:

Ditto.

> +			val = 24;
> +			break;
> +		}
> +		break;
> +	case 16:
> +		val = 16;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = iio_backend_data_size_set(st->back, val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap, AD4851_REG_PACKET,
> +				  AD4851_PACKET_FORMAT_MASK, (osr == 1) ? 0 : 1);

I would do it with a conditional

	if (osr ...)
		return regmap_update_bits(st->regmap, AD4851_REG_PACKET,
					  AD4851_PACKET_FORMAT_MASK, 0);

	return regmap_update_bits(st->regmap, AD4851_REG_PACKET,
				  AD4851_PACKET_FORMAT_MASK, 1);

But looking at the above I would split this to three functions, that outer will
look like

int ...(...)
{
	if (osr ...)
		return _osr_X(...);
	return _osr_Y(...);
}

> +}

...

> +static int ad4851_find_opt(bool *field, u32 size, u32 *ret_start)
> +{
> +	unsigned int i, cnt = 0, max_cnt = 0, max_start = 0;
> +	int start;
> +
> +	for (i = 0, start = -1; i < size; i++) {
> +		if (field[i] == 0) {
> +			if (start == -1)
> +				start = i;
> +			cnt++;
> +		} else {
> +			if (cnt > max_cnt) {
> +				max_cnt = cnt;
> +				max_start = start;
> +			}
> +			start = -1;
> +			cnt = 0;
> +		}
> +	}

This magic has to be commented... I have a déjà vu that I have commented on all
this, but it hasn't been addressed!

> +	if (cnt > max_cnt) {
> +		max_cnt = cnt;
> +		max_start = start;
> +	}
> +
> +	if (!max_cnt)
> +		return -ENOENT;
> +
> +	*ret_start = max_start;
> +
> +	return max_cnt;
> +}

Also the cover letter is missing.

I would recommend you to use my "smart" script [1] for sending series, it has
some good heuristics on whom to include into the email thread and handles
missed cover letters for the series.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko



