Return-Path: <linux-pwm+bounces-8787-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDbWApwF+mkEIgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8787-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 16:58:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6464CFD34
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 16:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFB3230309BD
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4C6480956;
	Tue,  5 May 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dkw1ZIEJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC7D282F13;
	Tue,  5 May 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993112; cv=none; b=CsI2PqDGoVJoQq5umTEtPnJE/JrEQDHGA286NCR04EalYOXIHfuKhja1e0fw26/XqLbZ/1yrBhvClalyuesvm7qD+KSVqc7pW0iGDvSRjJeSclWtwQyEIdTSANEAPPDcRprIEXMSku00ISwmkHnGvm2glhbxgLnWs3qKBBQjQoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993112; c=relaxed/simple;
	bh=DfZvQYnkoBGwZW0oxqpa5wA3Pebxa21gm3r1S7fvjC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=draplaDwA5rfUM4bI1qCNMrjbIERX5um6T1moyU4F5Ls6CQhPk4gRwY5aUWNC1s6wPclc7DClypztPZ81bSyEb5nY0z3Gr1KRgnZ4GnGl0vSi6ybHw/fSodm5EMT+5vGSGS++Y/IOg2ELznGLIlTztmh++L98OEZ/lPjNtgDOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dkw1ZIEJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777993111; x=1809529111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DfZvQYnkoBGwZW0oxqpa5wA3Pebxa21gm3r1S7fvjC8=;
  b=Dkw1ZIEJnkJpFoICJJSX8Gl7V9qu9IAbeK3GiozuT7YQ7IB/l1hjdl5S
   xq1m13XVO+/PxWoICO18E6Si7EVJWXz8Khk/QXwwJGgsU/NKhRTKq+R4n
   t/sXPldjNNebTqa4aRqfXqS/2UryA6ha1l1r5PEXEicXXuEBNvj/K4Z/g
   8EGND/+R06jDzjPH7RVapvMj+I9KBv+iMKJCz8IxwKTkPP/U4wKapFoYo
   YbgaNBtadRPPUwm42go7UOstwFXrunAzT9XjINswnmcz/nBmn508SKCfJ
   GML3yTCNYE2bkIQn5MO/r3P0S1HNoj7jSSozavdiD4gOzaMwd/aPUDPEQ
   g==;
X-CSE-ConnectionGUID: 1QL8LN1SRqCp2/N8yEjsnA==
X-CSE-MsgGUID: hWWwHhm2Rv6SlVbGHbW2PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78856949"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78856949"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 07:58:29 -0700
X-CSE-ConnectionGUID: LyHmRn2YRpGgbsvZ+NgLJg==
X-CSE-MsgGUID: R0Ev+5A8QOCgmDFK7bD/VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259183629"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 07:58:23 -0700
Date: Tue, 5 May 2026 17:58:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
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
Subject: Re: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <afoFjaUBcGXeuEzH@ashevche-desk.local>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
 <20260430-ad4692-multichannel-sar-adc-driver-v9-3-33e439e4fb87@analog.com>
 <afhReLCsEdaEOT_H@ashevche-desk.local>
 <LV9PR03MB841441B282275F8F36FD12C1F7312@LV9PR03MB8414.namprd03.prod.outlook.com>
 <20260505142640.49cde0ca@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505142640.49cde0ca@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 6B6464CFD34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-8787-lists,linux-pwm=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 02:26:40PM +0100, Jonathan Cameron wrote:

...

> > > > +	for (i = 0; i < ARRAY_SIZE(ad4691_gp_names); i++) {
> > > > +		irq = fwnode_irq_get_byname(dev_fwnode(dev),
> > > > +					    ad4691_gp_names[i]);
> > > > +		if (irq > 0)
> > > > +			break;  
> > > 
> > > This is problematic in case the above returns EPROBE_DEFER. Can you confirm
> > > it
> > > may not ever happen? (Note, I don't know the answer.)
> > 
> > You are right, thanks for this!
> I'm missing something. Why is that a problem?  Driver will return
> the error and a dev_err_probe() is used so it won't print anything.
> So probe will fail which is exactly what we want.

If there are two IRQs and the first one is probe deferred and second returns
an error, we return that error instead of the deferral probe.

May be I missed something, but I have no idea how in this case it may return
the first error code in such a case.

-- 
With Best Regards,
Andy Shevchenko



