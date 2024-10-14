Return-Path: <linux-pwm+bounces-3635-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E899C928
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 13:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802931C2196D
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E6F19B3FF;
	Mon, 14 Oct 2024 11:42:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF614A4DD;
	Mon, 14 Oct 2024 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906151; cv=none; b=NTKM2RuEjEzOCeuPO2HiZL9XqqsRQ3aBp1/VKdQ0IMHIn3hKZo4rGBJMoYiNcfOTJBL8VbFZUx5SxDPngOybLvuHYYFCo3wo5c6pwtSbT+XOv2UWM6tGapqeuLaqvnyyVVpcHOaNkzE89wj7bHU+V1tc0axn0Zbryk1Qe7lMy5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906151; c=relaxed/simple;
	bh=l5MYO66/WMMI45LSa9nTZsuDWnmoRvXQvjhOQaTwG00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWVkBzpsbsQnbL/IbiIYwW62haqbXcCMRkiUkf1/9l3upyqNjIG22+i3heUYDyd/e8dc873wcD+kwNDXpDUP0SZ9b0EW0jRJ/l4CJKJ8+m4Jg1yqIemLqNsDeSYXqQhjymQa+q4FQtfIRlAh4vZZD0PJFo9tiHgiHUgs8x0OqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: HHN4KzVgTv22IDNJ1x7C0A==
X-CSE-MsgGUID: 91uInNCVTgOSxG6qnEfQZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="32047315"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="32047315"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 04:42:30 -0700
X-CSE-ConnectionGUID: 2grNElgURSCTH1Y+GT/8ZA==
X-CSE-MsgGUID: kuJeZS/8RwCYfRp33I4/+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="81539575"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 04:42:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t0JSv-00000002srd-2pma;
	Mon, 14 Oct 2024 14:42:21 +0300
Date: Mon, 14 Oct 2024 14:42:21 +0300
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
	Mike Looijmans <mike.looijmans@topic.nl>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: adc: adi-axi-adc: add interface type
Message-ID: <Zw0DnW88GWMOMPft@smile.fi.intel.com>
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
 <20241014094154.9439-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014094154.9439-3-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 14, 2024 at 12:40:37PM +0300, Antoniu Miclaus wrote:
> Add support for getting the interface (CMOS or LVDS) used by the AXI ADC
> ip.

IP

...

>  #define   ADI_AXI_REG_RSTN_MMCM_RSTN		BIT(1)
>  #define   ADI_AXI_REG_RSTN_RSTN			BIT(0)
>  
> +#define ADI_AXI_ADC_REG_CONFIG			0x000c
> +#define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
> +
>  #define ADI_AXI_ADC_REG_CTRL			0x0044
>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)

Side note, the field definitions are indented with different amount of white
spaces.

-- 
With Best Regards,
Andy Shevchenko



