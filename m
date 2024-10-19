Return-Path: <linux-pwm+bounces-3728-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AE79A4AAB
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Oct 2024 02:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3BF284D94
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Oct 2024 00:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7381922EB;
	Sat, 19 Oct 2024 00:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcv56uEv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E029CF6;
	Sat, 19 Oct 2024 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729298243; cv=none; b=Qb11SaxX/l/QytKuqvrgiZpkmqVsnznAPua261ymEWily8dQjQQWoc1V+ZgU62QwALO6wn/c3DIc960OeukJCMYEygj41uwlvVF/JU1YcgA/mKdiF9BtEsPEpwbhgkBIR5qDfrnBptjyDYOjU8MwoILlAQN8NfGFh+v3fZQQpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729298243; c=relaxed/simple;
	bh=PfaYoaaPCu5DWdfaaTW12VQJY6h3MD3ntyNmux/6daA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciharSbb853aMxwfR/JYpIm01UBK3efcveTcBALA54yNldnDIi1V/hp1vK3O03AJ1F++6mdlSQnekrdLlOMOwZBrXgZKt1EzJpLGB09xOiI/BK1BZRnzo3G9CLEbGr5xEvU3+sbXW+z0FeJHb2lohwfOZ49n000ZNjBGYI13aos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcv56uEv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729298241; x=1760834241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PfaYoaaPCu5DWdfaaTW12VQJY6h3MD3ntyNmux/6daA=;
  b=gcv56uEva/ctlcfisaZHxrXvvu0APnuamyfhAUh3Jfzvx1YxkuMIcm14
   GB/tP+4qx0qFnlb17rnW+WFVKAmCdG82AOXsayVk4I82LiAm3jH8zWyFC
   lb5q+0R0NPVgKz868Jh/+b2cOxpQFXL+Ecf8iHYu/3s0gwt3BxvtE85ko
   8L+J6bg8XVVGDobC4HAT0buGdXfWy5Lzb0wqaMOFH5ftzNtSvMkAbaEyT
   PF13VZ+qrPi1Qk4oLEibUqoOuCamUfRbIpZ6Ao39MhB0jKZkJnK7JtI2w
   18Y2v3gz6TnHjuvI6dZ0J4L6KdjMiCgvvvZ9xXvCN1GmFO28Sw7gcDKzp
   g==;
X-CSE-ConnectionGUID: P2Y5Ib0YQ0KooHhXYQO8/A==
X-CSE-MsgGUID: x90PeKqvT3GUstjntTtZ6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="29054681"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="29054681"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 17:37:18 -0700
X-CSE-ConnectionGUID: 6YMgxZiVR9emesg1GpNAHA==
X-CSE-MsgGUID: 7zFAV9PvT6+fQq/pN8dEoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="109771570"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2024 17:37:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1xSw-000OTl-3C;
	Sat, 19 Oct 2024 00:37:10 +0000
Date: Sat, 19 Oct 2024 08:36:40 +0800
From: kernel test robot <lkp@intel.com>
To: Guillaume Stols <gstols@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	aardelean@baylibre.com, dlechner@baylibre.com,
	jstephan@baylibre.com, nuno.sa@analog.com,
	Guillaume Stols <gstols@baylibre.com>
Subject: Re: [PATCH v5 7/8] iio: adc: ad7606: Add iio-backend support
Message-ID: <202410190802.CLaySBOq-lkp@intel.com>
References: <20241015-ad7606_add_iio_backend_support-v5-7-654faf1ae08c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-ad7606_add_iio_backend_support-v5-7-654faf1ae08c@baylibre.com>

Hi Guillaume,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 465644ac29536d10178b5ca4684d0b84765b9fa4]

url:    https://github.com/intel-lab-lkp/linux/commits/Guillaume-Stols/dt-bindings-iio-adc-ad7606-Remove-spi-cpha-from-required/20241015-215831
base:   465644ac29536d10178b5ca4684d0b84765b9fa4
patch link:    https://lore.kernel.org/r/20241015-ad7606_add_iio_backend_support-v5-7-654faf1ae08c%40baylibre.com
patch subject: [PATCH v5 7/8] iio: adc: ad7606: Add iio-backend support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241019/202410190802.CLaySBOq-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410190802.CLaySBOq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410190802.CLaySBOq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ad7606_par.c:173:22: warning: unused variable 'back' [-Wunused-variable]
     173 |         struct iio_backend *back;
         |                             ^~~~
   1 warning generated.


vim +/back +173 drivers/iio/adc/ad7606_par.c

   164	
   165	static int ad7606_par_probe(struct platform_device *pdev)
   166	{
   167		const struct ad7606_chip_info *chip_info;
   168		const struct platform_device_id *id;
   169		struct resource *res;
   170		void __iomem *addr;
   171		resource_size_t remap_size;
   172		int irq;
 > 173		struct iio_backend *back;
   174	
   175		/*
   176		 * If a firmware node is available (ACPI or DT), platform_device_id is null
   177		 * and we must use get_match_data.
   178		 */
   179		if (dev_fwnode(&pdev->dev)) {
   180			chip_info = device_get_match_data(&pdev->dev);
   181			if (device_property_present(&pdev->dev, "io-backends"))
   182				/*
   183				 * If a backend is available ,call the core probe with backend
   184				 * bops, otherwise use the former bops.
   185				 */
   186				return ad7606_probe(&pdev->dev, 0, NULL,
   187						    chip_info,
   188						    &ad7606_bi_bops);
   189		} else {
   190			id = platform_get_device_id(pdev);
   191			chip_info = (const struct ad7606_chip_info *)id->driver_data;
   192		}
   193	
   194		irq = platform_get_irq(pdev, 0);
   195		if (irq < 0)
   196			return irq;
   197	
   198		addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
   199		if (IS_ERR(addr))
   200			return PTR_ERR(addr);
   201	
   202		remap_size = resource_size(res);
   203	
   204		return ad7606_probe(&pdev->dev, irq, addr, chip_info,
   205				    remap_size > 1 ? &ad7606_par16_bops :
   206				    &ad7606_par8_bops);
   207	}
   208	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

