Return-Path: <linux-pwm+bounces-8255-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFPUBb3ys2nYdgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8255-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 12:19:25 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF62821F6
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 12:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E27231C628D
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFAB3806BB;
	Fri, 13 Mar 2026 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0xgkwNu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66079277CA5;
	Fri, 13 Mar 2026 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400490; cv=none; b=oVzZkX80SmsnwaegzB76z/n4k1Gw0+k9/bTzhgfBLSLOU8Smo4HrTFJ53x3yDNAPCLFvNA6CnuucCjkG2yG9rYXJqXX3AdyHtrNl4UYp6yNhchD7y2BbXXKllbJi55IwzlY5YxegdX5xX7bP04UgUNCoMWgYK8ofCrX/M9segKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400490; c=relaxed/simple;
	bh=FOhFLuYIDC5nE7S+I1a4NS42j6o6UyInYAIpt7jfvUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvjZvGZV6GnsBzqfw7dsoLIxshjrUGWpdtksM9kfSTyIUi6/1MrZNBNh4Jk6+Pqzi6lFEBTusDVdOc20cldq77l9mkYnw3BCtpFHj5x+VQHXCuHXMiB1gCdMGCrK/ck4n4pVBjLgavPp70N2nrVl7Gf1N9hYYNZSE6AoELSjCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0xgkwNu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773400489; x=1804936489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FOhFLuYIDC5nE7S+I1a4NS42j6o6UyInYAIpt7jfvUs=;
  b=F0xgkwNuf6AxNcIV9KnOhtc4+Iy6D6arWx8UCJTIe+DnkDaSXoHHTH/Z
   CfqGf9tGfif2NBrDCNDUoDrRACxocvcIA0D4/o+eWEzF9HZU/iJZyD66b
   Rs6KI9pHjLJF80PSE9+Zp6XflMuVl4pTWCxUwkd9jhG81N4Xd2o4Kk2A+
   TicwpNRE7ibsXEMpZxb6RSYcGGWM6ZdeVCJg1DeMSh/OdfPpXO7rF13a3
   3Oesq+UtpJXw/0HElXAnvvBNkVKQHOAqB9zi9f3HWVxtzUDDzLqqYQG33
   bg2faaCMNklN10hACbqGwe17+VGCzgftvG6g/aLXs+uoG3QhjIEXzXoIu
   A==;
X-CSE-ConnectionGUID: BVxXfiViS6SOA04aDbv7yw==
X-CSE-MsgGUID: ZCFESVImQaC+Dgxl8IeXFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78356748"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="78356748"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 04:14:48 -0700
X-CSE-ConnectionGUID: 29XU/dBMSeKiinHG2o/jWQ==
X-CSE-MsgGUID: v5c8/l0YRmiK7epatjCS9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225255649"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 04:14:44 -0700
Date: Fri, 13 Mar 2026 13:14:41 +0200
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
Subject: Re: [PATCH v3 0/4] iio: adc: ad4691: add driver for AD4691
 multichannel SAR ADC family
Message-ID: <abPxocHDvBt3rIVL@ashevche-desk.local>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
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
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8255-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ashevche-desk.local:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 72BF62821F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 12:07:24PM +0200, Radu Sabau via B4 Relay wrote:
> This series adds support for the Analog Devices AD4691 family of
> high-speed, low-power multichannel successive approximation register
> (SAR) ADCs with an SPI-compatible serial interface.
> 
> The family includes:
>   - AD4691: 16-channel, 500 kSPS
>   - AD4692: 16-channel, 1 MSPS
>   - AD4693: 8-channel, 500 kSPS
>   - AD4694: 8-channel, 1 MSPS
> 
> The devices support two operating modes, auto-detected from the device
> tree:
>   - CNV Clock Mode: external PWM drives CNV independently of SPI;
>                     DATA_READY on GP0 signals end of conversion
>   - Manual Mode: CNV tied to SPI CS; each SPI transfer reads
>                  the previous conversion result and starts the
>                  next (pipelined N+1 scheme)
> 
> A new driver is warranted rather than extending ad4695: the AD4691
> data path uses an accumulator-register model — results are read from
> AVG_IN registers, with ACC_MASK, ADC_SETUP, DEVICE_SETUP, and
> GPIO_MODE registers controlling the sequencer — none of which exist
> in AD4695. CNV Clock Mode (PWM drives CNV independently of SPI) and
> Manual Mode (pipelined N+1 transfers) also have no equivalent in
> AD4695's command-embedded single-cycle protocol.
> 
> The series is structured as follows:
>   1/4 - DT bindings (YAML schema + dt-bindings header) and
>         MAINTAINERS entry
>   2/4 - Initial driver: register map via custom regmap callbacks,
>         IIO read_raw/write_raw, both operating modes, single-channel
>           reads via internal oscillator (Autonomous Mode)
>   3/4 - Triggered buffer support: IRQ-driven (DATA_READY on GP0) for
>         CNV Clock Mode; hrtimer-based trigger for Manual Mode to
>         handle the pipelined N+1 SPI protocol
>   4/4 - SPI Engine offload support: DMA-backed high-throughput
>         capture path using the SPI offload subsystem

I stopped review where I stopped because I have a feeling that you ignored some
of my comments from the previous version. Why? What's going on?

-- 
With Best Regards,
Andy Shevchenko



