Return-Path: <linux-pwm+bounces-8480-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGiQKhck0mkTTwcAu9opvQ
	(envelope-from <linux-pwm+bounces-8480-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Apr 2026 10:57:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC9E39DE94
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Apr 2026 10:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A46813009B08
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Apr 2026 08:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3E236F428;
	Sun,  5 Apr 2026 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="booqZUxe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B492813DDAA;
	Sun,  5 Apr 2026 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775379473; cv=none; b=lL6JWwil4KhYB8L148tQ1eFyumDAZnbSmsjduO9WQl7fXfkTHwd1XzbV64t/uAZvgxPE72T/TyDzd78OOpnGRVraW+4svb/i5me5COrnN2flSDZN9fVSyXSigGTZibSkBOkhY/qm4ksGaOS3Aly4jSUq3vD/q/9qWL8m9TAz7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775379473; c=relaxed/simple;
	bh=XvSZnnRQNFjQPKZmdyglaM8/uF3se4KKpvHFWt5+pfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNLxNwsJVGR/R54DNQfUkuNB5YY795LJzhhD6A+eflHdjPEMmotwUBquQnz8pYwKX3UTFqKmFCzrJ9IYB3AkvCXUVwWkBez8yulAxjz79aL+S9vepSkMDPBpMUuM432KrAW/nzEaIUF9xwv7yuUJSi/RwNviIlI8mszPOirPFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=booqZUxe; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775379470; x=1806915470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XvSZnnRQNFjQPKZmdyglaM8/uF3se4KKpvHFWt5+pfs=;
  b=booqZUxe7mqPQnVe99FHeaIGUD7f8V/6q9QZDy95HwbiY+otVq+clImF
   /NpvSGmbIc6Ll/JlS0mCCIOMqhKY0gdnnGZmvo+bnzmHmKivvuLPZidI2
   tVyyI3Ct+N6ZTHCdb4bYDYid3tXWCPp+AwO2izgwjVui0v0Br6TOKi0L6
   G4PK89o6BEiy43btDvgRbJdjhxIcrG3tVpBToObPGF4O5+YChoyZwl0YD
   lUinxhgxtIntqVqW7HP7Q9vardoAj/TFgTtwo9YXw2QYZ/fY4SWJopASO
   IAyGo3lwfH17m4fw8T6kKqJMLZyl3D4R++/dd5FOpZZw1ekUeLbMCCMHu
   A==;
X-CSE-ConnectionGUID: ZGn0pq/GSsKfDpN+jCRAjg==
X-CSE-MsgGUID: +tN/fUckQFSadln9kALN/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11749"; a="98992875"
X-IronPort-AV: E=Sophos;i="6.23,161,1770624000"; 
   d="scan'208";a="98992875"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2026 01:57:49 -0700
X-CSE-ConnectionGUID: LyOW3uRQTTmltuGGRf0HWw==
X-CSE-MsgGUID: FfaNSo2ZRaKE1oFNif9B8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,161,1770624000"; 
   d="scan'208";a="232026285"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2026 01:57:44 -0700
Date: Sun, 5 Apr 2026 11:57:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
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
Subject: Re: [PATCH v6 3/4] iio: adc: ad4691: add triggered buffer support
Message-ID: <adIkBcEoOJdvxa3Y@ashevche-desk.local>
References: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-3-fa2a01a57c4e@analog.com>
 <e38e5b97-e90f-4613-a15e-6c3d08cd77f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e38e5b97-e90f-4613-a15e-6c3d08cd77f7@baylibre.com>
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
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8480-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ashevche-desk.local:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 4FC9E39DE94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 10:12:04AM -0500, David Lechner wrote:
> On 4/3/26 6:03 AM, Radu Sabau via B4 Relay wrote:

> > Add buffered capture support using the IIO triggered buffer framework.
> > 
> > CNV Burst Mode: the GP pin identified by interrupt-names in the device
> > tree is configured as DATA_READY output. The IRQ handler stops
> > conversions and fires the IIO trigger; the trigger handler executes a
> > pre-built SPI message that reads all active channels from the AVG_IN
> > accumulator registers and then resets accumulator state and restarts
> > conversions for the next cycle.
> > 
> > Manual Mode: CNV is tied to SPI CS so each transfer simultaneously
> > reads the previous result and starts the next conversion (pipelined
> > N+1 scheme). At preenable time a pre-built, optimised SPI message of
> > N+1 transfers is constructed (N channel reads plus one NOOP to drain
> > the pipeline). The trigger handler executes the message in a single
> > spi_sync() call and collects the results. An external trigger (e.g.
> > iio-trig-hrtimer) is required to drive the trigger at the desired
> > sample rate.
> > 
> > Both modes share the same trigger handler and push a complete scan —
> > one u16 slot per channel at its scan_index position, followed by a
> > timestamp — to the IIO buffer via iio_push_to_buffers_with_ts().
> > 
> > The CNV Burst Mode sampling frequency (PWM period) is exposed as a
> > buffer-level attribute via IIO_DEVICE_ATTR.

Tried my best to avoid clashes with David's review.

...

> >  #include <linux/array_size.h>
> >  #include <linux/bitfield.h>

> > +#include <linux/bitmap.h>
> >  #include <linux/bitops.h>

When bitmap.h is present, it implies bitops.h, hence the latter can be simply
replaced.

> >  #include <linux/cleanup.h>
> >  #include <linux/delay.h>
> >  #include <linux/dev_printk.h>
> >  #include <linux/device/devres.h>
> >  #include <linux/err.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/math.h>
> >  #include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> > +#include <linux/property.h>
> > +#include <linux/pwm.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/reset.h>

...

> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
> > -				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> > +				    | BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
> > +				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> >  		.info_mask_separate_available =				\
> > -				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> > +				      BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
> > +				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\

You may reduce churn by squeezing a new ones in between existing ones.
Also consider use usual patter of placing the operator on the same line where
left operand is (currently it goes with the right operand).

...

> >  struct ad4691_state {

Just to double check, when add a new field or fields into the data structure
check with `pahole` that the new members placed at the best or at least good
enough locations.

> >  	const struct ad4691_chip_info *info;
> >  	struct regmap *regmap;
> > +
> > +	struct pwm_device *conv_trigger;
> > +	int irq;
> > +
> > +	bool manual_mode;
> > +
> >  	int vref_uV;
> > +	u8 osr[16];
> >  	bool refbuf_en;
> >  	bool ldo_en;
> > +	u32 cnv_period_ns;
> >  	/*
> >  	 * Synchronize access to members of the driver state, and ensure
> >  	 * atomicity of consecutive SPI operations.
> >  	 */
> >  	struct mutex lock;
> > +	/*
> > +	 * Per-buffer-enable lifetime resources:
> > +	 * Manual Mode - a pre-built SPI message that clocks out N+1
> > +	 *		 transfers in one go.
> > +	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
> > +	 *		    transfers in one go.
> > +	 */
> > +	struct spi_message scan_msg;
> > +	struct spi_transfer *scan_xfers;
> > +	__be16 *scan_tx;
> > +	__be16 *scan_rx;
> 
> Why not embed these arrays here? Then we don't have to deal with
> alloc/free later.
> 
> > +	/* Scan buffer: one slot per channel plus timestamp */
> > +	struct {
> > +		u16 vals[16];
> > +		aligned_s64 ts;
> > +	} scan __aligned(IIO_DMA_MINALIGN);
> 
> Better would be IIO_DECLARE_BUFFER_WITH_TS() since we don't always
> use all vals.
> 
> Also, current usage doesn't need to be DMA-safe because scan_tx
> is being used for the actual SPI xfer.
> 
> >  };

...

> > +static int ad4691_gpio_setup(struct ad4691_state *st, unsigned int gp_num)
> > +{
> > +	unsigned int shift = 4 * (gp_num % 2);
> > +
> > +	return regmap_update_bits(st->regmap,
> > +				  AD4691_GPIO_MODE1_REG + gp_num / 2,
> > +				  AD4691_GP_MODE_MASK << shift,
> > +				  AD4691_GP_MODE_DATA_READY << shift);

Not sure if compiler will see % and / together, I would go with two more
temporary variables to make it clear to it:

	... _bit_off = % 2;
	... _reg_off = / 2;

The practical example is described, for example, here:
9b3cd5c7099f ("regmap: place foo / 8 and foo % 8 closer to each other").

> > +}

...

> > +static int ad4691_manual_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4691_state *st = iio_priv(indio_dev);
> > +	struct device *dev = regmap_get_device(st->regmap);
> > +	struct spi_device *spi = to_spi_device(dev);

> > +	unsigned int n_active = bitmap_weight(indio_dev->active_scan_mask,
> > +					      iio_get_masklength(indio_dev));

In such cases please split definition and assignment. Will take two lines, but
readability will be better.

> > +	unsigned int n_xfers = n_active + 1;
> > +	unsigned int k, i;
> > +	int ret;
> > +
> > +	st->scan_xfers = kcalloc(n_xfers, sizeof(*st->scan_xfers), GFP_KERNEL);
> 
> Usually, we make st->scan_xfers a fixed array with the max number of possible
> xfers. Then we don't have to deal with alloc/free.

And please if it's still be required to allocate and possible use kzalloc_objs().

> > +	if (!st->scan_xfers)
> > +		return -ENOMEM;
> > +
> > +	st->scan_tx = kcalloc(n_xfers, sizeof(*st->scan_tx), GFP_KERNEL);
> > +	if (!st->scan_tx) {
> > +		kfree(st->scan_xfers);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	st->scan_rx = kcalloc(n_xfers, sizeof(*st->scan_rx), GFP_KERNEL);
> > +	if (!st->scan_rx) {
> > +		kfree(st->scan_tx);
> > +		kfree(st->scan_xfers);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	spi_message_init(&st->scan_msg);
> > +
> > +	k = 0;
> > +	iio_for_each_active_channel(indio_dev, i) {
> > +		st->scan_tx[k] = cpu_to_be16(AD4691_ADC_CHAN(i));
> > +		st->scan_xfers[k].tx_buf = &st->scan_tx[k];
> > +		st->scan_xfers[k].rx_buf = &st->scan_rx[k];
> > +		st->scan_xfers[k].len = sizeof(__be16);
> > +		st->scan_xfers[k].cs_change = 1;
> > +		spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
> > +		k++;
> > +	}
> > +
> > +	/* Final NOOP transfer to retrieve last channel's result. */
> > +	st->scan_tx[k] = cpu_to_be16(AD4691_NOOP);
> > +	st->scan_xfers[k].tx_buf = &st->scan_tx[k];
> > +	st->scan_xfers[k].rx_buf = &st->scan_rx[k];
> > +	st->scan_xfers[k].len = sizeof(__be16);
> > +	spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
> > +
> > +	st->scan_msg.spi = spi;
> 
> This isn't how the SPI framework is intended to be used. We should
> have st->spi = spi in probe instead.
> 
> > +
> > +	ret = spi_optimize_message(spi, &st->scan_msg);
> > +	if (ret) {
> > +		ad4691_free_scan_bufs(st);
> > +		return ret;
> > +	}
> > +
> > +	ret = ad4691_enter_conversion_mode(st);
> > +	if (ret) {
> > +		spi_unoptimize_message(&st->scan_msg);
> > +		ad4691_free_scan_bufs(st);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}

...

> > +static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)

As per above.

...

> > +static ssize_t sampling_frequency_show(struct device *dev,
> > +				       struct device_attribute *attr,
> > +				       char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct ad4691_state *st = iio_priv(indio_dev);
> > +
> > +	return sysfs_emit(buf, "%u\n", (u32)(NSEC_PER_SEC / st->cnv_period_ns));

Why casting?

> > +}

...

> > +static IIO_DEVICE_ATTR(sampling_frequency, 0644,
> > +		       sampling_frequency_show,
> > +		       sampling_frequency_store, 0);

IIO_DEVICE_ATTR_RW().

...

> > +static int ad4691_read_scan(struct iio_dev *indio_dev, s64 timestamp)
> > +{
> > +	struct ad4691_state *st = iio_priv(indio_dev);
> > +	unsigned int i, k = 0;
> > +	int ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	ret = spi_sync(st->scan_msg.spi, &st->scan_msg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (st->manual_mode) {
> > +		iio_for_each_active_channel(indio_dev, i) {
> > +			st->scan.vals[i] = be16_to_cpu(st->scan_rx[k + 1]);
> > +			k++;
> > +		}
> > +	} else {
> > +		iio_for_each_active_channel(indio_dev, i) {
> > +			st->scan.vals[i] = be16_to_cpu(st->scan_rx[k]);
> > +			k++;
> > +		}
> 
> I suppose this is fine, but we usually try to avoid extra copiying and
> byte swapping of bufferes like this if we can. It seems completly doable
> in both modes. Manual mode will just one extra two-byte buffer for the
> throw-away conversion on the first read xfer (or just write to the same
> element twice).

And in case it's still needed, we may introduce a helper in
include/linux/byteorder/generic.h calling it memcpy_to/from_be16().

> > +		ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> > +				   AD4691_STATE_RESET_ALL);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = ad4691_sampling_enable(st, true);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
> > +				    timestamp);
> > +	return 0;
> > +}

...

> > +static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
> > +					 struct ad4691_state *st)
> > +{
> > +	struct device *dev = regmap_get_device(st->regmap);
> > +	struct iio_trigger *trig;
> > +	unsigned int i;
> > +	int irq, ret;
> > +
> > +	trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> > +				      indio_dev->name,
> > +				      iio_device_id(indio_dev));
> > +	if (!trig)
> > +		return -ENOMEM;
> > +
> > +	trig->ops = &ad4691_trigger_ops;
> > +	iio_trigger_set_drvdata(trig, st);
> > +
> > +	ret = devm_iio_trigger_register(dev, trig);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "IIO trigger register failed\n");
> > +
> > +	indio_dev->trig = iio_trigger_get(trig);
> > +
> > +	if (!st->manual_mode) {
> 
> I would invert the if since the other case is shorter.

+1.

> > +		/*
> > +		 * The GP pin named in interrupt-names asserts at end-of-conversion.
> > +		 * The IRQ handler stops conversions and fires the IIO trigger so
> > +		 * the trigger handler can read and push the sample to the buffer.
> > +		 * The IRQ is kept disabled until the buffer is enabled.
> > +		 */
> > +		irq = -ENODEV;
> > +		for (i = 0; i < ARRAY_SIZE(ad4691_gp_names); i++) {
> > +			irq = fwnode_irq_get_byname(dev_fwnode(dev),
> > +						    ad4691_gp_names[i]);
> > +			if (irq > 0)
> > +				break;
> > +		}
> > +		if (irq <= 0)
> > +			return dev_err_probe(dev, irq < 0 ? irq : -ENODEV,
> > +					     "failed to get GP interrupt\n");
> 
> Usually we would usually just use spi->irq since it already
> has been looked up. But I guess it is OK to do it like this.

No, it's not. (Linux) IRQ shouldn't ever be 0, so this check is effectively a
dead code.

		irq = -ENXIO; // Note, this is the error code used by core for
			      // IRQ not found.
		...
		if (irq < 0)
			return dev_err_probe(dev, irq, "failed to get GP interrupt\n");

> > +		st->irq = irq;
> > +
> > +		ret = ad4691_gpio_setup(st, i);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/*
> > +		 * IRQ is kept disabled until the buffer is enabled to prevent
> > +		 * spurious DATA_READY events before the SPI message is set up.
> > +		 */
> > +		ret = devm_request_threaded_irq(dev, irq, NULL,
> > +						&ad4691_irq,
> > +						IRQF_ONESHOT | IRQF_NO_AUTOEN,
> > +						indio_dev->name, indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		return devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
> > +							   &iio_pollfunc_store_time,
> > +							   &ad4691_trigger_handler,
> > +							   IIO_BUFFER_DIRECTION_IN,
> > +							   &ad4691_cnv_burst_buffer_setup_ops,
> > +							   ad4691_buffer_attrs);
> > +	}
> > +
> > +	return devm_iio_triggered_buffer_setup(dev, indio_dev,
> > +					       &iio_pollfunc_store_time,
> > +					       &ad4691_trigger_handler,
> > +					       &ad4691_manual_buffer_setup_ops);
> > +}
> > +

-- 
With Best Regards,
Andy Shevchenko



