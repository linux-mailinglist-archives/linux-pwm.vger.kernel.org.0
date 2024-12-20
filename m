Return-Path: <linux-pwm+bounces-4446-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28129F9CF7
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Dec 2024 00:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094FE188F636
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 23:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14552236E8;
	Fri, 20 Dec 2024 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cf4ZbIEF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2DC218E8F;
	Fri, 20 Dec 2024 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734735751; cv=none; b=DNQ4p0oPxnpnmnCoqOgPmuC06oiGjiFMBM61FNkTsl/YzTqJdtgqEGi1LWd30OLWeB9yfxP7cPbqklNVMkaDjHQz4G17Xd1eQYoExVn4e09+bktaoTfe/gPtqLX4qzFsTRWRto67LMAqGkATMH7BAxqxSvY1MzbKArQvA7W4iQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734735751; c=relaxed/simple;
	bh=YOM0sxWH2NOdQ0u5BkPEsP69Y/I1eG5N0wfi3uJ7IMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLfnS+IfX4yLGMdROxEErT559mNRY116eeXQXDhj5ym3o8cKDqXw+rdeH+CorCbCawHyd/02t8HZQKwrAlVj09fEIPKFi8gbVbQI0pcClA/ufvpjf9DDr1ijC+sVHI13EAjfN/JhwTEhwoXkx7dB4O4hbwPjfkgkk7gYBYkPDT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cf4ZbIEF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734735750; x=1766271750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YOM0sxWH2NOdQ0u5BkPEsP69Y/I1eG5N0wfi3uJ7IMw=;
  b=cf4ZbIEF4JVC0j/tMxUFhanQzlIMCbHAcIqozWlRXuLLHwRUG2Qxtccv
   IeyTDIw7Qn4SrDVUZr3g9iNxVsYDa0a7sB62pNsei5r1RgO20En89YP/l
   nI2G0WjESfQ5KSXap8HfhOrrHY1qwz+H07wMyNHo/sXR3ugShj8lf0cWn
   43FxBrquckxu2m7IREXIdMD+Qv7+hl9HvOq49iVPVfkmNt2VsCNSc55J9
   qFKQtOQnuCQ2ZwDPcA1+w4UuRL/2j4canYREbdz88e7CS/wsGpUDKwhZs
   Syhme7PYklDPtEOVQGN4yelnAlLlT1L44Gan4GpT2ZjtrcQTKFp5sSnGg
   w==;
X-CSE-ConnectionGUID: csslQBuzRl6QmJVlp+4FlQ==
X-CSE-MsgGUID: p9Rcx2xQQlqOkfZ91ofJxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35007764"
X-IronPort-AV: E=Sophos;i="6.12,252,1728975600"; 
   d="scan'208";a="35007764"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 15:02:29 -0800
X-CSE-ConnectionGUID: CaRNdNAcSueE7TASKZn7NQ==
X-CSE-MsgGUID: 4X7QR5sVQvu52XqFyyAAYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102745710"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2024 15:02:25 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOm0k-0001ix-3B;
	Fri, 20 Dec 2024 23:02:22 +0000
Date: Sat, 21 Dec 2024 07:01:23 +0800
From: kernel test robot <lkp@intel.com>
To: mathieu.dubois-briand@bootlin.com, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [PATCH 3/8] mfd: Add max7360 support
Message-ID: <202412210613.xoQvMKlk-lkp@intel.com>
References: <20241219-mdb-max7360-support-v1-3-8e8317584121@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219-mdb-max7360-support-v1-3-8e8317584121@bootlin.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Dubois-Briand/dt-bindings-Add-MAX7360-MFD-device/20241220-002541
base:   78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
patch link:    https://lore.kernel.org/r/20241219-mdb-max7360-support-v1-3-8e8317584121%40bootlin.com
patch subject: [PATCH 3/8] mfd: Add max7360 support
config: openrisc-randconfig-r122-20241220 (https://download.01.org/0day-ci/archive/20241221/202412210613.xoQvMKlk-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241221/202412210613.xoQvMKlk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412210613.xoQvMKlk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mfd/max7360.c:52:27: sparse: sparse: symbol 'max7360_volatile_ranges' was not declared. Should it be static?

vim +/max7360_volatile_ranges +52 drivers/mfd/max7360.c

    51	
  > 52	const struct regmap_range max7360_volatile_ranges[] = {
    53		{
    54			.range_min = MAX7360_REG_KEYFIFO,
    55			.range_max = MAX7360_REG_KEYFIFO,
    56		}, {
    57			.range_min = 0x48,
    58			.range_max = 0x4a,
    59		},
    60	};
    61	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

