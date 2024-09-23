Return-Path: <linux-pwm+bounces-3338-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E7E97EA93
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 13:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834711F21D1F
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 11:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF28197A87;
	Mon, 23 Sep 2024 11:18:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C4193425;
	Mon, 23 Sep 2024 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727090294; cv=none; b=b7ApAz/BnTZPWbGPRU9WfZbotHrTfToyUO6l5patYO3YbGPQZKwt8WZFCy5xS3lJV2QpKWF2lQFzwwqZNwTtGcHmdNvUvDNf3fmpzDmw6VCi0ChhKf3+8ZCJ8IguiFuYJoHLkIs3rA+OWMFKnJENHCS/2pTgvJyWejvIU24AdfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727090294; c=relaxed/simple;
	bh=GqyC2yybef1lD6tv6wsovX+kFPwDmPfLPZ5sfUi2HUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO64VqDAzNDc3cbSY26f601cfxSMOUT/N2H2IchP3l/dR3BJ3LJVjpmSe39JYBKb++4lKMhp/FCq6mBSQ0nA4/6MzPIW9CfTct8Zp+Ymh+uiOSTgnqYINCsGC1eW4KVkgstpRS8GnHIDQRjP+bwPFpzaE8KNSPMTmaUVx7AHIPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: CT7WtbIPTOO6wK+uzn5WSw==
X-CSE-MsgGUID: X2eGSSFYQkSiYOWzqyaaQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="36616956"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="36616956"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 04:18:09 -0700
X-CSE-ConnectionGUID: vKnC9q5sRI+uMLyDePvJHA==
X-CSE-MsgGUID: FKkBZikRTJ6FXyxPwA26FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71347818"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 04:18:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1ssh4p-0000000BxzO-4Byd;
	Mon, 23 Sep 2024 14:18:00 +0300
Date: Mon, 23 Sep 2024 14:17:59 +0300
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
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/7] iio: backend: add support for data size set
Message-ID: <ZvFOZxZXzY18qljX@smile.fi.intel.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
 <20240923101206.3753-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923101206.3753-3-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 23, 2024 at 01:10:19PM +0300, Antoniu Miclaus wrote:
> Add backend support for setting the data size used.

...

> + * RETURNS:

It's main in this file, please add a patch that converts all 'RETURN' and
'RETURNS' to 'Return:'. Or at bare minimum use "Return:" here.

> + */

...

> +	if (!size)
> +		return -EINVAL;

Why 0 can be set? Is it default?

-- 
With Best Regards,
Andy Shevchenko



