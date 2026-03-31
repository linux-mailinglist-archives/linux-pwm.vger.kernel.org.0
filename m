Return-Path: <linux-pwm+bounces-8450-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIOPFm4bzGnHPgYAu9opvQ
	(envelope-from <linux-pwm+bounces-8450-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 21:07:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A573A3705DA
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 21:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 058CB300A760
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 19:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B1C3A3E68;
	Tue, 31 Mar 2026 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPSUDz8g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17E938CFE7;
	Tue, 31 Mar 2026 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983861; cv=none; b=MsRkhcNZjPqBsWfpNjwDwZ6uklk5GjxmxJSOgmp8c6v8t7HrhoKuHKabA+oalrGoG330QPHAT+M5n+O+/2YoCvpQjSyMM7/rsM7tEF7/EED7vtRQ5u0MoIZBLuoiGYa8lubFIqnaF2eq3UZyrGCiUKomq5I4fUXMNRRldhnhxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983861; c=relaxed/simple;
	bh=vl9bPdAnhZOB7e2rN8a7bQ/OUcqdayO0Mnx+F9C5UVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBpzkgmAEKMZagl0ZYb4ge7spSPVf6jNM46IB9B/8Pd989XxngGVqow2w1yXkvhgAAcq4uNldgKKnoisWeqfAcUkkpiAk5YJXxLPOY6bMsd3o86sXPnX8Rd8FioPEKgpu5qhwEYArcifK/s85ooHXjaE5P3mY+/4iV44zJcS9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPSUDz8g; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774983860; x=1806519860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vl9bPdAnhZOB7e2rN8a7bQ/OUcqdayO0Mnx+F9C5UVE=;
  b=dPSUDz8gpbUl+njiYFq4wKJ7wPhxShlp9VvqUunMYPWlm98R+X2vk/rL
   ZZPYlUDPDbJ2t9LAys5Nu1fwn5DoB4PXY0zd+QJ/3dexulNZdsQdflZ1J
   5mBsmLHPa5/cGwjV0xHEpkqF2tHa/CEdkmEkvvZC9d2zBCWrzayX6up/g
   /16yJeROZoUHkArocQXQ3qu3xfRMasVW/xR7PnOBo2Y9YHLX/9UC63+Zj
   wZ6HJr0fzu8T26oszLfzbFsS27F8FuQUV0aRbGgWjbEbublhdvkFfIjNR
   ykT2Xw/HUtPrzBYHQU5qo/scuK82uiHJDwSn3SVz0cOPQypt1LX4PBooL
   Q==;
X-CSE-ConnectionGUID: xQePCVYPTq6wEnDy8w9jrg==
X-CSE-MsgGUID: LRz1/7uSQ5abtNZLfho0sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76070831"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76070831"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 12:04:19 -0700
X-CSE-ConnectionGUID: wSpzeWmCTYC99op37aHAhA==
X-CSE-MsgGUID: SCK12xPFRo2r1F1cB/xtbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="225626681"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 12:04:13 -0700
Date: Tue, 31 Mar 2026 22:04:10 +0300
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
Message-ID: <acwaqrSMXR36KqVR@ashevche-desk.local>
References: <20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com>
 <20260327-ad4692-multichannel-sar-adc-driver-v5-2-11f789de47b8@analog.com>
 <acZrthJYQX-h_9p5@ashevche-desk.local>
 <LV9PR03MB84143540CE505514E1CD84B4F752A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <CAHp75VcUCM8aeUpNaFEXnS+Cm08Mq5j+Qp2gYqWP9vCO+9CtQA@mail.gmail.com>
 <LV9PR03MB8414CB05EB794F6974584C2AF753A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <acuMxjX_rsfsJvMp@ashevche-desk.local>
 <LV9PR03MB841477521DF5AB809D0184FAF753A@LV9PR03MB8414.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV9PR03MB841477521DF5AB809D0184FAF753A@LV9PR03MB8414.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-8450-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A573A3705DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 05:05:32PM +0000, Sabau, Radu bogdan wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Tuesday, March 31, 2026 11:59 AM
> > On Tue, Mar 31, 2026 at 08:36:42AM +0000, Sabau, Radu bogdan wrote:
> > > > -----Original Message-----
> > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Sent: Monday, March 30, 2026 8:24 PM

...

> > > > > > > +#include <linux/bitfield.h>
> > > > > > > +#include <linux/bitops.h>
> > > > > > > +#include <linux/cleanup.h>
> > > > > > > +#include <linux/delay.h>
> > > > > > > +#include <linux/device.h>
> > > > > >
> > > > > > Hmm... Is it used? Or perhaps you need only
> > > > > > dev_printk.h
> > > > > > device/devres.h
> > > > > > ?
> > > >
> > > > > I have checked this out and it seems device.h doesn't actually need
> > > > > to be included anyway since spi.h directly includes device.h, and since
> > > > > this is a SPI driver that's never going away, it's covered. Will drop it!
> > > >
> > > > No, this is the wrong justification. IWYU principle is about exact
> > > > match between what is used and included in a file (module). spi.h is
> > > > not dev_*() provider and may not be considered for that.
> > > >
> > >
> > > You are right, my justification was incorrect. Under IWYU, relying on
> > > spi.h's transitive pull of device.h is not valid. However, I think device.h
> > > is still needed in this case since struct device is used directly in the code
> > > both as local variables and in the regmap callbacks.
> > 
> > Really? I can't see that.
> > (Hint: use of the data type and use of its pointer is a huge difference.)
> > 
> > > Also dev_err_probe() is called directly and lives in device.h.
> > 
> > No, as I started with my replies. The proper header that provides it is
> > dev_printk.h.
> 
> Yep, my bad... device.h can be removed and devres and dev_printk be
> used instead. Sorry for the confusion from my end, I thought I was
> looking at device.h, but was instead looking at dev_printk.h.

No problem. Headers in Linux kernel is a mess. Mostly historically,
maintainers' preferences and neglecting the foreseeing the future of
the dependency hell.


-- 
With Best Regards,
Andy Shevchenko



