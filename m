Return-Path: <linux-pwm+bounces-8313-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMobEZBnvWnL9gIAu9opvQ
	(envelope-from <linux-pwm+bounces-8313-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 16:28:16 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 491442DCA8C
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 16:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5EB230D1293
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E86F3C7E03;
	Fri, 20 Mar 2026 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCNCaFvl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC686301704;
	Fri, 20 Mar 2026 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019793; cv=none; b=FwIiAo/qEHEI/SJAvZE2Fwfi+uCtpyTwYE4K+mN3xguOcZTt07TG76jIusVpBjlGBN0gu6smyAKL9Y0uwupDdKQjU2x5CWIpSxP4Hjz3vLFtHQrfZRsAkDXSzEaih2p/u/v+Z4p/dIE8gLZ1x7ug/PvJPkLysJw9nosVieV+ZZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019793; c=relaxed/simple;
	bh=GkNDdaVsOUqNwYWo7W4428KaeYtWZrqhStkpVFxO/AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGEloPiMjbsub9HFyDIHY4OLpb9Eyo5P1jayhPd9VKYDGxgB/CSET+8KhXCDUPIK03vLb5oxKt6g6FqRZQLx6f3kfNQV/e8I82z1YZDLKA8BGP8x3VVd+Rn5FwcFJIuv9G3hJEHCVjbixE6k2PS9SUKAnNgp3i9gzMgnzhQubKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCNCaFvl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774019792; x=1805555792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GkNDdaVsOUqNwYWo7W4428KaeYtWZrqhStkpVFxO/AU=;
  b=TCNCaFvlRG5La3Dzhh8PPJ5x+ImD2ZAB52D1wUq0gRIRlN4xeupsTzWs
   0Gk9BroU+/7xAw1MJZZBiIdNB1kNvmmSxNdsLXcSW3DG1bCuo8ZaqwNbF
   HZNJSjLHaG6jabimuwuker2mB5fM6w8pqevnNrUndvXk0686yxLraS4nr
   oB/FICRb3LMXjABkIllhglP9To5NsLyl431st26CbA/3+dByjFhZx57CJ
   2dHUtl/P8QwHTt8DEi6fMoP+aalfwDG5NKQmeeqQZ4t9bxiXPwm7oJo9k
   l4UMOBt9QH+4I8wCwr6+x+PyVCWAYam5mijA+/Z9Rk3iUFTJumG2cvo0w
   A==;
X-CSE-ConnectionGUID: DhxsN5BJTfKwZg80GygFdg==
X-CSE-MsgGUID: hjLw8A6qRROV8bR7PQzrSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="97725588"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="97725588"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:16:31 -0700
X-CSE-ConnectionGUID: LJIG37obSneLj5G8pQfLWg==
X-CSE-MsgGUID: VxaY5xfiQSyjNDsBM6s/ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223300291"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:16:27 -0700
Date: Fri, 20 Mar 2026 17:16:24 +0200
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
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <ab1kyFPyrkxJLw2Z@ashevche-desk.local>
References: <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
 <20260320-ad4692-multichannel-sar-adc-driver-v4-2-052c1050507a@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-2-052c1050507a@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8313-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	NEURAL_HAM(-0.00)[-0.977];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ashevche-desk.local:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 491442DCA8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 01:03:56PM +0200, Radu Sabau via B4 Relay wrote:

> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
> 
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
> 
> The chip idles in Autonomous Mode so that single-shot read_raw can use
> the internal oscillator without disturbing the hardware configuration.
> 
> Three voltage supply domains are managed: avdd (required), vio, and a
> reference supply on either the REF pin (ref-supply, external buffer)
> or the REFIN pin (refin-supply, uses the on-chip reference buffer;
> REFBUF_EN is set accordingly). Hardware reset is performed via
> the reset controller framework; a software reset through SPI_CONFIG_A
> is used as fallback when no hardware reset is available.
> 
> Accumulator channel masking for single-shot reads uses ACC_MASK_REG via
> an ADDR_DESCENDING SPI write, which covers both mask bytes in a single
> 16-bit transfer.

...

> +static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct spi_device *spi = context;
> +	u8 tx[2], rx[4];
> +	int ret;

> +	put_unaligned_be16(0x8000 | reg, tx);

I would expect that the config will have read_flag_mask set and here you just
use it. But it's fine like now, just add a comment

	/* Set bit 15 to mark the operation READ */

or something similar.

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

...

> +static int ad4691_regulator_setup(struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	int ret;
> +
> +	ret = devm_regulator_get_enable(dev, "avdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable AVDD\n");

> +	ret = devm_regulator_get_enable(dev, "ldo-in");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get and enable LDO-IN\n");
> +	st->ldo_en = (ret == -ENODEV);

You can use the approach from below

	ret = devm_regulator_get_enable(dev, "ldo-in");
	if (ret == -ENODEV)
		st->ldo_en = true;
	else if (ret)
		return dev_err_probe(dev, ret, "Failed to get and enable LDO-IN\n");
	// no other branches assuming ldo_en = false due to kzalloc():ed memory.


> +	ret = devm_regulator_get_enable(dev, "vio");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable VIO\n");
> +
> +	st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "ref");

> +	if (st->vref_uV >= 0) {
> +		st->refbuf_en = false;

Do you need this? Isn't 'st' allocated with kzalloc() or alike?

> +	} else if (st->vref_uV == -ENODEV) {
> +		st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "refin");
> +		st->refbuf_en = true;

> +	}
> +	if (st->vref_uV < 0)
> +		return dev_err_probe(dev, st->vref_uV,
> +				     "Failed to get reference supply\n");

