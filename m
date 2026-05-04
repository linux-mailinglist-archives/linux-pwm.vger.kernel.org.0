Return-Path: <linux-pwm+bounces-8763-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAZKMpVV+GmWtAIAu9opvQ
	(envelope-from <linux-pwm+bounces-8763-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 10:15:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB1A4BA054
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 10:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F4433005583
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2026 08:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CAB31E82B;
	Mon,  4 May 2026 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIdyDq1H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42D31C567;
	Mon,  4 May 2026 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882504; cv=none; b=tvPfFDW3r3SJUzcrTFxRxQ800pnCltVwP6dNJpQM2I6fbj6YgtOCqUC8yxgQQm7dKst3knxwoO5QFcakhFgsDdUjzZbl3/inyM18sryOehGei6bNuFtNysu0rmtSZ9Uxm7WWeJQkh4MUiN0cgcu6IrLYbYli/ooRsLvwK/aQ0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882504; c=relaxed/simple;
	bh=MQv4zk7h1yV1kcpyjPkg8okaCn/5xqQSH3mz8Kx5s5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZNMwI+Eu2d84wP9N66JN4OogxJHrfcIZbpeREZpooUfqwWG43HxIeWCLDkb5QD8sqt6koUP1j2Gu97QR2cv2hRZvK5LUXUc8xmhFDgoI3uWhwXT0klGGmqqq+wLR41ab8xG9aGMAkEYQjA1DQcmZVvswgmNOD6LCwdcMQm9yC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIdyDq1H; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777882503; x=1809418503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MQv4zk7h1yV1kcpyjPkg8okaCn/5xqQSH3mz8Kx5s5g=;
  b=OIdyDq1HhppHwsIUGZPc5KegxiAwMq1oS+irH4w86k6jNx7h2ABVdrCF
   W5JeU+oXcEbVElAr1cSRJNNgwFQ3Q5eGhCxTPLgcB2JiKetZX+YZquzAu
   paVsQUoF9xFcIN2+rfGms5qkvXolSscFULlcatPQzv9MBVf9o66kJ2yyb
   yLGRltJrxDw30ZIUJ35/gItiSChdtDJrKm0QuOjWWgO6xrTNslGoQAJwA
   U9awOrMLTd3LDOTM4va9o0fp6Zw5OtvNHrq1NAPTXgsFraU/STfH70hKJ
   +gHs/unoQXQOuJ0BAqKSlfKa/hxPqxpAtCV4jkOlhqmUH4AFOHFamGiyT
   g==;
X-CSE-ConnectionGUID: fmXnvuKvRXK2OJV/nZ7h+g==
X-CSE-MsgGUID: 9m1isV8JQqKoVU/zP2XSrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="77897936"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="77897936"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:15:02 -0700
X-CSE-ConnectionGUID: KoN5SnOOSy6kFmdtPkX1sg==
X-CSE-MsgGUID: aH03MOmPTL+0b5walA6uVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="239424698"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:14:56 -0700
Date: Mon, 4 May 2026 11:14:54 +0300
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
Subject: Re: [PATCH v9 5/6] iio: adc: ad4691: add oversampling support
Message-ID: <afhVfj6zo3pmLdC6@ashevche-desk.local>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
 <20260430-ad4692-multichannel-sar-adc-driver-v9-5-33e439e4fb87@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-ad4692-multichannel-sar-adc-driver-v9-5-33e439e4fb87@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 6CB1A4BA054
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8763-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,ashevche-desk.local:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 01:16:47PM +0300, Radu Sabau via B4 Relay wrote:

> Add per-channel oversampling ratio (OSR) support for CNV burst mode.
> The accumulator depth register (ACC_DEPTH_IN) is programmed with the
> selected OSR at buffer enable time and before each single-shot read.
> 
> Supported OSR values: 1, 2, 4, 8, 16, 32.
> 
> Introduce AD4691_MANUAL_CHANNEL() for manual mode channels, which do
> not expose the oversampling ratio attribute since OSR is not applicable
> in that mode. A separate manual_channels array is added to
> struct ad4691_channel_info and selected at probe time; offload paths
> reuse the same arrays with num_channels capping access before the soft
> timestamp entry.
> 
> in_voltageN_sampling_frequency represents the effective output rate for
> channel N, defined as osc_freq / osr[N]. The chip has one internal
> oscillator shared by all channels; each channel independently
> accumulates osr[N] oscillator cycles before producing a result.
> 
> Writing sampling_frequency computes needed_osc = freq * osr[N] and
> snaps down to the largest oscillator table entry that satisfies both
> osc <= needed_osc and osc % osr[N] == 0, guaranteeing an exact integer
> read-back. The result is stored in target_osc_freq_Hz and written to
> OSC_FREQ_REG at buffer enable and single-shot time, so sampling_frequency
> and oversampling_ratio can be set in any order.
> 
> in_voltageN_sampling_frequency_available is computed dynamically from
> the channel's current OSR, listing only oscillator table entries that
> divide evenly by osr[N], expressed as effective rates. The list becomes
> sparser as OSR increases, capping at max_rate / osr[N].
> 
> Writing oversampling_ratio stores the new OSR for that channel;
> target_osc_freq_Hz is left unchanged. The effective rate read back via
> in_voltageN_sampling_frequency becomes target_osc_freq_Hz / new_osr
> automatically. The two attributes are orthogonal: sampling_frequency
> controls the oscillator, oversampling_ratio controls the averaging depth.
> 
> OSR defaults to 1 (no accumulation) for all channels.

...

> +/* Write target_osc_freq_Hz to OSC_FREQ_REG. Called at use time. */
> +static int ad4691_write_osc_freq(struct ad4691_state *st)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {

It can be

	for (unsigned int i = 0; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {

> +		if (ad4691_osc_freqs_Hz[i] == st->target_osc_freq_Hz)
> +			return regmap_write(st->regmap, AD4691_OSC_FREQ_REG, i);
> +	}
> +	return -EINVAL;
> +}

...

> +/*
> + * Find the largest oscillator table entry that is both <= needed_osc and
> + * evenly divisible by osr (guaranteeing an integer effective rate on
> + * read-back). Returns 0 if no such entry exists in the chip's valid range.
> + */
> +static unsigned int ad4691_find_osc_freq(struct ad4691_state *st,
> +					 unsigned int needed_osc,
> +					 unsigned int osr)
>  {
> +	unsigned int start = ad4691_samp_freq_start(st->info);
>  
> +	for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
> +		if ((unsigned int)ad4691_osc_freqs_Hz[i] > needed_osc)
> +			continue;
> +		if (ad4691_osc_freqs_Hz[i] % osr != 0)

' != 0' is redundant.

> +			continue;
> +		return ad4691_osc_freqs_Hz[i];
> +	}
> +	return 0;
> +}

> +static int ad4691_get_sampling_freq(struct ad4691_state *st, u8 osr, int *val)
> +{
> +	*val = st->target_osc_freq_Hz / osr;
>  	return IIO_VAL_INT;
>  }

...

> -static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int freq)
> +static int ad4691_set_sampling_freq(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan, int freq)

Can you use --histogram algo when preparing patches? This might make them look
better.

...

> +	if (freq <= 0 || (unsigned int)freq > st->info->max_rate / osr)

Why casting?

> +		return -EINVAL;

...

> -	/* Wait 2 oscillator periods for the conversion to complete. */
> -	period_us = DIV_ROUND_UP(2UL * USEC_PER_SEC, ad4691_osc_freqs_Hz[osc_idx]);
> +	/*
> +	 * Wait osr + 1 oscillator periods: osr for accumulation, +1 for the
> +	 * pipeline margin (one extra period ensures the final result is ready).
> +	 */
> +	period_us = DIV_ROUND_UP((unsigned long)(st->osr[chan->channel] + 1) * USEC_PER_SEC,

Why casting?

> +				 st->target_osc_freq_Hz);
>  	fsleep(period_us);

-- 
With Best Regards,
Andy Shevchenko



