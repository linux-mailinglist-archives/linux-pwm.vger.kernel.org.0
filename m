Return-Path: <linux-pwm+bounces-3337-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D34C97EA86
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 13:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5445E1C215DC
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 11:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADA3198838;
	Mon, 23 Sep 2024 11:14:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB1C19412F;
	Mon, 23 Sep 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727090064; cv=none; b=M4VG0p3ULfgaV7c0VKIdMRlnKDAtzBKn6qSQIz0rFfITXosQ689PwQGwIyZW+xcDZnDIYhbMq24PzNZF/NhQ6OpPRKEhmdVHaqnF4OPX5E1uvkfQdRQiNDeKcY9SiwpfnqR398RgpL/0aNXlGm5V9lXXMQ3jPLPeeDUKriuf1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727090064; c=relaxed/simple;
	bh=Bq/UMrG4pbuUbckyfGhjUFjrP/4IPFtDo6ZAxSD5KYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wx3QhJq7/IpltAtDOx/asMxhsIpegw7uFU5e51SjeTI15mL+EINnCFH/V3cZcKWrna2RxmSPvhM1wiTDSNbHVkoqrj4b87S0ra1E7nUegdeMtC299lQYc3MprJsFMMkyUBsq9q7JVPXzK2xVS3AIfHiff20aAtkHba3UNagy4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: L8Sb1rNORpqAhfXgrl4c4Q==
X-CSE-MsgGUID: 0rIVFschS7+ymhdIPZNidA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26150733"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="26150733"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 04:14:22 -0700
X-CSE-ConnectionGUID: lvBCSTzISEKQ5xHc/QHiiw==
X-CSE-MsgGUID: qdtAfHCPTyK+NQaNm6zcWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="70626585"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 04:14:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1ssh1C-0000000Bxv2-2mWd;
	Mon, 23 Sep 2024 14:14:14 +0300
Date: Mon, 23 Sep 2024 14:14:14 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
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
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/7] *** Add support for AD485x DAS Family ***
Message-ID: <ZvFNhiU3aOZ_zHJP@smile.fi.intel.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923101206.3753-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 23, 2024 at 01:10:17PM +0300, Antoniu Miclaus wrote:
> Add support for AD485X fully buffered, 8-channel simultaneous sampling,
> 16/20-bit, 1 MSPS data acquisition system (DAS) with differential, wide
> common-mode range inputs.
> 
> Some particularities:
> 1. softspan - the devices support multiple softspans which are represented in iio
>               through offset/scale. The current handling implies changing both
>               the scale and the offset separately via IIO, therefore in order to
>               properly set the softspan, each time the offset changes the softspan
>               is set to the default value. And only after changing also the scale
>               the desired softspan is set. This is the approach we are suggesting
>               since we need the softspan configurable from userspace and not from
>               devicetree.
> 
> 2. packet format - Data provided on the CMOS and LVDS conversion data output buses
>                    are packaged into eight channel packets. This is currently handled
>                    as extended info.

Thanks for the series!

Quick note: *** in the Subject was also meant to be removed, but it's fine as
long as it's a cover letter and git send-email does its job.

-- 
With Best Regards,
Andy Shevchenko



