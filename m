Return-Path: <linux-pwm+bounces-8205-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INlyOU3mqmkTYAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8205-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 15:35:57 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF1F222C3B
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 15:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 826D730512AA
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2026 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6A534A766;
	Fri,  6 Mar 2026 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/VOkmsT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E3F271A94;
	Fri,  6 Mar 2026 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807592; cv=none; b=MhiJcfTERLv/RksU/yRBsY91kIfOYTA4uag2QP+XDIbJeIBfMPnZM5YvLoh7aDCMe0pEOOfvvrRfreXcsexgZe4LrrcALvJZF9VqijeNTw9GlLPOOZj3UY6BfF73v5MyRLV1mudWo+mA48ffC1CQnFsS2G/2abUs2ggaH0lGu/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807592; c=relaxed/simple;
	bh=6bpb8U4o1pj6JShYNq2ftR3yy8sMU1tPrbz8tpbfjDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8pmTt2tljy6MtgyryvXPs3lTnqzfueD0nAbp0Pdtt/WreQGrvobbdoReGtMNyMuJT7ygFzXQHDf/b/FtwXH3u4gDfX+OQUyguFPKEuZzyUdMl6+i9A7p1MwLbvXz9hGNfUmbMDGW01UjuDFxJgekMq4ytng3FmvBaCyJ3477+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/VOkmsT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772807591; x=1804343591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6bpb8U4o1pj6JShYNq2ftR3yy8sMU1tPrbz8tpbfjDw=;
  b=H/VOkmsTRzdgOWf0yJoj0dA1/DLqOAE9fOSZuZu4qHOf5jfDfh7K3/b7
   DYiYLUg3dLyTCowv15f4dj0+fIdG0dJgrj67DNSI/LbnPNhxYoDzbo6Rq
   ROUIDkjTzmiCc1sq7rl3KA9cYysZZY7Z/XNAjJnNn9xXAmjBccFVlhB5J
   ihmZYhvgTZDuVCCQRpDne5EX2n+qdytE2I2NLnFSzPU1TLV4TLzyoZCfO
   n6sJCl0I6ZB+aucZGBWAXXDBTKEErMCPwSqqlTZ4we4XKvqVmiPysVv9+
   1jK/L3lgY7kUxXXWFlY8tXiW3nEIo0IX5k6H4zcsq1HRIKMBRrM2tzQSM
   A==;
X-CSE-ConnectionGUID: 5DrlXQoLT9+m15QXptD/aw==
X-CSE-MsgGUID: GThIlJLjSW+jLtF+jFoZOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="84627349"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="84627349"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:33:09 -0800
X-CSE-ConnectionGUID: Ky+8fPOMQrC10urVEQ+gjg==
X-CSE-MsgGUID: pUyz7LejTYaWQilWDsiUNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="223510755"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:33:04 -0800
Date: Fri, 6 Mar 2026 16:33:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
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
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 0/4] iio: adc: ad4691: add driver for AD4691 multichannel
 SAR ADC family
Message-ID: <aarlnZUR984DH98V@ashevche-desk.local>
References: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
 <aarDJicasFlUnOkx@ashevche-desk.local>
 <LV9PR03MB84149EAE41DE73C61B81091FF77AA@LV9PR03MB8414.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV9PR03MB84149EAE41DE73C61B81091FF77AA@LV9PR03MB8414.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 4FF1F222C3B
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-8205-lists,linux-pwm=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ashevche-desk.local:mid]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 12:39:30PM +0000, Sabau, Radu bogdan wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Friday, March 6, 2026 2:06 PM
> > On Thu, Mar 05, 2026 at 02:23:26PM +0200, Radu Sabau via B4 Relay wrote:

...

> > This cover letter doesn't answer to the first important question: Why a brand
> > new driver? Do your homework and check what is already in the kernel and
> > explain in the next version why no other existing driver can be reused (refactored).
> 
> Indeed at first glance I thought about adding support for these parts in the existing
> AD4965 driver. The registers indeed are a bit similar between them, but the
> channel specific registers are completely different, and more than this the
> conversion modes are different.
> With this being said, I will try and make things more clear by answering this
> question in the cover letter of the next patch. Thank you for pointing this out.

Good, the summary of the above will fulfil the request, thanks.

-- 
With Best Regards,
Andy Shevchenko



