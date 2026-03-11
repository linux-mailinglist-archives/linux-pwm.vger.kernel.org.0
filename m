Return-Path: <linux-pwm+bounces-8231-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFMYMrdVsWmGtwIAu9opvQ
	(envelope-from <linux-pwm+bounces-8231-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 12:44:55 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD8A2630D2
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 12:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F82D30474C6
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 11:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BF63DDDAE;
	Wed, 11 Mar 2026 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUX2qga6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360833DD524;
	Wed, 11 Mar 2026 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229471; cv=none; b=RhjtORSt2UAzukFwEKXywLKmuRDl2lHvW5RtNNsjNQU+rd2OHO+E0nmyf3e75aRiRylxeCOWHByan7Ymt3aGY0xVXpmBpzvUgT7JGX1G7noVQXYeIn7YVwU/TnlMAyXB99J4rBpgwLRpl2Hh6rDlaolJ3CFbeHAAyNFlIqzV798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229471; c=relaxed/simple;
	bh=XY0jFffDLGVGCJw4uqbLQtSOOoaUJosbQqgvPfqZ4LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeszoPIaUv/hYQBXxAJzLeLUmoJ1yeAUoszhps15ANGZ+JAmb0ili8PVF+RAyW+M2T1bmZpxVkegbcyhAvtwok/8TdrfIFS6Wr83BM2QlLXSmHAoxVdQn7ZONKYjbDGsaxP5OtBVrqDzVfT2wp8rTick7wmYFXKfqZlznjCboAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUX2qga6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773229470; x=1804765470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XY0jFffDLGVGCJw4uqbLQtSOOoaUJosbQqgvPfqZ4LI=;
  b=aUX2qga6DY6GwldgNNpCU/6ODvUKJziz0+M8AWG/gkt6YLZVR+sJycdr
   MeWJDY1b53YE8lFqifCikX8ovNF3YhMl7VmWEkKAg5NPvRfzGcV+EsGS6
   oSWdtc3N0bK9MWjA3Gd9eL4eg4mWbnG8SBDsjgKL5rMzOPrK15QnEdcxf
   tNg2q2rIDFAy1pzKB1CbulPc505tLaW9WgrE/yXo6tk4TwpRI0nIX9ruT
   jgXhBvuNdGD6G1BXrgclVuCGYQxy6hGei9CqksLq7u+rM/Ukzn5A+M0ij
   ZDS+WCbE2SOvnpuX3H514vPIDw0Wl0fa17crfKTpZsLsR+Zn3r0x3hVcy
   w==;
X-CSE-ConnectionGUID: 0ZNIkEHJT6aK1qloMEPV6g==
X-CSE-MsgGUID: LLAmb7UbQFejdFtNnqxSPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74204379"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74204379"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 04:44:29 -0700
X-CSE-ConnectionGUID: 5mc6tgogSPiqkolLF3VOEQ==
X-CSE-MsgGUID: YENNypp7SMa5mrNHIGhYWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="224601491"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 04:44:25 -0700
Date: Wed, 11 Mar 2026 13:44:23 +0200
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
Subject: Re: [PATCH v2 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <abFVl8NhfBkvyI4I@ashevche-desk.local>
References: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
 <20260311-dev_ad5706r-v2-2-f367063dbd1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dev_ad5706r-v2-2-f367063dbd1b@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 2CD8A2630D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8231-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 08:23:18AM +0800, Alexis Czezar Torreno wrote:
> Add support for the Analog Devices AD5706R, a 4-channel 16-bit
> current output digital-to-analog converter with SPI interface.
> 
> Features:
>   - 4 independent DAC channels
>   - Hardware and software LDAC trigger
>   - Configurable output range
>   - PWM-based LDAC control
>   - Dither and toggle modes
>   - Dynamically configurable SPI speed

...

> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>

IWYU, please.
Yet another typical issue with ADI patches. Really, talk to your senior
colleagues who are experienced kernel developers before sending it to ML.

...

> +#define AD5706R_DAC_RESOLUTION		16
> +#define AD5706R_DAC_MAX_CODE		BIT(AD5706R_DAC_RESOLUTION)  /* 65536 */

Useless comment, use the same number explicitly instead

	BIT(16)

which is much more readable.

...

> +	st->tx_buf = cpu_to_be32((((u32)reg) << 16) |
> +			((u32)val << (16 - (num_bytes * 8))));

What the heck is this?

...

> +static const struct of_device_id ad5706r_of_match[] = {
> +	{ .compatible = "adi,ad5706r" },
> +	{ },

Even inside a single file this is inconsistent, besides being third of
101 IIO	patch issues.

> +};
> +MODULE_DEVICE_TABLE(of, ad5706r_of_match);
> +
> +static const struct spi_device_id ad5706r_id[] = {
> +	{ "ad5706r", 0 },

When there is no driver data, no need to explicitly initialise it.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad5706r_id);

-- 
With Best Regards,
Andy Shevchenko



