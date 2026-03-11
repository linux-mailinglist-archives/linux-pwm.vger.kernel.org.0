Return-Path: <linux-pwm+bounces-8237-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFG7KRPasWlPFwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8237-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 22:09:39 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 552E426A475
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 22:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4E8C307096A
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 21:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D4133D6EE;
	Wed, 11 Mar 2026 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuednAHl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185762C0261;
	Wed, 11 Mar 2026 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263293; cv=none; b=edqw8a4DYDhr8G4MrG/AyhTpVTd5NzzzidAvdQL2E+eb67qaQqwb77oIE2SX7JJXG6lSnc7RJ/pLJpEmWYodYgElicewQz1nZ7TNoExZ+REYt8VN7okGZZsx0xEKUOoE5/z5Lx4oPXd9sftQRBwWtBnqEi0RoK1UNXc9y5tM2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263293; c=relaxed/simple;
	bh=kRjOgkOnr7fYH+eWHo8E9TkCd+WB2e21NPMSBrm1rhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwv/pOrC1sIL1ZhFq3lPVjpQ5MgOc4RDeA3oetIZNvYHI4aN3mejxNN3RwuZ0YiKfJpRMA1gljnvA69hY64GTEKz9ZyLZRh3aA+3/jLZgZj7xyeEdCNSAIeIkbXa5FDFO1N4HZiM4uXKB96S+XvSldZB6oakgIso2WK1mpYSHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EuednAHl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773263292; x=1804799292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kRjOgkOnr7fYH+eWHo8E9TkCd+WB2e21NPMSBrm1rhM=;
  b=EuednAHlb8UnoZnqR6tGU7YvPy0KPGEaDPoCQ1OFZW3jbffEttw7Rmq3
   lcHThTX0w++tKTF9cElsWTn/3gyZrZsEJ2QVEF9yeuXmngVMbiVqMwtOB
   ChWotFwCgCp5uBBawE1pN8djM1Ie82+ZwWvdvWCkkv3y6MWiJDPt36RJs
   VWFEJ6u/DTB98TVP+4K/C6A95lqqfv+GJ9shE904ECznaROIge6OhzEg8
   TpGPp+sMxQWR2taJ59z+CnFGaM6wvLJwgRjqLFzaUvzJgotyImx/eLZGd
   UZaDtrCwNFOkUBqAYNeh6o1+0PYDQ4xOZsSFi5k1hdfMvNv7elO4JDaZH
   g==;
X-CSE-ConnectionGUID: RW9ggTkoTNWKe0ksszO+RQ==
X-CSE-MsgGUID: p5OP0QK5Q0WyzO+6419+dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85824482"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85824482"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 14:08:12 -0700
X-CSE-ConnectionGUID: cXwe4WTaQpaMy+Rt5wftzg==
X-CSE-MsgGUID: TWoslZNDRqS7eF+1QCkbTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225573534"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 14:08:07 -0700
Date: Wed, 11 Mar 2026 23:08:04 +0200
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: adc: ad4691: add triggered buffer support
Message-ID: <abHZtEYuzou9fBgn@ashevche-desk.local>
References: <20260310-ad4692-multichannel-sar-adc-driver-v2-0-d9bb8aeb5e17@analog.com>
 <20260310-ad4692-multichannel-sar-adc-driver-v2-3-d9bb8aeb5e17@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310-ad4692-multichannel-sar-adc-driver-v2-3-d9bb8aeb5e17@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8237-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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
X-Rspamd-Queue-Id: 552E426A475
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 04:32:24PM +0200, Radu Sabau via B4 Relay wrote:

