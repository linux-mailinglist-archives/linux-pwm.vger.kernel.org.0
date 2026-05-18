Return-Path: <linux-pwm+bounces-8981-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFpyCO1ZC2ovGAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8981-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 20:26:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C15F85723AC
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 20:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2FF830208A9
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 18:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BA23890F8;
	Mon, 18 May 2026 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2T0DUHL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC238237D;
	Mon, 18 May 2026 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128780; cv=none; b=K4qKyOo+CdkeUWENeTkd4r0lLziTuYsFg+M55ficJ9WjVLE0P6nUCQviCcPdpzoHfo5JCP046pn1YltIcpN4f1FgKtpiXxm3O2s8W9lx66St9syzvZt4LhmeUDrDa8tB2I44L5+MNe9U5Vm7Op4L7HHzp3JimzOcWjdkhYCE0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128780; c=relaxed/simple;
	bh=pbXYLQ1mwct3+ssZlrWJpr6OzTUkZbnMsQ/G5sb/T3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD7/43eDuGOoEq+T35lC4QD/Y67eyRbJR31nR957MQEP33uzEiMhdd1Os9xCmMCY3IwNa6mJtH6kuzid6b1V1V0QMwYGzZ6Tal+6X1pqp/x9GUTkgvMDhlVWjPAxjcz1/VE5QjG9NyaeTs7t4nCrxNpTKBXlgY277v65NDN6foI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2T0DUHL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779128779; x=1810664779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pbXYLQ1mwct3+ssZlrWJpr6OzTUkZbnMsQ/G5sb/T3M=;
  b=A2T0DUHLXSAZYQw2jRiF+UoKrVoD0sUG+NgJtbnOEQb18t2vQsGxLopw
   YUxKWtYH8sxVruSa43cAl3BbpnZ04oBxA4nDyeKXLSbRW1afM6G4WSkr4
   ZJObrW+BGc0Icc6onS9dZJE4WOU0QPpHzD8wHPszfE+/amcnq74W8dnKi
   ojxajFEfbqExWClaWwZqO4rARkYfU4V+fyjqBpaVjrQhtM0PqYc19qSsI
   3nLaQA3OGxSSKCqC+ljONKYwvx39XAdeaOkXLxRLKrsuiGC3BZF3e3Dub
   /9Ft5tR0johwFWGFLRiCCXov2JNgAOk0WOR15314fzbbobb8vfam97s1H
   A==;
X-CSE-ConnectionGUID: 9qriItO/ScWlODNBpfRg1Q==
X-CSE-MsgGUID: +k3VPqE9SVOFJAvzB/QnXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="90575555"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="90575555"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 11:26:18 -0700
X-CSE-ConnectionGUID: O0zap/NiRba3AYD16GFVrA==
X-CSE-MsgGUID: e9aNJkI4TGO68gsQIjE1Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="239764455"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 11:26:12 -0700
Date: Mon, 18 May 2026 21:26:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
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
Subject: Re: [PATCH v11 4/6] iio: adc: ad4691: add SPI offload support
Message-ID: <agtZwbeVeZdnlXTI@ashevche-desk.local>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
 <20260515-ad4692-multichannel-sar-adc-driver-v11-4-eab27d852ac2@analog.com>
 <80f61c0b-1f36-4fee-9f76-b93f63b87abe@baylibre.com>
 <LV9PR03MB841418AEF0059E802F7A69B2F7032@LV9PR03MB8414.namprd03.prod.outlook.com>
 <60d66897-41cc-4f3f-afd2-64e49f0bb55e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d66897-41cc-4f3f-afd2-64e49f0bb55e@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-8981-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,baylibre.com:email]
X-Rspamd-Queue-Id: C15F85723AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 10:16:38AM -0500, David Lechner wrote:
> On 5/18/26 10:14 AM, Sabau, Radu bogdan wrote:
> >> -----Original Message-----
> >> From: David Lechner <dlechner@baylibre.com>
> >> Sent: Saturday, May 16, 2026 8:53 PM

...

> >>> +	if (st->manual_mode && st->offload)
> >>> +		return sysfs_emit(buf, "%llu\n", READ_ONCE(st->offload-
> >>> trigger_hz));
> >>
> >> Why do we need READ_ONCE?
> > 
> > trigger_hz is u64 and if the target is 32-bit, a 64-bit access compiles to two 32-bit
> > instructions, so show() reading it without a lock and store() writing it concurrently
> > can produce a torn value at the compiler level. READ_ONCE/WRITE_ONCE suppress
> > the compiler transformations that would allow that splitting or caching. We could
> > have st->lock in show() instead, but that felt heavier than necessary for a single
> > scalar where a transiently stale-but-whole read is fine.
> 
> I would go with the mutex. It will be easier for people to understand.

But why? READ_ONCE() here is exactly enough. We do not care about
serialisation, we care only about integrity. With mutex it will confuse
(some) people more, e.g., me. Because in that case I would think about
some specific access to it that may happen. Yes, I saw many times the show
functions that do mutex and then print the result when mutex is not held
anymore, but for simple cases like here, mutex is overkill. Interestingly
that using guard()() inside show makes the mentioned functions to print
(almost) latest value of the variable in question. It narrows window down
as printing will go inside critical section.

-- 
With Best Regards,
Andy Shevchenko



