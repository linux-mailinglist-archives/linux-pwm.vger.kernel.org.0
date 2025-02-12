Return-Path: <linux-pwm+bounces-4868-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA00AA326F1
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 14:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03EA7A0624
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69A720E309;
	Wed, 12 Feb 2025 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfHPH37Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB68820E026;
	Wed, 12 Feb 2025 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366819; cv=none; b=m6cmAaDZQgDtGfU77kUeFVie4D6laYl1gSPNlvxVTXB1eZa575gfcefGkuBbdd4Ik40O5i7FRAKliIdfmbxcPqn1RuWBrUUPwR06tn6ll3X29I7TJaeG6M6PFIoZGx4jHyE6e3CXNqFG4ylDDUnM1Cf68ftDLl8Psy8pEFNDr2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366819; c=relaxed/simple;
	bh=bkXdmxCxZsDHk3Y05ARA4UQDiBcjf3UwW9xdZH1Iiik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7ufEveooUI/c9dfZ4scHa4dws9L7JmHS68CNqvr+UApKgd60ewvC16o/XvKR9VYZ6b39GyLNiNiK40Iq2KNG07zlCoBwdt5BHBz/VRz4yhTi5U7bRtgaqryU7c6qmP5LbfTM3PF0GB2it2T6Mzrpu+4OeNlML6Kaz9aYsZZXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfHPH37Q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739366818; x=1770902818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bkXdmxCxZsDHk3Y05ARA4UQDiBcjf3UwW9xdZH1Iiik=;
  b=jfHPH37Q6tZGcuWhkyllWpzK2VkZpTuo6aEzh79dWwQa/hb41WI/FWAk
   Y0qr4MP7QrDzFBrKObqoL1H5VZgzayjeS2PGzfLRpLCNwnoehe0vAUK+7
   mAbfzb0ueXMvcRjD8U7KnXeRf9klYgvgltjYIKSkWp5mdEypQ8nfM0OB4
   z8yhiFbUhnOTkPQWMmvuzTIE+3DsdHppQ1YZ/82cV7/sbIpp05yghiz3A
   lH6sJX1WfrSDzGR2X3ZCf445dvWLf8kdIX6gFvfax09FzelP1rD2RbQJ5
   +eipxXas9jb9nS+wc2J4Pk+3XJ4DBokBOCvfSEbuPdYQn4gNcb72mR7RZ
   A==;
X-CSE-ConnectionGUID: xtp6W9peRz6DpUIczyDqgg==
X-CSE-MsgGUID: HH/zVh+5TxKTuYZFyeVrqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="27617283"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="27617283"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 05:26:57 -0800
X-CSE-ConnectionGUID: imw32EpcR822tBT37IxG4g==
X-CSE-MsgGUID: 1TPyhM8qQ/m2nv0IUNI+HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="113327526"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Feb 2025 05:26:54 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiClQ-0015eB-15;
	Wed, 12 Feb 2025 13:26:52 +0000
Date: Wed, 12 Feb 2025 21:26:27 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Michael Walle <mwalle@kernel.org>,
	Bamvor Jian Zhang <bamv2005@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Keerthy <j-keerthy@ti.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/14] gpiolib: make value setters have return values
Message-ID: <202502122145.IvWgtz8V-lkp@intel.com>
References: <20250211-gpio-set-retval-v1-1-52d3d613d7d3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-gpio-set-retval-v1-1-52d3d613d7d3@linaro.org>

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on df5d6180169ae06a2eac57e33b077ad6f6252440]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpiolib-make-value-setters-have-return-values/20250211-201426
base:   df5d6180169ae06a2eac57e33b077ad6f6252440
patch link:    https://lore.kernel.org/r/20250211-gpio-set-retval-v1-1-52d3d613d7d3%40linaro.org
patch subject: [PATCH 01/14] gpiolib: make value setters have return values
config: s390-randconfig-001-20250212 (https://download.01.org/0day-ci/archive/20250212/202502122145.IvWgtz8V-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502122145.IvWgtz8V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502122145.IvWgtz8V-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/leds/leds-aw200xx.c:382:2: warning: void function 'aw200xx_disable' should not return a value [-Wreturn-type]
           return gpiod_set_value_cansleep(chip->hwen, 0);
           ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/aw200xx_disable +382 drivers/leds/leds-aw200xx.c

d882762f7950c3 Dmitry Rokosov 2023-11-25  379  
d882762f7950c3 Dmitry Rokosov 2023-11-25  380  static void aw200xx_disable(const struct aw200xx *const chip)
d882762f7950c3 Dmitry Rokosov 2023-11-25  381  {
d882762f7950c3 Dmitry Rokosov 2023-11-25 @382  	return gpiod_set_value_cansleep(chip->hwen, 0);
d882762f7950c3 Dmitry Rokosov 2023-11-25  383  }
d882762f7950c3 Dmitry Rokosov 2023-11-25  384  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

