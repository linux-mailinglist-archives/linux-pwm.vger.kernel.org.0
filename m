Return-Path: <linux-pwm+bounces-8762-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ+wG6dV+GmWtAIAu9opvQ
	(envelope-from <linux-pwm+bounces-8762-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 10:15:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 001B04BA072
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 10:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07FFF307249E
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2026 08:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C2D319847;
	Mon,  4 May 2026 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVbea1nh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798D2318EC7;
	Mon,  4 May 2026 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882216; cv=none; b=pdt5XofwlOOYPM9ZTc+HifgOdT56VRa3bvrvpm82UPWFiVuaf6YQqIMVDbXX+TIzFqVlQF/BiRKFNSbv7AOfIw162A+xqzXDiry6+Rvu487Ir2BB9WWE9iBcN4KhwfOnlYSPomuK0VkGcmSXjYDwK/kGS/Vk9Eo4b5XlttO21+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882216; c=relaxed/simple;
	bh=Aw2goGd/fJilo1nNYybeEo/I7OqMgACuWTjhFwMods4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oE17pItpnTYVDWVMpp7EhHXS7SSgwhGn0J7Ewjbs74/lyEflyol8UGCq+4BX3T6wTPaJVuHkv9jwQDV60QwX4KieGAA/8RFuOM8lhnQ+SbBvubj3v1VFUi/5Q0zILSMdtsLcyU++ig1qUPUX8CeO/nfnt+jKFRbXP8lDrTZp/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVbea1nh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777882214; x=1809418214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Aw2goGd/fJilo1nNYybeEo/I7OqMgACuWTjhFwMods4=;
  b=HVbea1nhIwye6rLGUk7aI/W/gORp6BcotpbuqM6ZIo7WRSAEtJcjXZbY
   KlqKKreXrVuNmdEBIfdVL9WiOjZvBLvkeja7evBdll8pAPTIhQZNr/HXV
   CKgus8K/C1UEiJPuosQnHiNnHS7aCBrFTL+oY2OsVKqBtDb0fxKJu4DCq
   6b7sEzH2Zvf7rJroi9qytG1MyDalRh70LleOjOsXih/mqqeQV2iZj16QB
   GnUzMt9UT+dx0icNkkG7SKwn2Hu/J5eJVqqF4b6f1yjHM+NeC1y8itrJa
   o/9cmkyS+wTdvz2VASmBAD8mkhBzatryA76fzTdKOZg/VdfhSeWlVyPev
   Q==;
X-CSE-ConnectionGUID: lLNcDu3cS6ebty0Nr8mHmA==
X-CSE-MsgGUID: kRERN/alTxuSOSfQuYCQ6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78442661"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78442661"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:10:13 -0700
X-CSE-ConnectionGUID: hreLLtATR/mogtrNmMDSBg==
X-CSE-MsgGUID: Yh+aZY+rRpW8DxwXWoF2jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="235708240"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:10:08 -0700
Date: Mon, 4 May 2026 11:10:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 4/6] iio: adc: ad4691: add SPI offload support
Message-ID: <afhUXf_wGVLA0P0B@ashevche-desk.local>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
 <20260430-ad4692-multichannel-sar-adc-driver-v9-4-33e439e4fb87@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430-ad4692-multichannel-sar-adc-driver-v9-4-33e439e4fb87@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 001B04BA072
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8762-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,ashevche-desk.local:mid]

On Thu, Apr 30, 2026 at 01:16:46PM +0300, Radu Sabau via B4 Relay wrote:

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
> the pipelined CNV-on-CS protocol: N+1 16-bit transfers are issued
> for N active channels (the first result is discarded as garbage from
> the pipeline flush) and the remaining N results are captured by DMA.
> 
> All offload transfers use 16-bit frames (bits_per_word=16, len=2).
> The channel scan_type (storagebits=16, shift=0, IIO_BE) is shared
> between the software triggered-buffer and offload paths; no separate
> scan_type or channel array is needed for the offload case. The
> ad4691_manual_channels[] array introduced in the triggered-buffer
> commit is reused here: it hides the IIO_CHAN_INFO_OVERSAMPLING_RATIO
> attribute, which is not applicable in Manual Mode.

> Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.

Unneeded detail in the commit message. It's visible from the patch.
You probably wanted to explain "why?" it's required.

...

>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/spi/spi.h>
> +#include <linux/spi/offload/consumer.h>
> +#include <linux/spi/offload/provider.h>

You missed at some point types.h (in this patch or earlier).

>  #include <linux/units.h>
>  #include <linux/unaligned.h>

...

> -	/* max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst). */
> +	/*
> +	 * Non-offload: max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst).
> +	 * Offload reuses this array — both paths are mutually exclusive.
> +	 */

Can you make sure this will be in the end result from the beginning, id est
in the previous change put it as

	/*
	 * Non-offload: max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst).
	 * Offload is not supported.
	 */

OR

	/*
	 * Non-offload: max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst).
	 */

OR

	/*
	 * max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst).
	 */

This will minimize the churn.

>  	struct spi_transfer scan_xfers[34];

...

> +static bool ad4691_offload_trigger_match(struct spi_offload_trigger *trigger,
> +					 enum spi_offload_trigger_type type,
> +					 u64 *args, u32 nargs)
> +{
> +	return type == SPI_OFFLOAD_TRIGGER_DATA_READY &&
> +	       nargs == 1 && args[0] <= 3;

Seems there is a room in the previous line for more.

> +}

...

> -	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> -			   ~bitmap_read(indio_dev->active_scan_mask, 0,
> -				iio_get_masklength(indio_dev)) & GENMASK(15, 0));
> +	acc_mask = ~bitmap_read(indio_dev->active_scan_mask, 0,
> +				iio_get_masklength(indio_dev)) & GENMASK(15, 0);
> +	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG, acc_mask);

Make it like this in the previous patch.

>  	if (ret)
>  		goto err_unoptimize;

...

> +	offload = devm_kzalloc(dev, sizeof(*offload), GFP_KERNEL);

Do you have device/devres.h already included (either explicitly or via device.h
or platform_device.h)?

> +	if (!offload)
> +		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko



