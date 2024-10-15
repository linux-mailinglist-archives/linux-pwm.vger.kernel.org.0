Return-Path: <linux-pwm+bounces-3644-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAD699E541
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 13:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C322819E7
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 11:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946141E32AF;
	Tue, 15 Oct 2024 11:12:08 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41961D5AC8;
	Tue, 15 Oct 2024 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990728; cv=none; b=mqgRYt+vHgMF/By0zQdo3pJxAmG05Z5mg9jOMI2nyW4FJFBdj3rNn5DW6IdzsTYMYUEUHZpi2Vlb6I/cys+BmSajN0g7KRO12AhVSl1PDSBPVM9i/01WkUHHGDjWKN1QL5WA2iIgFw7xgalnUzwMJ5bmRowJ3qLyQf+pmQi7Xu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990728; c=relaxed/simple;
	bh=0Y13YaOF0ifXz9dAPlgHesxwsuYGyA8FSURb52R4BFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsVd87ZvqQf/Hoq50QQzA0gEnGtxXQ1NVOiC9Itt8hZ4wvfKZc5Y9b+jxHfbXJsEukkzRjIfDnLMK+k45ttivaGLWnRIzwuTzF9F/UVugoOdmEq3H+RBKuHzcZH44B+PMasR3Mj9sFXAFxfg6kCZtPrKrJmNpEJbLxEwaO0pL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: mdqjkey8RTKtkXDXlzRYvQ==
X-CSE-MsgGUID: 3iQotRwwQJqt3f21M/p2Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="38955412"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="38955412"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 04:12:07 -0700
X-CSE-ConnectionGUID: t089w9YdQdWUvW+++wB9+A==
X-CSE-MsgGUID: QoJIyq4ARCO4/Py/pbfc4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77871980"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 04:12:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t0fT4-00000003FFc-0cTt;
	Tue, 15 Oct 2024 14:11:58 +0300
Date: Tue, 15 Oct 2024 14:11:57 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: adc: ad4851: add ad485x driver
Message-ID: <Zw5N_fxdDKQxlPoj@smile.fi.intel.com>
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
 <20241014094154.9439-6-antoniu.miclaus@analog.com>
 <Zw0ZM0vQXJep3dFJ@smile.fi.intel.com>
 <20241014201515.463c7c07@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014201515.463c7c07@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 14, 2024 at 08:15:15PM +0100, Jonathan Cameron wrote:
> On Mon, 14 Oct 2024 16:14:27 +0300
> Andy Shevchenko <andy@kernel.org> wrote:
> > On Mon, Oct 14, 2024 at 12:40:40PM +0300, Antoniu Miclaus wrote:

...

> > > +config AD4851
> > > +	tristate "Analog Device AD4851 DAS Driver"
> > > +	depends on SPI
> > > +	select REGMAP_SPI
> > > +	select IIO_BACKEND
> > > +	help
> > > +	  Say yes here to build support for Analog Devices AD4851, AD4852,
> > > +	  AD4853, AD4854, AD4855, AD4856, AD4857, AD4858, AD4858I high speed
> > > +	  data acquisition system (DAS).  
> > 
> > I think I already commented on this... Anyway, it's much better to support when
> > this list is broke down on per device per line. In such a case it's less churn
> > if we need to remove or add an entry in the future.
> > 
> > > +	  To compile this driver as a module, choose M here: the module will be
> > > +	  called ad4851.  
> > 
> > Also, with all these devices to be supported why not ad485x as the name of
> > the driver? Is it a preference by the IIO subsystem?
> 
> Don't.  We've been bitten by too many cases of manufacturers noticing
> a hole in their part numbers and 'slotting' something unrelated in.
> So it just causes confusion.  Hence strong preference for any new code
> is pick a name from the list.  The wild card also implies restrictions
> that tend to break overtime when other part numbers outside the range
> are used.  Not using a wildcard keeps it consistently wrong so people
> get used to it :)

I see your point!

But shouldn't we have a formal criteria for choosing that one from the list?
I would go with "most featured device" as it may be aligned with all enabled
features that otherwise would be questionable / confusing for the chips that
do not support them or support in a limited manner.

-- 
With Best Regards,
Andy Shevchenko



