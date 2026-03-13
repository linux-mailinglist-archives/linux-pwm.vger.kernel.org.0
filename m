Return-Path: <linux-pwm+bounces-8257-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBPpGOAhtGnahgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8257-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 15:40:32 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CDD2852AB
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 15:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 736083071A7E
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155023A3E70;
	Fri, 13 Mar 2026 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGbAEev7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA95372B22;
	Fri, 13 Mar 2026 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412830; cv=none; b=bX8P1jMpp5BfTKzfbsyJFoY969mww3ljUolwYS2v3pDkR4+kjTQM101Px7CvhL17wyMzWmz7EF8Q2Z7ym4s2ZzD+z1INYgmABId67PCf9BNo2bh7e3RqppVUokZrYCqcHc0+kjDurjESZR2oMWaeKolV01wrpQy3apjG5PZEN7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412830; c=relaxed/simple;
	bh=d23l5QfZILL92TANqDOqm0WjgNLDASSxYAanpTwaEgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbYjLy1lDxd/97UyVqHFz6k4M62X59Z8i8awDxEL8pUDYsCDkKPD9WYBhq/CDPmBmX5/7xHzIduzXmjbGyg+uZGKWC4QkbV7IvFrvzS3+xtb2DDLGmf9RAod64hh6uiv4wuf5LJKRPrqH/7XQrWXt4GvXGe1E7tpXlp3q/0RY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGbAEev7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773412828; x=1804948828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d23l5QfZILL92TANqDOqm0WjgNLDASSxYAanpTwaEgE=;
  b=EGbAEev7miV1BJjqzfAtGilgzJ6wbn3TF37tNjvaFhIAE32cbq5x12Pa
   puSuGkBMEm2Xsi1eHALpoLF6KRug/ENzAZw8ncKixsDXGBrjVu0RC5HRd
   GadDxOgefoumjJfYQqe6SfNhCuL0ZCrajzy/Y7n8E6/DXDFE3pD5Wv2b9
   zueXNB82dQvj/EOxIkRHyXTo5Cr+7PvFUSGEKeE7ooE48BPfbQDh2yMes
   bFKEG7hIL/XrF6waGg3vXpoYV8mdeBCF/rZKaRjG6YfKg4CsWezbRru+z
   XSynfdtNys+nfuUyKf7wOOtHnxrrRKPZd6SzD/m3ZpcdU9ygDzE5eBDMx
   g==;
X-CSE-ConnectionGUID: G/dvZH0LQFaussNxKmw1wA==
X-CSE-MsgGUID: Uqvw0KZ3Tu+wvuhPD66L3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="62090732"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="62090732"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:40:28 -0700
X-CSE-ConnectionGUID: k7P44SedR9iseEQORDQ+MA==
X-CSE-MsgGUID: fZ+VfvuWSh6RDMwVkZXiOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="217597282"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:40:23 -0700
Date: Fri, 13 Mar 2026 16:40:21 +0200
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] iio: adc: ad4691: add triggered buffer support
Message-ID: <abQh1Y5_oGyvIxwT@ashevche-desk.local>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-3-b4d14d81a181@analog.com>
 <abPxR0TVa70sMg38@ashevche-desk.local>
 <LV9PR03MB841415AA5DB9FFB714710CC3F745A@LV9PR03MB8414.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV9PR03MB841415AA5DB9FFB714710CC3F745A@LV9PR03MB8414.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-8257-lists,linux-pwm=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: D5CDD2852AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 12:09:55PM +0000, Sabau, Radu bogdan wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Friday, March 13, 2026 11:13 AM
> > On Fri, Mar 13, 2026 at 12:07:27PM +0200, Radu Sabau via B4 Relay wrote:

...

> > > -#define AD4691_ACC_COUNT_VAL			0x3F
> > > +#define AD4691_ACC_COUNT_VAL			0x01
> > 
> > No ping-pong, and actually this was not used at all. So, make sure you add
> > constants when they are really started being used.
> 
> This value is being used in the buffer_postenable in order to make
> sure we don't encounter oversampling, since Manual Mode doesn't
> oversample, and per Jonathan's review, there is no reason to support
> both oversampled and raw readings at the same time.

Yes, but it wasn't used before this patch.

...

> > > +static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
> > > +					 struct ad4691_state *st)
> > > +{
> > > +	struct device *dev = regmap_get_device(st->regmap);
> > > +	struct spi_device *spi = to_spi_device(dev);
> > > +	int irq, ret;
> > > +
> > > +	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> > > +					  indio_dev->name,
> > > +					  iio_device_id(indio_dev));
> > 
> > It seems you ignored some of my comments. Please go back and read carefully
> > what I commented on previous version of the series.
> 
> I am very sorry for this. I may have misunderstood the comments, and thus
> seem like I ignored them, but this wasn't my intention at all.

When in such a situation, ask! A request is free and acceptable.

> If you refer to the trigger_alloc comment, I did talk to my senior colleagues
> and they referred to the fact -ENOMEM return should have been enough,
> but perhaps this was wrong too. Could you please clarify?

I'm talking about the room of the previous lines

	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
					  iio_device_id(indio_dev));

fits 80 limit, for example. OTOH this is less logical, perhaps your variant
is okay.

...

> Radu

When answering, remove the context you are agree with and not going to discuss.
I had to drop over 200 lines just "for fun" (no).

-- 
With Best Regards,
Andy Shevchenko



