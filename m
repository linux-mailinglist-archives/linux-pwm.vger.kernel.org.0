Return-Path: <linux-pwm+bounces-3636-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F22399C93C
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 13:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A550D1C21C61
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 11:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C49719CC10;
	Mon, 14 Oct 2024 11:45:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35A5158A19;
	Mon, 14 Oct 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906343; cv=none; b=p117JZPsWFq7iC9MvdiKgys8xz97AHKCh6w8gLcXrv2pB0GzCUtgKYED8MGbrBjL9/4O69TCue0Ahoqm6/TjChEZDx3P4SQYEMrluplWaYhYDLsjTfk/QGGs1VWYKHEo6HQF1nvDNK7wJ/dNDwlIyPh+xvyIoC2UcJxEkbqDG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906343; c=relaxed/simple;
	bh=kvBg45epIZBluaGPE8QC6UH9A/pJOQir32Ks9euA3nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0h6bnqdtnLf3QScVFGR9Hx4mZOWxrD88krHXPpqBQcUsPNLIrXyZGKOL7UGp2OJyZSPkIYYkCSgLZeZJWFO5HmH+A3RFxN8ACF19iwS7c6xVSj1jtgNW0NycACt4kVRut8fX6G9osdQQSUtRuoKGZ6EN5C0KCtU1cf4uq6XFig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: hLIAoa5kTRCWVwVH7PmeNw==
X-CSE-MsgGUID: eXlziHwHRxS9kGtWYELmDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39371261"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39371261"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 04:45:42 -0700
X-CSE-ConnectionGUID: I6LRMQnuTia7F1G6zsgNJQ==
X-CSE-MsgGUID: y1/A7EKwS36Pokn0s+H9Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82326571"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 04:45:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t0JW1-00000002sv1-1GM4;
	Mon, 14 Oct 2024 14:45:33 +0300
Date: Mon, 14 Oct 2024 14:45:33 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 4/6] iio: adc: adi-axi-adc: set data format
Message-ID: <Zw0EXXDJPjWtLCIr@smile.fi.intel.com>
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
 <20241014094154.9439-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014094154.9439-4-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 14, 2024 at 12:40:38PM +0300, Antoniu Miclaus wrote:
> Add support for selecting the data format within the AXI ADC ip.

IP

...

>  #define ADI_AXI_ADC_REG_CTRL			0x0044
>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>  
> +#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> +#define ADI_AXI_ADC_CNTRL_3_CUSTOM_CONTROL_MSK	GENMASK(7, 0)

And here is no (additional) indentation at all and no proper prefix...
Can you be consistent (to some extent) with the existing code? Or
update it to be consistent all over the places.

>  #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
>  #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)

...

> +static int axi_adc_data_size_set(struct iio_backend *back,
> +				 ssize_t size)

This is perfectly one line. We wrap at 80. I believe your text editor
configuration has to be adjusted for this project.

-- 
With Best Regards,
Andy Shevchenko