> +	if (st->vref_uV < AD4691_VREF_uV_MIN || st->vref_uV > AD4691_VREF_uV_MAX)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "vref(%d) must be in the range [%u...%u]\n",
> +				     st->vref_uV, AD4691_VREF_uV_MIN,
> +				     AD4691_VREF_uV_MAX);
> +
> +	return 0;
> +}

...

> +	if (!rst)

It's not an error check, so I would invert the condition.

> +		/* No hardware reset available, fall back to software reset. */
> +		return regmap_write(st->regmap, AD4691_SPI_CONFIG_A_REG,
> +				    AD4691_SW_RESET);
> +
> +	reset_control_assert(rst);
> +	/* Reset delay required. See datasheet Table 5. */
> +	fsleep(300);
> +	reset_control_deassert(rst);

	if (rst) {
		reset_control_assert(rst);
		/* Reset delay required. See datasheet Table 5. */
		fsleep(300);
		reset_control_deassert(rst);

		return 0;
	}

	/* No hardware reset available, fall back to software reset. */
	return regmap_write(st->regmap, AD4691_SPI_CONFIG_A_REG, AD4691_SW_RESET);


...

> +	ret = regmap_write(st->regmap, AD4691_REF_CTRL,
> +			   FIELD_PREP(AD4691_REF_CTRL_MASK, ref_val) |
> +			   (st->refbuf_en ? AD4691_REFBUF_EN : 0));

regmap_update_bits()?
regmap_assign_bits()?

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write REF_CTRL\n");
> +
> +	ret = regmap_write(st->regmap, AD4691_DEVICE_SETUP,
> +			   st->ldo_en ? AD4691_LDO_EN : 0);

Ditto.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write DEVICE_SETUP\n");
> +
> +	/*
> +	 * Set the internal oscillator to the highest valid rate for this chip.
> +	 * Index 0 (1 MHz) is valid only for AD4692/AD4694; AD4691/AD4693 start
> +	 * at index 1 (500 kHz).
> +	 */
> +	ret = regmap_write(st->regmap, AD4691_OSC_FREQ_REG,
> +			   (st->info->max_rate == HZ_PER_MHZ) ? 0 : 1);

Ditto.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write OSC_FREQ\n");

-- 
With Best Regards,
Andy Shevchenko



