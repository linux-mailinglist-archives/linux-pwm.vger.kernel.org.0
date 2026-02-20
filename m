Return-Path: <linux-pwm+bounces-8132-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKuOMzU4mGkSDQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8132-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 11:32:21 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 090F3166D5E
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 11:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F2A63002B62
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27233D6C9;
	Fri, 20 Feb 2026 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8bj/pZp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A219D07A;
	Fri, 20 Feb 2026 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583536; cv=none; b=YUXj4NCl7iSNNJXAvrP3E+867BpuGr5Rfx5Xhc7jVv31RCjJjwWnYAgG9hwtINR/OPlT9dGwl1Wcx4GVJBsEbZEPMQlsGt0x5VXEjvsWCSG5j0H1REjxW2TiHfgMpmgzRg+9qV+v6M8iLf8DzRrzQI3SP/TzMY4Fs0dKJTt2EhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583536; c=relaxed/simple;
	bh=izOszyZ0PL+gLuOygoLMHD/rSH5k99mu8J6k5Xqzz+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYP3mG0vntnA0v/36yvociQXqXB7HQcIbD0bbi+y/SyzYL8bSEZEf6DU4T1xYZiXJ2z1a3AEPrB/LZoXVgtJ4g9PNWQFovWeZyyggb9StcbbQZi5KvlTXYHEMYMR1Ztp2YNvJKD+MMPLfMxJE3tj9+e8HQOF+42ZRcbqFzudNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8bj/pZp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771583535; x=1803119535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=izOszyZ0PL+gLuOygoLMHD/rSH5k99mu8J6k5Xqzz+o=;
  b=B8bj/pZpZ9uQp3vYweub9K1QB3AYR1pbA9m/EGnIPbnraEPqfqNYygn/
   hqRsYhEMOg79YvK8cnbjEvSWegugb26u7ZlQF3SBI4zSQY6vMlLutv+h+
   /I5gU59wVKZXcZE9nWPWe+WiJvDqrvGfYg/q13Zyk3CLIqpIYJNJmOGuM
   ULvdz8QkhphO7QVVVm5dTyVQSaYy4qDIyaLuy0MHNyygGOXnJNMm33hVv
   miTCWXEcojBMi3jMu1AZTnhpQq33XSgOpjp9r+uBSFou8vlgXMKJuNpx+
   YaXQdZc+1sQ79DVPQ/nJd87uLWq5zMiKWnACb0yjkwOkEkX6fEjPaQoy9
   w==;
X-CSE-ConnectionGUID: E+sToR/mRyC1bRUo4SyWLg==
X-CSE-MsgGUID: 7V/C4RFAQcejeoXobCHIfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="71880941"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="71880941"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 02:32:14 -0800
X-CSE-ConnectionGUID: lG8QlSvFSpKVOIGzNWtxwQ==
X-CSE-MsgGUID: +TgXSV34QzGgSeZgymbLZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="218949595"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 02:31:52 -0800
Date: Fri, 20 Feb 2026 12:31:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
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
Subject: Re: [PATCH 0/3] Add support for AD5706R DAC
Message-ID: <aZg4FRx9z4ObwJ7q@smile.fi.intel.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8132-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,analog.com:url,analog.com:email]
X-Rspamd-Queue-Id: 090F3166D5E
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 04:02:55PM +0800, Alexis Czezar Torreno wrote:
> This series adds support for the Analog Devices AD5706R, a 4-channel
> 16-bit current output digital-to-analog converter with SPI interface.
> 
> The AD5706R features:
>   - 4 independent current output DAC channels
>   - Configurable output ranges (50mA, 150mA, 200mA, 300mA)
>   - Hardware and software LDAC trigger with configurable edge selection
>   - Toggle and dither modes per channel
>   - Internal or external voltage reference selection
>   - PWM-controlled LDAC
>   - Dynamic change SPI speed

It's ~2300 LoC file, please split by features, so the first patch brings basics
and a few followups that add the rest.

> The driver exposes standard IIO raw/scale/offset channel attributes for
> DAC output control, sampling frequency for PWM-based LDAC timing, and
> extended attributes for device configuration including output range
> selection, trigger mode, and multiplexer output.
> 
> This driver is developed and tested on the Cora Z7S platform using
> the AXI SPI Engine and AXI CLKGEN IP cores. The 'clocks' property
> enables dynamic SPI clock rate management via the CLKGEN.
> 
> Datasheet: https://www.analog.com/en/products/ad5706r.html

> 

No blank lines in the tag block.
(Not sure if `b4` can spread it over the series either way.)

> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>


-- 
With Best Regards,
Andy Shevchenko



