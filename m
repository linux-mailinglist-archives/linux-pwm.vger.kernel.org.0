Return-Path: <linux-pwm+bounces-8843-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPyxB0Zq/WkndwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8843-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 08 May 2026 06:44:54 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 075F14F1B63
	for <lists+linux-pwm@lfdr.de>; Fri, 08 May 2026 06:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61B9D300E2AD
	for <lists+linux-pwm@lfdr.de>; Fri,  8 May 2026 04:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69E13176EF;
	Fri,  8 May 2026 04:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K02TKGZt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FA624503B;
	Fri,  8 May 2026 04:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778215489; cv=none; b=cFR49XOkYvx0QieiKn28i2vnxd+nLz3f/lQIHmq9r/opIaXuQ7GZzZ+jefXQtA9bKLxdOWOfd6oPHHA+uRyiktbfyfeChkBM9v38QNftYyQgayLhgK5ukQwoScx65KOq8ofUZYdA6KPlOeYT3RwvU4pJ7ikn1tc18FkK3c+fy/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778215489; c=relaxed/simple;
	bh=WVcZmcrMUcQSLgmbj20gn3L9v+Hk/LfU1kizlZqcX4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLbMP5Yv5B5mDTT8+7NMHc1LsR5wynhjKP6+q7flc8dLn/7LCzdwY9od9+lGpD6RFxlBxkhoK0zvv1r7GFg1RZu4hFB950GoMen8ECocB8P3J8Sxg1CDi6IU6MLa8Z5i3q/G3I/3rMOP69qCkuX9UrZqTrJt+HwAPe8gElDpFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K02TKGZt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778215488; x=1809751488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WVcZmcrMUcQSLgmbj20gn3L9v+Hk/LfU1kizlZqcX4s=;
  b=K02TKGZth7UhOWWBc3o0arQ6/ncnd4HYIHMM5AZ2nVhs2jUATXJ+M2zw
   znDcM0o3Nq+iE7JJMjyUrfs07frt8BlD4lqB4qHq4VOF7Th+Kevs7Rqux
   yhQZVoZDkXPxeeUu9zsudMknMq+7+oXPRkxeRaqPGxPVrasRQlciu6ztZ
   6IiM2PI8MSXzdrOZ10C9zokdjDnPbxGeB8ZRwpEIVUECt6gdegR/VFVac
   Ryk+UM+qsg40jGudXvklcOdWlTjkC5SokjoMyFvETKFifOuTx1XPACT3z
   wSrBaO3azuNUZh9BUnNNd80gtBw2xjSDBKYUQ3/FWbuOuAeUh6LSun5nm
   Q==;
X-CSE-ConnectionGUID: VPTQXlkGT9yIvieho3H3gg==
X-CSE-MsgGUID: eJG3IhviQt6y5UoV8Dmjvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90558477"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="90558477"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 21:44:47 -0700
X-CSE-ConnectionGUID: qEVbJLo2RyKB63FiqhsKMw==
X-CSE-MsgGUID: ua4RiqMJQ1O91HqbJZ0jlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="232309852"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 21:44:42 -0700
Date: Fri, 8 May 2026 07:44:39 +0300
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
Subject: Re: [PATCH v9 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <af1qN1Bvio1v6TKG@ashevche-desk.local>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
 <20260430-ad4692-multichannel-sar-adc-driver-v9-2-33e439e4fb87@analog.com>
 <LV9PR03MB841460307B0CF4C6F267A631F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
 <20260507151549.61e4e8fb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507151549.61e4e8fb@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 075F14F1B63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-8843-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,analog.com:email,ashevche-desk.local:mid]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 03:15:49PM +0100, Jonathan Cameron wrote:
> On Thu, 7 May 2026 09:26:00 +0000
> "Sabau, Radu bogdan" <Radu.Sabau@analog.com> wrote:

...

> > > +	st->info = spi_get_device_match_data(spi);  
> > 
> > "Is it possible for st->info to be NULL here?
> > If the driver is manually bound to a device with a non-matching name using
> > the sysfs bind interface in combination with driver_override,
> > spi_get_device_match_data() could return NULL, which would cause a NULL
> > pointer dereference later in the probe sequence."
> > 
> > Agreed, will add the NULL check with -ENODEV immediately after
> > spi_get_device_match_data().
> 
> Andy, you seeing this one?  Looks like we are putting these checks back in again.
> Whilst anyone forcing a bind like this is onto a looser anyway we shouldn't
> crash due to a null dereference.

We should find a way how to disable that combination from the start. The driver
makes no sense to be instantiated from user space. Actually most of the drivers
nowadays should not be bound to the devices without driver data.


-- 
With Best Regards,
Andy Shevchenko



