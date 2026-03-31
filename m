Return-Path: <linux-pwm+bounces-8448-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPzTMOiNy2kuIwYAu9opvQ
	(envelope-from <linux-pwm+bounces-8448-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 11:03:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7012F366A55
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 11:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66F6F3023F19
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 08:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CD03E0252;
	Tue, 31 Mar 2026 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfiMuoyV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0092989B7;
	Tue, 31 Mar 2026 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947536; cv=none; b=kyJzDJalOpN1RRL+9ic+I+RiQ8LtXpPvAo9lfkwf07T+GDwqYdMY19Bn2OWDOBP6ItwZ3VADZkx6p32zcTh21ijgrBA2vfqibqslAtNz8Pt6rhArfVTaP+GHWlhmrNSmKAHVTSu76esOSOugwUHUDOJPLgAVzUQzTRnXfDkR344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947536; c=relaxed/simple;
	bh=FUPUgjK8/+PvpwggJPyEhrpAfXGX6f/ynqW5/FOp1v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8bI6y6UI1HW4jUf2Z7uvq1T40ZdwExcU2mwk+wO0tqfbDQJ1IbItXE6/tyVZBnweuYaFl1Rnj0D624k7uBPv0vbPQTaoP3xhfNnGYBeM5R6uUmj3pqNerKQSJbXBXkltU8RlsLDqp0wgiZwKcZl54kNsB3slRsZ5LysVySnsSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfiMuoyV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774947534; x=1806483534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FUPUgjK8/+PvpwggJPyEhrpAfXGX6f/ynqW5/FOp1v4=;
  b=XfiMuoyV4Qjg5rojr5boMK1ojcFkCYD0ylX3/dybqy0MOZTTPYpUc0ux
   HsIt7zYDUe3x4QMQ1H1hAW4rwOcQBNlM/TVxwg5qZbUlNAvd7P+3utiXA
   w/ZcFvBjdFUjJhGOxXrep2WrIqvvmAp7fF8lpS6Bzd3dME0utlVU+X5nh
   t2SXKmjiHdSgKpTqLzR+WfClkohl38iBCYMokTwzGQeVPPQCgRIcQXiSo
   0jqTvsbazba8XN6MEOts/HJJqk9ugxsWrqo861ytcGNO5h7F/G+NFZ0DP
   pO27chUZG8lbtMDt66lC1rxMoZTTDrPiGYkXif66Kjfu0SPctmDVMegDG
   A==;
X-CSE-ConnectionGUID: 83d4g1I1RuK6cPT7MKcd7w==
X-CSE-MsgGUID: Am2LcPXNTT+r8y26gSOl3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93536866"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="93536866"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:58:53 -0700
X-CSE-ConnectionGUID: DuuIgLTxRZyRcp5clt1jOA==
X-CSE-MsgGUID: yoig1j+TR9SmrTbrMrvCTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="231120906"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:58:48 -0700
Date: Tue, 31 Mar 2026 11:58:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <acuMxjX_rsfsJvMp@ashevche-desk.local>
References: <20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com>
 <20260327-ad4692-multichannel-sar-adc-driver-v5-2-11f789de47b8@analog.com>
 <acZrthJYQX-h_9p5@ashevche-desk.local>
 <LV9PR03MB84143540CE505514E1CD84B4F752A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <CAHp75VcUCM8aeUpNaFEXnS+Cm08Mq5j+Qp2gYqWP9vCO+9CtQA@mail.gmail.com>
 <LV9PR03MB8414CB05EB794F6974584C2AF753A@LV9PR03MB8414.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV9PR03MB8414CB05EB794F6974584C2AF753A@LV9PR03MB8414.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-8448-lists,linux-pwm=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,metafoo.de,analog.com,kernel.org,baylibre.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: 7012F366A55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 08:36:42AM +0000, Sabau, Radu bogdan wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Monday, March 30, 2026 8:24 PM

...

> > > > > +#include <linux/bitfield.h>
> > > > > +#include <linux/bitops.h>
> > > > > +#include <linux/cleanup.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/device.h>
> > > >
> > > > Hmm... Is it used? Or perhaps you need only
> > > > dev_printk.h
> > > > device/devres.h
> > > > ?
> > 
> > > I have checked this out and it seems device.h doesn't actually need
> > > to be included anyway since spi.h directly includes device.h, and since
> > > this is a SPI driver that's never going away, it's covered. Will drop it!
> > 
> > No, this is the wrong justification. IWYU principle is about exact
> > match between what is used and included in a file (module). spi.h is
> > not dev_*() provider and may not be considered for that.
> > 
> 
> You are right, my justification was incorrect. Under IWYU, relying on
> spi.h's transitive pull of device.h is not valid. However, I think device.h
> is still needed in this case since struct device is used directly in the code
> both as local variables and in the regmap callbacks.

Really? I can't see that.
(Hint: use of the data type and use of its pointer is a huge difference.)

> Also dev_err_probe() is called directly and lives in device.h.

No, as I started with my replies. The proper header that provides it is
dev_printk.h.

> What's your take on this?

-- 
With Best Regards,
Andy Shevchenko



