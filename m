Return-Path: <linux-pwm+bounces-5839-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FABAAD6CD
	for <lists+linux-pwm@lfdr.de>; Wed,  7 May 2025 09:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD523B0ACD
	for <lists+linux-pwm@lfdr.de>; Wed,  7 May 2025 07:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6154F213E9E;
	Wed,  7 May 2025 07:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmlOy1s8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86CF2101B3;
	Wed,  7 May 2025 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601659; cv=none; b=rSRjsC0ZDwGQyUp7OwDOGAfGOSQHFQujoHoaZdyFefo37FlVvibf+0RvV3lYjqldmWNoNs+k144LASz2eZ21EAOEsmgY6D7H7yCtKtWTcOfkpwpvJ2S5oAl84JgLPT2H2XXFjrNi5N66Bfayhjqx8FnD+kf8fnLY+leKwQ2C7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601659; c=relaxed/simple;
	bh=4g1meUY7nXGsLmA3ICMv283OhsmrHmNHTC3hWxkVC9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwKgML+nzqYAorZAinQe6dfKOM5F05nanDkNvCxVXquRbgs+tGhMv89ewG8Rxuo1PQ9R2hXeHkdbTn2HEaAIB2p8xAJNJ3x1Nsg+3zpU1tkPJKgtCEoSUg9RyASQGRcD6srTN6e5WNGVQ1qj/DQz5q2RPg3+Teq99ylPBIWfvCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmlOy1s8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746601658; x=1778137658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4g1meUY7nXGsLmA3ICMv283OhsmrHmNHTC3hWxkVC9U=;
  b=nmlOy1s87hyw4VmAmRUSCh+IdTw3/DuYbTBDmBxAULC+aVgA7rg4sMYD
   +mN/r50Hpw+43b063UQATs6tc7gN7ltlPuE27SPVlVUIqCluCSX0Enpzf
   G6HOax9Bbgxsicdyj+pjY5gDL2tggE9+GkTVbz5xDzqkgBZRz1q5lguzd
   qlOepO19K1Ke9GHluMiYfrM9+2XUcUoSRfW71wyZIYUkarpcB4xGT98k9
   xoe2r+2qTdOrDN5vZSdmem8mk+jtnKh3VcCQvkJyKm+dC9rDu5dR9VMVT
   GJF1u/WNS4Mwez4bjZ3t3Ab2PdQpbxZ7WtpHSKuawFprlLsLFvitGkZ56
   w==;
X-CSE-ConnectionGUID: AIBkOdDnSJu6dicLZsgM9Q==
X-CSE-MsgGUID: wQv1mhoiQICh4e5FGkj6yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="73702382"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="73702382"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:07:37 -0700
X-CSE-ConnectionGUID: zCSCCDRrTdSJsRd7DdL1/Q==
X-CSE-MsgGUID: fYVDb9S2SfyCD34yU9tWOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="135767280"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 May 2025 00:07:31 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCYsK-0007GF-2A;
	Wed, 07 May 2025 07:07:28 +0000
Date: Wed, 7 May 2025 15:07:16 +0800
From: kernel test robot <lkp@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [PATCH v7 08/11] gpio: max7360: Add MAX7360 gpio support
Message-ID: <202505071411.RPLesOGz-lkp@intel.com>
References: <20250428-mdb-max7360-support-v7-8-4e0608d0a7ff@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-mdb-max7360-support-v7-8-4e0608d0a7ff@bootlin.com>

Hi Mathieu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b4432656b36e5cc1d50a1f2dc15357543add530e]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Dubois-Briand/dt-bindings-mfd-gpio-Add-MAX7360/20250428-221705
base:   b4432656b36e5cc1d50a1f2dc15357543add530e
patch link:    https://lore.kernel.org/r/20250428-mdb-max7360-support-v7-8-4e0608d0a7ff%40bootlin.com
patch subject: [PATCH v7 08/11] gpio: max7360: Add MAX7360 gpio support
config: alpha-randconfig-r111-20250429 (https://download.01.org/0day-ci/archive/20250507/202505071411.RPLesOGz-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.4.0
reproduce: (https://download.01.org/0day-ci/archive/20250507/202505071411.RPLesOGz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071411.RPLesOGz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpio/gpio-max7360.c:30:31: sparse: sparse: symbol 'max7360_gpio_port_plat' was not declared. Should it be static?
>> drivers/gpio/gpio-max7360.c:31:31: sparse: sparse: symbol 'max7360_gpio_col_plat' was not declared. Should it be static?

vim +/max7360_gpio_port_plat +30 drivers/gpio/gpio-max7360.c

    29	
  > 30	struct max7360_gpio_plat_data max7360_gpio_port_plat = { .function = MAX7360_GPIO_PORT };
  > 31	struct max7360_gpio_plat_data max7360_gpio_col_plat = { .function = MAX7360_GPIO_COL };
    32	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

