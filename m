Return-Path: <linux-pwm+bounces-8135-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOhZN8w+mGneDwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8135-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 12:00:28 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F761671EA
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 12:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E71EC300335A
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3DD340D8C;
	Fri, 20 Feb 2026 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCjiRx0O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBD2F3C26;
	Fri, 20 Feb 2026 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585226; cv=none; b=fqk2ZS35c1Gi0EeFgA5LSv4kzKM7vGV+mRFeQBCLHBKhwjJvR3h06jG0oUK1W/LUNoXcpTfYzghK+F/1qo/W3+H03T3dKjodgyn2T6BLDU2R234rNc5MCJ5LmWWzVxwcNPTUQtXv/rMk4loOx4QAhPyqgE2SJPX2GZU1tV0mzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585226; c=relaxed/simple;
	bh=iNcKUhcDBC7DS7fLtdCAgJUwplE3Xzy+e6JHVWqEix0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnjHWqXveYpryRoQd/mm3Q8n3oTP/4dTTrLGNQnbHFQ5ziCvKdAMKqu4P1v9EHQ3p9cL4cqIybNbqBIMlu3uuI27ULMnpvWFzfJrjxk7d0ZbhV4520MfyC6jTKJBoTlaFiC0lg4ZKF4W4VvAoIvaRj3vb4nNK4Flu546P0d+iI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCjiRx0O; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771585224; x=1803121224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iNcKUhcDBC7DS7fLtdCAgJUwplE3Xzy+e6JHVWqEix0=;
  b=aCjiRx0Oc7kmWU5E0W3vzxGxOkNDxeRLJ/BymmKhmM3HZ8sM5MwV/bIJ
   joDlXs/s28V38l8fXl6phqIpJBx3TH+gJ2F66Kdl8F+UNvr25cYoSbSJL
   Ot6hbDfiTNZRzIipt1QwGUTvueQDZaTHc/BxckSCw3eGLeF99iPhIpmrg
   V9EJdUOOsgWRpW6WSpqsqzhUrzGQkQKnKxBl+nsyxZV7u6GjIdNhJOvlK
   9eq20sOAuHXbKfRUJEq5I28bkQfDkPRgDg3Y4DNMXlQ2vWmLnhsNy8rcp
   F050JLIm/l8E6Wh3kyuJk6UtI03qbUb2L+R59NfIgn+/94ylLRGyk6hTg
   A==;
X-CSE-ConnectionGUID: 7p5DaA+0SD+nuYT56020ng==
X-CSE-MsgGUID: mf+CM1ZWSJ6tgErxpBvYjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72582542"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72582542"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 03:00:24 -0800
X-CSE-ConnectionGUID: l+ZxE1JySnKLY4z/9cj1GA==
X-CSE-MsgGUID: yGRs53IUSDWisLQCTbALXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="218955283"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 03:00:16 -0800
Date: Fri, 20 Feb 2026 13:00:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <aZg-vtenBU2rKKX_@smile.fi.intel.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
 <20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
 <4fd329ed6416fd2f8e2a72adfa5a77f73107948b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fd329ed6416fd2f8e2a72adfa5a77f73107948b.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8135-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 82F761671EA
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:48:59AM +0000, Nuno Sá wrote:
> On Fri, 2026-02-20 at 16:02 +0800, Alexis Czezar Torreno wrote:

...

> > +static void ad5706r_debugs_init(struct iio_dev *indio_dev)
> > +{
> > +	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
> 
> It should have:
> 
> if (!IS_ENABLED(CONFIG_DEBUGFS))
> 	return

But why? The debugfs is a stub when disabled, nobody should do that
in the cases when the main purpose is not the debugfs code.

> > +	debugfs_create_file_unsafe("streaming_addr", 0600, d,
> > +				   indio_dev, &ad5706r_streaming_addr_fops);
> > +	debugfs_create_file_unsafe("streaming_len", 0600, d,
> > +				   indio_dev, &ad5706r_streaming_len_fops);
> > +	debugfs_create_file_unsafe("streaming_data", 0600, d,
> > +				   indio_dev, &ad5706r_streaming_data_fops);
> > +	debugfs_create_file_unsafe("streaming_reg_access", 0600, d,
> > +				   indio_dev, &ad5706r_streaming_reg_access_fops);
> > +	debugfs_create_file_unsafe("spi_speed_hz_write", 0600, d,
> > +				   indio_dev, &ad5706r_spi_speed_write_fops);
> > +	debugfs_create_file_unsafe("spi_speed_hz_read", 0600, d,
> > +				   indio_dev, &ad5706r_spi_speed_read_fops);
> > +}

...

> > +	/* Find which index has this register value */
> > +	for (i = 0; i < ARRAY_SIZE(mux_out_sel_reg_values); i++) {

	for (size_t i...)

> > +		if (mux_out_sel_reg_values[i] == reg_byte) {
> > +			st->mux_out_sel = i;
> > +			return i;  /* Return index, not register value */
> > +		}
> > +	}

...

> > +	return ret ? ret : len;

Use Elvis operator

	return ret ?: len;

...


> > +	{},

IIO has a style for terminator entry, along with confusing trailing comma.
If it's a sentinel, it must be one even at a compile time.

> > +};

...

> > +	st->debug_spi_speed_hz_write = 10000000;
> > +	st->debug_spi_speed_hz_read = 10000000;

units.h and other headers for your help

10 * HZ_PER_MHZ

...

> > +	st->sampling_frequency = 1000000;

In the similar way.

...

> > +	st->reference_volts = 2500;

2.5kV?! I think you mistakenly put volts where should be _mV

...

> > +	for (i = 0; i < 4; i++) {

Magic 4.

> > +		st->hw_active_edge[i] = HW_ACTIVE_EDGE_RISING_EDGE;
> > +		st->range_sel[i] = RANGE_SEL_50;
> > +		st->output_state[i] = OUTPUT_STATE_NORMAL_SW;
> > +		st->ldac_trigger_chn[i] = LDAC_TRIGGER_CHN_HW_TRIGGER;
> > +		st->toggle_trigger_chn[i] = TOGGLE_TRIGGER_CHN_HW_TRIGGER;
> > +		st->dither_trigger_chn[i] = DITHER_TRIGGER_CHN_HW_TRIGGER;
> > +		st->multi_dac_sel_ch[i] = MULTI_DAC_SEL_CH_EXCLUDE;

Hmm... Perhaps memsetXX()? But original loop with the defined iterator will be
okay:

	for (unsigned int i = 0; i < $MAGIC_CONST; i++) {

> > +	}

...

> > +	st->resetb_gpio = devm_gpiod_get_optional(dev, "dac-resetb", GPIOD_OUT_LOW);
> > +	if (IS_ERR(st->resetb_gpio)) {
> > +		return dev_err_probe(dev, PTR_ERR(st->resetb_gpio),
> > +				     "Failed to get RESET_B GPIO\n");
> > +	}

> > +	st->shdn_gpio = devm_gpiod_get_optional(dev, "dac-shdn", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(st->shdn_gpio)) {
> > +		return dev_err_probe(dev, PTR_ERR(st->shdn_gpio),
> > +				     "Failed to get SHDN GPIO\n");
> > +	}

The {} are not needed when the body is a single call.

...

> > +static const struct of_device_id ad5706r_of_match[] = {
> > +	{ .compatible = "adi,ad5706r" },
> > +	{ },

See above about terminator entry style.

> > +};

-- 
With Best Regards,
Andy Shevchenko