> Add buffered capture support using the IIO triggered buffer framework.
> 
> Both operating modes share a single IIO trigger and trigger handler.
> The handler builds a complete scan — one u32 slot per channel at its
> scan_index position, followed by a timestamp — and pushes it to the
> IIO buffer in a single iio_push_to_buffers_with_ts() call.
> 
> For CNV Clock Mode the GP0 pin is configured as DATA_READY output. The
> IRQ handler stops conversions and fires the IIO trigger; the trigger
> handler reads accumulated results from the AVG_IN registers via regmap
> and restarts conversions for the next cycle.
> 
> For Manual Mode there is no DATA_READY signal; CNV is tied to SPI CS
> so conversions are triggered by CS assertion rather than by a dedicated
> pin. The standard iio-trig-hrtimer module is not used because the timer
> period must be derived from the SPI clock rate and the number of active
> channels: the pipelined protocol requires N+1 SPI transfers per scan
> (the first result is garbage and is discarded), so the minimum period
> depends on both the SPI speed and the live channel count at buffer
> enable time. A driver-private hrtimer whose period is recomputed by
> buffer_postenable is simpler and avoids requiring the user to configure
> an external trigger with the correct hardware-derived period.
> 
> Manual mode channels use storagebits=32 (shift=8, realbits=16) so all
> channel slots in the scan buffer are uniformly sized regardless of the
> SPI wire format (24-bit transfer, 16-bit ADC data in bits[23:8]).

Many comments from previous patch are applicable here.

...

> +static irqreturn_t ad4691_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int val;

> +	int ret, i;

Why is 'i' signed?

> +	mutex_lock(&st->lock);

No guard()()?

> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		unsigned int prev_val;
> +		int prev_chan = -1;
> +
> +		/*
> +		 * MANUAL_MODE with CNV tied to CS: each transfer triggers a
> +		 * conversion AND returns the previous conversion's result.
> +		 * First transfer returns garbage, so we do N+1 transfers for
> +		 * N channels. Collect all results into scan.vals[], then push
> +		 * the complete scan once.
> +		 */
> +		iio_for_each_active_channel(indio_dev, i) {
> +			ret = ad4691_transfer(st, AD4691_ADC_CHAN(i), &val);
> +			if (ret)
> +				goto done;
> +
> +			if (prev_chan >= 0)
> +				st->scan.vals[prev_chan] = prev_val;
> +			prev_val = val;
> +			prev_chan = i;
> +		}
> +
> +		/* Final NOOP transfer to retrieve last channel's result */
> +		ret = ad4691_transfer(st, AD4691_NOOP, &val);
> +		if (ret)
> +			goto done;
> +
> +		st->scan.vals[prev_chan] = val;
> +	} else {
> +		for (i = 0; i < st->chip->num_channels; i++) {
> +			if (BIT(i) & *indio_dev->active_scan_mask) {

NIH for_each_set_bit().

> +				ret = regmap_read(st->regmap, AD4691_AVG_IN(i), &val);
> +				if (ret)
> +					goto done;
> +
> +				st->scan.vals[i] = val;
> +			}
> +		}
> +
> +		regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_RESET_ALL);
> +
> +		/* Restart conversions for the next trigger cycle. */
> +		ad4691_sampling_enable(st, true);
> +	}
> +
> +	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
> +				    pf->timestamp);
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	mutex_unlock(&st->lock);
> +	return IRQ_HANDLED;
> +}

...

> +	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +					  indio_dev->name,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)

> +		return dev_err_probe(dev, -ENOMEM,
> +				     "Failed to allocate IIO trigger\n");

No. Ask your senior colleagues why.

...

> +		irq = fwnode_irq_get(dev_fwnode(dev), 0);
> +		if (irq <= 0)

' = 0' ?!

> +			return dev_err_probe(dev, irq ? irq : -ENOENT,
> +					     "failed to get DATA_READY interrupt\n");

This ugly ternary will gone.

...

> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						&ad4691_irq,
> +						IRQF_ONESHOT,
> +						indio_dev->name, indio_dev);
> +		if (ret)

> +			return dev_err_probe(dev, ret,
> +					     "request irq %d failed\n", irq);

Also no. Similar reason as above.

-- 
With Best Regards,
Andy Shevchenko



