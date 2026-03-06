Return-Path: <linux-pwm+bounces-8202-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIYXOYXEqmnVWwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8202-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 13:11:49 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A4F220406
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 13:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98DDC313EFB3
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2026 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE08338E5C7;
	Fri,  6 Mar 2026 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXm0vl9R"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6F38E122;
	Fri,  6 Mar 2026 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798767; cv=none; b=p+bQKy7zvcK9bvGcyUo2Z24KsEV5mzhVKhIOTQNaWt5OBfRFZt9VtsF15mAm1dHcnX1GnarML1jC1zoV0XRVjj5NjHtqFtSPsZai3tctjJQlTTpSt4fFc7xKSkJH0hKix1GAQWzA+xneAZBiazIwR6p5NHOeO+dN73GPhRJ9Mvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798767; c=relaxed/simple;
	bh=tDO3tMBubRJSmBotVf8K/a4q5f5YJCh4+ak8U1es/hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4XsZ5HYaqTGl/gVQfZOSP9YRq2aZS1nizXTZtDQVLGJwcPLLaPkuNaBdU27/lUqs9wn+DBpkoqVVg+19v+FbeZTOZSLADmlFKJMtjkIeujQbnNeRfJL8La3FcusSEpDcRTWAsXY5x3yph1in2P5YABzZVASLRQtkw0ol010nqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXm0vl9R; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772798766; x=1804334766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tDO3tMBubRJSmBotVf8K/a4q5f5YJCh4+ak8U1es/hg=;
  b=JXm0vl9RZTdJlylTio7dv+fJs6ZUo/6zyHGKGyVM9xq+3LY5UijJhxnO
   12Ru2BNDu3UlSuJnMe5TRyYos0+6hYJ4NbxF0VJYYZiULQhyrYEbkNPNU
   SelM/1kt8z4OAxcBCpDM5eoyGgrRo3xrvdqBEtc+uC2U2MvXWEzXjc+cc
   7kg+Bwb0Zjdhtrr/sGPtu+mQB/8srJc/Yl1bmwTrZBKPFjfyc1vbJYWm2
   nLJEcqa6pL7Xmfcyp0mP9P2DRIzUdirupoWbRZnJwQqTj/VoclCd3IGk0
   xTo/NSBQlGaqid9BKMZxUcILKHGWTRIMZQlqtSJy8D06jYc5HWIQUFozA
   w==;
X-CSE-ConnectionGUID: sUnCZtWMSaKFsPtEzcvilg==
X-CSE-MsgGUID: SmJPRIt7SgiJ4qSh1/UXcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="96520743"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="96520743"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:06:05 -0800
X-CSE-ConnectionGUID: sCG+ZcC6SEmRcOTOHOemwQ==
X-CSE-MsgGUID: KK7mkGgaQ0KVEQibuFNTPw==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:06:00 -0800
Date: Fri, 6 Mar 2026 14:05:58 +0200
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
Subject: Re: [PATCH 0/4] iio: adc: ad4691: add driver for AD4691 multichannel
 SAR ADC family
Message-ID: <aarDJicasFlUnOkx@ashevche-desk.local>
References: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 51A4F220406
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
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8202-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,ashevche-desk.local:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 02:23:26PM +0200, Radu Sabau via B4 Relay wrote:
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
> The devices support five operating modes:
>   - CNV Clock Mode:    external PWM drives CNV, samples at PWM rate
>   - CNV Burst Mode:    PWM triggers bursts, internal oscillator drives
>                        conversions within each burst
>   - Autonomous Mode:   internal oscillator drives conversions,
>                        software starts/stops via register write
>   - SPI Burst Mode:    similar to Autonomous Mode but optimised for
>                        SPI burst reads
>   - Manual Mode:       CNV tied to SPI CS; each SPI transfer triggers
>                        a conversion and returns the previous result
>                        (pipelined);

This cover letter doesn't answer to the first important question: Why a brand
new driver? Do your homework and check what is already in the kernel and
explain in the next version why no other existing driver can be reused (refactored).

-- 
With Best Regards,
Andy Shevchenko



