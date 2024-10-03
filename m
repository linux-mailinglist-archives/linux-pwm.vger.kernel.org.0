Return-Path: <linux-pwm+bounces-3444-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEB898ED1B
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 12:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E676228345C
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1A314EC4E;
	Thu,  3 Oct 2024 10:36:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B21814E2CC;
	Thu,  3 Oct 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727951770; cv=none; b=OOnhKaS5sI+RKf1Nak3uSX+Dl56BftYf7n0MH2Xqd0dLTpi8SJLPYb6FtUVmk2d0DbTkD97H73tjLkPtPT56vlpecILETI8TO4qqOhSimLvTMYwThgms+TjzST4kzTz6A7WzFXuOr2VVGxUMkmNEe9n7AJsVxjaHpHmSkhyTW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727951770; c=relaxed/simple;
	bh=KL/7NaUf80px9j5kVh+PueqYs3ianbam9jVZoCRkYVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La2QeH/7K7ObDTBnGl2l2OSyTVB3WSidkXbqaIEV9I8nz1nU8pj4rnZLrWslVsHG1KQtqs7c08sWHGgrKJrO2lwHNOnw5U+9OtNnl/ClXuEzkIJGw5WsFV5fbQ1wxa7/W5Q4KdNZyNEBlERil3t0dW091Da0SAvnATQ+ND6Uho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 5twSyTV4Rm+h5S0mZStl0g==
X-CSE-MsgGUID: OkYm9Q10Siec09eEGiqfbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="44667931"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="44667931"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 03:36:09 -0700
X-CSE-ConnectionGUID: hC5HWsCOTkWpI/QYqeynEg==
X-CSE-MsgGUID: K5s4KqXlSD6RMuVnLR0GaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="79155394"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 03:36:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1swJBg-0000000G5iz-0tcX;
	Thu, 03 Oct 2024 13:36:00 +0300
Date: Thu, 3 Oct 2024 13:35:59 +0300
From: Andy Shevchenko <andy@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	"Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	"Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
	"Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Message-ID: <Zv5zj0PFhxoeBUXQ@smile.fi.intel.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
 <20240923101206.3753-7-antoniu.miclaus@analog.com>
 <20240928184722.314b329b@jic23-huawei>
 <CY4PR03MB33991208029C4877760B528D9B772@CY4PR03MB3399.namprd03.prod.outlook.com>
 <Zvvw7ah4wGsl2vjw@smile.fi.intel.com>
 <CY4PR03MB3399D90F2A3C7AE3505B60A29B772@CY4PR03MB3399.namprd03.prod.outlook.com>
 <4ee001d2-67d0-45ab-ae62-ce5b8dd7553e@baylibre.com>
 <CY4PR03MB3399D9B9C5B4952E7A7F40F39B712@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR03MB3399D9B9C5B4952E7A7F40F39B712@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 03, 2024 at 10:14:57AM +0000, Miclaus, Antoniu wrote:
> > On 10/1/24 8:51 AM, Miclaus, Antoniu wrote:
> > >>> Regarding the bulk writes/reads, the msb/mid/lsb registers need to be
> > >>> read/write in a specific order and the addresses are not incremental,
> > >>
> > >> We have _noinc() variants of regmap accessors.
> > > [Miclaus, Antoniu]
> > > I think _noinc() functions read from the same register address so it doesn't
> > > apply.
> > > I am reading values from multiple register addresses that are not reg_addr,
> > > reg_addr+1, reg_addr+2.
> > 
> > I'm confused by the statement that the registers are not incremental.
> > 
> > For example, this patch defines...
> > 
> > +#define AD485X_REG_CHX_OFFSET_LSB(ch)
> > 	AD485X_REG_CHX_OFFSET(ch)
> > +#define AD485X_REG_CHX_OFFSET_MID(ch)
> > 	(AD485X_REG_CHX_OFFSET_LSB(ch) + 0x01)
> > +#define AD485X_REG_CHX_OFFSET_MSB(ch)
> > 	(AD485X_REG_CHX_OFFSET_MID(ch) + 0x01)
> > 
> > This looks exactly like reg_addr, reg_addr+1, reg_addr+2 to me.
> Yes you are right. Although I tested with hardware and it seems that the registers
> are not properly written when using bulk operations. My guess is that holding CS low during
> the entire transaction might be a possible issue. Any suggestions are appreciated.

Okay, so each byte has to be written as a separate SPI transfer?
I believe we have already examples of the drivers for such a hardware
in the Linux kernel, but I can't throw any example form top of my head.

> > >>> so I am not sure how the bulk functions fit. On this matter, we will need
> > >>> unsigned int (not u8) to store the values read via regmap_read, and in this
> > >>> case we will need extra casts and assignments to use get_unaligned.

-- 
With Best Regards,
Andy Shevchenko



