Return-Path: <linux-pwm+bounces-3340-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA1297EAED
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 13:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7BD1F21CCC
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C776B19538A;
	Mon, 23 Sep 2024 11:45:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A7782866;
	Mon, 23 Sep 2024 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727091919; cv=none; b=OK+LfjD/f6HvGBjASZnMMLINN3WrsZDiPW6aVkC6p2GbWuUlUFLpUF4sVDJLdw8asnRkbbuz+TNXpqUj5d3e6tKZID3yBdOhFvv7FKek/IhzN0sppcYqj1sgzZup3+1Y2qwA3V+UsLn9CUfW2IP2TIG3Je5ciNxp3Tzq1Tz83l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727091919; c=relaxed/simple;
	bh=kp5RM9NeVa8kXHlFBQwMpLlMwtX8pzIXCZlRi07bSJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgVncWwt6J7ZYLPRFM10O5bVDGxe3AZ64U+CuszuG5hHUwhddXvvbXQssX++GxAYO9Sr7i2tHIFuYEP/QZ7AlolPZTN/uEz/nAnoHSJlMInQGVLVxevp5pGcKMnUzJkUpYZi39oWbdWjU+5nxcn3/xkx44bTIIwwWHQGXZ8108M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: xqDTcD5GTOi1LttRJEUY3g==
X-CSE-MsgGUID: UT+7vPg2TL+7N0syzie1Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26188680"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="26188680"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 04:45:17 -0700
X-CSE-ConnectionGUID: n1+990J2TryfYvC8F0InNg==
X-CSE-MsgGUID: yXpVwY32Qfu7jLdPRLFRnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71316820"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 04:45:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sshV6-0000000ByTt-2zbm;
	Mon, 23 Sep 2024 14:45:08 +0300
Date: Mon, 23 Sep 2024 14:45:08 +0300
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
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 7/7] Documentation: ABI: testing: ad485x: add ABI docs
Message-ID: <ZvFUxHZpB-xecTF0@smile.fi.intel.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
 <20240923101206.3753-8-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923101206.3753-8-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 23, 2024 at 01:10:24PM +0300, Antoniu Miclaus wrote:
> Add documentation for the packet size.

...

> +KernelVersion:

Hmm...
Can't you use https://hansen.beer/~dave/phb/ (for v6.13)?

> +KernelVersion:

-- 
With Best Regards,
Andy Shevchenko



