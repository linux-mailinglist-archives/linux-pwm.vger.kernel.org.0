Return-Path: <linux-pwm+bounces-8761-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K7PBo5S+GmQsQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8761-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 10:02:22 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7414B9CE6
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 10:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D34EE3022F92
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2026 07:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2630F7F3;
	Mon,  4 May 2026 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qz9JWqLD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E82BE05E;
	Mon,  4 May 2026 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881475; cv=none; b=TAxzqKX7+ZOskt+FFqZ4DG7VYCNvadlHfY5Ug74901d5ZzdUxaNDLXuyiEKf8sDxwEz2ovNKu7CqlFLLmJQPJRLHRMMlMud3H3eFvyE/mHr7RbCM4BPaTu1BSFPCOn0BYgEIL/RSf2ssd2qvlj23KOh5YcSLPi43fB85AsBYxM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881475; c=relaxed/simple;
	bh=JzuXb6VN/SZn9tvqvQmq4T9k9vVm7n3WJDsTcgQJE1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAtZ8MzXi0HKWtxFqvKlKadRxIT9H3+MayQlmdqob3tJV4aLgW0EpvTOLaTzodq+CvvvqkBTykaafbuMBEnYLC1W4A1RZ8AcC/uIHFx6aqTIFJahWV6N0ShfoP/oyItHV3G0EqU134Ysqqzcjz56NRd/uQTIoP/AA6cxz5eHOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qz9JWqLD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777881472; x=1809417472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JzuXb6VN/SZn9tvqvQmq4T9k9vVm7n3WJDsTcgQJE1g=;
  b=Qz9JWqLDeEROCGbhB4TVBezdA1VYABTaqYwfDvRY8obBJYzQG/R9GNAu
   +yRabxx/lo3IagwVOXAMbaVsuKxeGJNS34vclRc3uStb3xq5hCZJG93lH
   wb9XjU1LsMi54TDjqEevuN5Rtq8P6elCLkfHW0hzculL1HxTpl8RRPKtz
   6GRB6oh1D1+R6Yxka24wVxda+X4ZVsqUIAhHZs4PcK4MlaeN5jxhr/EXF
   PonXDCq7vaSigPnd1znrewrm5N7945hj5nu3H3grqe5K4fMIJG+STq1Tj
   DM1cyFdq5ZUA9NsT0tpj9rEvA6YaaLOMu9C8X1MJBUQkgqLk/EtKnD6De
   A==;
X-CSE-ConnectionGUID: 7l+c3mX1TcGxL0G8qQE8kw==
X-CSE-MsgGUID: qjkSW3XMRuOqakdSebp80A==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="89321262"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89321262"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:57:51 -0700
X-CSE-ConnectionGUID: ABQ2jlfkSnGpKlpsAER2WA==
X-CSE-MsgGUID: wJPfSrmTRWKa7dQ8w2rfIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="258799764"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:57:46 -0700
Date: Mon, 4 May 2026 10:57:44 +0300
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
Subject: Re: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <afhReLCsEdaEOT_H@ashevche-desk.local>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
 <20260430-ad4692-multichannel-sar-adc-driver-v9-3-33e439e4fb87@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430-ad4692-multichannel-sar-adc-driver-v9-3-33e439e4fb87@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 5E7414B9CE6
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
	TAGGED_FROM(0.00)[bounces-8761-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]

On Thu, Apr 30, 2026 at 01:16:45PM +0300, Radu Sabau via B4 Relay wrote:

> Add buffered capture support using the IIO triggered buffer framework.
> 
> CNV Burst Mode: the GP pin identified by interrupt-names in the device
> tree is configured as DATA_READY output. The IRQ handler stops
> conversions and fires the IIO trigger; the trigger handler executes a
> pre-built SPI message that reads all active channels from the AVG_IN
> accumulator registers and then resets accumulator state and restarts
> conversions for the next cycle.
> 
> Manual Mode: CNV is tied to SPI CS so each transfer simultaneously
> reads the previous result and starts the next conversion (pipelined
> N+1 scheme). At preenable time a pre-built, optimised SPI message of
> N+1 transfers is constructed (N channel reads plus one NOOP to drain
> the pipeline). The trigger handler executes the message in a single
> spi_sync() call and collects the results. An external trigger (e.g.
> iio-trig-hrtimer) is required to drive the trigger at the desired
> sample rate.
> 
> Both modes share the same trigger handler and push a complete scan —
> one u16 slot per channel at its scan_index position, followed by a
> timestamp — to the IIO buffer via iio_push_to_buffers_with_ts().
> 
> The CNV Burst Mode sampling frequency (PWM period) is exposed as a
> buffer-level attribute via IIO_DEVICE_ATTR.

