Return-Path: <linux-pwm+bounces-8137-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB/hFHCSmGkfJwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8137-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 17:57:20 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D7B169859
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 17:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07D2E301457F
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C082F6192;
	Fri, 20 Feb 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuERNVJ/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC6E2F49F0;
	Fri, 20 Feb 2026 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606621; cv=none; b=BIPGmXc7ouQVdR1tL3yrNTrP+P8y2JfJHdI0te23p+P7utMokmPJZz8dP8Q7yeCZyQkZK5jFqOn974mtcS2KSiqVUmWND+j65wc8qYck/rmTtrcglo3LSLXV428x0huTvs3g63xesBEDbcQ/RFVkJ8g33mcyytyb8UJ3Bt9Hrnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606621; c=relaxed/simple;
	bh=h0roktZ6hh9v4RmiXDWicExfqn4gtwVXGM/LZlgJDEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYKPaSbaS5zMCEzVoefbvZQ9YCuSGGcol/P5RIdpnXQW4fYDr3IO3twKE8LUTBpTWdn17xk/D0o+lML48Pb48g7/6wO9Xl8oFs6+7Tf7Tp+82v/XeezADkgeJ/jcVxiyc49Y72OSb+3HMRpXLeDVygkTk97A+Pd0TlRg33ztIyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuERNVJ/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771606620; x=1803142620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=h0roktZ6hh9v4RmiXDWicExfqn4gtwVXGM/LZlgJDEc=;
  b=HuERNVJ/l5zzD35pwiVzPmqH36ARBmwlr5yWUIIe9/NzHjjURTFZ2iZo
   RlT5twqBTw5IqQqYxmq26Q0j/912m5nPQetO3o5FbY800N/lDNdZQEtjq
   gScMx1TlpazlU8Ezqjg2QhNvwa8sGT/H2Gq5Lz2la+lVPLv6wO3GebNse
   7Ld9WX1paZX1k3sHcXX/CFnnTudw4WCJufmS3GQp6o77UUlempwlIRXAS
   jBSZfQVOChZ+meTVuKo6+/4yA0CdCqm30ZhKEGCbP66+uxzZ6DtREiSOh
   s6jv8xurLyEjlflSBqBinK752Bh6gPXA3CU2VpYzIaOzToyG62qnjT7X5
   Q==;
X-CSE-ConnectionGUID: qM7P8bjRT3CGmho2IQiikg==
X-CSE-MsgGUID: +r7sWX5uS06dx0nJoOsviQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="83416513"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="83416513"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 08:56:59 -0800
X-CSE-ConnectionGUID: vv4hx5r+SU2MoIFwH3PBCQ==
X-CSE-MsgGUID: mHJv1OxTRfao46F0857R6Q==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 08:56:56 -0800
Date: Fri, 20 Feb 2026 18:56:53 +0200
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
Message-ID: <aZiSVSvCOS4MvcGt@smile.fi.intel.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
 <20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
 <4fd329ed6416fd2f8e2a72adfa5a77f73107948b.camel@gmail.com>
 <aZg-vtenBU2rKKX_@smile.fi.intel.com>
 <a6a2fc3ebb45fa4d7b379d552196d56eb13fa8d3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6a2fc3ebb45fa4d7b379d552196d56eb13fa8d3.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8137-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: B1D7B169859
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 03:02:37PM +0000, Nuno Sá wrote:
> On Fri, 2026-02-20 at 13:00 +0200, Andy Shevchenko wrote:
> > On Fri, Feb 20, 2026 at 10:48:59AM +0000, Nuno Sá wrote:
> > > On Fri, 2026-02-20 at 16:02 +0800, Alexis Czezar Torreno wrote:

...

> > > > +static void ad5706r_debugs_init(struct iio_dev *indio_dev)
> > > > +{
> > > > +	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
> > > 
> > > It should have:
> > > 
> > > if (!IS_ENABLED(CONFIG_DEBUGFS))
> > > 	return
> > 
> > But why? The debugfs is a stub when disabled, nobody should do that
> > in the cases when the main purpose is not the debugfs code.
> 
> Because the compiler can then optimize away all of the above code...

How is it different to the code elimination part that is inside in each of
the below calls?

> > > > +	debugfs_create_file_unsafe("streaming_addr", 0600, d,
> > > > +				   indio_dev, &ad5706r_streaming_addr_fops);
> > > > +	debugfs_create_file_unsafe("streaming_len", 0600, d,
> > > > +				   indio_dev, &ad5706r_streaming_len_fops);
> > > > +	debugfs_create_file_unsafe("streaming_data", 0600, d,
> > > > +				   indio_dev, &ad5706r_streaming_data_fops);
> > > > +	debugfs_create_file_unsafe("streaming_reg_access", 0600, d,
> > > > +				   indio_dev, &ad5706r_streaming_reg_access_fops);
> > > > +	debugfs_create_file_unsafe("spi_speed_hz_write", 0600, d,
> > > > +				   indio_dev, &ad5706r_spi_speed_write_fops);
> > > > +	debugfs_create_file_unsafe("spi_speed_hz_read", 0600, d,
> > > > +				   indio_dev, &ad5706r_spi_speed_read_fops);
> > > > +}

-- 
With Best Regards,
Andy Shevchenko



