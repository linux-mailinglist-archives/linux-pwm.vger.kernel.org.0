Return-Path: <linux-pwm+bounces-5811-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C8CAA72CC
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 15:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7587A770D
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 13:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CD4246761;
	Fri,  2 May 2025 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCofNX/M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F542049;
	Fri,  2 May 2025 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191042; cv=none; b=PtHDIpVagF0Bw/ctV1yyW9HsD7bI9xxD88iruJ0W3BbnkuZF/iCo8Cz1CuhMwqHtpXiPd64dkDlAQe0j9HLMlORbmuyawmcqoTvGmorMdgeHwGkuG0AdUNdeZBpwlcRlz2bcyjd1bBT8af90uYVyBtgX8+HMwxcAuI04IpCZD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191042; c=relaxed/simple;
	bh=QatY+WDFSaAt6uRhjr00UcB5/OkX54c4KsiiSBMzf0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFC7nhc02EfqvL7bw4X4T5So9yCqRh/4ZYNfK7wQpFqM6v5VFMonsJC1ASXiHY2wkvzEB/uIbl5kgesfR8blDh2MsZ9wsdWiwD5lhHSYYZiiFHsZIhwaZHKyAzVSTXmpH9WsWUm5LH3qji9PvbV78Pdccxh8Fla2OG5jLsvQzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCofNX/M; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746191041; x=1777727041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QatY+WDFSaAt6uRhjr00UcB5/OkX54c4KsiiSBMzf0A=;
  b=bCofNX/M9Rdt6E4Y2wPl2LIqwwZlzFHgWtOWuUQ2b8JH9T/MiQmrk83x
   4kcCkDc/PVqbFzdzZumQ33mUdFDzb+9YOn9/zfRatUuGez3DKrraTFtE5
   pTwrdOC6WwqiS2QpQyB1wOGkWk1KxzLhEg9znUkJxf+D5g2PLAFo/VONP
   3D66m4W4Dd820CAA27XDMQ6SwcbdykCt7II/NTBvxRaNirzrY+HtLaTE7
   MlQXQfwm297q99XC+Pq/XUP7dsmenV//iLd5mMfwJ29LSdUI0d5Yb8EB8
   p5hYL73VnrZS5ZQ6olQtpvL1ZGluwQ8zlIPuc7LmLJENt1bMrv3j6EOFS
   A==;
X-CSE-ConnectionGUID: QN8nh0/vRZmYXvgfdIcEHQ==
X-CSE-MsgGUID: 5R+2udtSSd+Yv+t9Y8TtPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="58861565"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="58861565"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 06:04:00 -0700
X-CSE-ConnectionGUID: d31mDcEsT8GAa+ZYKQFeew==
X-CSE-MsgGUID: aPtqETHXT6288IEgLhtryA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="139776859"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 06:03:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uAq3U-00000002Cgi-28Xc;
	Fri, 02 May 2025 16:03:52 +0300
Date: Fri, 2 May 2025 16:03:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 08/11] gpio: max7360: Add MAX7360 gpio support
Message-ID: <aBTCuIBxGI3M_pSE@smile.fi.intel.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-8-4e0608d0a7ff@bootlin.com>
 <aBSg2qwNhPqJJRxK@smile.fi.intel.com>
 <D9LOD5X8NXF2.2GWBU2IAZESH7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9LOD5X8NXF2.2GWBU2IAZESH7@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 02, 2025 at 02:31:13PM +0200, Mathieu Dubois-Briand wrote:
> On Fri May 2, 2025 at 12:39 PM CEST, Andy Shevchenko wrote:
> > On Mon, Apr 28, 2025 at 01:57:26PM +0200, Mathieu Dubois-Briand wrote:

...

> >> +			irq_chip = devm_kzalloc(dev, sizeof(*irq_chip), GFP_KERNEL);
> >
> > Can this be made static const instead?
> 
> Sorry, I don't think we can. We do have a few data that will vary:
> ->name, but above all ->irq_drv_data, as it will point on the regmap of
> the specific device.

I see, perhaps a (oneline) comment?

-- 
With Best Regards,
Andy Shevchenko