...

>  #include <linux/array_size.h>
>  #include <linux/bitfield.h>
> -#include <linux/bitops.h>
> +#include <linux/bitmap.h>
>  #include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/dev_printk.h>
>  #include <linux/device/devres.h>
> +#include <linux/dmaengine.h>
>  #include <linux/err.h>
> +#include <linux/interrupt.h>

+ kstrtox.h

>  #include <linux/limits.h>
>  #include <linux/math.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>

(double check that string.h is here or string_helpers.h in case the latter has
 any use)

>  #include <linux/units.h>
>  #include <linux/unaligned.h>

...

>  	struct regmap *regmap;
> +	struct spi_device *spi;
> +
> +	struct pwm_device *conv_trigger;
> +	int irq;
>  	int vref_uV;
> +	u32 cnv_period_ns;
> +
> +	bool manual_mode;
>  	bool refbuf_en;
>  	bool ldo_en;


>  	struct mutex lock;
> +	/*
> +	 * Per-buffer-enable lifetime resources:
> +	 * Manual Mode - a pre-built SPI message that clocks out N+1
> +	 *		 transfers in one go.
> +	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
> +	 *		    transfers in one go.
> +	 */
> +	struct spi_message scan_msg;
> +	/* max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst). */
> +	struct spi_transfer scan_xfers[34];
> +	/*
> +	 * CNV burst: 16 AVG_IN addresses + state-reset address + state-reset
> +	 * value = 18.  Manual: 16 channel cmds + 1 NOOP = 17.
> +	 */
> +	__be16 scan_tx[18] __aligned(IIO_DMA_MINALIGN);
> +	/*
> +	 * Scan buffer: one BE16 slot per active channel, plus timestamp.
> +	 * DMA-aligned because scan_xfers point rx_buf directly into vals[].
> +	 */
> +	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, vals, 16);

Have you run `pahole`? I'm wondering if this aligned member can be coupled with
something that gives lesser gap.

...

> +static ssize_t sampling_frequency_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	int freq, ret;
> +
> +	ret = kstrtoint(buf, 10, &freq);
> +	if (ret)
> +		return ret;
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;

> +
> +

Single blank line is enough.

> +	ret = ad4691_set_pwm_freq(st, freq);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}

...

> +static int ad4691_read_scan(struct iio_dev *indio_dev, s64 timestamp)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = spi_sync(st->spi, &st->scan_msg);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * rx_buf pointers in scan_xfers point directly into scan.vals, so no
> +	 * copy is needed. The scan_msg already includes a STATE_RESET at the
> +	 * end (appended in preenable), so no explicit reset is needed here.
> +	 */
> +	iio_push_to_buffers_with_ts(indio_dev, st->vals, sizeof(st->vals),
> +				    timestamp);

I would leave it on a single line (note, you can also shorten the timestamp to
ts).

> +	return 0;
> +}

...

> +static int ad4691_pwm_setup(struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +
> +	st->conv_trigger = devm_pwm_get(dev, "cnv");
> +	if (IS_ERR(st->conv_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->conv_trigger),
> +				     "Failed to get cnv pwm\n");

PWM

> +	return ad4691_set_pwm_freq(st, st->info->max_rate);
> +}

...

> +	/*
> +	 * The GP pin named in interrupt-names asserts at end-of-conversion.
> +	 * The IRQ handler stops conversions and fires the IIO trigger so
> +	 * the trigger handler can read and push the sample to the buffer.
> +	 * The IRQ is kept disabled until the buffer is enabled.
> +	 */
> +	irq = -ENXIO;
> +	for (i = 0; i < ARRAY_SIZE(ad4691_gp_names); i++) {
> +		irq = fwnode_irq_get_byname(dev_fwnode(dev),
> +					    ad4691_gp_names[i]);
> +		if (irq > 0)
> +			break;

This is problematic in case the above returns EPROBE_DEFER. Can you confirm it
may not ever happen? (Note, I don't know the answer.)

> +	}
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "failed to get GP interrupt\n");

-- 
With Best Regards,
Andy Shevchenko



