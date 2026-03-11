Return-Path: <linux-pwm+bounces-8230-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFwzE1FUsWlHtwIAu9opvQ
	(envelope-from <linux-pwm+bounces-8230-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 12:38:57 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B41626300A
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 12:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD3A9304202F
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 11:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53A23DDDC7;
	Wed, 11 Mar 2026 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxlYOLCU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912753DE450;
	Wed, 11 Mar 2026 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229110; cv=none; b=TqNVADQ47nOeT3yNXuHxxVRt1SMGDmhGzqPk7BRLDPCrt+XKR6CvH9klqzFHqGfjzG7+OoGx+WG8sOtZQenaxHfHifp104IrrzEsez6jLRFhnW3u9cjIYLEyDfGn2+jOKpeDZm/HA67s25dGal277qUXvVIya/lI/v4JQgWNTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229110; c=relaxed/simple;
	bh=ui73lqYm7qf9rJsB9UiEVC0i6OGz2H3zeZeUYIT5X2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYYsZEM823aV6CrE/SYbykuCA+iO60YleovnXjiycrUt460sB3tpWYuG1917oZgyaXLYUoV5oBP/GF0WzJ4plU/37JnRxw9Bohmh68vmUZeyh46rWsSiCaG81xf8Q3sC6n2GEFjo64V+Yz42IWOfPUxjVENGpmuI5F7giVhIKvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxlYOLCU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773229110; x=1804765110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ui73lqYm7qf9rJsB9UiEVC0i6OGz2H3zeZeUYIT5X2Q=;
  b=hxlYOLCUZOMIBs/te9/bb37O7fruzsfeXmlJqZQ7torStkqAFwsUTTS3
   dAuucEq6Cb2yEF//LvvJRhoJdJDtaibXoT/nmTuzk4Sfo1CHP1XVKgQV7
   N0rTZ8nOV+aqBQDcdZTQOpSLCywDjBE4hW1Rf3F/D6FwbZcjdNuyw9l10
   1GPA1ALa31glLEj+pl3OvFfNetNGuhS8vYAENsC2YGPVg1RfjUh4vVvm/
   5h1MBnMU0poZccV90B3uvKUvaBeB+RFGLOfvCdpWri3wvPna86umTbPDH
   S/lpzxLr+IcvrR4LX/7m0pTw/5J4UC6cFXP5yldjua27PPmEKgcrekXiC
   Q==;
X-CSE-ConnectionGUID: fOADiU9yTqyJIcs3mJIJwg==
X-CSE-MsgGUID: zaQ999mzQfGxPF1V4yEPQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="84998912"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="84998912"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 04:38:29 -0700
X-CSE-ConnectionGUID: X3kNN1LARnepHK0oCUkwJg==
X-CSE-MsgGUID: 7L5N+b08Rxi+gFVMV5WJhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="243447899"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 04:38:26 -0700
Date: Wed, 11 Mar 2026 13:38:23 +0200
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
Subject: Re: [PATCH v2 0/3] Add support for AD5706R DAC
Message-ID: <abFUL5kfq9ZNzFuy@ashevche-desk.local>
References: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 0B41626300A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8230-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ashevche-desk.local:mid,intel.com:dkim]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 08:23:16AM +0800, Alexis Czezar Torreno wrote:
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
> 
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

It's a v2 and still some very basic comments may be applied, such an
introduction of the record in MAINTAINERS database.

One more time, can't ADI introduce an internal Wiki page where standard
practices and/or typical issues be listed and be addressed BEFORE it's going to
the mailing lists?

-- 
With Best Regards,
Andy Shevchenko



