Return-Path: <linux-pwm+bounces-8282-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMJXEVktuGnhZgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8282-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 17:18:33 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEC629D345
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 17:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D11AA30027C4
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C58E3328E6;
	Mon, 16 Mar 2026 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXBToig9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99B332610;
	Mon, 16 Mar 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677647; cv=none; b=ej2cMRBrHMfz79wGjPDweZK/XRZxkIw2ZZNHm3gQUuUR7H4E71RwzDD7nx+x+oh9NH724ajG/Ng1k/oJUYneYtx9wfOYyaiMmwSbLbwrYoy6a2AQrnCVqsoNlZp6iXe0Tb7iAF9W2XR+kp1P7iMhTSrxL1YYGouaR9m7Ww3q2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677647; c=relaxed/simple;
	bh=L2hOlbVbeBnX2zvVvlt7wm3QiGVXO5V89NnZSJckvUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfL8LVZ+0zaRHRj475s+zgxeL4xyLVxUeyZfDHgDrCM64FekV/cLxaFu66ykVkLb6JzjTDZuiceNRqTLmeMU+q94AXbb+Pj/3Coh/SY3C8BnAGtyOPBhI8kBHNtqBJgprxxWEMEkapbY3m1qyNlhq8XNE0aTy0rVxUi7SY1OSPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXBToig9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773677645; x=1805213645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L2hOlbVbeBnX2zvVvlt7wm3QiGVXO5V89NnZSJckvUU=;
  b=YXBToig9MIoe8vQ6gzxQ9SV0KDg6jIXfnHtT3NcbqbINKeVe/0rirzmn
   hkeQ85G/IHYbfeA4zE+sjzTlQmEFoSnIljex4H91i/LO1hrnV6/IfSO6V
   o/m2L/TMPDsAs6TnjXUc7lhh62kr4s7uYck1kLo0hslj6Fj2oGsAgKr7n
   mFTAoLzH1cQZwDJ/iWghH2gGjE5gDq3c5Tlx00GIf03Znc+70t5ToSkgn
   5VnBozFe/vauBxLHv6xS0qqJPToGl1hDz1eIWgb7la0XLehCu91EZQnry
   L152J77M/1xGoYJqZnDRoyLzlyhOCfLQ2UhizgyG4yMjgzhFhNiMCCyjC
   g==;
X-CSE-ConnectionGUID: aF4DRiS0S8yxvO+Ilwlh4w==
X-CSE-MsgGUID: xEI9vGG0TRemxVf1hJtRiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73718889"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="73718889"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:14:04 -0700
X-CSE-ConnectionGUID: hAHqELnXQxS2nIftdBLOYg==
X-CSE-MsgGUID: iD1kbxRDTIqwbgm4gzrFNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="216462797"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:13:59 -0700
Date: Mon, 16 Mar 2026 18:13:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
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
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <abgsRcTfhELaxjLz@ashevche-desk.local>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
 <abPtv0Y_QWYoMuAO@ashevche-desk.local>
 <LV9PR03MB84148A9A0A7F6544CF370B7DF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <e33b0096-c7b6-45e5-a9d1-8da11714ac8e@baylibre.com>
 <LV9PR03MB84141484B1472E01578A2243F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV9PR03MB84141484B1472E01578A2243F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8282-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9AEC629D345
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 03:57:53PM +0000, Sabau, Radu bogdan wrote:
> > From: David Lechner <dlechner@baylibre.com>
> > Sent: Monday, March 16, 2026 5:51 PM
> > On 3/16/26 10:29 AM, Sabau, Radu bogdan wrote:
> > >> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > >> Sent: Friday, March 13, 2026 12:58 PM
> > >> To: Sabau, Radu bogdan <Radu.Sabau@analog.com>

...

> > >>> +	u32 acc_mask[2] = { mask & 0xFF, mask >> 8 };
> > >>
> > >> This looks quite wrong. Is it for sure like two 32-bit stances per each mask
> > >> byte? If not, this should be __le16 acc_mask = cpu_to_le16(~BIT(...));
> > >>
> > >
> > > Hi Andy,
> > >
> > > Each acc_mask has its own register, therefore the u32 acc_mask[2] is
> > > intentional - since the regmap is configured with val_bits=32 - the 4-byte
> > > stride matches what regmap reads. However, I understand how this
> > > can be confusing for anyone reading the code, therefore I propose
> > > two ways for this :
> > >
> > > 1. Keep regmap_bulk_write and add a comment above acc_mask explaining
> > > why u32 is used, although these register values are 8 bits.
> > > 2. Switch to regmap_multi_reg_write, which takes explicit (reg, value) pairs
> > > and sidesteps the ambiguity entirely.
> > >
> > > Do you have a preference?
> > 
> > Since we already have a custom read/write functions to handle different
> > register sizes and the chip can read more than one consecutive register
> > at once, can we just call this a single register and add a special case
> > to ad4691_reg_read/write() to handle it? Then we can just do a regular
> > regmap_read/write() functions to access it as a single 16-bit value.
> 
> This sounds even better! I will have this in the next version!

I also second David's suggestion, please go for it.

-- 
With Best Regards,
Andy Shevchenko



